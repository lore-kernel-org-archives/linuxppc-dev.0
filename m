To: Ruedi Hofer <ruedi.hofer@ascom.ch>
Cc: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Subject: Re: PCMCIA support for 860
References: <38E9D766.28A0BD27@ascom.ch>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 04 Apr 2000 15:23:56 +0200
In-Reply-To: Ruedi Hofer's message of "Tue, 04 Apr 2000 13:52:06 +0200"
Message-ID: <kfyd7o6vw2b.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi Hofer <ruedi.hofer@ascom.ch> writes:

> Hi
>
> Well, I found out that I have to add in kernel/ksyms.c the line
> EXPORT_SYMBOL(request_irq);
>
> Now I'm able to load the different kernel modules, but
>
> sh-2.03#
> sh-2.03# insmod pcmcia_core
> Linux PCMCIA Card Services 3.1.10
>   kernel build: 2.2.13 #85 Tue Apr 4 10:26:49 CEST 2000
>   options:  none
> sh-2.03# insmod m8xx_pcmcia
> m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
> m8xx_pcmcia: ADS using SLOT_A with IRQ 13.
> sh-2.03# insmod ds
> sh-2.03# insmod ide_cs
> /lib/modules/2.2.13/pcmcia/ide_cs.o: unresolved symbol ide_unregister
> /lib/modules/2.2.13/pcmcia/ide_cs.o: unresolved symbol ide_register
> sh-2.03#
>
> ... I can't add the module ide_cs. For that reason, do I have to
> enable 'Enhanced IDE support' in the kernel options??

Yes, if you want to use ATA flash disks you must do that. Also note
that I haven't got the IDE code to run as modules, so you'll have to
compile it into the kernel.

