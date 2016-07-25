Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rypQk4CQ9zDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 03:39:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PHd4x1023229
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:39:06 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c2wfgdda-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 13:39:05 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 11:39:04 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A4F9519D8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:38:20 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PHcjMZ16449932
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:38:45 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CC2D6A03B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:38:45 -0600 (MDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id 049436A03C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 11:38:44 -0600 (MDT)
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] powerpc/pseries: Implement indexed-count hotplug
 memory management
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 25 Jul 2016 12:38:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ef1e34d9-376c-1418-2862-f2543452298e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Indexed-count memory management allows addition and removal of contiguous
lmb blocks with a single command. When compared to the series of calls
previously required to manage contiguous blocks, indexed-count decreases
command frequency and reduces risk of buffer overflow.

Changes in v2:
--------------
-[PATCH 1/2]:	-remove potential memory leak when parsing command
		-use u32s drc_index and count instead of u32 ic[]
		 in dlpar_memory
-[PATCH 2/2]:	-use u32s drc_index and count instead of u32 ic[]
		 in dlpar_memory

Changes in v3:
--------------
-[PATCH 1/2]:	-add logic to handle invalid drc_index input
		-update indexed-count trigger to follow naming convention
		-update dlpar_memory to follow kernel if-else style
-[PATCH 2/2]:	-add logic to handle invalid drc_index input

-Sahil Mehta
---
 include/asm/rtas.h                 |    2
 platforms/pseries/dlpar.c          |   34 +++++-
 platforms/pseries/hotplug-memory.c |  200 +++++++++++++++++++++++++++++++++++--
 3 files changed, 224 insertions(+), 12 deletions(-)
