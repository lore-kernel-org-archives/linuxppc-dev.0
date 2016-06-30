Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgTt05dskzDrJG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 05:21:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UJIoNZ142748
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:21:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09rub8d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:21:09 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 15:21:07 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5FB6A6E804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:20:47 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UJL6bc40960130
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 19:21:06 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B0952804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:21:05 -0400 (EDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 79EBF28046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:21:05 -0400 (EDT)
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc/pseries: Implemented indexed-count hotplug memory
 management
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 30 Jun 2016 14:21:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <19ab11fc-9771-1ad4-95d7-d26dd8f18184@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Indexed-count memory management allows addition and removal of contiguous
lmb blocks to be added and removed with a single command. When compared
to the series of calls previously required to manage contiguous blocks,
indexed-count decreases command frequency and complexity, consequently
preventing buffer overflow.

-Sahil Mehta
---
 include/asm/rtas.h                 |    2
 platforms/pseries/dlpar.c          |   32 +++++-
 platforms/pseries/hotplug-memory.c |  194 ++++++++++++++++++++++++++++++++++---
 3 files changed, 210 insertions(+), 18 deletions(-)
