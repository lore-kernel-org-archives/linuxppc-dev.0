Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA3B3B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 06:36:36 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 5 Jun 2012 16:36:32 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 51DB46E8049
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 16:36:29 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q55KaTIV150028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 16:36:29 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5627LnF025618
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2012 22:07:21 -0400
Date: Tue, 5 Jun 2012 13:32:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] perf: Don't use SIAR for user addresses
Message-ID: <20120605203247.GA1525@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mpjohn@us.ibm.com, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 1 Jun 2012 20:56:02 -0400
Subject: [PATCH] perf: Don't use SIAR for user-space addresses

With the pipelining on Power7, the SIAR can be off by several instructions
leading to incorrect callgraphs. For user space code at least we can be more
accurate by just using the next instruction pointer.

Based on code/input from Anton Blanchard.

Before this fon Power7, we see callgraphs like:

     1.90%  sprintft  sprintft           [.] do_my_sprintf
               |
               --- 00000011.plt_call.strlen@@GLIBC_2.3+0
                   do_my_sprintf
                   main
                   generic_start_main
                   __libc_start_main
                   (nil)
        ...snip...

              |
               --- __random
                   rand
                  |
                  |--63.16%-- do_my_sprintf
                  |          main
                  |          generic_start_main
                  |          __libc_start_main
                  |          (nil)
                  |
                   --36.84%-- rand
                             do_my_sprintf
                             main
                             generic_start_main
                             __libc_start_main
                             (nil)

which seems to indicate the libc __random() calls do_my_sprintf(), instead
of the other way around.

After the fix, the same trace looks like this:

     4.08%  sprintft  sprintft           [.] do_my_sprintf
            |
            --- do_my_sprintf
                do_my_sprintf
                main
                generic_start_main
                __libc_start_main
                (nil)

Cc: Anton Blanchard <anton@samba.org>
Reported-by: Maynard Johnson <mpjohn@us.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8f84bcb..846bd68 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -116,6 +116,26 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 		*addrp = mfspr(SPRN_SDAR);
 }
 
+static bool mmcra_sihv(unsigned long mmcra)
+{
+	unsigned long sihv = MMCRA_SIHV;
+
+	if (ppmu->flags & PPMU_ALT_SIPR)
+		sihv = POWER6_MMCRA_SIHV;
+
+	return !!(mmcra & sihv);
+}
+
+static bool mmcra_sipr(unsigned long mmcra)
+{
+	unsigned long sipr = MMCRA_SIPR;
+
+	if (ppmu->flags & PPMU_ALT_SIPR)
+		sipr = POWER6_MMCRA_SIPR;
+
+	return !!(mmcra & sipr);
+}
+
 static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 {
 	if (regs->msr & MSR_PR)
@@ -128,8 +148,6 @@ static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	unsigned long mmcra = regs->dsisr;
-	unsigned long sihv = MMCRA_SIHV;
-	unsigned long sipr = MMCRA_SIPR;
 
 	/* Not a PMU interrupt: Make up flags from regs->msr */
 	if (TRAP(regs) != 0xf00)
@@ -156,15 +174,10 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 		return PERF_RECORD_MISC_USER;
 	}
 
-	if (ppmu->flags & PPMU_ALT_SIPR) {
-		sihv = POWER6_MMCRA_SIHV;
-		sipr = POWER6_MMCRA_SIPR;
-	}
-
 	/* PR has priority over HV, so order below is important */
-	if (mmcra & sipr)
+	if (mmcra_sipr(mmcra))
 		return PERF_RECORD_MISC_USER;
-	if ((mmcra & sihv) && (freeze_events_kernel != MMCR0_FCHV))
+	if (mmcra_sihv(mmcra) && (freeze_events_kernel != MMCR0_FCHV))
 		return PERF_RECORD_MISC_HYPERVISOR;
 	return PERF_RECORD_MISC_KERNEL;
 }
@@ -1340,6 +1353,14 @@ unsigned long perf_instruction_pointer(struct pt_regs *regs)
 	    !(mmcra & MMCRA_SAMPLE_ENABLE))
 		return regs->nip;
 
+	/*
+	 * With pipelining on P7, addresses in the SIAR can be off by several
+	 * instructions. For user space use the next instruction pointer as
+	 * that will be more accurate.
+	 */
+	if (mmcra_sipr(mmcra))
+		return regs->nip;
+
 	return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
 }
 
-- 
1.7.1
