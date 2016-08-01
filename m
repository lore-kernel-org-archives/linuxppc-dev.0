Return-Path: <smehta@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s35gQ3WnnzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 03:20:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u71HJxCg145960
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 13:20:00 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gpjevbfx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 13:19:59 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <smehta@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 11:19:45 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 95E0A19D801C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 11:19:16 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u71HJV4215073676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 10:19:42 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 044E9C605D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 11:19:42 -0600 (MDT)
Received: from oc2173006240.ibm.com (unknown [9.41.92.166])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP id DD93AC6057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 11:19:41 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/2] powerpc/pseries: Implement indexed-count hotplug
 memory management
From: Sahil Mehta <smehta@linux.vnet.ibm.com>
Date: Mon, 1 Aug 2016 12:19:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <437ead25-8938-a0e8-c7cf-8ead45e5ef3b@linux.vnet.ibm.com>
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

Changes in v4:
--------------
-[PATCH 1/2]:	-add logic to handle kstrdup failure
		-add logic to handle invalid command format

-Sahil Mehta
---
 include/asm/rtas.h                 |    2
 platforms/pseries/dlpar.c          |   48 ++++++++
 platforms/pseries/hotplug-memory.c |  200 +++++++++++++++++++++++++++++++++++--
 3 files changed, 237 insertions(+), 13 deletions(-)
