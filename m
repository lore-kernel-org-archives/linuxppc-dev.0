From: Joe Green <jgreen@mvista.com>
To: dony <dony.he@huawei.com.cn>, Dan Malek <dan@netx4.com>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Does mpc8xx-2.2.13 support "Enable loadable module support"?
Date: Tue, 21 Mar 2000 17:54:30 -0800
Content-Type: text/plain
References: <NCBBKJKKGDLPHKDPAFFMMEIPCDAA.jsw-embedded@mindspring.com> <38D6E781.884AA846@embeddededge.com> <38D8236B.C27DE94B@huawei.com.cn>
In-Reply-To: <38D8236B.C27DE94B@huawei.com.cn>
MIME-Version: 1.0
Message-Id: <00032117584900.03592@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 21 Mar 2000, dony wrote:
>      If I compile the kernel without "Enable loadable module support" , then it
> works successfully. But if  I do again with "Enable loadable module support", then
> some errors occur:
> Does someone know why?

Here's a patch I believe should fix these problems.  Let me know if you
have any problems with it.  This is based on the Hard Hat Linux kernel
we ship, so there may be some differences from the tree you have (hope
not).

--- linux.old/arch/ppc/kernel/ppc8xx_pic.c	Tue Mar 21 02:03:06 2000
+++ linux/arch/ppc/kernel/ppc8xx_pic.c	Tue Mar 21 17:42:58 2000
@@ -148,4 +148,15 @@
 	irq += i8259_pic.irq_offset;
 	return (request_8xxirq(irq, handler, irqflags, devname, dev_id));
 }
-#endif
+#else /* CONFIG_MBX */
+int request_irq(
+	unsigned int irq,
+	void (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char * devname,
+	void *dev_id
+)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_MBX */
--- linux.old/arch/ppc/kernel/ppc_ksyms.c	Wed Oct 20 00:14:00 1999
+++ linux/arch/ppc/kernel/ppc_ksyms.c	Tue Mar 21 18:31:02 2000
@@ -69,14 +69,18 @@
 EXPORT_SYMBOL(ppc_local_irq_count);
 EXPORT_SYMBOL(ppc_local_bh_count);

+#ifdef CONFIG_PCI
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
+#endif /* CONFIG_PCI */
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
+#endif /* CONFIG_8xx */

 EXPORT_SYMBOL(atomic_add);
 EXPORT_SYMBOL(atomic_sub);
@@ -181,18 +185,21 @@
 EXPORT_SYMBOL(_machine);
 EXPORT_SYMBOL(ppc_md);

+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(adb_request);
 EXPORT_SYMBOL(adb_register);
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
+#endif /* CONFIG_8xx */
 #ifdef CONFIG_PMAC_PBOOK
 EXPORT_SYMBOL(pmu_register_sleep_notifier);
 EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
 EXPORT_SYMBOL(pmu_enable_irled);
 #endif CONFIG_PMAC_PBOOK
 EXPORT_SYMBOL(abort);
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(find_devices);
 EXPORT_SYMBOL(find_type_devices);
 EXPORT_SYMBOL(find_compatible_devices);
@@ -204,6 +211,7 @@
 EXPORT_SYMBOL(feature_set);
 EXPORT_SYMBOL(feature_clear);
 EXPORT_SYMBOL(feature_test);
+#endif /* CONFIG_8xx */
 #ifdef CONFIG_SCSI
 EXPORT_SYMBOL(note_scsi_host);
 #endif
@@ -214,7 +222,9 @@
 #endif /* CONFIG_PMAC */

 EXPORT_SYMBOL(abs);
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(device_is_compatible);
+#endif /* CONFIG_8xx */

 EXPORT_SYMBOL_NOVERS(__ashrdi3);
 EXPORT_SYMBOL_NOVERS(__lshrdi3);
--- linux.old/drivers/macintosh/Makefile	Thu Apr 29 19:53:48 1999
+++ linux/drivers/macintosh/Makefile	Tue Mar 21 18:21:04 2000
@@ -15,7 +15,7 @@
 L_TARGET := macintosh.a
 M_OBJS   :=

-ifndef CONFIG_MBX
+ifndef CONFIG_8xx
 L_OBJS   := via-cuda.o macio-adb.o via-pmu.o mediabay.o
 LX_OBJS  := adb.o
 endif


--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
