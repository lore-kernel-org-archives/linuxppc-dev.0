Subject: RE: Module support for 8260 in 2.4(.1) kernel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 20 Apr 2001 14:26:00 -0500
Message-ID: <CD5CA14300A9D54A8D13D58CD3C87B422DD732@advcorp-exc01.advent.com>
From: "Oliver Brown" <obrown@adventnetworks.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "linuxppc-embedded List" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This diff was against a ppc_ksyms.c from kernel.org 2.4.1 tree. Below is
a unified diff. I'll try and add the __udelay to the exports.

Regards,
Oliver Brown

+++ ppc_ksyms.c	Fri Apr 20 12:16:28 2001
@@ -42,10 +42,15 @@
 #ifdef CONFIG_SMP
 #include <asm/smplock.h>
 #include <asm/smp.h>
 #endif /* CONFIG_SMP */
 #include <asm/time.h>
+/* exporting 8260 sysmbols for modules - OFB */
+#ifdef CONFIG_8260
+#include <asm/cpm_8260.h>
+#include <asm/mpc8260.h>
+#endif /* CONFIG_8260 - OFB */

 /* Tell string.h we don't want memcpy etc. as cpp defines */
 #define EXPORT_SYMTAB_STROPS

 extern void transfer_to_handler(void);
@@ -85,25 +90,42 @@
 EXPORT_SYMBOL(probe_irq_mask);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(kernel_flag);
 #endif /* CONFIG_SMP */

-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+/* Added CONFIG_8260 to exclude symbols below - OFB */
+#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) &&
!defined(CONFIG_8260)
 EXPORT_SYMBOL_NOVERS(isa_io_base);
 EXPORT_SYMBOL_NOVERS(isa_mem_base);
 EXPORT_SYMBOL_NOVERS(pci_dram_offset);
 #endif
+
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
 #ifndef CONFIG_8xx
 #if defined(CONFIG_ALL_PPC)
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
 #endif
 #endif

+/* exporting CPM symbols for modules - OFB */
+#ifdef CONFIG_8260
+EXPORT_SYMBOL(cpmp);
+EXPORT_SYMBOL(m8260_cpm_hostalloc);
+EXPORT_SYMBOL(m8260_cpm_dpalloc);
+EXPORT_SYMBOL(m8260_cpm_setbrg);
+EXPORT_SYMBOL(m8260_cpm_fastbrg);
+EXPORT_SYMBOL(__res);
+#endif /* CONFIG_8260 */
+
+/* exporting symbols for modules - OFB */
+#if (defined(CONFIG_8260) || defined(CONFIG_8xx))
+EXPORT_SYMBOL(request_8xxirq);
+#endif /* (defined(CONFIG_8260) || defined(CONFIG_8xx)) - OFB */
+
 #if !__INLINE_BITOPS
 EXPORT_SYMBOL(set_bit);
 EXPORT_SYMBOL(clear_bit);
 EXPORT_SYMBOL(change_bit);
 EXPORT_SYMBOL(test_and_set_bit);
@@ -239,11 +261,15 @@
 EXPORT_SYMBOL(get_backlight_level);
 EXPORT_SYMBOL(set_backlight_level);
 EXPORT_SYMBOL(set_backlight_enable);
 EXPORT_SYMBOL(register_backlight_controller);
 #endif /* CONFIG_PMAC_BACKLIGHT */
+
+#ifdef CONFIG_ALL_PPC
 EXPORT_SYMBOL_NOVERS(sys_ctrler);
+#endif /* CONFIG_ALL_PPC */
+
 #ifndef CONFIG_MACH_SPECIFIC
 EXPORT_SYMBOL_NOVERS(have_of);
 #endif /* CONFIG_MACH_SPECIFIC */
 #if defined(CONFIG_ALL_PPC)
 EXPORT_SYMBOL(find_devices);
@@ -277,11 +303,15 @@
 EXPORT_SYMBOL(bootx_update_display);
 #endif
 #if defined(CONFIG_SCSI) && defined(CONFIG_ALL_PPC)
 EXPORT_SYMBOL(note_scsi_host);
 #endif
+
+#ifdef CONFIG_VT
 EXPORT_SYMBOL(kd_mksound);
+#endif /* CONFIG_VT */
+
 #ifdef CONFIG_NVRAM
 EXPORT_SYMBOL(nvram_read_byte);
 EXPORT_SYMBOL(nvram_write_byte);
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);
@@ -344,11 +374,12 @@
 EXPORT_SYMBOL(ret_to_user_hook);
 EXPORT_SYMBOL(do_softirq);
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
 EXPORT_SYMBOL(mmu_context_overflow);
-#if !defined(CONFIG_8xx) && !defined(CONFIG_4xx)
+/* Added CONFIG_8260 -OFB */
+#if !defined(CONFIG_8xx) && !defined(CONFIG_4xx) &&
!defined(CONFIG_8260)
 extern long *intercept_table;
 EXPORT_SYMBOL(intercept_table);
 #endif
 extern long *ret_from_intercept;
 EXPORT_SYMBOL(ret_from_intercept);

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Friday, April 20, 2001 2:03 PM
To: Oliver Brown
Cc: linuxppc-embedded List
Subject: Re: Module support for 8260 in 2.4(.1) kernel


On Fri, Apr 20, 2001 at 01:51:00PM -0500, Oliver Brown wrote:

> I am working on loadable driver modules for the 8260. I had to make
the
> changes below to the ppc_ksyms.c file to export the symbols in needed.
>
> The problems I am having are
> 1. The udelay marco is not exportable. Is there a substitute? For now
I
> am using __delay() which is not a constant delay.

Er, you should be able to at least kludge around this and use __udelay
which skips the macro (which just does sanity checks).

> 2. The m8260_cpm_hostalloc() and m8260_cpm_dpalloc do not have
deallocs.
> I can load my module, but I can't unload it.
>
> I've added an init_module and cleanup_module to the fcc_enet.c from
> (bitkeeper 2.5 tree). Also, I had to replace all of the udelay()'s
with
> __delay()'s. And I've diabled the MDIO PHY support.

Er, what tree is this vs exactly?  Also, can you send a unified diff
next time?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
