Return-Path: <xenidis@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33F37B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Oct 2011 00:26:15 +1000 (EST)
Received: by yxk8 with SMTP id 8so1887468yxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 07:26:09 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc: book3e: WSP: Add Chroma as a new WSP/PowerEN
	platform.
Date: Fri, 30 Sep 2011 09:26:13 -0500
Message-Id: <1317392773-19218-1-git-send-email-jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch add the Chroma platform to WSP/PowerEN, which is a PCIe
card (a defconfig is included).

The card includes an H8 service processor that is used to manage the
card.  The H8 is connected over the second serial UART on the PowerEN
chip so this patch includes a simple 16550 driver to enable
communication, mostly for "power off" and "rebooting".

This patch also includes a, WSP specific, "halt" method that will shut
of all A2 cores but still leave power on at the chip level.  This is
desirable, especially if you wish to interrogate the chip with a
hardware probe after the halt.

Signed-off-by: Jimi Xenidis <jimix@pobox.com>

---
Re: galak@kernel.crashing.org
    use make savedefconfig

ARGH!: apparently make savedefconfig does not clean up the INITRAMFS_SOURCE
---
 arch/powerpc/configs/chroma_defconfig |  307 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/wsp/Kconfig    |   11 +-
 arch/powerpc/platforms/wsp/Makefile   |    8 +-
 arch/powerpc/platforms/wsp/chroma.c   |   56 ++++++
 arch/powerpc/platforms/wsp/h8.c       |  134 ++++++++++++++
 arch/powerpc/platforms/wsp/psr2.c     |   56 ++-----
 arch/powerpc/platforms/wsp/wsp.c      |  115 ++++++++++++
 arch/powerpc/platforms/wsp/wsp.h      |   16 ++-
 8 files changed, 651 insertions(+), 52 deletions(-)
 create mode 100644 arch/powerpc/configs/chroma_defconfig
 create mode 100644 arch/powerpc/platforms/wsp/chroma.c
 create mode 100644 arch/powerpc/platforms/wsp/h8.c
 create mode 100644 arch/powerpc/platforms/wsp/wsp.c

