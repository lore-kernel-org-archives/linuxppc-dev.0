Return-Path: <Emilian.Medve@Freescale.com>
From: Emil Medve <Emilian.Medve@Freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] [POWERPC] Fix return value check logic
Date: Thu, 22 May 2008 14:49:22 -0500
Message-Id: <1211485762-29637-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

debugfs_create_file() return a non-NULL (non-zero) value in case of success

This fixes this non-critical boot-time debuging error message:

[    1.316386] calling  irq_debugfs_init+0x0/0x50
[    1.316399] initcall irq_debugfs_init+0x0/0x50 returned -12 after 0 msecs
[    1.316411] initcall irq_debugfs_init+0x0/0x50 returned with error code -12

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

$ scripts/checkpatch.pl 0001--POWERPC-Fix-return-value-check-logic.patch 
total: 0 errors, 0 warnings, 8 lines checked

0001--POWERPC-Fix-return-value-check-logic.patch has no obvious style problems and is ready for submission.

 arch/powerpc/kernel/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2f73f70..bcc249d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -1073,7 +1073,7 @@ static const struct file_operations virq_debug_fops = {
 static int __init irq_debugfs_init(void)
 {
 	if (debugfs_create_file("virq_mapping", S_IRUGO, powerpc_debugfs_root,
-				 NULL, &virq_debug_fops))
+				 NULL, &virq_debug_fops) == NULL)
 		return -ENOMEM;
 
 	return 0;
-- 
1.5.5.GIT
