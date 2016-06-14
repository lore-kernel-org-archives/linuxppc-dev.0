Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4g0brqzDqk2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:14 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6s0I4000872
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:12 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23gbjvp91j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:12 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:11 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 05/10] powerpc: Call jump_label_init early
Date: Tue, 14 Jun 2016 12:24:43 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call jump_label_init early so that can use static keys for cpu and
mmu feature check. We should have finalzed all the cpu/mmu features when
we call setup_system and we also did feature fixup for ASM based code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_32.c | 6 ++++++
 arch/powerpc/kernel/setup_64.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index ecdc42d44951..8831738c3dcb 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -99,6 +99,12 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 			 PTRRELOC(&__stop___lwsync_fixup));
 
 	do_final_fixups();
+	/*
+	 * init jump label so that cpu and mmu feature check can be optimized
+	 * using jump label. We should have all the cpu/mmu features finalized
+	 * by now.
+	 */
+	jump_label_init();
 
 	return KERNELBASE + offset;
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 86aea0537270..a4867a900b02 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -480,6 +480,12 @@ void __init setup_system(void)
 	do_lwsync_fixups(cur_cpu_spec->cpu_features,
 			 &__start___lwsync_fixup, &__stop___lwsync_fixup);
 	do_final_fixups();
+	/*
+	 * init jump label so that cpu and mmu feature check can be optimized
+	 * using jump label. We should have all the cpu/mmu features finalized
+	 * by now.
+	 */
+	jump_label_init();
 
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
-- 
2.7.4