diff --git a/arch/powerpc/configs/chroma_defconfig b/arch/powerpc/configs/chroma_defconfig
new file mode 100644
index 0000000..acf7fb2
--- /dev/null
+++ b/arch/powerpc/configs/chroma_defconfig
@@ -0,0 +1,307 @@
+CONFIG_PPC64=y
+CONFIG_PPC_BOOK3E_64=y
+# CONFIG_VIRT_CPU_ACCOUNTING is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=256
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_TASKSTATS=y
+CONFIG_TASK_DELAY_ACCT=y
+CONFIG_TASK_XACCT=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_AUDIT=y
+CONFIG_AUDITSYSCALL=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=19
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_RESOURCE_COUNTERS=y
+CONFIG_CGROUP_MEM_RES_CTLR=y
+CONFIG_CGROUP_MEM_RES_CTLR_SWAP=y
+CONFIG_NAMESPACES=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_BZIP2=y
+CONFIG_RD_LZMA=y
+CONFIG_INITRAMFS_COMPRESSION_GZIP=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_COUNTERS=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_SCOM_DEBUGFS=y
+CONFIG_PPC_A2_DD2=y
+CONFIG_KVM_GUEST=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_HZ_100=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_MISC=y
+CONFIG_NUMA=y
+# CONFIG_MIGRATION is not set
+CONFIG_PPC_64K_PAGES=y
+CONFIG_SCHED_SMT=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+# CONFIG_SECCOMP is not set
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
+CONFIG_PCI_MSI=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=m
+CONFIG_XFRM_SUB_POLICY=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_NET_KEY=m
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
+CONFIG_INET_IPCOMP=m
+CONFIG_IPV6=y
+CONFIG_IPV6_PRIVACY=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_INET6_AH=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_IPCOMP=y
+CONFIG_IPV6_MIP6=y
+CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
+CONFIG_IPV6_TUNNEL=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_SUBTREES=y
+CONFIG_IPV6_MROUTE=y
+CONFIG_IPV6_PIMSM_V2=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
+CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_COMMENT=m
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_DCCP=m
+CONFIG_NETFILTER_XT_MATCH_DSCP=m
+CONFIG_NETFILTER_XT_MATCH_ESP=m
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
+CONFIG_NETFILTER_XT_MATCH_HELPER=m
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_MARK=m
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+CONFIG_NETFILTER_XT_MATCH_OWNER=m
+CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_QUOTA=m
+CONFIG_NETFILTER_XT_MATCH_RATEEST=m
+CONFIG_NETFILTER_XT_MATCH_REALM=m
+CONFIG_NETFILTER_XT_MATCH_RECENT=m
+CONFIG_NETFILTER_XT_MATCH_SCTP=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_MATCH_STRING=m
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
+CONFIG_NETFILTER_XT_MATCH_TIME=m
+CONFIG_NETFILTER_XT_MATCH_U32=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_IP_NF_QUEUE=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_AH=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_NETMAP=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_NET_TCPPROBE=y
+# CONFIG_WIRELESS is not set
+CONFIG_NET_9P=y
+CONFIG_NET_9P_DEBUG=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_LE_BYTE_SWAP=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_CRYPTOLOOP=y
+CONFIG_BLK_DEV_NBD=m
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_CDROM_PKTCDVD=y
+CONFIG_MISC_DEVICES=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_BLK_DEV_SR_VENDOR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_SPI_ATTRS=y
+CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_ISCSI_ATTRS=m
+CONFIG_SCSI_SAS_ATTRS=m
+CONFIG_SCSI_SRP_ATTRS=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_SIL24=y
+CONFIG_SATA_MV=y
+CONFIG_SATA_SIL=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PATA_MARVELL=y
+CONFIG_PATA_SIL680=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=y
+CONFIG_MD_LINEAR=y
+CONFIG_BLK_DEV_DM=y
+CONFIG_DM_CRYPT=y
+CONFIG_DM_SNAPSHOT=y
+CONFIG_DM_MIRROR=y
+CONFIG_DM_ZERO=y
+CONFIG_DM_UEVENT=y
+CONFIG_NETDEVICES=y
+CONFIG_TUN=y
+CONFIG_E1000E=y
+CONFIG_TIGON3=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_HW_RANDOM=y
+CONFIG_RAW_DRIVER=y
+CONFIG_MAX_RAW_DEVS=1024
+# CONFIG_HWMON is not set
+# CONFIG_VGA_ARB is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1511=y
+CONFIG_RTC_DRV_DS1553=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT2_FS_XIP=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS=y
+# CONFIG_DNOTIFY is not set
+CONFIG_FUSE_FS=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=m
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_ROOT_NFS=y
+CONFIG_CIFS=y
+CONFIG_CIFS_WEAK_PW_HASH=y
+CONFIG_CIFS_XATTR=y
+CONFIG_CIFS_POSIX=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_CRC_CCITT=m
+CONFIG_CRC_T10DIF=y
+CONFIG_LIBCRC32C=m
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_PPC_EMULATED_STATS=y
+CONFIG_XMON=y
+CONFIG_XMON_DEFAULT=y
+CONFIG_VIRQ_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_KEYS_DEBUG_PROC_KEYS=y
+CONFIG_CRYPTO_NULL=m
+CONFIG_CRYPTO_TEST=m
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_GCM=m
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_MICHAEL_MIC=m
+CONFIG_CRYPTO_SHA256=m
+CONFIG_CRYPTO_SHA512=m
+CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_WP512=m
+CONFIG_CRYPTO_AES=m
+CONFIG_CRYPTO_ANUBIS=m
+CONFIG_CRYPTO_BLOWFISH=m
+CONFIG_CRYPTO_CAST5=m
+CONFIG_CRYPTO_CAST6=m
+CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_SALSA20=m
+CONFIG_CRYPTO_SERPENT=m
+CONFIG_CRYPTO_TEA=m
+CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_LZO=m
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_VIRTUALIZATION=y
diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
index ea2811c..a3eef8e 100644
--- a/arch/powerpc/platforms/wsp/Kconfig
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -1,6 +1,7 @@
 config PPC_WSP
 	bool
 	select PPC_A2
+	select GENERIC_TBSYNC
 	select PPC_ICSWX
 	select PPC_SCOM
 	select PPC_XICS
@@ -8,14 +9,20 @@ config PPC_WSP
 	select PCI
 	select PPC_IO_WORKAROUNDS if PCI
 	select PPC_INDIRECT_PIO if PCI
+	select PPC_WSP_COPRO
 	default n
 
 menu "WSP platform selection"
 	depends on PPC_BOOK3E_64
 
 config PPC_PSR2
-	bool "PSR-2 platform"
-	select GENERIC_TBSYNC
+	bool "PowerEN System Reference Platform 2"
+	select EPAPR_BOOT
+	select PPC_WSP
+	default y
+
+config PPC_CHROMA
+	bool "PowerEN PCIe Chroma Card"
 	select EPAPR_BOOT
 	select PPC_WSP
 	default y
