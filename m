Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41j0Qs4DdgzF2DY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 07:23:49 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w73LNlIf091452
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2018 17:23:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmudxf9ur-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 17:23:46 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 3 Aug 2018 15:23:42 -0600
Subject: Re: vio.c:__vio_register_driver && LPAR Migration issue
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.co>,
 Michael Ellerman <mpe@ellerman.id.au>, engebret@us.ibm.com,
 santil@us.ibm.com, hollisb@us.ibm.com, rcjenn@us.ibm.com
References: <e815e222-e468-4bd4-5f6f-8657fc980689@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 3 Aug 2018 14:23:35 -0700
MIME-Version: 1.0
In-Reply-To: <e815e222-e468-4bd4-5f6f-8657fc980689@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d3d9e08c-70a7-aa6b-13f4-1afed294d39e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2018 11:15 AM, Michael Bringmann wrote:
> Hello:
>     I have been observing an anomaly during LPAR migrations between
> a couple of P8 systems.
> 
> This is the problem.  After migrating an LPAR, the PPC mobility code
> receives RTAS requests to delete nodes with platform-/hardware-specific
> attributes when restarting the kernel after a migration.  My example is
> for migration between a P8 Alpine and a P8 Brazos.  Among the nodes
> that I see being deleted are 'ibm,random-v1', 'ibm,compression-v1',
> 'ibm,platform-facilities', and 'ibm,sym-encryption-v1'.  Of these
> nodes, the following are created during initial boot by calls to
> vio_register_driver:
> 
> drivers/char/hw_random/pseries-rng.c
>         ibm,random-v1
> 
> drivers/crypto/nx/nx-842-pseries.c
>         ibm,compression-v1
> 
> drivers/crypto/nx/nx.c
>         ibm,sym-encryption-v1
> 
> After the migration, these nodes are deleted, but nothing recreates
> them.  If I boot the LPAR on the target system, the nodes are added
> again.
> 
> My question is how do we recreate these nodes after migration?

Hmm, I'd have to see the scenario in action, but these should be added back by ibm,update-nodes RTAS call. There is some debug code in driver/of/dynamic.c that can be enabled that will log node/property dynamic reconfiguration events.

-Tyrel

> 
> Thanks.
> 
