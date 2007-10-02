Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED904DDECC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:18:52 +1000 (EST)
Date: Tue, 02 Oct 2007 17:18:46 +0900 (JST)
Message-Id: <20071002.171846.-1350507483.kouish@swc.toshiba.co.jp>
Subject: [PATCH 1/5] Celleb: Move pause, kexec_cpu_down to beat.c
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is an update for "Beat on Celleb"
  - Move beat_pause(), beat_kexec_cpu_down() from setup.c to beat.c

Signed-off-by: <Kou.Ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/beat.h
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.h
@@ -36,5 +36,7 @@ ssize_t beat_nvram_get_size(void);
 ssize_t beat_nvram_read(char *, size_t, loff_t *);
 ssize_t beat_nvram_write(char *, size_t, loff_t *);
 int beat_set_xdabr(unsigned long);
+void beat_power_save(void);
+void beat_kexec_cpu_down(int, int);
 
 #endif /* _CELLEB_BEAT_H */
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
@@ -111,11 +111,6 @@ static void __init celleb_setup_arch(voi
 #endif
 }
 
-static void beat_power_save(void)
-{
-	beat_pause(0);
-}
-
 static int __init celleb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -128,13 +123,6 @@ static int __init celleb_probe(void)
 	return 1;
 }
 
-#ifdef CONFIG_KEXEC
-static void celleb_kexec_cpu_down(int crash, int secondary)
-{
-	beatic_deinit_IRQ();
-}
-#endif
-
 static struct of_device_id celleb_bus_ids[] __initdata = {
 	{ .type = "scc", },
 	{ .type = "ioif", },	/* old style */
@@ -175,7 +163,7 @@ define_machine(celleb) {
 	.pci_probe_mode 	= celleb_pci_probe_mode,
 	.pci_setup_phb		= celleb_setup_phb,
 #ifdef CONFIG_KEXEC
-	.kexec_cpu_down		= celleb_kexec_cpu_down,
+	.kexec_cpu_down		= beat_kexec_cpu_down,
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
 	.machine_crash_shutdown	= default_machine_crash_shutdown,
Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/beat.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat.c
@@ -158,6 +158,18 @@ int64_t beat_put_term_char(u64 vterm, u6
 	return beat_put_characters_to_console(vterm, len, (u8*)db);
 }
 
+void beat_power_save(void)
+{
+	beat_pause(0);
+}
+
+#ifdef CONFIG_KEXEC
+void beat_kexec_cpu_down(int crash, int secondary)
+{
+	beatic_deinit_IRQ();
+}
+#endif
+
 EXPORT_SYMBOL(beat_get_term_char);
 EXPORT_SYMBOL(beat_put_term_char);
 EXPORT_SYMBOL(beat_halt_code);
