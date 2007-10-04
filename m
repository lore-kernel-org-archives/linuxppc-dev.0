Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0A65EDDE27
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 12:00:41 +1000 (EST)
Date: Thu, 4 Oct 2007 12:00:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove some section mismatch warnings
Message-Id: <20071004120028.4744b797.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From g5_defconfig:
WARNING: vmlinux.o(.text+0x2ff5c): Section mismatch: reference to .init.text:.pmac_find_ide_boot (between '.note_bootable_part' and '.note_scsi_host')

>From holly_defconfig:
WARNING: vmlinux.o(.text+0x164fe): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')
WARNING: vmlinux.o(.text+0x16506): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')

>From linkstation_defconfig:
WARNING: vmlinux.o(.text+0x158fe): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')
WARNING: vmlinux.o(.text+0x15906): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')

>From mpc7448_hpc2_defconfig:
WARNING: vmlinux.o(.text+0x1583e): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')
WARNING: vmlinux.o(.text+0x15846): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')

>From pmac32_defconfig:
WARNING: vmlinux.o(.text+0x154ca): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'note_scsi_host')
WARNING: vmlinux.o(.text+0x154d2): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'note_scsi_host')
WARNING: vmlinux.o(.text+0x1553c): Section mismatch: reference to .init.text:pmac_find_ide_boot (between 'note_bootable_part' and 'note_scsi_host')

>From ppc64_defconfig:
WARNING: vmlinux.o(.text+0x3acdc): Section mismatch: reference to .init.text:.pmac_find_ide_boot (between '.note_bootable_part' and '.note_scsi_host')

>From prpmc2800_defconfig:
WARNING: vmlinux.o(.text+0x1611e): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')
WARNING: vmlinux.o(.text+0x16126): Section mismatch: reference to .init.data:boot_command_line (between 'note_bootable_part' and 'find_via_pmu')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/powermac/setup.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 7ccb923..840f5b4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -466,8 +466,13 @@ static int pmac_late_init(void)
 
 late_initcall(pmac_late_init);
 
-/* can't be __init - can be called whenever a disk is first accessed */
-void note_bootable_part(dev_t dev, int part, int goodness)
+/*
+ * This is __init_refok because we check for "initializing" before
+ * touching any of the __init sensitive things and "initializing"
+ * will be false after __init time. This can't be __init because it
+ * can be called whenever a disk is first accessed.
+ */
+void __init_refok note_bootable_part(dev_t dev, int part, int goodness)
 {
 	static int found_boot = 0;
 	char *p;
-- 
1.5.3.3
