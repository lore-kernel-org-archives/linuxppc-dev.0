Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <00512BA4F9D3D311912A009027E9B8F407E3F8@NT>
From: Dave Ellis <DGE@sixnetio.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problem using FEC on a860T
Date: Mon, 22 Oct 2001 10:51:12 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C15B08.FE5E4FC0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C15B08.FE5E4FC0
Content-Type: text/plain;
	charset="iso-8859-1"

Borracini Evandro wrote:
...
> Firstly, apply the attached patch. This patch was written by
> Dave Ellis. It will disable the mii_link_interrupt when the
> "MDIO for PHY configuration" was not selected.
>
> Secondly, you need compile without the "MDIO for PHY
> configuration". FADS does not use that.

With the patch the FADS should work with or without MDIO support.
At least my FADS (with an 855T) does.

This was discussed on the ppcboot-users list last month, but
my attachments apparently didn't survive in the archives
on geocrawler, so I am posting them here again. The patches
are for the Denx linux-2.4.4-2001-07-23 kernel.

from my post on Ppcboot-users (11-Sep-01):
> ... so I am attaching 2 patches and 2 configurations.
> fads0723.patch - my first patch to make FADS with FEC ethernet build
> fads0723_2.patch - this patch (which needs the first one) fixes:
>  * if CONFIG_USE_MDIO is disabled don't enable mii link interrupts,
>    since the link interrupt routine doesn't know what to do with them.
>  * make fec.c default to LXT971 PHY only if the PHY type is not
>    already configured. fads.h now defines CONFIG_FEC_LXT970.
>  * remove duplicate PHY_INTERRUPT #define from fads.h
> FADS860FNM_config - FADS 860 with FEC ethernet, CONFIG_USE_MDIO disabled
> FADS860FM_config - FADS 860 with FEC ethernet, CONFIG_USE_MDIO enabled

Dave

----------------------------------------
Dave Ellis - Director of Engineering
SIXNET  "Programmable I/O for Windows"
PO Box 767
Clifton Park, NY  12065
Tel. +1 (518) 877-5173
Fax. +1 (518) 877-8346
Mail: mailto:dge@sixnetio.com
product info at http://www.sixnetio.com
----------------------------------------



------_=_NextPart_000_01C15B08.FE5E4FC0
Content-Type: application/octet-stream;
	name="fads0723.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fads0723.patch"

diff -Naur linux-2.4.4-2001-07-23/arch/ppc/8xx_io/commproc.h =
linux-2.4.4-2001-07-23.sxn/arch/ppc/8xx_io/commproc.h=0A=
--- linux-2.4.4-2001-07-23/arch/ppc/8xx_io/commproc.h	Mon Jul 23 =
10:05:03 2001=0A=
+++ linux-2.4.4-2001-07-23.sxn/arch/ppc/8xx_io/commproc.h	Wed Sep  5 =
23:05:57 2001=0A=
@@ -732,7 +732,7 @@=0A=
 #define SICR_ENET_MASK	((uint)0x0000ff00)=0A=
 #define SICR_ENET_CLKRT	((uint)0x00002e00)=0A=
 =0A=
-# else=0A=
+# elif defined(CONFIG_SCC_ENET)=0A=
 #  error No SCC defined for Ethernet=0A=
 # endif=0A=
 =0A=
diff -Naur linux-2.4.4-2001-07-23/include/asm-ppc/fads.h =
linux-2.4.4-2001-07-23.sxn/include/asm-ppc/fads.h=0A=
--- linux-2.4.4-2001-07-23/include/asm-ppc/fads.h	Sun Jun 24 17:26:59 =
2001=0A=
+++ linux-2.4.4-2001-07-23.sxn/include/asm-ppc/fads.h	Wed Sep  5 =
21:30:28 2001=0A=
@@ -43,7 +43,6 @@=0A=
 #define BCSR4_FETHCFG1		((uint)0x00400000)	/* PHY autoneg mode */=0A=
 #define BCSR4_FETHFDE		((uint)0x02000000)	/* PHY FDX advertise */=0A=
 #define BCSR4_FETHRST		((uint)0x00200000)	/* PHY Reset */=0A=
-#endif /* !__ASSEMBLY__ */=0A=
  =0A=
 /* Interrupt level assignments.=0A=
  */=0A=

------_=_NextPart_000_01C15B08.FE5E4FC0
Content-Type: application/octet-stream;
	name="fads0723_2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fads0723_2.patch"

