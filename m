Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 32C9DB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 11:10:21 +1100 (EST)
Date: Thu, 23 Feb 2012 11:10:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: remove CONFIG_PPC_ISERIES from the architecture
 Kconfig files
Message-Id: <20120223111012.cf31162aeef3737bc7bc8b19@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__23_Feb_2012_11_10_12_+1100_YaIZsaE1ztcY_.nL"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Feb_2012_11_10_12_+1100_YaIZsaE1ztcY_.nL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After this, we can remove the legacy iSeries code more easily.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig                   |    2 +-
 arch/powerpc/Kconfig.debug             |    7 -
 arch/powerpc/configs/iseries_defconfig |  236 ----------------------------=
----
 arch/powerpc/platforms/Kconfig         |    3 +-
 arch/powerpc/platforms/iseries/Kconfig |   38 -----
 arch/powerpc/platforms/pseries/Kconfig |    2 +-
 6 files changed, 3 insertions(+), 285 deletions(-)
 delete mode 100644 arch/powerpc/configs/iseries_defconfig
 delete mode 100644 arch/powerpc/platforms/iseries/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1919634..e640107 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -611,7 +611,7 @@ endmenu
=20
 config ISA_DMA_API
 	bool
-	default !PPC_ISERIES || PCI
+	default PCI
=20
 menu "Bus options"
=20
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4ccb2a0..72d55db 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -196,13 +196,6 @@ config PPC_EARLY_DEBUG_MAPLE
 	help
 	  Select this to enable early debugging for Maple.
=20
-config PPC_EARLY_DEBUG_ISERIES
-	bool "iSeries HV Console"
-	depends on PPC_ISERIES
-	help
-	  Select this to enable early debugging for legacy iSeries. You need
-	  to hit "Ctrl-x Ctrl-x" to see the messages on the console.
-
 config PPC_EARLY_DEBUG_PAS_REALMODE
 	bool "PA Semi real mode"
 	depends on PPC_PASEMI
diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/=
iseries_defconfig
deleted file mode 100644
index 27c46d6..0000000
--- a/arch/powerpc/configs/iseries_defconfig
+++ /dev/null
@@ -1,236 +0,0 @@
-CONFIG_PPC64=3Dy
-CONFIG_SMP=3Dy
-CONFIG_EXPERIMENTAL=3Dy
-CONFIG_SYSVIPC=3Dy
-CONFIG_POSIX_MQUEUE=3Dy
-CONFIG_AUDIT=3Dy
-CONFIG_AUDITSYSCALL=3Dy
-CONFIG_IKCONFIG=3Dy
-CONFIG_IKCONFIG_PROC=3Dy
-CONFIG_BLK_DEV_INITRD=3Dy
-# CONFIG_COMPAT_BRK is not set
-CONFIG_MODULES=3Dy
-CONFIG_MODULE_UNLOAD=3Dy
-CONFIG_MODVERSIONS=3Dy
-CONFIG_MODULE_SRCVERSION_ALL=3Dy
-# CONFIG_PPC_PSERIES is not set
-CONFIG_LPARCFG=3Dy
-CONFIG_PPC_ISERIES=3Dy
-CONFIG_VIODASD=3Dy
-CONFIG_VIOCD=3Dm
-CONFIG_VIOTAPE=3Dm
-# CONFIG_PPC_PMAC is not set
-CONFIG_NO_HZ=3Dy
-CONFIG_HIGH_RES_TIMERS=3Dy
-CONFIG_IRQ_ALL_CPUS=3Dy
-# CONFIG_MIGRATION is not set
-CONFIG_PACKET=3Dy
-CONFIG_UNIX=3Dy
-CONFIG_XFRM_USER=3Dm
-CONFIG_XFRM_SUB_POLICY=3Dy
-CONFIG_NET_KEY=3Dm
-CONFIG_INET=3Dy
-CONFIG_IP_MULTICAST=3Dy
-CONFIG_NET_IPIP=3Dy
-CONFIG_SYN_COOKIES=3Dy
-CONFIG_INET_AH=3Dm
-CONFIG_INET_ESP=3Dm
-CONFIG_INET_IPCOMP=3Dm
-CONFIG_INET_XFRM_MODE_BEET=3Dm
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_NETFILTER=3Dy
-CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
-CONFIG_NETFILTER_NETLINK_LOG=3Dm
-CONFIG_NF_CONNTRACK=3Dm
-CONFIG_NF_CONNTRACK_EVENTS=3Dy
-# CONFIG_NF_CT_PROTO_SCTP is not set
-CONFIG_NF_CONNTRACK_FTP=3Dm
-CONFIG_NF_CONNTRACK_IRC=3Dm
-CONFIG_NF_CONNTRACK_TFTP=3Dm
-CONFIG_NF_CT_NETLINK=3Dm
-CONFIG_NETFILTER_TPROXY=3Dm
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
-CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
-CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
-CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
-CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
-CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
-CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
-CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
-CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
-CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
-CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
-CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
-CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
-CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
-CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
-CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
-CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
-CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
-CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
-CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
-CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
-CONFIG_NF_CONNTRACK_IPV4=3Dm
-CONFIG_IP_NF_QUEUE=3Dm
-CONFIG_IP_NF_IPTABLES=3Dm
-CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
-CONFIG_IP_NF_MATCH_ECN=3Dm
-CONFIG_IP_NF_MATCH_TTL=3Dm
-CONFIG_IP_NF_FILTER=3Dm
-CONFIG_IP_NF_TARGET_REJECT=3Dm
-CONFIG_IP_NF_TARGET_LOG=3Dm
-CONFIG_IP_NF_TARGET_ULOG=3Dm
-CONFIG_NF_NAT=3Dm
-CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
-CONFIG_IP_NF_TARGET_NETMAP=3Dm
-CONFIG_IP_NF_TARGET_REDIRECT=3Dm
-CONFIG_IP_NF_MANGLE=3Dm
-CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
-CONFIG_IP_NF_TARGET_ECN=3Dm
-CONFIG_IP_NF_TARGET_TTL=3Dm
-CONFIG_IP_NF_RAW=3Dm
-CONFIG_IP_NF_ARPTABLES=3Dm
-CONFIG_IP_NF_ARPFILTER=3Dm
-CONFIG_IP_NF_ARP_MANGLE=3Dm
-CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
-CONFIG_PROC_DEVICETREE=3Dy
-CONFIG_BLK_DEV_LOOP=3Dy
-CONFIG_BLK_DEV_NBD=3Dm
-CONFIG_BLK_DEV_RAM=3Dy
-CONFIG_BLK_DEV_RAM_SIZE=3D65536
-CONFIG_SCSI=3Dy
-CONFIG_BLK_DEV_SD=3Dy
-CONFIG_CHR_DEV_ST=3Dy
-CONFIG_BLK_DEV_SR=3Dy
-CONFIG_BLK_DEV_SR_VENDOR=3Dy
-CONFIG_CHR_DEV_SG=3Dy
-CONFIG_SCSI_MULTI_LUN=3Dy
-CONFIG_SCSI_CONSTANTS=3Dy
-CONFIG_SCSI_SPI_ATTRS=3Dy
-CONFIG_SCSI_FC_ATTRS=3Dy
-CONFIG_SCSI_SAS_LIBSAS=3Dm
-CONFIG_SCSI_IBMVSCSI=3Dm
-CONFIG_MD=3Dy
-CONFIG_BLK_DEV_MD=3Dy
-CONFIG_MD_LINEAR=3Dy
-CONFIG_MD_RAID0=3Dy
-CONFIG_MD_RAID1=3Dy
-CONFIG_MD_RAID10=3Dm
-CONFIG_MD_MULTIPATH=3Dm
-CONFIG_MD_FAULTY=3Dm
-CONFIG_BLK_DEV_DM=3Dy
-CONFIG_DM_CRYPT=3Dm
-CONFIG_DM_SNAPSHOT=3Dm
-CONFIG_DM_MIRROR=3Dm
-CONFIG_DM_ZERO=3Dm
-CONFIG_NETDEVICES=3Dy
-CONFIG_DUMMY=3Dm
-CONFIG_BONDING=3Dm
-CONFIG_TUN=3Dm
-CONFIG_NET_ETHERNET=3Dy
-CONFIG_NET_PCI=3Dy
-CONFIG_PCNET32=3Dy
-CONFIG_E100=3Dy
-CONFIG_ACENIC=3Dm
-CONFIG_E1000=3Dm
-CONFIG_ISERIES_VETH=3Dy
-CONFIG_PPP=3Dm
-CONFIG_PPP_ASYNC=3Dm
-CONFIG_PPP_SYNC_TTY=3Dm
-CONFIG_PPP_DEFLATE=3Dm
-CONFIG_PPP_BSDCOMP=3Dm
-CONFIG_PPPOE=3Dm
-CONFIG_NETCONSOLE=3Dy
-CONFIG_NETPOLL_TRAP=3Dy
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-CONFIG_SERIAL_ICOM=3Dm
-# CONFIG_HW_RANDOM is not set
-CONFIG_GEN_RTC=3Dy
-CONFIG_RAW_DRIVER=3Dy
-# CONFIG_HWMON is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_EXT2_FS=3Dy
-CONFIG_EXT2_FS_XATTR=3Dy
-CONFIG_EXT2_FS_POSIX_ACL=3Dy
-CONFIG_EXT2_FS_SECURITY=3Dy
-CONFIG_EXT2_FS_XIP=3Dy
-CONFIG_EXT3_FS=3Dy
-CONFIG_EXT3_FS_POSIX_ACL=3Dy
-CONFIG_EXT3_FS_SECURITY=3Dy
-CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
-CONFIG_JFS_FS=3Dm
-CONFIG_JFS_POSIX_ACL=3Dy
-CONFIG_JFS_SECURITY=3Dy
-CONFIG_XFS_FS=3Dm
-CONFIG_XFS_POSIX_ACL=3Dy
-CONFIG_GFS2_FS=3Dm
-CONFIG_AUTOFS_FS=3Dm
-CONFIG_ISO9660_FS=3Dy
-CONFIG_JOLIET=3Dy
-CONFIG_ZISOFS=3Dy
-CONFIG_UDF_FS=3Dm
-CONFIG_MSDOS_FS=3Dy
-CONFIG_VFAT_FS=3Dy
-CONFIG_PROC_KCORE=3Dy
-CONFIG_TMPFS=3Dy
-CONFIG_TMPFS_POSIX_ACL=3Dy
-CONFIG_CRAMFS=3Dy
-CONFIG_NFS_FS=3Dy
-CONFIG_NFS_V3=3Dy
-CONFIG_NFS_V3_ACL=3Dy
-CONFIG_NFS_V4=3Dy
-CONFIG_NFSD=3Dm
-CONFIG_NFSD_V3_ACL=3Dy
-CONFIG_NFSD_V4=3Dy
-CONFIG_RPCSEC_GSS_SPKM3=3Dm
-CONFIG_CIFS=3Dm
-CONFIG_CIFS_XATTR=3Dy
-CONFIG_CIFS_POSIX=3Dy
-CONFIG_NLS_CODEPAGE_437=3Dy
-CONFIG_NLS_ASCII=3Dy
-CONFIG_NLS_ISO8859_1=3Dy
-CONFIG_DLM=3Dm
-CONFIG_CRC_T10DIF=3Dy
-CONFIG_MAGIC_SYSRQ=3Dy
-CONFIG_DEBUG_FS=3Dy
-CONFIG_DEBUG_KERNEL=3Dy
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_LATENCYTOP=3Dy
-CONFIG_SYSCTL_SYSCALL_CHECK=3Dy
-CONFIG_DEBUG_STACKOVERFLOW=3Dy
-CONFIG_DEBUG_STACK_USAGE=3Dy
-CONFIG_CRYPTO_NULL=3Dm
-CONFIG_CRYPTO_TEST=3Dm
-CONFIG_CRYPTO_ECB=3Dm
-CONFIG_CRYPTO_PCBC=3Dm
-CONFIG_CRYPTO_HMAC=3Dy
-CONFIG_CRYPTO_MD4=3Dm
-CONFIG_CRYPTO_MICHAEL_MIC=3Dm
-CONFIG_CRYPTO_SHA256=3Dm
-CONFIG_CRYPTO_SHA512=3Dm
-CONFIG_CRYPTO_TGR192=3Dm
-CONFIG_CRYPTO_WP512=3Dm
-CONFIG_CRYPTO_AES=3Dm
-CONFIG_CRYPTO_ANUBIS=3Dm
-CONFIG_CRYPTO_ARC4=3Dm
-CONFIG_CRYPTO_BLOWFISH=3Dm
-CONFIG_CRYPTO_CAST6=3Dm
-CONFIG_CRYPTO_KHAZAD=3Dm
-CONFIG_CRYPTO_SEED=3Dm
-CONFIG_CRYPTO_SERPENT=3Dm
-CONFIG_CRYPTO_TEA=3Dm
-CONFIG_CRYPTO_TWOFISH=3Dm
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 0cfb46d..236ab67 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -2,7 +2,6 @@ menu "Platform support"
=20
 source "arch/powerpc/platforms/powernv/Kconfig"
 source "arch/powerpc/platforms/pseries/Kconfig"
