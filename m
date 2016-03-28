Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYWlD03VwzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2016 22:24:24 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qYWlC4mgmz9sBm
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 22:24:23 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 28 Mar 2016 21:24:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6D9D43578052
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 22:24:14 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SBO6pN5112224
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 22:24:14 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SBNfQF006099
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 22:23:41 +1100
Subject: [PATCH] ppc64/book3s: copy interrupts till __end_handlers marker
 instead of __end_interrupts
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 28 Mar 2016 16:53:22 +0530
Message-ID: <20160328112305.18048.43759.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the interrupt vectors on 64-bit POWER server processors  are
only 32 bytes long (8 instructions), which is not enough for the full
first-level interrupt handler. For these we need to branch to an out-
of-line (OOL) handler. But when we are running a relocatable kernel,
interrupt vectors till __end_interrupts marker are copied down to real
address 0x100. So, branching to labels (read OOL handlers) outside this
section should be handled differently (see LOAD_HANDLER()), considering
relocatable kernel, which would need atleast 4 instructions.

However, branching from interrupt vector means that we corrupt the CFAR
(come-from address register) on POWER7 and later processors as mentioned
in commit 1707dd16. So, EXCEPTION_PROLOG_0
(6 instructions) that contains the part up to the point where the CFAR is
saved in the PACA should be part of the short interrupt vectors before we
branch out to OOL handlers.

But as mentioned already, there are interrupt vectors on 64-bit POWER server
processors that are only 32 bytes long (like vectors 0x4f00, 0x4f20, etc.),
which cannot accomodate the above two cases at the same time owing to space
constraint. Currently, in these interrupt vectors, we simply branch out to
OOL handlers, without using LOAD_HANDLER(), which leaves us vulnerable when
running a relocatable kernel (eg. kdump case). While this has been the case
for sometime now and kdump is used widely, we were fortunate not to see any
problems so far, for three reasons:

    1. In almost all cases, production kernel (relocatable) is used for
       kdump as well, which would mean that crashed kernel's OOL handler
       would be at the same place where we endup branching to, from short
       interrupt vector of kdump kernel.
    2. Also, OOL handler was unlikely the reason for crash in almost all
       the kdump scenarios, which meant we had a sane OOL handler from
       crashed kernel that we branched to.
    3. On most 64-bit POWER server processors, page size is large enough
       that marking interrupt vector code as executable (see commit
       429d2e83) leads to marking OOL handler code from crashed kernel,
       that sits right below interrupt vector code from kdump kernel, as
       executable as well.

Let us fix this undependable code path firstly, by moving down __end_handlers
marker down past OOL handlers. Secondly, copying interrupt vectors down till
__end_handlers marker instead of __end_interrupts, when running a relocatable
kernel, to make sure we endup in relocated (kdump) kernel's OOL handler instead
of crashed kernel's. Thirdly, by marking all the interrupt vector code that is
copied down to real address 0x100 as executable, considering the relocation on
exception feature that allows exceptions to be raised in virtual mode (IR=DR=1).

This fix has been tested successfully in kdump scenario, on a lpar with 4K page
size by using different default/production kernel and kdump kernel.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/sections.h  |    3 ++-
 arch/powerpc/kernel/exceptions-64s.S |    8 ++++----
 arch/powerpc/kernel/head_64.S        |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index abf5866..b4139a5 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -10,6 +10,7 @@
 
 extern char __start_interrupts[];
 extern char __end_interrupts[];
+extern char __end_handlers[];
 
 extern char __prom_init_toc_start[];
 extern char __prom_init_toc_end[];
@@ -39,7 +40,7 @@ static inline int overlaps_interrupt_vector_text(unsigned long start,
 {
 	unsigned long real_start, real_end;
 	real_start = __start_interrupts - _stext;
-	real_end = __end_interrupts - _stext;
+	real_end = __end_handlers - _stext;
 
 	return start < (unsigned long)__va(real_end) &&
 		(unsigned long)__va(real_start) < end;
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7716ceb..98e2ce5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1230,10 +1230,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
 	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
 
-	.align	7
-	.globl	__end_handlers
-__end_handlers:
-
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
@@ -1244,6 +1240,10 @@ __end_handlers:
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
 	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
 
+	.align	7
+	.globl	__end_handlers
+__end_handlers:
+
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4286775..829c74c 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -611,7 +611,7 @@ __after_prom_start:
 	sub	r5,r5,r11
 #else
 	/* just copy interrupts */
-	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
+	LOAD_REG_IMMEDIATE(r5, __end_handlers - _stext)
 #endif
 	b	5f
 3:
