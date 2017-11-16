Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd7jP19BczDrDj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 04:37:12 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGHb3C7061706
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:37:11 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9f4fgcah-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:37:04 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 10:36:06 -0700
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vAGHa28I36045004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:36:02 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B9A66E044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:36:02 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.243])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id 0ACC36E048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:36:01 -0700 (MST)
Subject: Re: [PATCH 2/2] powerpc/hotplug: Ensure nodes initialized for hotplug
To: linuxppc-dev@lists.ozlabs.org
References: <a5f7fdb2-d974-03c6-5ecc-c7f726f2b244@linux.vnet.ibm.com>
 <87y3objlrk.fsf@concordia.ellerman.id.au>
 <3be6fd7b-36ec-3beb-21ce-1def39ef0938@linux.vnet.ibm.com>
 <2c095594-7040-2bf9-6444-4583854c957a@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 11:36:01 -0600
MIME-Version: 1.0
In-Reply-To: <2c095594-7040-2bf9-6444-4583854c957a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <83153b17-3fcb-7c0b-f8ac-c728437748d6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>
>>>> +	if ((NODE_DATA(nid) == NULL) ||
>>>> +	    (NODE_DATA(nid)->node_spanned_pages == 0)) {
>>>> +		if (try_online_node(nid))
>>>
>>> .. to do something like online a node.
>>
>> We have changed the function name to 'find_cpu_nid'.
> 
> Ok, but I would still not expect 'find_cpu_nid' to online the node.
> 

We would have to talk to the developer that created try_online_node()
which fully initializes the node and all of the related data structures.
A few of the APIs are external, and 'numa.c' knows how to allocate the
base 'pgdat' structure, but everything else that the kernel depends
upon for a node is handled in mm/page_alloc.c and mm/hotplug_memory.c.
I was trying to avoid piecemeal changes to that code -- avoid any changes
if it comes to it.

Even if it was not expected to put the node online, it is convenient,
as otherwise the patches to 'numa.c' would have to put the node online
-- that is expected for a CPU that is online.

Regards,

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
