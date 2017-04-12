Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w32Fk3WwWzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:46:50 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBd9Bf091072
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:42 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29scj8t3qr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:42 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 07:46:40 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powernv:idle: Use correct IDLE_THREAD_BITS in POWER8/9
Date: Wed, 12 Apr 2017 17:16:20 +0530
In-Reply-To: <cover.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
Message-Id: <1b89d07b1a7ea140501a86b1ed246c5af1b0ce83.1491996797.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

This patch ensures that POWER8 and POWER9 processors use the correct
value of IDLE_THREAD_BITS as POWER8 has 8 threads per core and hence
the IDLE_THREAD_BITS should be 0xFF while POWER9 has only 4 threads
per core and hence the IDLE_THREAD_BITS should be 0xF.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    | 3 ++-
 arch/powerpc/kernel/idle_book3s.S     | 9 ++++++---
 arch/powerpc/platforms/powernv/idle.c | 5 ++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 52586f9..fece6ca 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -34,7 +34,8 @@
 #define PNV_CORE_IDLE_THREAD_WINKLE_BITS_SHIFT	8
 #define PNV_CORE_IDLE_THREAD_WINKLE_BITS	0x0000FF00
 
-#define PNV_CORE_IDLE_THREAD_BITS       	0x000000FF
+#define PNV_CORE_IDLE_4THREAD_BITS       	0x0000000F
+#define PNV_CORE_IDLE_8THREAD_BITS       	0x000000FF
 
 /*
  * ============================ NOTE =================================
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 2b13fe2..9b747e9 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -223,7 +223,7 @@ lwarx_loop1:
 	add	r15,r15,r5			/* Add if winkle */
 	andc	r15,r15,r7			/* Clear thread bit */
 
-	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
+	andi.	r9,r15,PNV_CORE_IDLE_8THREAD_BITS
 
 /*
  * If cr0 = 0, then current thread is the last thread of the core entering
@@ -582,8 +582,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	stwcx.	r15,0,r14
 	bne-	1b
 	isync
-
-	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
+BEGIN_FTR_SECTION
+	andi.	r9,r15,PNV_CORE_IDLE_4THREAD_BITS
+FTR_SECTION_ELSE
+	andi.	r9,r15,PNV_CORE_IDLE_8THREAD_BITS
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	cmpwi	cr2,r9,0
 
 	/*
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 445f30a..d46920b 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -112,7 +112,10 @@ static void pnv_alloc_idle_core_states(void)
 		size_t paca_ptr_array_size;
 
 		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
-		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			*core_idle_state = PNV_CORE_IDLE_4THREAD_BITS;
+		else
+			*core_idle_state = PNV_CORE_IDLE_8THREAD_BITS;
 		paca_ptr_array_size = (threads_per_core *
 				       sizeof(struct paca_struct *));
 
-- 
1.9.4