diff -Naur linux-2.4.4-2001-07-23.sxn/arch/ppc/8xx_io/fec.c =
linux-2.4.4-2001-07-23.sxn2/arch/ppc/8xx_io/fec.c=0A=
--- linux-2.4.4-2001-07-23.sxn/arch/ppc/8xx_io/fec.c	Mon Mar 12 =
10:48:01 2001=0A=
+++ linux-2.4.4-2001-07-23.sxn2/arch/ppc/8xx_io/fec.c	Tue Sep 11 =
16:30:54 2001=0A=
@@ -25,12 +25,6 @@=0A=
  * Copyright (c) 2000 Wolfgang Denk, DENX Software Engineering.=0A=
  */=0A=
 =0A=
-/* List of PHYs we wish to support.=0A=
-*/=0A=
-#undef	CONFIG_FEC_LXT970=0A=
-#define	CONFIG_FEC_LXT971=0A=
-#undef	CONFIG_FEC_QS6612=0A=
-=0A=
 #include <linux/config.h>=0A=
 #include <linux/kernel.h>=0A=
 #include <linux/sched.h>=0A=
@@ -59,6 +53,15 @@=0A=
 #include <asm/uaccess.h>=0A=
 #include "commproc.h"=0A=
 =0A=
+/* List of PHYs we wish to support.=0A=
+** If one or more is defined, just use it (or them), otherwise =
default=0A=
+** to LXT971.=0A=
+*/=0A=
+#if !defined(CONFIG_FEC_LXT970) && !defined(CONFIG_FEC_LXT971)\=0A=
+    && !defined(CONFIG_FEC_QS6612)=0A=
+#define	CONFIG_FEC_LXT971=0A=
+#endif=0A=
+=0A=
 #ifdef	CONFIG_USE_MDIO=0A=
 /* Forward declarations of some structures to support different =
PHYs=0A=
 */=0A=
@@ -1336,6 +1339,8 @@=0A=
 }=0A=
 #endif	/* CONFIG_USE_MDIO */=0A=
 =0A=
+#if defined(CONFIG_USE_MDIO) \=0A=
+    && (defined(PHY_INTERRUPT) || defined(CONFIG_RPXCLASSIC))=0A=
 /* This interrupt occurs when the PHY detects a link change.=0A=
 */=0A=
 static void=0A=
@@ -1345,7 +1350,6 @@=0A=
 mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)=0A=
 #endif=0A=
 {=0A=
-#ifdef	CONFIG_USE_MDIO=0A=
 	struct	net_device *dev =3D dev_id;=0A=
 	struct fec_enet_private *fep =3D dev->priv;=0A=
 	volatile immap_t *immap =3D (immap_t *)IMAP_ADDR;=0A=
@@ -1357,25 +1361,15 @@=0A=
 	if ((ecntrl & FEC_ECNTRL_ETHER_EN) =3D=3D 0) {=0A=
 		fecp->fec_ecntrl |=3D FEC_ECNTRL_ETHER_EN;=0A=
 	}=0A=
-#endif	/* CONFIG_USE_MDIO */=0A=
-=0A=
-#if 0=0A=
-	disable_irq(fep->mii_irq);  /* disable now, enable later */=0A=
-#endif=0A=
-=0A=
 =0A=
-#ifdef	CONFIG_USE_MDIO=0A=
 	mii_do_cmd(dev, fep->phy->ack_int);=0A=
 	mii_do_cmd(dev, phy_cmd_relink);  /* restart and display status */=0A=
 =0A=
 	if ((ecntrl & FEC_ECNTRL_ETHER_EN) =3D=3D 0) {=0A=
 		fecp->fec_ecntrl =3D ecntrl;	/* restore old settings */=0A=
 	}=0A=
-#else=0A=
-printk("%s[%d] %s: unexpected Link interrupt\n", =
__FILE__,__LINE__,__FUNCTION__);=0A=
-#endif	/* CONFIG_USE_MDIO */=0A=
-=0A=
 }=0A=
+#endif	/* defined(CONFIG_USE_MDIO) && ... */=0A=
 =0A=
 static int=0A=
 fec_enet_open(struct net_device *dev)=0A=
@@ -1643,6 +1637,7 @@=0A=
 		panic("Could not allocate FEC IRQ!");=0A=
 =0A=
 #ifdef CONFIG_RPXCLASSIC=0A=
+#ifdef CONFIG_USE_MDIO=0A=
 	/* Make Port C, bit 15 an input that causes interrupts.=0A=
 	*/=0A=
 	immap->im_ioport.iop_pcpar &=3D ~0x0001;=0A=