diff --git a/arch/powerpc/platforms/wsp/Makefile b/arch/powerpc/platforms/wsp/Makefile
index a1486b4..56817ac 100644
--- a/arch/powerpc/platforms/wsp/Makefile
+++ b/arch/powerpc/platforms/wsp/Makefile
@@ -1,8 +1,10 @@
 ccflags-y			+= -mno-minimal-toc
 
-obj-y				+= setup.o ics.o
-obj-$(CONFIG_PPC_PSR2)		+= psr2.o opb_pic.o
+obj-y				+= setup.o ics.o wsp.o
+obj-$(CONFIG_PPC_PSR2)		+= psr2.o
+obj-$(CONFIG_PPC_CHROMA)	+= chroma.o h8.o
+obj-$(CONFIG_PPC_WSP)		+= opb_pic.o
 obj-$(CONFIG_PPC_WSP)		+= scom_wsp.o
 obj-$(CONFIG_SMP)		+= smp.o scom_smp.o
 obj-$(CONFIG_PCI)		+= wsp_pci.o
-obj-$(CONFIG_PCI_MSI)		+= msi.o
\ No newline at end of file
+obj-$(CONFIG_PCI_MSI)		+= msi.o
diff --git a/arch/powerpc/platforms/wsp/chroma.c b/arch/powerpc/platforms/wsp/chroma.c
new file mode 100644
index 0000000..ca6fa26
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/chroma.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright 2008-2011, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <linux/time.h>
+
+#include <asm/machdep.h>
+#include <asm/system.h>
+#include <asm/udbg.h>
+
+#include "ics.h"
+#include "wsp.h"
+
+void __init chroma_setup_arch(void)
+{
+	wsp_setup_arch();
+	wsp_setup_h8();
+
+}
+
+static int __init chroma_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,wsp-chroma"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(chroma_md) {
+	.name			= "Chroma PCIe",
+	.probe			= chroma_probe,
+	.setup_arch		= chroma_setup_arch,
+	.restart		= wsp_h8_restart,
+	.power_off		= wsp_h8_power_off,
+	.halt			= wsp_halt,
+	.calibrate_decr		= generic_calibrate_decr,
+	.init_IRQ		= wsp_setup_irq,
+	.progress		= udbg_progress,
+	.power_save		= book3e_idle,
+};
+
+machine_arch_initcall(chroma_md, wsp_probe_devices);
diff --git a/arch/powerpc/platforms/wsp/h8.c b/arch/powerpc/platforms/wsp/h8.c
new file mode 100644
index 0000000..d18e6cc
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/h8.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright 2008-2011, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/io.h>
+
+#include "wsp.h"
+
+/*
+ * The UART connection to the H8 is over ttyS1 which is just a 16550.
+ * We assume that FW has it setup right and no one messes with it.
+ */
+
+
+static u8 __iomem *h8;
+
+#define RBR 0		/* Receiver Buffer Register */
+#define THR 0		/* Transmitter Holding Register */
+#define LSR 5		/* Line Status Register */
+#define LSR_DR 0x01	/* LSR value for Data-Ready */
+#define LSR_THRE 0x20	/* LSR value for Transmitter-Holding-Register-Empty */
+static void wsp_h8_putc(int c)
+{
+	u8 lsr;
+
+	do {
+		lsr = readb(h8 + LSR);
+	} while ((lsr & LSR_THRE) != LSR_THRE);
+	writeb(c, h8 + THR);
+}
+
+static int wsp_h8_getc(void)
+{
+	u8 lsr;
+
+	do {
+		lsr = readb(h8 + LSR);
+	} while ((lsr & LSR_DR) != LSR_DR);
+
+	return readb(h8 + RBR);
+}
+
+static void wsp_h8_puts(const char *s, int sz)
+{
+	int i;
+
+	for (i = 0; i < sz; i++) {
+		wsp_h8_putc(s[i]);
+
+		/* no flow control so wait for echo */
+		wsp_h8_getc();
+	}
+	wsp_h8_putc('\r');
+	wsp_h8_putc('\n');
+}
+
+static void wsp_h8_terminal_cmd(const char *cmd, int sz)
+{
+	hard_irq_disable();
+	wsp_h8_puts(cmd, sz);
+	/* should never return, but just in case */
+	for (;;)
+		continue;
+}
+
+
+void wsp_h8_restart(char *cmd)
+{
+	static const char restart[] = "warm-reset";
+
+	(void)cmd;
+	wsp_h8_terminal_cmd(restart, sizeof(restart) - 1);
+}
+
+void wsp_h8_power_off(void)
+{
+	static const char off[] = "power-off";
+
+	wsp_h8_terminal_cmd(off, sizeof(off) - 1);
+}
+
+static void __iomem *wsp_h8_getaddr(void)
+{
+	struct device_node *aliases;
+	struct device_node *uart;
+	struct property *path;
+	void __iomem *va = NULL;
+
+	/*
+	 * there is nothing in the devtree to tell us which is mapped
+	 * to the H8, but se know it is the second serial port.
+	 */
+
+	aliases = of_find_node_by_path("/aliases");
+	if (aliases == NULL)
+		return NULL;
+
+	path = of_find_property(aliases, "serial1", NULL);
+	if (path == NULL)
+		goto out;
+
+	uart = of_find_node_by_path(path->value);
+	if (uart == NULL)
+		goto out;
+
+	va = of_iomap(uart, 0);
+
+	/* remove it so no one messes with it */
+	of_detach_node(uart);
+	of_node_put(uart);
+
+out:
+	of_node_put(aliases);
+
+	return va;
+}
+
+void __init wsp_setup_h8(void)
+{
+	h8 = wsp_h8_getaddr();
+
+	/* Devtree change? lets hard map it anyway */
+	if (h8 == NULL) {
+		pr_warn("UART to H8 could not be found");
+		h8 = ioremap(0xffc0008000ULL, 0x100);
+	}
+}
diff --git a/arch/powerpc/platforms/wsp/psr2.c b/arch/powerpc/platforms/wsp/psr2.c
index 166f2e4..0c1ae06 100644
--- a/arch/powerpc/platforms/wsp/psr2.c
+++ b/arch/powerpc/platforms/wsp/psr2.c
@@ -14,10 +14,10 @@
 #include <linux/mm.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/time.h>
 
 #include <asm/machdep.h>
 #include <asm/system.h>
