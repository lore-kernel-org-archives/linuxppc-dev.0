Date: Mon, 31 Jan 2000 19:18:46 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Modular kernels
Message-ID: <Pine.LNX.4.21.0001311915410.10514-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

This patch (against 2.2.13) makes it possible to compile modular kernels
at least for RPX. It also removes a lot of Macintosh-related code from
kernels for 8xx boards other than MBX.

Pavel Roskin

=== cut here ===
Index: arch/ppc/kernel/ppc_ksyms.c
===================================================================
RCS file: /home/6cmr/kernel/arch/ppc/kernel/ppc_ksyms.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ppc_ksyms.c
--- arch/ppc/kernel/ppc_ksyms.c	2000/01/03 20:10:38	1.1.1.1
+++ arch/ppc/kernel/ppc_ksyms.c	2000/01/18 20:38:02
@@ -69,14 +69,18 @@
 EXPORT_SYMBOL(ppc_local_irq_count);
 EXPORT_SYMBOL(ppc_local_bh_count);

+#ifdef CONFIG_PCI
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
+#endif
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
+#endif

 EXPORT_SYMBOL(atomic_add);
 EXPORT_SYMBOL(atomic_sub);
@@ -181,29 +185,37 @@
 EXPORT_SYMBOL(_machine);
 EXPORT_SYMBOL(ppc_md);

+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(adb_request);
 EXPORT_SYMBOL(adb_register);
 EXPORT_SYMBOL(cuda_request);
 EXPORT_SYMBOL(cuda_poll);
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
+#endif
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
 EXPORT_SYMBOL(find_path_device);
 EXPORT_SYMBOL(find_phandle);
 EXPORT_SYMBOL(get_property);
+#endif
+#ifdef CONFIG_PCI
 EXPORT_SYMBOL(pci_io_base);
 EXPORT_SYMBOL(pci_device_loc);
+#endif
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(feature_set);
 EXPORT_SYMBOL(feature_clear);
 EXPORT_SYMBOL(feature_test);
+#endif
 #ifdef CONFIG_SCSI
 EXPORT_SYMBOL(note_scsi_host);
 #endif
@@ -214,7 +226,9 @@
 #endif /* CONFIG_PMAC */

 EXPORT_SYMBOL(abs);
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(device_is_compatible);
+#endif

 EXPORT_SYMBOL_NOVERS(__ashrdi3);
 EXPORT_SYMBOL_NOVERS(__lshrdi3);
Index: drivers/macintosh/Makefile
===================================================================
RCS file: /home/6cmr/kernel/drivers/macintosh/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- drivers/macintosh/Makefile	2000/01/03 20:10:47	1.1.1.1
+++ drivers/macintosh/Makefile	2000/01/18 20:38:02
@@ -15,7 +15,7 @@
 L_TARGET := macintosh.a
 M_OBJS   :=

-ifndef CONFIG_MBX
+ifndef CONFIG_8xx
 L_OBJS   := via-cuda.o macio-adb.o via-pmu.o mediabay.o
 LX_OBJS  := adb.o
 endif
Index: kernel/ksyms.c
===================================================================
RCS file: /home/6cmr/kernel/kernel/ksyms.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ksyms.c
--- kernel/ksyms.c	2000/01/03 20:11:04	1.1.1.1
+++ kernel/ksyms.c	2000/01/18 20:38:04
@@ -275,7 +275,9 @@
 EXPORT_SYMBOL(proc_dointvec_minmax);

 /* interrupt handling */
+#ifndef CONFIG_8xx
 EXPORT_SYMBOL(request_irq);
+#endif
 EXPORT_SYMBOL(free_irq);
 EXPORT_SYMBOL(probe_irq_on);
 EXPORT_SYMBOL(probe_irq_off);
=== cut here ===


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
