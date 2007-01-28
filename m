Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C58F0DE0FF
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 09:31:08 +1100 (EST)
Date: Sun, 28 Jan 2007 23:31:08 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] linkstation / kurobox support
In-Reply-To: <1165058392.22108.34.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0612120039470.4039@poirot.grange>
References: <Pine.LNX.4.60.0612012241430.13326@poirot.grange>
	<200612021156.37067.arnd@arndb.de>
	<1165058392.22108.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2 Dec 2006, Benjamin Herrenschmidt wrote:

> On Sat, 2006-12-02 at 11:56 +0100, Arnd Bergmann wrote:
> 
> > > +#ifdef CONFIG_BLK_DEV_INITRD
> > > +       if (initrd_start)
> > > +               ROOT_DEV = Root_RAM0;
> > > +       else
> > > +#endif
> > > +#ifdef CONFIG_ROOT_NFS
> > > +               ROOT_DEV = Root_NFS;
> > > +#else
> > > +               ROOT_DEV = Root_HDA1;
> > > +#endif
> > > +
> > 
> > This looks wrong. Didn't the same code come up recently in a review for
> > another platform? What was the conclusion?
> 
> It's a copy paste that we inhertit from the big bang...  Should probably
> go...

...and there it goes. Re-diffed against 2.6.20-rc6. For inclusion in 
2.6.21.

Thanks
Guennadi
---
Guennadi Liakhovetski

Linkstation systems capable of running mainline kernels use u-boot as a 
bootloader, so, specifying a suitable kernel command is not a problem. 
Don't guess. Also extend linkstation_defconfig to support the linkstation HS
model with a IT8212 IDE controller and kuroboxHD/HD-HLAN linkstation
models with a tulip ethernet chip. The latter also require a slightly
different .dts file, which is also included with this patch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

diff -u a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c	2006-12-12 00:37:38.000000000 +0100
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c	2006-12-01 22:50:44.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/initrd.h>
-#include <linux/root_dev.h>
 #include <linux/mtd/physmap.h>
 
 #include <asm/time.h>
@@ -91,17 +90,6 @@
 			       ARRAY_SIZE(linkstation_physmap_partitions));
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-#ifdef	CONFIG_ROOT_NFS
-		ROOT_DEV = Root_NFS;
-#else
-		ROOT_DEV = Root_HDA1;
-#endif
-
 	/* Lookup PCI host bridges */
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
diff -u a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
--- a/arch/powerpc/configs/linkstation_defconfig	2006-12-12 00:54:47.000000000 +0100
+++ b/arch/powerpc/configs/linkstation_defconfig	2006-12-12 00:52:48.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:17:58 2007
+# Linux kernel version: 2.6.20-rc6
+# Sun Jan 28 23:13:56 2007
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -58,7 +58,7 @@
 #
 # General setup
 #
-CONFIG_LOCALVERSION="-kuroboxHG"
+CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
@@ -206,7 +206,7 @@
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
-# CONFIG_SECCOMP is not set
+CONFIG_SECCOMP=y
 CONFIG_ISA_DMA_API=y
 
 #
@@ -312,39 +312,40 @@
 # CONFIG_NF_CT_ACCT is not set
 # CONFIG_NF_CONNTRACK_MARK is not set
 # CONFIG_NF_CONNTRACK_EVENTS is not set
-# CONFIG_NF_CT_PROTO_SCTP is not set
-# CONFIG_NF_CONNTRACK_AMANDA is not set
+CONFIG_NF_CT_PROTO_GRE=m
+CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
-# CONFIG_NF_CONNTRACK_H323 is not set
+CONFIG_NF_CONNTRACK_H323=m
 CONFIG_NF_CONNTRACK_IRC=m
-# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
-# CONFIG_NF_CONNTRACK_PPTP is not set
-# CONFIG_NF_CONNTRACK_SIP is not set
+CONFIG_NF_CONNTRACK_NETBIOS_NS=m
+CONFIG_NF_CONNTRACK_PPTP=m
+CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
 # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
-CONFIG_NETFILTER_XT_TARGET_MARK=m
+# CONFIG_NETFILTER_XT_TARGET_MARK is not set
 # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
-CONFIG_NETFILTER_XT_TARGET_NFLOG=m
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
 # CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
 # CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
 # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
 # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
-CONFIG_NETFILTER_XT_MATCH_ESP=m
-CONFIG_NETFILTER_XT_MATCH_HELPER=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_LIMIT=m
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
 CONFIG_NETFILTER_XT_MATCH_MAC=m
-CONFIG_NETFILTER_XT_MATCH_MARK=m
+# CONFIG_NETFILTER_XT_MATCH_MARK is not set
 # CONFIG_NETFILTER_XT_MATCH_POLICY is not set
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
+# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
 # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
 # CONFIG_NETFILTER_XT_MATCH_REALM is not set
 # CONFIG_NETFILTER_XT_MATCH_SCTP is not set
