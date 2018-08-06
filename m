Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41khYQ74HmzF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 01:35:22 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w76FOc0L053009
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2018 11:35:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kpnqcsxq3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Aug 2018 11:35:20 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 6 Aug 2018 11:35:19 -0400
Subject: Re: vio.c:__vio_register_driver && LPAR Migration issue
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, engebret@us.ibm.com
References: <e815e222-e468-4bd4-5f6f-8657fc980689@linux.vnet.ibm.com>
 <d3d9e08c-70a7-aa6b-13f4-1afed294d39e@linux.vnet.ibm.com>
 <18ddc119-f364-369e-6037-ef7fa0e00e00@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Mon, 6 Aug 2018 10:35:15 -0500
MIME-Version: 1.0
In-Reply-To: <18ddc119-f364-369e-6037-ef7fa0e00e00@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <e0dd4aa2-470e-4766-2844-a33647d97a96@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2018 06:01 PM, Tyrel Datwyler wrote:
> On 08/03/2018 02:23 PM, Tyrel Datwyler wrote:
>> On 08/02/2018 11:15 AM, Michael Bringmann wrote:
>>> Hello:
>>>     I have been observing an anomaly during LPAR migrations between
>>> a couple of P8 systems.
>>>
>>> This is the problem.  After migrating an LPAR, the PPC mobility code
>>> receives RTAS requests to delete nodes with platform-/hardware-specific
>>> attributes when restarting the kernel after a migration.  My example is
>>> for migration between a P8 Alpine and a P8 Brazos.  Among the nodes
>>> that I see being deleted are 'ibm,random-v1', 'ibm,compression-v1',
>>> 'ibm,platform-facilities', and 'ibm,sym-encryption-v1'.  Of these
>>> nodes, the following are created during initial boot by calls to
>>> vio_register_driver:
>>>
>>> drivers/char/hw_random/pseries-rng.c
>>>         ibm,random-v1
>>>
>>> drivers/crypto/nx/nx-842-pseries.c
>>>         ibm,compression-v1
>>>
>>> drivers/crypto/nx/nx.c
>>>         ibm,sym-encryption-v1
>>>
>>> After the migration, these nodes are deleted, but nothing recreates
>>> them.  If I boot the LPAR on the target system, the nodes are added
>>> again.
>>>
>>> My question is how do we recreate these nodes after migration?
>>
>> Hmm, I'd have to see the scenario in action, but these should be added back by ibm,update-nodes RTAS call. There is some debug code in driver/of/dynamic.c that can be enabled that will log node/property dynamic reconfiguration events.
>>
> 
> I took a quick look by turning of phandle caching and turning on the OF reconfig debug on one of my lpars. I noticed that it looks like this could be a firmware issue. Looks to me like we aren't being notified to re-add those child nodes of ibm,platform-facilities.
> 
> [ 1671.638041] OF: notify DETACH_NODE     /cpus/l2-cache@2022
> [ 1671.638094] OF: notify DETACH_NODE     /cpus/l3-cache@3122
> [ 1671.638119] OF: notify DETACH_NODE     /cpus/l2-cache@2023
> [ 1671.638136] OF: notify DETACH_NODE     /cpus/l3-cache@3123
> [ 1671.638164] OF: notify DETACH_NODE     /ibm,platform-facilities/ibm,random-v1
> [ 1671.638182] OF: notify DETACH_NODE     /ibm,platform-facilities/ibm,compression-v1
> [ 1671.638198] OF: notify DETACH_NODE     /ibm,platform-facilities/ibm,sym-encryption-v1
> [ 1671.638219] OF: notify DETACH_NODE     /ibm,platform-facilities
> [ 1671.776419] OF: notify UPDATE_PROPERTY /:ibm,model-class
> 
> ... snipped property updates
> 
> [ 1672.129941] OF: notify UPDATE_PROPERTY /cpus/PowerPC,POWER8@8:ibm,dfp
> [ 1672.147551] OF: notify ATTACH_NODE     /cpus/l2-cache@202e
> [ 1672.166321] OF: notify ATTACH_NODE     /cpus/l3-cache@312e
> [ 1672.183971] OF: notify ATTACH_NODE     /cpus/l2-cache@202f
> [ 1672.202752] OF: notify ATTACH_NODE     /cpus/l3-cache@312f
> [ 1672.230760] OF: notify ATTACH_NODE     /ibm,platform-facilities
> 
> Need to verify this by tracing the RTAS calls to ibm,update-nodes. I'll try and look at that tomorrow. The loop that processes the nodes to update in pseries_devicetree_update() blindly ignores the return codes from delete_dt_node(), update_dt_node(), and add_dt_node(). So, it is also possible that we are notified, but are silently failing the add.

I am seeing the same set of detach/attach events for migration between an Alpine and Brazos.
I did the logging up in delete_dt_node, update_dt_node, and add_dt_node, and did not see any
notification of additional nodes.

> 
> -Tyrel
> 

Michael

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