-#include <asm/time.h>
 #include <asm/udbg.h>
 
 #include "ics.h"
@@ -27,7 +27,8 @@
 static void psr2_spin(void)
 {
 	hard_irq_disable();
-	for (;;) ;
+	for (;;)
+		continue;
 }
 
 static void psr2_restart(char *cmd)
@@ -35,65 +36,32 @@ static void psr2_restart(char *cmd)
 	psr2_spin();
 }
 
-static int psr2_probe_devices(void)
-{
-	struct device_node *np;
-
-	/* Our RTC is a ds1500. It seems to be programatically compatible
-	 * with the ds1511 for which we have a driver so let's use that
-	 */
-	np = of_find_compatible_node(NULL, NULL, "dallas,ds1500");
-	if (np != NULL) {
-		struct resource res;
-		if (of_address_to_resource(np, 0, &res) == 0)
-			platform_device_register_simple("ds1511", 0, &res, 1);
-	}
-	return 0;
-}
-machine_arch_initcall(psr2_md, psr2_probe_devices);
-
-static void __init psr2_setup_arch(void)
-{
-	/* init to some ~sane value until calibrate_delay() runs */
-	loops_per_jiffy = 50000000;
-
-	scom_init_wsp();
-
-	/* Setup SMP callback */
-#ifdef CONFIG_SMP
-	a2_setup_smp();
-#endif
-#ifdef CONFIG_PCI
-	wsp_setup_pci();
-#endif
-
-}
-
 static int __init psr2_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
+	if (of_flat_dt_is_compatible(root, "ibm,wsp-chroma")) {
+		/* chroma systems also claim they are psr2s */
+		return 0;
+	}
+
 	if (!of_flat_dt_is_compatible(root, "ibm,psr2"))
 		return 0;
 
 	return 1;
 }
 
-static void __init psr2_init_irq(void)
-{
-	wsp_init_irq();
-	opb_pic_init();
-}
-
 define_machine(psr2_md) {
 	.name			= "PSR2 A2",
 	.probe			= psr2_probe,
-	.setup_arch		= psr2_setup_arch,
+	.setup_arch		= wsp_setup_arch,
 	.restart		= psr2_restart,
 	.power_off		= psr2_spin,
 	.halt			= psr2_spin,
 	.calibrate_decr		= generic_calibrate_decr,
-	.init_IRQ		= psr2_init_irq,
+	.init_IRQ		= wsp_setup_irq,
 	.progress		= udbg_progress,
 	.power_save		= book3e_idle,
 };
