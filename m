Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLYcD0F7HzDrdq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 07:10:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7QL75Co059595
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:49 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25231tunts-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:49 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 17:10:47 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E8BAD6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:23 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7QLAk7417432856
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 21:10:46 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF595AE043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:44 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 915B8AE034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:44 -0400 (EDT)
Subject: [PATCH 0/3] powerpc/pseries: Manage single copy of ibm, dynamic-memory
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 17:03:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory property
of the device-tree can be fairly big on systems with a large amount
of memory. A system with 1 TB of memory (256 MB LMBs) the property
size is 94k, this equates to roughly a 30MB property size for a 32 TB
system. This file size is not neccessarily huge, but the need to update
this property every time we DLPAR add or remove an LMB could be
problematic.

Every time the property is updated a new copy of the property is made
with the previous copy being added to the old_properties list. Due to
the lack of reference counting on properties old versions of a property
are never free'ed. One a large 32TB system we could easilty do
several thousands of memory add/remove operations and thus create
several thousand of copies of this property. This seems a bit wasteful
with respect to system resources.
    
Patch 1/3:
This patch changes the pseries hotplug memory code to maintain a static
reference to this property instead of creating a new copy for every LMB
that we add or remove. In doing this we have to ensure that the property
remains in BE format so a set of accessor methods are provided to
get/set values from the property in the proper cpu format.

Patch 2/3:
Remove a no longer need rtas_hp_event flag.

Patch 3/3:
Add a bit field to track updated LMBs during DLPAR add/remove operations.
 
This should provide an improvement in kernel resources as
we will no longer have un-referenced copies of this property.

-Nathan
---

Nathan Fontenot (3):
      powerpc/pseries: maintain single copy of ibm,dynamic-memory property
      powerpc/pseries: Remove no longer needed rtas_hp_event flag
      powerpc/pseries: Add bitmap to track updated LMBs


 arch/powerpc/platforms/pseries/hotplug-memory.c |  526 ++++++++++-------------
 1 file changed, 224 insertions(+), 302 deletions(-)