> If I do so, I get the following compile errors:
>
> m8xx_setup.c: In function `m8xx_init_IRQ':
> m8xx_setup.c:286: warning: implicit declaration of function `cpm_interrupt_init'
> m8xx_setup.c: In function `m8xx_ide_init_hwif_ports':
> m8xx_setup.c:390: warning: unused variable `port'
> m8xx_setup.c: In function `m8xx_init':
> m8xx_setup.c:522: structure has no member named `ide_request_irq'
> make[1]: *** [m8xx_setup.o] Error 1
> make[1]: Leaving directory
> `/usr/src/linux-mpc8xx-2.2.13-damm-bossek-fpu-pcmcia/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2

The IDE support in Dan's 2.2.13 isn't uptodate.

This first diff puts it in sync with the rest of the kernel:

diff -u -r1.1 -r1.2
--- Config.in	2000/01/11 18:13:30	1.1
+++ Config.in	2000/01/11 18:21:02	1.2
@@ -21,4 +21,8 @@

 bool 'RPX-Lite 823(e) LCD Frame Buffer' CONFIG_RPXLCD

+if [ "$CONFIG_BLK_DEV_IDE" = "y" ]; then
+ bool 'Configure IDE driver for ATA on PCMCIA' CONFIG_IDE_ATA_FLASH
+fi
+
 endmenu
diff -u -u -r1.1 -r1.2
--- m8xx_setup.c	2000/01/11 18:13:31	1.1
+++ m8xx_setup.c	2000/01/11 18:28:29	1.2
@@ -160,7 +160,7 @@
 	fp = (binfo->bi_intfreq * 1000000) / 16;
 	freq = fp*60;	/* try to make freq/1e6 an integer */
         divisor = 60;
-        printk("time_init: decrementer frequency = %d/%d\n", freq, divisor);
+        printk("Decrementer frequency: %d/%d\n", freq, divisor);
         decrementer_count = freq / HZ / divisor;
         count_period_num = divisor;
         count_period_den = freq / 1000000;
@@ -300,17 +300,13 @@

 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)

-/* Define this to make a PCMCIA ATA Flash card work.
-*/
-#define ATA_FLASH 1
-
 /*
  * IDE stuff.
  */
 void
 m8xx_ide_insw(ide_ioreg_t port, void *buf, int ns)
 {
-#ifdef ATA_FLASH
+#ifdef CONFIG_IDE_ATA_FLASH
 	ide_insw(port, buf, ns);
 #else
 	ide_insw(port+_IO_BASE, buf, ns);
@@ -320,7 +316,7 @@
 void
 m8xx_ide_outsw(ide_ioreg_t port, void *buf, int ns)
 {
-#ifdef ATA_FLASH
+#ifdef CONFIG_IDE_ATA_FLASH
 	ide_outsw(port, buf, ns);
 #else
 	ide_outsw(port+_IO_BASE, buf, ns);
@@ -330,7 +326,7 @@
 int
 m8xx_ide_default_irq(ide_ioreg_t base)
 {
-#ifdef ATA_FLASH
+#ifdef CONFIG_IDE_ATA_FLASH
 	return PCMCIA_INTERRUPT;
 #else
         return 14;
@@ -362,20 +358,6 @@
 {
 }

-int
-m8xx_ide_request_irq(unsigned int irq,
-		       void (*handler)(int, void *, struct pt_regs *),
-		       unsigned long flags,
-		       const char *device,
-		       void *dev_id)
-{
-#ifdef ATA_FLASH
-	return request_8xxirq(irq, handler, flags, device, dev_id);
-#else
-	return request_irq(irq, handler, flags, device, dev_id);
-#endif
-}
-
 void
 m8xx_ide_fix_driveid(struct hd_driveid *id)
 {
@@ -389,11 +371,11 @@
 {
 	ide_ioreg_t port = base;
 	int i;
-#ifdef ATA_FLASH
+#ifdef CONFIG_IDE_ATA_FLASH
 	volatile pcmconf8xx_t	*pcmp;
 #endif

-#ifdef ATA_FLASH
+#ifdef CONFIG_IDE_ATA_FLASH
 	*p = 0;
 	*irq = 0;

@@ -406,6 +388,14 @@

 	base = (unsigned long) ioremap(PCMCIA_MEM_ADDR, 0x200);

+#if defined(CONFIG_ADS) || defined(CONFIG_FADS)
+	pcmp->pcmc_pbr0 = PCMCIA_MEM_ADDR;
+	pcmp->pcmc_por0 = 0xc00ff051;  // 16bit access - read CIS
+	pcmp->pcmc_pgcra = 0;
+	pcmp->pcmc_pgcrb = 0;
+	pcmp->pcmc_por0 = 0xc00ff041;  // mem-mapped
+#endif
+
 	/* For the M-Systems ATA card, the first 8 registers map 1:1.
 	 * The following register, control/Altstatus, is located at 0x0e.
 	 * Following that, the irq offset, is not used, so we place it in
@@ -519,7 +509,6 @@
         ppc_ide_md.release_region = m8xx_ide_release_region;
         ppc_ide_md.fix_driveid = m8xx_ide_fix_driveid;
         ppc_ide_md.ide_init_hwif = m8xx_ide_init_hwif_ports;
-        ppc_ide_md.ide_request_irq = m8xx_ide_request_irq;

         ppc_ide_md.io_base = _IO_BASE;
 #endif

Note that you must say _no_ to 'Configure IDE driver for ATA on PCMCIA'
to use the pcmcia-cs package.

This second diff is required to use ATA flash disks, but may break
support for normal IDE controllers on some other bus:

diff -u -b -u -r1.7 -r1.9
--- m8xx_setup.c	2000/03/17 16:17:44	1.7
+++ m8xx_setup.c	2000/03/29 19:14:17	1.9
@@ -379,7 +379,7 @@
 /* We can use an external IDE controller or wire the IDE interface to
  * the internal PCMCIA controller.
  */
-void __init m8xx_ide_init_hwif_ports(ide_ioreg_t *p, ide_ioreg_t base, int *irq)
+void m8xx_ide_init_hwif_ports(ide_ioreg_t *p, ide_ioreg_t base, int *irq)
 {
 	ide_ioreg_t port = base;
 	int i;
@@ -434,10 +434,23 @@

 	/* Just a regular IDE drive on some I/O port.
 	*/
+#if 1
+	if (base < MAX_HWIFS) {
+		/* Don't try to probe for IDE controllers. */
+		*p = 0;
+		*irq = 0;
+		return;
+	}
+#endif
 	i = 8;
 	while (i--)
 		*p++ = port++;
+#if 1
+	*p++ = base + 0x0e;
+	*p++ = base + 0x0a;
+#else
 	*p++ = base + 0x206;
+#endif
 	if (irq != NULL)
 		*irq = 0;
 #endif

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