@@ -1650,13 +1645,14 @@=0A=
 	immap->im_ioport.iop_pcso  &=3D ~0x0001;=0A=
 	immap->im_ioport.iop_pcint |=3D  0x0001;=0A=
 	cpm_install_handler(CPMVEC_PIO_PC15, mii_link_interrupt, dev);=0A=
+#endif=0A=
 =0A=
 	/* Make LEDS reflect Link status.=0A=
 	*/=0A=
 	*((uint *) RPX_CSR_ADDR) &=3D ~BCSR2_FETHLEDMODE;=0A=
 #endif=0A=
 =0A=
-#ifdef PHY_INTERRUPT=0A=
+#if defined(PHY_INTERRUPT) && defined(CONFIG_USE_MDIO)=0A=
 	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) =
!=3D 0)=0A=
 		panic("Could not allocate MII IRQ!");=0A=
 =0A=
@@ -1706,12 +1702,12 @@=0A=
 #endif	/* CONFIG_USE_MDIO */=0A=
 =0A=
 	printk ("%s: FEC ENET Version 0.2, FEC irq %d"=0A=
-#ifdef PHY_INTERRUPT=0A=
+#if defined(PHY_INTERRUPT) && defined(CONFIG_USE_MDIO)=0A=
 		", MII irq %d"=0A=
 #endif=0A=
 		", addr ",=0A=
 		dev->name, FEC_INTERRUPT=0A=
-#ifdef PHY_INTERRUPT=0A=
+#if defined(PHY_INTERRUPT) && defined(CONFIG_USE_MDIO)=0A=
 		, PHY_INTERRUPT=0A=
 #endif=0A=
 	);=0A=
diff -Naur linux-2.4.4-2001-07-23.sxn/include/asm-ppc/fads.h =
linux-2.4.4-2001-07-23.sxn2/include/asm-ppc/fads.h=0A=
--- linux-2.4.4-2001-07-23.sxn/include/asm-ppc/fads.h	Tue Sep 11 =
15:46:25 2001=0A=
+++ linux-2.4.4-2001-07-23.sxn2/include/asm-ppc/fads.h	Tue Sep 11 =
16:13:02 2001=0A=
@@ -48,6 +48,7 @@=0A=
  */=0A=
 #define FEC_INTERRUPT	SIU_LEVEL1	/* FEC interrupt */=0A=
 #define PHY_INTERRUPT	SIU_IRQ2	/* PHY link change interrupt */=0A=
+#define	CONFIG_FEC_LXT970               /* many (all?) FADS use the =
LXT970 */=0A=
 =0A=
 /* We don't use the 8259.=0A=
  */=0A=
@@ -56,7 +57,5 @@=0A=
 /* Machine type=0A=
  */=0A=
 #define _MACH_8xx (_MACH_fads)=0A=
-=0A=
-#define PHY_INTERRUPT		SIU_IRQ2=0A=
 =0A=
 #endif=0A=

------_=_NextPart_000_01C15B08.FE5E4FC0
Content-Type: application/octet-stream;
	name="FADS860FM_config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="FADS860FM_config"

