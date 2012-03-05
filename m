Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E550B6FC8
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:47 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:48:33 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252qSDe1032240
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:33 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qRYd007519
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:27 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/13] powerpc: Fix register clobbering when accumulating
 stolen time
Date: Mon,  5 Mar 2012 13:51:28 +1100
Message-Id: <1330915891-19523-11-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running under a hypervisor that supports stolen time accounting,
we may call C code from the macro EXCEPTION_PROLOG_COMMON in the
exception entry path, which clobbers CR0.

However, the FPU and vector traps rely on CR0 indicating whether we
are coming from userspace or kernel to decide what to do.

So we need to restore that value after the C call

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/ppc_asm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 368f72f..50f73aa 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -60,6 +60,8 @@ BEGIN_FW_FTR_SECTION;							\
 	cmpd	cr1,r11,r10;						\
 	beq+	cr1,33f;						\
 	bl	.accumulate_stolen_time;				\
+	ld	r12,_MSR(r1);						\
+	andi.	r10,r12,MSR_PR;		/* Restore cr0 (coming from user) */ \
 33:									\
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 
-- 
1.7.9
