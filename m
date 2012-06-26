Return-Path: <anton@samba.org>
Date: Tue, 26 Jun 2012 21:04:20 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com
Subject: [PATCH 4/4] powerpc/perf: Use perf_instruction_pointer in callchains
Message-ID: <20120626210420.4e5e7e78@kryten>
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


We use SIAR or regs->nip for the instruction pointer depending on
the PMU configuration, but we always use regs->nip in the callchain.

Use perf_instruction_pointer so the backtrace is consistent.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/perf/callchain.c
===================================================================
--- linux-build.orig/arch/powerpc/perf/callchain.c	2012-04-12 11:36:26.236223786 +1000
+++ linux-build/arch/powerpc/perf/callchain.c	2012-06-26 12:49:28.944202712 +1000
@@ -57,7 +57,7 @@ perf_callchain_kernel(struct perf_callch
 
 	lr = regs->link;
 	sp = regs->gpr[1];
-	perf_callchain_store(entry, regs->nip);
+	perf_callchain_store(entry, perf_instruction_pointer(regs));
 
 	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
 		return;
@@ -238,7 +238,7 @@ static void perf_callchain_user_64(struc
 	struct signal_frame_64 __user *sigframe;
 	unsigned long __user *fp, *uregs;
 
-	next_ip = regs->nip;
+	next_ip = perf_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
@@ -444,7 +444,7 @@ static void perf_callchain_user_32(struc
 	long level = 0;
 	unsigned int __user *fp, *uregs;
 
-	next_ip = regs->nip;
+	next_ip = perf_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