#=0A=
# Automatically generated by make menuconfig: don't edit=0A=
#=0A=
# CONFIG_UID16 is not set=0A=
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
# CONFIG_6xx is not set=0A=
# CONFIG_4xx is not set=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
CONFIG_8xx=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_RPXLITE is not set=0A=
# CONFIG_RPXCLASSIC is not set=0A=
# CONFIG_BSEIP is not set=0A=
CONFIG_FADS860=3Dy=0A=
# CONFIG_TQM823L is not set=0A=
# CONFIG_TQM850L is not set=0A=
# CONFIG_TQM855L is not set=0A=
# CONFIG_TQM860L is not set=0A=
# CONFIG_FPS850L is not set=0A=
# CONFIG_TQM860 is not set=0A=
# CONFIG_SPD823TS is not set=0A=
# CONFIG_IVMS8 is not set=0A=
# CONFIG_IVML24 is not set=0A=
# CONFIG_SM850 is not set=0A=
# CONFIG_HERMES is not set=0A=
# CONFIG_HERMES_SH is not set=0A=
# CONFIG_IP860 is not set=0A=
# CONFIG_LWMON is not set=0A=
# CONFIG_PCU_E is not set=0A=
# CONFIG_LANTEC is not set=0A=
# CONFIG_MBX is not set=0A=
# CONFIG_WINCEPT is not set=0A=
# CONFIG_PPC601_SYNC_FIX is not set=0A=
# CONFIG_ALL_PPC is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_MACH_SPECIFIC=3Dy=0A=
CONFIG_MATH_EMULATION=3Dy=0A=
# CONFIG_SASH is not set=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
# CONFIG_HIGHMEM is not set=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_SBUS is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_PCI_QSPAN is not set=0A=
# CONFIG_PCI is not set=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_KCORE_ELF=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
# CONFIG_PNP is not set=0A=
# CONFIG_ISAPNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
# CONFIG_BLK_DEV_INITRD is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_MD_LINEAR is not set=0A=
# CONFIG_MD_RAID0 is not set=0A=
# CONFIG_MD_RAID1 is not set=0A=
# CONFIG_MD_RAID5 is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
CONFIG_NETLINK=3Dy=0A=
# CONFIG_RTNETLINK is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
# CONFIG_BLK_DEV_IDE_MODES is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
# CONFIG_GMAC is not set=0A=
# CONFIG_NCR885E is not set=0A=
# CONFIG_OAKNET is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_PCI is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
# CONFIG_SERIAL is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D32=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_JOYSTICK is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_INTEL_RNG is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_FLASH is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_FAT_FS is not set=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_UMSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_TMPFS is not set=0A=
# CONFIG_RAMFS is not set=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_JOLIET is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVFS_MOUNT is not set=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_QNX4FS_RW is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_EXT2_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_SYSV_FS_WRITE is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_NFSD_V3 is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_NCPFS_PACKET_SIGNING is not set=0A=
# CONFIG_NCPFS_IOCTL_LOCKING is not set=0A=
# CONFIG_NCPFS_STRONG is not set=0A=
# CONFIG_NCPFS_NFS_NS is not set=0A=
# CONFIG_NCPFS_OS2_NS is not set=0A=
# CONFIG_NCPFS_SMALLDOS is not set=0A=
# CONFIG_NCPFS_NLS is not set=0A=
# CONFIG_NCPFS_EXTRAS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
# CONFIG_MSDOS_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_SMB_NLS is not set=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# MPC8xx CPM Options=0A=
#=0A=
# CONFIG_SCC_ENET is not set=0A=
CONFIG_FEC_ENET=3Dy=0A=
CONFIG_USE_MDIO=3Dy=0A=
CONFIG_ENET_BIG_BUFFERS=3Dy=0A=
CONFIG_SMC1_UART_RX_BDNUM=3D4=0A=
CONFIG_SMC1_UART_RX_BDSIZE=3D32=0A=
CONFIG_SMC1_UART_TX_BDNUM=3D4=0A=
CONFIG_SMC1_UART_TX_BDSIZE=3D32=0A=
CONFIG_SMC2_UART=3Dy=0A=
# CONFIG_ALTSMC2 is not set=0A=
# CONFIG_CONS_SMC2 is not set=0A=
CONFIG_UART_MAXIDL_SMC2=3D1=0A=
CONFIG_SMC2_UART_RX_BDNUM=3D4=0A=
CONFIG_SMC2_UART_RX_BDSIZE=3D32=0A=
CONFIG_SMC2_UART_TX_BDNUM=3D4=0A=
CONFIG_SMC2_UART_TX_BDSIZE=3D32=0A=
# CONFIG_USE_SCC_IO is not set=0A=
CONFIG_8xx_COPYBACK=3Dy=0A=
# CONFIG_8xx_CPU6 is not set=0A=
# CONFIG_UCODE_PATCH is not set=0A=
# CONFIG_8xx_LCD is not set=0A=
# CONFIG_8xx_BUZZER is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=

------_=_NextPart_000_01C15B08.FE5E4FC0
Content-Type: application/octet-stream;
	name="FADS860FNM_config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="FADS860FNM_config"