-source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
 source "arch/powerpc/platforms/512x/Kconfig"
 source "arch/powerpc/platforms/52xx/Kconfig"
@@ -138,7 +137,7 @@ config MPIC_BROKEN_REGREAD
 	  of the register contents in software.
=20
 config IBMVIO
-	depends on PPC_PSERIES || PPC_ISERIES
+	depends on PPC_PSERIES
 	bool
 	default y
=20
diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platform=
s/iseries/Kconfig
deleted file mode 100644
index b57cda3..0000000
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ /dev/null
@@ -1,38 +0,0 @@
-config PPC_ISERIES
-	bool "IBM Legacy iSeries"
-	depends on PPC64 && PPC_BOOK3S
-	select PPC_SMP_MUXED_IPI
-	select PPC_INDIRECT_PIO
-	select PPC_INDIRECT_MMIO
-	select PPC_PCI_CHOICE if EXPERT
-
-menu "iSeries device drivers"
-	depends on PPC_ISERIES
-
-config VIODASD
-	tristate "iSeries Virtual I/O disk support"
-	depends on BLOCK
-	select VIOPATH
-	help
-	  If you are running on an iSeries system and you want to use
-	  virtual disks created and managed by OS/400, say Y.
-
-config VIOCD
-	tristate "iSeries Virtual I/O CD support"
-	depends on BLOCK
-	select VIOPATH
-	help
-	  If you are running Linux on an IBM iSeries system and you want to
-	  read a CD drive owned by OS/400, say Y here.
-
-config VIOTAPE
-	tristate "iSeries Virtual Tape Support"
-	select VIOPATH
-	help
-	  If you are running Linux on an iSeries system and you want Linux
-	  to read and/or write a tape drive owned by OS/400, say Y here.
-
-endmenu
-
-config VIOPATH
-	bool
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platform=
s/pseries/Kconfig
index 31f22c1..9c28847 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -72,7 +72,7 @@ config IO_EVENT_IRQ
=20
 config LPARCFG
 	bool "LPAR Configuration Data"
