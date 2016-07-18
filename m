Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtRKr0RfpzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 01:04:46 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6IEx1IL124559
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:04:44 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24827ev57u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:04:44 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Mon, 18 Jul 2016 09:04:43 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id AFCB33E40054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 09:04:41 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6IF4eGq47186096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 08:04:41 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ACD996002
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 09:04:41 -0600 (MDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id 615FF7A007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 09:04:41 -0600 (MDT)
Subject: [PATCH v2 0/2] powerpc/pseries: Implemented indexed-count hotplug
 memory management
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 18 Jul 2016 10:04:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <f3a63611-ae4d-be48-64d7-88a7ac7c1091@linux.vnet.ibm.com>
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

-Sahil Mehta
---
 include/asm/rtas.h                 |    2
 platforms/pseries/dlpar.c          |   34 ++++++
 platforms/pseries/hotplug-memory.c |  184 +++++++++++++++++++++++++++++++++++--
 3 files changed, 208 insertions(+), 12 deletions(-)
