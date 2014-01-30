Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 790C82C031C
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 06:01:16 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 05:01:16 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5371A3578052
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 06:01:14 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UIg1fQ51380250
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 05:42:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UJ1Dkt020583
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jan 2014 06:01:14 +1100
Subject: [PATCH] powerpc: Fix kdump hang issue on p8 with relocation on
 exception enabled.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 00:31:04 +0530
Message-ID: <20140130190104.19333.86268.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Steve Best <sbest@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On p8 systems, with relocation on exception feature enabled we are seeing
kdump kernel hang at interrupt vector 0xc*4400. The reason is, with this
feature enabled, exception are raised with MMU (IR=DR=1) ON with the
default offset of 0xc*4000. Since exception is raised in virtual mode it
requires the vector region to be executable without which it fails to
fetch and execute instruction at 0xc*4xxx. For default kernel since kernel
is loaded at real 0, the htab mappings sets the entire kernel text region
executable. But for relocatable kernel (e.g. kdump case) we only copy
interrupt vectors down to real 0 and never marked that region as
executable because in p7 and below we always get exception in real mode.

This patch fixes this issue by marking htab mapping range as executable
that overlaps with the interrupt vector region for relocatable kernel.

Thanks to Ben who helped me to debug this issue and find the root cause.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/sections.h |   12 ++++++++++++
 arch/powerpc/mm/hash_utils_64.c     |   14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 4ee06fe..d0e784e 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -8,6 +8,7 @@
 
 #ifdef __powerpc64__
 
+extern char __start_interrupts[];
 extern char __end_interrupts[];
 
 extern char __prom_init_toc_start[];
@@ -21,6 +22,17 @@ static inline int in_kernel_text(unsigned long addr)
 	return 0;
 }
 
+static inline int overlaps_interrupt_vector_text(unsigned long start,
+							unsigned long end)
+{
+	unsigned long real_start, real_end;
+	real_start = __start_interrupts - _stext;
+	real_end = __end_interrupts - _stext;
+
+	return start < (unsigned long)__va(real_end) &&
+		(unsigned long)__va(real_start) < end;
+}
+
 static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
 {
 	return start < (unsigned long)__init_end &&
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 6176b3c..50e21af 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -206,6 +206,20 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 		if (overlaps_kernel_text(vaddr, vaddr + step))
 			tprot &= ~HPTE_R_N;
 
+		/*
+		 * If relocatable, check if it overlaps interrupt vectors that
+		 * are copied down to real 0. For relocatable kernel
+		 * (e.g. kdump case) we copy interrupt vectors down to real
+		 * address 0. Mark that region as executable. This is
+		 * because on p8 system with relocation on exception feature
+		 * enabled, exceptions are raised with MMU (IR=DR=1) ON. Hence
+		 * in order to execute the interrupt handlers in virtual
+		 * mode the vector region need to be marked as executable.
+		 */
+		if ((PHYSICAL_START > MEMORY_START) &&
+			overlaps_interrupt_vector_text(vaddr, vaddr + step))
+				tprot &= ~HPTE_R_N;
+
 		hash = hpt_hash(vpn, shift, ssize);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