-	depends on PPC_PSERIES || PPC_ISERIES
+	depends on PPC_PSERIES
 	help
 	Provide system capacity information via human readable
 	<key word>=3D<value> pairs through a /proc/ppc64/lparcfg interface.
--=20
1.7.9.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Feb_2012_11_10_12_+1100_YaIZsaE1ztcY_.nL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPRYPkAAoJEECxmPOUX5FEUiQP/14kbgNkrf7/viwwf+8uQ6SY
L2tA/CjGT2fWgO84oVIBTJ0IyW2DZ75jSA5G1fjmnainKkk2so7w0Om1rjnW5dcs
bsbKAHo51vJHHnd/Z83ggt3HciSSQeJWieMzCu/IQfqZ24iVF29mT03/MxSpquyI
uav1ch7lAnLMSnuvx5gg35chBscJV2l8yFsq3SSWVMmdIUemI2eEtBO4euwt+f8i
Fcbx9WOrPpRN25J9T3H6j5PPbCQ4Yja2QzpclHDkk3Fve6iCt48l2DaN+sp9254K
MhOm9tp92w52ic/iDe2FXKk2IV6ZQb7Qa/YH7NHAesuI0aCahs7rR3kkmicYxkda
T4PYjlTB05KEki2I2tXtUtKlPVGQIJ5PCwbxsgNb034tOEPd9jZZ2VBJ+3RwGg8T
ZElEIllKmHelrU5+RKQIyWS5UlQW+jUDLrHYbGvO10uwQ01oFbI9ZH9srkYV4geU
pX7OqEgOnPNdaE6q/rwTJoHcuGMYuQKcsc0NpPSeyIIJgjKCb3MdR66oECXCNSTL
2Wxhvkhv6QDrKCOqsAnO6LuCTOX320rgd0NSwc2upM8iPmW/SZuAVaZpO8IHFNmE
/kDwnrIIBbIlLSDyuIATs5lWgR92M5aVPn/7vXm4rosgJiGR5nn1Zj5CkJpnx9kZ
b3GfvJX+QloCn/JY1W88
=qIYi
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Feb_2012_11_10_12_+1100_YaIZsaE1ztcY_.nL--