#=0A=
# Automatically generated by make menuconfig: don't edit=0A=
#=0A=
# CONFIG_UID16 is not set=0A=
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
# CONFIG_6xx is not set=0A=
# CONFIG_4xx is not set=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
CONFIG_8xx=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_RPXLITE is not set=0A=
# CONFIG_RPXCLASSIC is not set=0A=
# CONFIG_BSEIP is not set=0A=
CONFIG_FADS860=3Dy=0A=
# CONFIG_TQM823L is not set=0A=
# CONFIG_TQM850L is not set=0A=
# CONFIG_TQM855L is not set=0A=
# CONFIG_TQM860L is not set=0A=
# CONFIG_FPS850L is not set=0A=
# CONFIG_TQM860 is not set=0A=
# CONFIG_SPD823TS is not set=0A=
# CONFIG_IVMS8 is not set=0A=
# CONFIG_IVML24 is not set=0A=
# CONFIG_SM850 is not set=0A=
# CONFIG_HERMES is not set=0A=
# CONFIG_HERMES_SH is not set=0A=
# CONFIG_IP860 is not set=0A=
# CONFIG_LWMON is not set=0A=
# CONFIG_PCU_E is not set=0A=
# CONFIG_LANTEC is not set=0A=
# CONFIG_MBX is not set=0A=
# CONFIG_WINCEPT is not set=0A=
# CONFIG_PPC601_SYNC_FIX is not set=0A=
# CONFIG_ALL_PPC is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_MACH_SPECIFIC=3Dy=0A=
CONFIG_MATH_EMULATION=3Dy=0A=
# CONFIG_SASH is not set=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
# CONFIG_HIGHMEM is not set=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_SBUS is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_PCI_QSPAN is not set=0A=
# CONFIG_PCI is not set=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_KCORE_ELF=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
# CONFIG_PNP is not set=0A=
# CONFIG_ISAPNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
# CONFIG_BLK_DEV_INITRD is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_MD_LINEAR is not set=0A=
# CONFIG_MD_RAID0 is not set=0A=
# CONFIG_MD_RAID1 is not set=0A=
# CONFIG_MD_RAID5 is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
CONFIG_NETLINK=3Dy=0A=
# CONFIG_RTNETLINK is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
# CONFIG_BLK_DEV_IDE_MODES is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
# CONFIG_GMAC is not set=0A=
# CONFIG_NCR885E is not set=0A=
# CONFIG_OAKNET is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_PCI is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
# CONFIG_SERIAL is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D32=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_JOYSTICK is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_INTEL_RNG is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_FLASH is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_FAT_FS is not set=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_UMSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_TMPFS is not set=0A=
# CONFIG_RAMFS is not set=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_JOLIET is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVFS_MOUNT is not set=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_QNX4FS_RW is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_EXT2_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_SYSV_FS_WRITE is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_NFSD_V3 is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_NCPFS_PACKET_SIGNING is not set=0A=
# CONFIG_NCPFS_IOCTL_LOCKING is not set=0A=
# CONFIG_NCPFS_STRONG is not set=0A=
# CONFIG_NCPFS_NFS_NS is not set=0A=
# CONFIG_NCPFS_OS2_NS is not set=0A=
# CONFIG_NCPFS_SMALLDOS is not set=0A=
# CONFIG_NCPFS_NLS is not set=0A=
# CONFIG_NCPFS_EXTRAS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
CONFIG_PARTITION_ADVANCED=3Dy=0A=
# CONFIG_ACORN_PARTITION is not set=0A=
# CONFIG_OSF_PARTITION is not set=0A=
# CONFIG_AMIGA_PARTITION is not set=0A=
# CONFIG_ATARI_PARTITION is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
# CONFIG_MSDOS_PARTITION is not set=0A=
# CONFIG_SGI_PARTITION is not set=0A=
# CONFIG_ULTRIX_PARTITION is not set=0A=
# CONFIG_SUN_PARTITION is not set=0A=
# CONFIG_SMB_NLS is not set=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# MPC8xx CPM Options=0A=
#=0A=
# CONFIG_SCC_ENET is not set=0A=
CONFIG_FEC_ENET=3Dy=0A=
# CONFIG_USE_MDIO is not set=0A=
CONFIG_ENET_BIG_BUFFERS=3Dy=0A=
CONFIG_SMC1_UART_RX_BDNUM=3D4=0A=
CONFIG_SMC1_UART_RX_BDSIZE=3D32=0A=
CONFIG_SMC1_UART_TX_BDNUM=3D4=0A=
CONFIG_SMC1_UART_TX_BDSIZE=3D32=0A=
CONFIG_SMC2_UART=3Dy=0A=
# CONFIG_ALTSMC2 is not set=0A=
# CONFIG_CONS_SMC2 is not set=0A=
CONFIG_UART_MAXIDL_SMC2=3D1=0A=
CONFIG_SMC2_UART_RX_BDNUM=3D4=0A=
CONFIG_SMC2_UART_RX_BDSIZE=3D32=0A=
CONFIG_SMC2_UART_TX_BDNUM=3D4=0A=
CONFIG_SMC2_UART_TX_BDSIZE=3D32=0A=
# CONFIG_USE_SCC_IO is not set=0A=
CONFIG_8xx_COPYBACK=3Dy=0A=
# CONFIG_8xx_CPU6 is not set=0A=
# CONFIG_UCODE_PATCH is not set=0A=
# CONFIG_8xx_LCD is not set=0A=
# CONFIG_8xx_BUZZER is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=

------_=_NextPart_000_01C15B08.FE5E4FC0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
