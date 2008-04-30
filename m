Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f44ff2b979408240d97252ba337499191a5e2241.1209530824.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Fix crashkernel= handling when no crashkernel= specified
Date: Wed, 30 Apr 2008 14:47:12 +1000 (EST)
Cc: bwalle@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit edd8ce67436851a62f99f1d9707b40ea6a8e5323 (Use extended crashkernel
command line on ppc64), changed the logic in reserve_crashkernel()
which deals with the crashkernel= command line option.

This introduced a bug in the case when there is no crashkernel= option,
or it is incorrect. We would fallthrough and calculate the crash_size
based on the existing values in crashk_res. If both start and end are 0,
the default, we calculate the crash_size as 1 byte - which is wrong.

Rework the logic so that we use crashk_res, regardless of whether it's
set by the command line or via the device tree (see prom.c). Then check
if we have an empty range (end == start), and if so make sure to set
both end and start to zero (this is checked in machine_kexec_64.c). Then
we calculate the crash_size once we know we have a non-zero range.

Finally we always want to warn the user if they specify a base != 32MB,
so remove the special case for that in the command line parsing case.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/machine_kexec.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 2d202f2..29a0e03 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -74,20 +74,20 @@ void __init reserve_crashkernel(void)
 	ret = parse_crashkernel(boot_command_line, lmb_phys_mem_size(),
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size > 0) {
-		if (crash_base == 0)
-			crash_base = KDUMP_KERNELBASE;
 		crashk_res.start = crash_base;
-	} else {
-		/* handle the device tree */
-		crash_size = crashk_res.end - crashk_res.start + 1;
+		crashk_res.end = crash_base + crash_size - 1;
 	}
 
-	if (crash_size == 0)
+	if (crashk_res.end == crashk_res.start) {
+		crashk_res.start = crashk_res.end = 0;
 		return;
+	}
 
 	/* We might have got these values via the command line or the
 	 * device tree, either way sanitise them now. */
 
+	crash_size = crashk_res.end - crashk_res.start + 1;
+
 	if (crashk_res.start != KDUMP_KERNELBASE)
 		printk("Crash kernel location must be 0x%x\n",
 				KDUMP_KERNELBASE);
-- 
1.5.5
