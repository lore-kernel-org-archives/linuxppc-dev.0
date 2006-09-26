Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D690667BC1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 15:07:24 +1000 (EST)
Date: Tue, 26 Sep 2006 00:06:16 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] iSeries has no legacy I/O
Message-ID: <20060926000616.5ece9149@pb15>
In-Reply-To: <20060926135721.50f7f1b0.sfr@canb.auug.org.au>
References: <20060926135721.50f7f1b0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Sep 2006 13:57:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> +/*
> + * iSeries has no legacy IO, anything calling this function has to
> + * fail or bad things will happen
> + */
> +static int iseries_check_legacy_ioport(unsigned int baseport)

Ok, I was the third platform that needed this, you're fourth. How about
we just switch the default to assume legacy ioports not being allowed?

This will break floppy and 8042 on platforms that previously did not
define it and relied on the default being that it was allowed. I'm not
sure which ones that would be?  Getting it in early would give us
plenty of time to deal with fallout, if any.





Every single platform that lacks legacy ports has to define a dummy
check_legacy_ioport() or else things will blow up since default is
to allow the accesses.  Instead, default to legacy io ports not being
supported unless the platform defines the function and returns 0 from it.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6/arch/powerpc/platforms/cell/setup.c
@@ -155,15 +155,6 @@ static int __init cell_probe(void)
 	return 1;
 }
 
-/*
- * Cell has no legacy IO; anything calling this function has to
- * fail or bad things will happen
- */
-static int cell_check_legacy_ioport(unsigned int baseport)
-{
-	return -ENODEV;
-}
-
 define_machine(cell) {
 	.name			= "Cell",
 	.probe			= cell_probe,
@@ -177,7 +168,6 @@ define_machine(cell) {
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.check_legacy_ioport	= cell_check_legacy_ioport,
 	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
 	.pcibios_fixup		= cell_pcibios_fixup,
Index: linux-2.6/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/setup.c
+++ linux-2.6/arch/powerpc/platforms/pasemi/setup.c
@@ -93,12 +93,6 @@ static void __init pas_init_early(void)
 	pci_direct_iommu_init();
 }
 
-/* No legacy IO on our parts */
-static int pas_check_legacy_ioport(unsigned int baseport)
-{
-	return -ENODEV;
-}
-
 static __init void pas_init_IRQ(void)
 {
 	struct device_node *np;
@@ -183,6 +177,5 @@ define_machine(pas) {
 	.halt			= pas_halt,
 	.get_boot_time		= pas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.check_legacy_ioport    = pas_check_legacy_ioport,
 	.progress		= pas_progress,
 };
Index: linux-2.6/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/setup.c
+++ linux-2.6/arch/powerpc/platforms/powermac/setup.c
@@ -615,14 +615,6 @@ static void __init pmac_init_early(void)
 #endif
 }
 
-/*
- * pmac has no legacy IO, anything calling this function has to
- * fail or bad things will happen
- */
-static int pmac_check_legacy_ioport(unsigned int baseport)
-{
-	return -ENODEV;
-}
 
 static int __init pmac_declare_of_platform_devices(void)
 {
@@ -737,7 +729,6 @@ define_machine(powermac) {
 	.get_rtc_time		= pmac_get_rtc_time,
 	.calibrate_decr		= pmac_calibrate_decr,
 	.feature_call		= pmac_do_feature_call,
-	.check_legacy_ioport	= pmac_check_legacy_ioport,
 	.progress		= udbg_progress,
 #ifdef CONFIG_PPC64
 	.pci_probe_mode		= pmac_pci_probe_mode,
Index: linux-2.6/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6/arch/powerpc/kernel/setup-common.c
@@ -523,8 +523,8 @@ void probe_machine(void)
 
 int check_legacy_ioport(unsigned long base_port)
 {
-	if (ppc_md.check_legacy_ioport == NULL)
-		return 0;
+	if (!ppc_md.check_legacy_ioport)
+		return -ENODEV;
 	return ppc_md.check_legacy_ioport(base_port);
 }
 EXPORT_SYMBOL(check_legacy_ioport);
