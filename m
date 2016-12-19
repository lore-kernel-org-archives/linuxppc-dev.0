Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cT5TPvzDwPx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:49 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id w68so3191609pgw.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 10/10] powerpc: xmon wait for secondaries before sending IPI
Date: Tue, 20 Dec 2016 04:30:11 +1000
Message-Id: <20161219183011.28310-11-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An externally triggered system reset (e.g., via QEMU nmi command, or
pseries reset button) can cause system reset interrupts on all CPUs.
In case this causes xmon to be entered, it is undesirable for the primary
(first) CPU into xmon to trigger an NMI IPI to others, because this may
cause a nested system reset interrupt.

So spin for a time waiting for secondaries to join xmon before performing
the NMI IPI, similarly to what the crash dump code does.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 77a88319f494..9f88ec4af0b3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -516,14 +516,25 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		xmon_owner = cpu;
 		mb();
 		if (ncpus > 1) {
+			/*
+			 * system resets can be triggered on all CPUs, so
+			 * wait for others to come in and avoid the IPI. This
+			 * is similar to crash_kexec_secondary()
+			 */
+			for (timeout = 100000000; timeout != 0; --timeout) {
+				if (cpumask_weight(&cpus_in_xmon) >= ncpus)
+					goto got_cpus;
+				barrier();
+			}
 			smp_send_debugger_break();
 			/* wait for other cpus to come in */
 			for (timeout = 100000000; timeout != 0; --timeout) {
 				if (cpumask_weight(&cpus_in_xmon) >= ncpus)
-					break;
+					goto got_cpus;
 				barrier();
 			}
 		}
+got_cpus:
 		remove_bpts();
 		disable_surveillance();
 		/* for breakpoint or single step, print the current instr. */
-- 
2.11.0
