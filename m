Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/xmon: Don't signal we've entered until we're
 finished printing
Date: Mon, 23 Dec 2013 23:46:06 +1100
Message-Id: <1387802766-7199-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1387802766-7199-1-git-send-email-mpe@ellerman.id.au>
References: <1387802766-7199-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we set our cpu's bit in cpus_in_xmon, and then we take the
output lock and print the exception information.

This can race with the master cpu entering the command loop and printing
the backtrace. The result is that the backtrace gets garbled with
another cpu's exception print out.

Fix it by delaying the set of cpus_in_xmon until we are finished
printing.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 051037e..b59f44f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -404,7 +404,6 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	}
 
 	xmon_fault_jmp[cpu] = recurse_jmp;
-	cpumask_set_cpu(cpu, &cpus_in_xmon);
 
 	bp = NULL;
 	if ((regs->msr & (MSR_IR|MSR_PR|MSR_64BIT)) == (MSR_IR|MSR_64BIT))
@@ -426,6 +425,8 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		release_output_lock();
 	}
 
+	cpumask_set_cpu(cpu, &cpus_in_xmon);
+
  waiting:
 	secondary = 1;
 	while (secondary && !xmon_gate) {
-- 
1.8.3.2
