Date: Fri, 13 Jun 2003 14:10:06 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: redwood-5 compile fixes for linuxppc-2.5
Message-ID: <20030613121005.GA1839@codeblau.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a small diff that makes the kernel compile for me.  Can't say
whether it works, but at least it compiles ;-)

If anyone is working with such a board, please contact me!

Felix


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ppc-diff

--- linuxppc-2.5/drivers/net/Kconfig	2003-06-12 15:22:51.000000000 +0200
+++ linuxppc-2.5-fefe/drivers/net/Kconfig	2003-06-13 10:34:59.000000000 +0200
@@ -868,6 +868,25 @@
 	  module, say M here and read <file:Documentation/modules.txt> as well
 	  as <file:Documentation/networking/net-modules.txt>.

+config SMC91111
+	tristate "SMC 91111 support"
+
+config SMC91111_ADVANCED
+	bool "  Advanced configuration options for SMC91111"
+	depends on SMC91111
+
+config SMC91111_BYTE_SWAP
+	bool "      Byte swap device accesses"
+	depends on SMC91111
+
+config SMC91111_USE_8_BIT
+	bool "      Allow 8 bit device accesses"
+	depends on SMC91111
+
+config SMC91111_USE_32_BIT
+	bool "      Allow 32 bit device accesses"
+	depends on SMC91111
+
 config NET_VENDOR_RACAL
 	bool "Racal-Interlan (Micom) NI cards"
 	depends on NET_ETHERNET && ISA
--- linuxppc-2.5/drivers/net/Makefile	2003-06-12 15:21:54.000000000 +0200
+++ linuxppc-2.5-fefe/drivers/net/Makefile	2003-06-13 10:35:18.000000000 +0200
@@ -76,6 +76,7 @@
 obj-$(CONFIG_SK_G16) += sk_g16.o
 obj-$(CONFIG_HP100) += hp100.o
 obj-$(CONFIG_SMC9194) += smc9194.o
+obj-$(CONFIG_SMC91111) += smc91111.o
 obj-$(CONFIG_FEC) += fec.o
 obj-$(CONFIG_68360_ENET) += 68360enet.o
 obj-$(CONFIG_ARM_ETHERH) += 8390.o
--- linuxppc-2.5/include/linux/pci.h	2003-06-12 15:22:13.000000000 +0200
+++ linuxppc-2.5-fefe/include/linux/pci.h	2003-06-13 10:56:42.000000000 +0200
@@ -806,9 +806,11 @@
  * configuration space.
  */

+#ifdef CONFIG_PCI
 #ifndef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 #endif
+#endif

 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
--- linuxppc-2.5/arch/ppc/kernel/ppc_ksyms.c	2003-06-12 15:22:53.000000000 +0200
+++ linuxppc-2.5-fefe/arch/ppc/kernel/ppc_ksyms.c	2003-06-13 11:10:07.000000000 +0200
@@ -273,8 +273,10 @@
 #ifdef CONFIG_NVRAM
 EXPORT_SYMBOL(nvram_read_byte);
 EXPORT_SYMBOL(nvram_write_byte);
+#ifdef CONFIG_PMAC
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);
+#endif
 #endif /* CONFIG_NVRAM */
 EXPORT_SYMBOL(to_tm);

--- linuxppc-2.5/arch/ppc/kernel/misc.S	2003-06-12 15:22:54.000000000 +0200
+++ linuxppc-2.5-fefe/arch/ppc/kernel/misc.S	2003-06-13 11:14:36.000000000 +0200
@@ -1324,9 +1324,15 @@
 	.long sys_stat64	/* 195 */
 	.long sys_lstat64
 	.long sys_fstat64
+#ifdef CONFIG_PCI
 	.long sys_pciconfig_read
 	.long sys_pciconfig_write
 	.long sys_pciconfig_iobase 	/* 200 */
+#else
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+#endif
 	.long sys_ni_syscall		/* 201 - reserved - MacOnLinux - new */
 	.long sys_getdents64
 	.long sys_pivot_root
--- linuxppc-2.5/arch/ppc/boot/simple/misc-embedded.c	2003-06-12 15:21:49.000000000 +0200
+++ linuxppc-2.5-fefe/arch/ppc/boot/simple/misc-embedded.c	2003-06-13 11:16:37.000000000 +0200
@@ -262,7 +262,9 @@
 		rec = (struct bi_record *)((unsigned long)rec + rec->size);
 	}
 	puts("Now booting the kernel\n");
+#if 0
 	serial_close(com_port);
+#endif

 	return (unsigned long)hold_residual;
 }

--cWoXeonUoKmBZSoM--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
