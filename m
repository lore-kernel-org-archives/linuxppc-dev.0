Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXtlg1236zDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:38:06 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8CGXW1M072533
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 12:38:03 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25dx86x0ff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 12:38:03 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Sep 2016 10:38:02 -0600
Subject: [PATCH v5 0/2] powerpc/pseries: Implement indexed-count hotplug
 memory management
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: sahilmehta17@gmail.com
Date: Mon, 12 Sep 2016 12:30:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160912163009.56321.70346.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
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

Changes in v5:
--------------
-[PATCH 2/2]:   -update for() loop to use start_index
---

Sahil Mehta (2):
      powerpc/pseries: Implement indexed-count hotplug memory add
      powerpc/pseries: Implement indexed-count hotplug memory remove


 arch/powerpc/include/asm/rtas.h                 |    2 
 arch/powerpc/platforms/pseries/dlpar.c          |   46 +++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |  200 ++++++++++++++++++++++-
 3 files changed, 236 insertions(+), 12 deletions(-)
