Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C7D69DDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 20:55:58 +1000 (EST)
Date: Wed, 15 Aug 2007 20:55:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatches in udbg_adb.c
Message-Id: <20070815205557.724c5393.sfr@canb.auug.org.au>
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

The functions ae only called from __init functions.

WARNING: vmlinux.o(.text+0x45ed0): Section mismatch: reference to .init.text:.btext_find_display (between '.udbg_adb_init_early' and '.udbg_adb_init')
WARNING: vmlinux.o(.text+0x45f9c): Section mismatch: reference to .init.text:.btext_find_display (between '.udbg_adb_init' and '.udbg_adb_getc_poll')
WARNING: vmlinux.o(.text+0x46000): Section mismatch: reference to .init.text:.find_via_pmu (between '.udbg_adb_init' and '.udbg_adb_getc_poll')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/powermac/udbg_adb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/powermac/udbg_adb.c b/arch/powerpc/platforms/powermac/udbg_adb.c
index 6124e59..1f60f2a 100644
--- a/arch/powerpc/platforms/powermac/udbg_adb.c
+++ b/arch/powerpc/platforms/powermac/udbg_adb.c
@@ -150,7 +150,7 @@ static void udbg_adb_putc(char c)
 		return udbg_adb_old_putc(c);
 }
 
-void udbg_adb_init_early(void)
+void __init udbg_adb_init_early(void)
 {
 #ifdef CONFIG_BOOTX_TEXT
 	if (btext_find_display(1) == 0) {
@@ -160,7 +160,7 @@ void udbg_adb_init_early(void)
 #endif
 }
 
-int udbg_adb_init(int force_btext)
+int __init udbg_adb_init(int force_btext)
 {
 	struct device_node *np;
 
-- 
1.5.2.4
