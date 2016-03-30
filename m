Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZwtn73mYzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 05:20:49 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qZwtn5s54z9sD3
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 05:20:49 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 04:20:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CF46B2CE8056
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 05:20:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2UIKJh560162208
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 05:20:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2UIJshl001040
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 05:19:55 +1100
Subject: [PATCH v3] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Mar 2016 23:49:29 +0530
Message-ID: <20160330181853.392.95184.stgit@hbathini.in.ibm.com>
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
in commit 1707dd16. So, EXCEPTION_PROLOG_0 (6 instructions) that contains
the part up to the point where the CFAR is saved in the PACA should be
part of the short interrupt vectors before we branch out to OOL handlers.

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

Let us fix this undependable code path by moving these OOL handlers below
__end_interrupts marker to make sure we also copy these handlers to real
address 0x100 when running a relocatable kernel. Because the interrupt
vectors branching to these OOL handlers are not long enough to use
LOAD_HANDLER() for branching as discussed above.

This fix has been tested successfully in kdump scenario, on a lpar with 4K page
size by using different default/production kernel and kdump kernel.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---

changes from v2:
2. Move the OOL handlers before __end_interrupts marker instead of moving the __end_interrupts marker
3. Leave __end_handlers marker as is.

 arch/powerpc/kernel/exceptions-64s.S |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7716ceb..9ac3a38 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -953,6 +953,25 @@ hv_facility_unavailable_relon_trampoline:
 #endif
 	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
 
+	/*
+	 * Out-Of-Line handlers for relocation-on interrupt vectors
+	 *
+	 * We need these OOL handlers to be below __end_interrupts
+	 * marker to enusre we also copy these OOL handlers along
+	 * with the interrupt vectors to real address 0x100 when
+	 * running a relocatable kernel. Because the interrupt
+	 * vectors branching to these OOL handlers are not long
+	 * enough to use LOAD_HANDLER() for branching.
+	 */
+	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
+
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
+	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
+
 	/* Other future vectors */
 	.align	7
 	.globl	__end_interrupts
@@ -1234,16 +1253,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	.globl	__end_handlers
 __end_handlers:
 
-	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
-
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
-
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