-# CONFIG_NETFILTER_XT_MATCH_STATE is not set
+CONFIG_NETFILTER_XT_MATCH_STATE=m
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 # CONFIG_NETFILTER_XT_MATCH_STRING is not set
 # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
@@ -359,12 +360,12 @@
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_IPRANGE=m
 # CONFIG_IP_NF_MATCH_TOS is not set
-# CONFIG_IP_NF_MATCH_RECENT is not set
+CONFIG_IP_NF_MATCH_RECENT=m
 # CONFIG_IP_NF_MATCH_ECN is not set
 # CONFIG_IP_NF_MATCH_AH is not set
 # CONFIG_IP_NF_MATCH_TTL is not set
-# CONFIG_IP_NF_MATCH_OWNER is not set
-# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+CONFIG_IP_NF_MATCH_OWNER=m
+CONFIG_IP_NF_MATCH_ADDRTYPE=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 # CONFIG_IP_NF_TARGET_LOG is not set
@@ -374,16 +375,17 @@
 CONFIG_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
-CONFIG_IP_NF_TARGET_NETMAP=m
-CONFIG_IP_NF_TARGET_SAME=m
+# CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_SAME is not set
 # CONFIG_NF_NAT_SNMP_BASIC is not set
+CONFIG_NF_NAT_PROTO_GRE=m
 CONFIG_NF_NAT_FTP=m
 CONFIG_NF_NAT_IRC=m
 CONFIG_NF_NAT_TFTP=m
-# CONFIG_NF_NAT_AMANDA is not set
-# CONFIG_NF_NAT_PPTP is not set
-# CONFIG_NF_NAT_H323 is not set
-# CONFIG_NF_NAT_SIP is not set
+CONFIG_NF_NAT_AMANDA=m
+CONFIG_NF_NAT_PPTP=m
+CONFIG_NF_NAT_H323=m
+CONFIG_NF_NAT_SIP=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_TOS=m
 CONFIG_IP_NF_TARGET_ECN=m
@@ -472,6 +474,7 @@
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
@@ -518,6 +521,7 @@
 CONFIG_MTD_PHYSMAP_START=0xffc00000
 CONFIG_MTD_PHYSMAP_LEN=0x400000
 CONFIG_MTD_PHYSMAP_BANKWIDTH=1
+# CONFIG_MTD_PHYSMAP_OF is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -540,6 +544,7 @@
 # NAND Flash Device Drivers
 #
 # CONFIG_MTD_NAND is not set
+# CONFIG_MTD_NAND_CAFE is not set
 
 #
 # OneNAND Flash Device Drivers
@@ -696,7 +701,7 @@
 # CONFIG_PATA_HPT37X is not set
 # CONFIG_PATA_HPT3X2N is not set
 # CONFIG_PATA_HPT3X3 is not set
-# CONFIG_PATA_IT821X is not set
+CONFIG_PATA_IT821X=y
 # CONFIG_PATA_JMICRON is not set
 # CONFIG_PATA_TRIFLEX is not set
 # CONFIG_PATA_MARVELL is not set
@@ -763,11 +768,33 @@
 #
 # PHY device support
 #
+# CONFIG_PHYLIB is not set
 
 #
 # Ethernet (10 or 100Mbit)
 #
-# CONFIG_NET_ETHERNET is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+CONFIG_NET_TULIP=y
+# CONFIG_DE2104X is not set
+CONFIG_TULIP=y
+# CONFIG_TULIP_MWI is not set
+CONFIG_TULIP_MMIO=y
+# CONFIG_TULIP_NAPI is not set
+# CONFIG_DE4X5 is not set
+# CONFIG_WINBOND_840 is not set
+# CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
 
 #
 # Ethernet (1000 Mbit)
@@ -829,7 +856,8 @@
 # CONFIG_USB_ZD1201 is not set
 # CONFIG_HOSTAP is not set
 # CONFIG_BCM43XX is not set
-# CONFIG_ZD1211RW is not set
+CONFIG_ZD1211RW=m
+# CONFIG_ZD1211RW_DEBUG is not set
 CONFIG_NET_WIRELESS=y
 
 #
@@ -1098,7 +1126,7 @@
 #
 # HID Devices
 #
-CONFIG_HID=y
+CONFIG_HID=m
 
 #
 # USB support
@@ -1115,7 +1143,6 @@
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_BANDWIDTH is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_MULTITHREAD_PROBE is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -1136,7 +1163,7 @@
 # USB Device Class drivers
 #
 # CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
+CONFIG_USB_PRINTER=m
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -1371,7 +1398,11 @@
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-# CONFIG_XFS_FS is not set
+CONFIG_XFS_FS=m
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_SECURITY is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_XFS_RT is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -1461,7 +1492,12 @@
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
+CONFIG_CIFS=m
+# CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
+# CONFIG_CIFS_XATTR is not set
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_EXPERIMENTAL is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -1495,7 +1531,7 @@
 # CONFIG_NLS_CODEPAGE_869 is not set
 # CONFIG_NLS_CODEPAGE_936 is not set
 # CONFIG_NLS_CODEPAGE_950 is not set
