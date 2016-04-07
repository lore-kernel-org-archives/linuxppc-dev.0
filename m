Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgxMk31ZKzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 07:59:46 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qgxMk1Zmpz9t5S
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2016 07:59:46 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 07:59:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E21242CE8057
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2016 07:59:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u37LxYIR11469268
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Apr 2016 07:59:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u37Lx9pG029545
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Apr 2016 07:59:10 +1000
Subject: [PATCH v4 2/3] ppc64/book3s: make some room for common interrupt
 vector code
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 08 Apr 2016 03:28:50 +0530
Message-ID: <20160407215811.8404.6733.stgit@hbathini.in.ibm.com>
In-Reply-To: <20160407215541.8404.15022.stgit@hbathini.in.ibm.com>
References: <20160407215541.8404.15022.stgit@hbathini.in.ibm.com>
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

With the previous patch, we choke out whatever little space is left
below 0x7000 (FWNMI hard block) while there is a hole of ~1400 bytes
below __end_interrupts marker when CONFIG_CBE_RAS is disabled.
Considering CONFIG_CBE_RAS is not enabled by default for BOOK3S, this
is not a desirable scenario especially when we have to worry about
each additional instruction that goes below 0x7000.

Memory region from 0x1800 to 0x4000 is dedicated for common interrupt
vector code. Also, we never hit an interrupt below 0x300 when IR=DR=1
implying memory region between 0x4000 to 0x4300 can also be used for
common interrupt vector code. So, we can effectively use memory region
between 0x1800 to 0x4300 for common interrupt vector code.

This patch tries to free up some space below 0x7000 by rearranging the
common interrupt vector code. The approach here is to avoid large holes
below 0x4300 for any kernel configuration. For this, let us move common
interrupt vector code that only gets enabled with CONFIG_CBE_RAS above
0x8000, as it doesn't need to be too close to the call sites and can be
branched to with LOAD_HANDLER() as long as it is within the first 64KB
(0x10000) of the kernel image. Instead, lets move common interrupt vector
code marked h_instr_storage_common, facility_unavailable_common &
hv_facility_unavailable_common below 0x4300. This leaves ~250 bytes
free below 0x4300 and ~1150 bytes free below 0x7000 - enough space to
stop worrying about every additional instruction that goes below 0x7000.

This patch assumes at least commit 376af594, part of the patch series
that starts with commit 468a3302, is part of the code to avoid messy
compilation issues like:

    relocation truncated to fit: R_PPC64_REL14 against `.text'+1c90
    Makefile:864: recipe for target 'vmlinux' failed

I tested this patch successfully on ppc64, ppc64le lpars and baremetal
environments. Couldn't test it on IBM cell blade though but expecting no
problems with this patch in IBM cell blade environment as well. If
someone can test this patch in cell platform, it would be great.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f76b2f3..c193ebd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -786,6 +786,7 @@ kvmppc_skip_Hinterrupt:
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, single_step_exception)
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, unknown_exception)
+	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
 	STD_EXCEPTION_COMMON(0xe40, emulation_assist, emulation_assist_interrupt)
 	STD_EXCEPTION_COMMON_ASYNC(0xe60, hmi_exception, handle_hmi_exception)
 #ifdef CONFIG_PPC_DOORBELL
@@ -794,6 +795,9 @@ kvmppc_skip_Hinterrupt:
 	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, unknown_exception)
 #endif
 	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, performance_monitor_exception)
+	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
+	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
+
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, instruction_breakpoint_exception)
 	STD_EXCEPTION_COMMON(0x1502, denorm, unknown_exception)
 #ifdef CONFIG_ALTIVEC
@@ -801,11 +805,6 @@ kvmppc_skip_Hinterrupt:
 #else
 	STD_EXCEPTION_COMMON(0x1700, altivec_assist, unknown_exception)
 #endif
-#ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
-	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
-	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
-#endif /* CONFIG_CBE_RAS */
 
 	/*
 	 * Relocation-on interrupts: A subset of the interrupts can be delivered
@@ -1029,8 +1028,6 @@ instruction_access_common:
 	li	r5,0x400
 	b	do_hash_page		/* Try to handle as hpte fault */
 
-	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
-
 /*
  * Here is the common SLB miss user that is used when going to virtual
  * mode for SLB misses, that is currently not used
@@ -1246,9 +1243,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	bl	vsx_unavailable_exception
 	b	ret_from_except
 
-	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
-	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
-
 	.align	7
 	.globl	__end_handlers
 __end_handlers:
@@ -1268,6 +1262,12 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
+#ifdef CONFIG_CBE_RAS
+	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
+	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
+	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
+#endif /* CONFIG_CBE_RAS */
+
 	.globl hmi_exception_early
 hmi_exception_early:
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