+
+machine_arch_initcall(psr2_md, wsp_probe_devices);
diff --git a/arch/powerpc/platforms/wsp/wsp.c b/arch/powerpc/platforms/wsp/wsp.c
new file mode 100644
index 0000000..d25cc96
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/wsp.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright 2008-2011, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <linux/time.h>
+
+#include <asm/scom.h>
+
+#include "wsp.h"
+#include "ics.h"
+
+#define WSP_SOC_COMPATIBLE	"ibm,wsp-soc"
+#define PBIC_COMPATIBLE		"ibm,wsp-pbic"
+#define COPRO_COMPATIBLE	"ibm,wsp-coprocessor"
+
+static int __init wsp_probe_buses(void)
+{
+	static __initdata struct of_device_id bus_ids[] = {
+		/*
+		 * every node in between needs to be here or you won't
+		 * find it
+		 */
+		{ .compatible = WSP_SOC_COMPATIBLE, },
+		{ .compatible = PBIC_COMPATIBLE, },
+		{ .compatible = COPRO_COMPATIBLE, },
+		{},
+	};
+	of_platform_bus_probe(NULL, bus_ids, NULL);
+
+	return 0;
+}
+
+void __init wsp_setup_arch(void)
+{
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	scom_init_wsp();
+
+	/* Setup SMP callback */
+#ifdef CONFIG_SMP
+	a2_setup_smp();
+#endif
+#ifdef CONFIG_PCI
+	wsp_setup_pci();
+#endif
+}
+
+void __init wsp_setup_irq(void)
+{
+	wsp_init_irq();
+	opb_pic_init();
+}
+
+
+int __init wsp_probe_devices(void)
+{
+	struct device_node *np;
+
+	/* Our RTC is a ds1500. It seems to be programatically compatible
+	 * with the ds1511 for which we have a driver so let's use that
+	 */
+	np = of_find_compatible_node(NULL, NULL, "dallas,ds1500");
+	if (np != NULL) {
+		struct resource res;
+		if (of_address_to_resource(np, 0, &res) == 0)
+			platform_device_register_simple("ds1511", 0, &res, 1);
+	}
+
+	wsp_probe_buses();
+
+	return 0;
+}
+
+void wsp_halt(void)
+{
+	u64 val;
+	scom_map_t m;
+	struct device_node *dn;
+	struct device_node *mine;
+	struct device_node *me;
+
+	me = of_get_cpu_node(smp_processor_id(), NULL);
+	mine = scom_find_parent(me);
+
+	/* This will halt all the A2s but not power off the chip */
+	for_each_node_with_property(dn, "scom-controller") {
+		if (dn == mine)
+			continue;
+		m = scom_map(dn, 0, 1);
+
+		/* read-modify-write it so the HW probe does not get
+		 * confused */
+		val = scom_read(m, 0);
+		val |= 1;
+		scom_write(m, 0, val);
+		scom_unmap(m);
+	}
+	m = scom_map(mine, 0, 1);
+	val = scom_read(m, 0);
+	val |= 1;
+	scom_write(m, 0, val);
+	/* should never return */
+	scom_unmap(m);
+}
diff --git a/arch/powerpc/platforms/wsp/wsp.h b/arch/powerpc/platforms/wsp/wsp.h
index 3347981..10c1d1f 100644
--- a/arch/powerpc/platforms/wsp/wsp.h
+++ b/arch/powerpc/platforms/wsp/wsp.h
@@ -6,15 +6,25 @@
 /* Devtree compatible strings for major devices */
 #define PCIE_COMPATIBLE     "ibm,wsp-pciex"
 
+extern void wsp_setup_arch(void);
+extern void wsp_setup_irq(void);
+extern int wsp_probe_devices(void);
+extern void wsp_halt(void);
+
 extern void wsp_setup_pci(void);
 extern void scom_init_wsp(void);
 
 extern void a2_setup_smp(void);
 extern int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
 			       struct device_node *np);
-int smp_a2_cpu_bootable(unsigned int nr);
-int __devinit smp_a2_kick_cpu(int nr);
+extern int smp_a2_cpu_bootable(unsigned int nr);
+extern int __devinit smp_a2_kick_cpu(int nr);
+
+extern void opb_pic_init(void);
 
-void opb_pic_init(void);
+/* chroma specific managment */
+extern void wsp_h8_restart(char *cmd);
+extern void wsp_h8_power_off(void);
+extern void __init wsp_setup_h8(void);
 
 #endif /*  __WSP_H */
-- 
1.7.0.4
