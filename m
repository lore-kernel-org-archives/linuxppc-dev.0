Return-Path: <anton@samba.org>
Date: Tue, 26 Jun 2012 21:02:15 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com
Subject: [PATCH 3/4] powerpc/perf: Always use pt_regs for userspace samples
Message-ID: <20120626210215.639a1f8a@kryten>
In-Reply-To: <20120626210013.2fbb9044@kryten>
References: <20120626210013.2fbb9044@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


At the moment we always use the SIAR if the PMU supports continuous
sampling. Unfortunately the SIAR and the PMU exception are not
synchronised for non marked events so we can end up with callchains
that dont make sense.

The following patch checks the HV and PR bits for samples coming from
userspace and always uses pt_regs for them. Userspace will never have
interrupts off so there is no real advantage to using the SIAR for
non marked events in userspace.

I had experimented with a patch that did a similar thing for kernel
samples but we lost a significant amount of information. I was
unable to profile any of our early exception code for example.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/perf/core-book3s.c
===================================================================
--- linux-build.orig/arch/powerpc/perf/core-book3s.c	2012-06-26 10:45:12.402615339 +1000
+++ linux-build/arch/powerpc/perf/core-book3s.c	2012-06-26 10:51:25.465039364 +1000
@@ -189,9 +189,30 @@ static inline void perf_read_regs(struct
 	int marked = mmcra & MMCRA_SAMPLE_ENABLE;
 	int use_siar;
 
+	/*
+	 * If this isn't a PMU exception (eg a software event) the SIAR is
+	 * not valid. Use pt_regs.
+	 *
+	 * If it is a marked event use the SIAR.
+	 *
+	 * If the PMU doesn't update the SIAR for non marked events use
+	 * pt_regs.
+	 *
+	 * If the PMU has HV/PR flags then check to see if they
+	 * place the exception in userspace. If so, use pt_regs. In
+	 * continuous sampling mode the SIAR and the PMU exception are
+	 * not synchronised, so they may be many instructions apart.
+	 * This can result in confusing backtraces. We still want
+	 * hypervisor samples as well as samples in the kernel with
+	 * interrupts off hence the userspace check.
+	 */
 	if (TRAP(regs) != 0xf00)
 		use_siar = 0;
-	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING) && !marked)
+	else if (marked)
+		use_siar = 1;
+	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
+		use_siar = 0;
+	else if (!(ppmu->flags & PPMU_NO_SIPR) && mmcra_sipr(mmcra))
 		use_siar = 0;
 	else
 		use_siar = 1;