-# CONFIG_NLS_CODEPAGE_932 is not set
+CONFIG_NLS_CODEPAGE_932=m
 # CONFIG_NLS_CODEPAGE_949 is not set
 # CONFIG_NLS_CODEPAGE_874 is not set
 # CONFIG_NLS_ISO8859_8 is not set
@@ -1526,12 +1562,14 @@
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_CRC_CCITT is not set
+CONFIG_CRC_CCITT=m
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=m
 CONFIG_ZLIB_DEFLATE=m
+CONFIG_TEXTSEARCH=y
+CONFIG_TEXTSEARCH_KMP=m
 CONFIG_PLIST=y
 CONFIG_IOMAP_COPY=y
 
diff -u a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
--- a/arch/powerpc/boot/dts/kuroboxHD.dts	2007-01-28 23:18:43.000000000 +0100
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts	2007-01-28 23:18:43.000000000 +0100
@@ -0,0 +1,148 @@
+/*
+ * Device Tree Souce for Buffalo KuroboxHD
+ *
+ * Choose CONFIG_LINKSTATION to build a kernel for KuroboxHD, or use
+ * the default configuration linkstation_defconfig.
+ *
+ * Based on sandpoint.dts
+ *
+ * 2006 (c) G. Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+
+XXXX add flash parts, rtc, ??
+
+build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
+
+
+ */
+
+/ {
+	linux,phandle = <1000>;
+	model = "KuroboxHD";
+	compatible = "linkstation";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		linux,phandle = <2000>;
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,603e { /* Really 8241 */
+			linux,phandle = <2100>;
+			linux,boot-cpu;
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <bebc200>;	/* Fixed by bootwrapper */
+			timebase-frequency = <1743000>; /* Fixed by bootwrapper */
+			bus-frequency = <0>;		/* From bootloader */
+			/* Following required by dtc but not used */
+			i-cache-line-size = <0>;
+			d-cache-line-size = <0>;
+			i-cache-size = <4000>;
+			d-cache-size = <4000>;
+		};
+	};
+
+	memory {
+		linux,phandle = <3000>;
+		device_type = "memory";
+		reg = <00000000 04000000>;
+	};
+
+	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
+		linux,phandle = <4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		compatible = "mpc10x";
+		store-gathering = <0>; /* 0 == off, !0 == on */
+		reg = <80000000 00100000>;
+		ranges = <80000000 80000000 70000000	/* pci mem space */
+			  fc000000 fc000000 00100000	/* EUMB */
+			  fe000000 fe000000 00c00000	/* pci i/o space */
+			  fec00000 fec00000 00300000	/* pci cfg regs */
+			  fef00000 fef00000 00100000>;	/* pci iack */
+
+		i2c@80003000 {
+			linux,phandle = <4300>;
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <80003000 1000>;
+			interrupts = <5 2>;
+			interrupt-parent = <4400>;
+		};
+
+		serial@80004500 {
+			linux,phandle = <4511>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <80004500 8>;
+			clock-frequency = <5d08d88>;
+			current-speed = <2580>;
+			interrupts = <9 2>;
+			interrupt-parent = <4400>;
+		};
+
+		serial@80004600 {
+			linux,phandle = <4512>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <80004600 8>;
+			clock-frequency = <5d08d88>;
+			current-speed = <e100>;
+			interrupts = <a 0>;
+			interrupt-parent = <4400>;
+		};
+
+		pic@80040000 {
+			linux,phandle = <4400>;
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			reg = <80040000 40000>;
+			built-in;
+		};
+
+		pci@fec00000 {
+			linux,phandle = <4500>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "mpc10x-pci";
+			reg = <fec00000 400000>;
+			ranges = <01000000 0        0 fe000000 0 00c00000
+				  02000000 0 80000000 80000000 0 70000000>;
+			bus-range = <0 ff>;
+			clock-frequency = <7f28155>;
+			interrupt-parent = <4400>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x11 - IRQ0 ETH */
+				5800 0 0 1 4400 0 1
+				5800 0 0 2 4400 1 1
+				5800 0 0 3 4400 2 1
+				5800 0 0 4 4400 3 1
+				/* IDSEL 0x12 - IRQ1 IDE0 */
+				6000 0 0 1 4400 1 1
+				6000 0 0 2 4400 2 1
+				6000 0 0 3 4400 3 1
+				6000 0 0 4 4400 0 1
+				/* IDSEL 0x14 - IRQ3 USB2.0 */
+				7000 0 0 1 4400 3 1
+				7000 0 0 2 4400 3 1
+				7000 0 0 3 4400 3 1
+				7000 0 0 4 4400 3 1
+			>;
+		};
+	};
+};
