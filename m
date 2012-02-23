Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 58270B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 11:13:28 +1100 (EST)
Message-ID: <1329955991.20389.17.camel@pasglop>
Subject: Re: [PATCH] powerpc: remove CONFIG_PPC_ISERIES from the
 architecture Kconfig files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 23 Feb 2012 11:13:11 +1100
In-Reply-To: <20120223111012.cf31162aeef3737bc7bc8b19@canb.auug.org.au>
References: <20120223111012.cf31162aeef3737bc7bc8b19@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-23 at 11:10 +1100, Stephen Rothwell wrote:
> After this, we can remove the legacy iSeries code more easily.

This is the LAST CALL for objections ... I intend to put that in
-next early next week so speak up NOW if you disagree.

Cheers,
Ben.

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/Kconfig                   |    2 +-
>  arch/powerpc/Kconfig.debug             |    7 -
>  arch/powerpc/configs/iseries_defconfig |  236 --------------------------------
>  arch/powerpc/platforms/Kconfig         |    3 +-
>  arch/powerpc/platforms/iseries/Kconfig |   38 -----
>  arch/powerpc/platforms/pseries/Kconfig |    2 +-
>  6 files changed, 3 insertions(+), 285 deletions(-)
>  delete mode 100644 arch/powerpc/configs/iseries_defconfig
>  delete mode 100644 arch/powerpc/platforms/iseries/Kconfig
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1919634..e640107 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -611,7 +611,7 @@ endmenu
>  
>  config ISA_DMA_API
>  	bool
> -	default !PPC_ISERIES || PCI
> +	default PCI
>  
>  menu "Bus options"
>  
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4ccb2a0..72d55db 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -196,13 +196,6 @@ config PPC_EARLY_DEBUG_MAPLE
>  	help
>  	  Select this to enable early debugging for Maple.
>  
> -config PPC_EARLY_DEBUG_ISERIES
> -	bool "iSeries HV Console"
> -	depends on PPC_ISERIES
> -	help
> -	  Select this to enable early debugging for legacy iSeries. You need
> -	  to hit "Ctrl-x Ctrl-x" to see the messages on the console.
> -
>  config PPC_EARLY_DEBUG_PAS_REALMODE
>  	bool "PA Semi real mode"
>  	depends on PPC_PASEMI
> diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
> deleted file mode 100644
> index 27c46d6..0000000
> --- a/arch/powerpc/configs/iseries_defconfig
> +++ /dev/null
> @@ -1,236 +0,0 @@
> -CONFIG_PPC64=y
> -CONFIG_SMP=y
> -CONFIG_EXPERIMENTAL=y
> -CONFIG_SYSVIPC=y
> -CONFIG_POSIX_MQUEUE=y
> -CONFIG_AUDIT=y
> -CONFIG_AUDITSYSCALL=y
> -CONFIG_IKCONFIG=y
> -CONFIG_IKCONFIG_PROC=y
> -CONFIG_BLK_DEV_INITRD=y
> -# CONFIG_COMPAT_BRK is not set
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_MODVERSIONS=y
> -CONFIG_MODULE_SRCVERSION_ALL=y
> -# CONFIG_PPC_PSERIES is not set
> -CONFIG_LPARCFG=y
> -CONFIG_PPC_ISERIES=y
> -CONFIG_VIODASD=y
> -CONFIG_VIOCD=m
> -CONFIG_VIOTAPE=m
> -# CONFIG_PPC_PMAC is not set
> -CONFIG_NO_HZ=y
> -CONFIG_HIGH_RES_TIMERS=y
> -CONFIG_IRQ_ALL_CPUS=y
> -# CONFIG_MIGRATION is not set
> -CONFIG_PACKET=y
> -CONFIG_UNIX=y
> -CONFIG_XFRM_USER=m
> -CONFIG_XFRM_SUB_POLICY=y
> -CONFIG_NET_KEY=m
> -CONFIG_INET=y
> -CONFIG_IP_MULTICAST=y
> -CONFIG_NET_IPIP=y
> -CONFIG_SYN_COOKIES=y
> -CONFIG_INET_AH=m
> -CONFIG_INET_ESP=m
> -CONFIG_INET_IPCOMP=m
> -CONFIG_INET_XFRM_MODE_BEET=m
> -# CONFIG_INET_LRO is not set
> -# CONFIG_IPV6 is not set
> -CONFIG_NETFILTER=y
> -CONFIG_NETFILTER_NETLINK_QUEUE=m
> -CONFIG_NETFILTER_NETLINK_LOG=m
> -CONFIG_NF_CONNTRACK=m
> -CONFIG_NF_CONNTRACK_EVENTS=y
> -# CONFIG_NF_CT_PROTO_SCTP is not set
> -CONFIG_NF_CONNTRACK_FTP=m
> -CONFIG_NF_CONNTRACK_IRC=m
> -CONFIG_NF_CONNTRACK_TFTP=m
> -CONFIG_NF_CT_NETLINK=m
> -CONFIG_NETFILTER_TPROXY=m
> -CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> -CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> -CONFIG_NETFILTER_XT_TARGET_DSCP=m
> -CONFIG_NETFILTER_XT_TARGET_MARK=m
> -CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> -CONFIG_NETFILTER_XT_TARGET_TPROXY=m
> -CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m
> -CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> -CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> -CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> -CONFIG_NETFILTER_XT_MATCH_DSCP=m
> -CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
> -CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> -CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> -CONFIG_NETFILTER_XT_MATCH_MAC=m
> -CONFIG_NETFILTER_XT_MATCH_MARK=m
> -CONFIG_NETFILTER_XT_MATCH_OWNER=m
> -CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
> -CONFIG_NETFILTER_XT_MATCH_RATEEST=m
> -CONFIG_NETFILTER_XT_MATCH_REALM=m
> -CONFIG_NETFILTER_XT_MATCH_RECENT=m
> -CONFIG_NETFILTER_XT_MATCH_STRING=m
> -CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> -CONFIG_NETFILTER_XT_MATCH_TIME=m
> -CONFIG_NF_CONNTRACK_IPV4=m
> -CONFIG_IP_NF_QUEUE=m
> -CONFIG_IP_NF_IPTABLES=m
> -CONFIG_IP_NF_MATCH_ADDRTYPE=m
> -CONFIG_IP_NF_MATCH_ECN=m
> -CONFIG_IP_NF_MATCH_TTL=m
> -CONFIG_IP_NF_FILTER=m
> -CONFIG_IP_NF_TARGET_REJECT=m
> -CONFIG_IP_NF_TARGET_LOG=m
> -CONFIG_IP_NF_TARGET_ULOG=m
> -CONFIG_NF_NAT=m
> -CONFIG_IP_NF_TARGET_MASQUERADE=m
> -CONFIG_IP_NF_TARGET_NETMAP=m
> -CONFIG_IP_NF_TARGET_REDIRECT=m
> -CONFIG_IP_NF_MANGLE=m
> -CONFIG_IP_NF_TARGET_CLUSTERIP=m
> -CONFIG_IP_NF_TARGET_ECN=m
> -CONFIG_IP_NF_TARGET_TTL=m
> -CONFIG_IP_NF_RAW=m
> -CONFIG_IP_NF_ARPTABLES=m
> -CONFIG_IP_NF_ARPFILTER=m
> -CONFIG_IP_NF_ARP_MANGLE=m
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> -CONFIG_PROC_DEVICETREE=y
> -CONFIG_BLK_DEV_LOOP=y
> -CONFIG_BLK_DEV_NBD=m
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_BLK_DEV_RAM_SIZE=65536
> -CONFIG_SCSI=y
> -CONFIG_BLK_DEV_SD=y
> -CONFIG_CHR_DEV_ST=y
> -CONFIG_BLK_DEV_SR=y
> -CONFIG_BLK_DEV_SR_VENDOR=y
> -CONFIG_CHR_DEV_SG=y
> -CONFIG_SCSI_MULTI_LUN=y
> -CONFIG_SCSI_CONSTANTS=y
> -CONFIG_SCSI_SPI_ATTRS=y
> -CONFIG_SCSI_FC_ATTRS=y
> -CONFIG_SCSI_SAS_LIBSAS=m
> -CONFIG_SCSI_IBMVSCSI=m
> -CONFIG_MD=y
> -CONFIG_BLK_DEV_MD=y
> -CONFIG_MD_LINEAR=y
> -CONFIG_MD_RAID0=y
> -CONFIG_MD_RAID1=y
> -CONFIG_MD_RAID10=m
> -CONFIG_MD_MULTIPATH=m
> -CONFIG_MD_FAULTY=m
> -CONFIG_BLK_DEV_DM=y
> -CONFIG_DM_CRYPT=m
> -CONFIG_DM_SNAPSHOT=m
> -CONFIG_DM_MIRROR=m
> -CONFIG_DM_ZERO=m
> -CONFIG_NETDEVICES=y
> -CONFIG_DUMMY=m
> -CONFIG_BONDING=m
> -CONFIG_TUN=m
> -CONFIG_NET_ETHERNET=y
> -CONFIG_NET_PCI=y
> -CONFIG_PCNET32=y
> -CONFIG_E100=y
> -CONFIG_ACENIC=m
> -CONFIG_E1000=m
> -CONFIG_ISERIES_VETH=y
> -CONFIG_PPP=m
> -CONFIG_PPP_ASYNC=m
> -CONFIG_PPP_SYNC_TTY=m
> -CONFIG_PPP_DEFLATE=m
> -CONFIG_PPP_BSDCOMP=m
> -CONFIG_PPPOE=m
> -CONFIG_NETCONSOLE=y
> -CONFIG_NETPOLL_TRAP=y
> -# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> -# CONFIG_INPUT_KEYBOARD is not set
> -# CONFIG_INPUT_MOUSE is not set
> -# CONFIG_SERIO is not set
> -CONFIG_SERIAL_ICOM=m
> -# CONFIG_HW_RANDOM is not set
> -CONFIG_GEN_RTC=y
> -CONFIG_RAW_DRIVER=y
> -# CONFIG_HWMON is not set
> -# CONFIG_HID_SUPPORT is not set
> -# CONFIG_USB_SUPPORT is not set
> -CONFIG_EXT2_FS=y
> -CONFIG_EXT2_FS_XATTR=y
> -CONFIG_EXT2_FS_POSIX_ACL=y
> -CONFIG_EXT2_FS_SECURITY=y
> -CONFIG_EXT2_FS_XIP=y
> -CONFIG_EXT3_FS=y
> -CONFIG_EXT3_FS_POSIX_ACL=y
> -CONFIG_EXT3_FS_SECURITY=y
> -CONFIG_EXT4_FS=y
> -CONFIG_REISERFS_FS=y
> -CONFIG_REISERFS_FS_XATTR=y
> -CONFIG_REISERFS_FS_POSIX_ACL=y
> -CONFIG_REISERFS_FS_SECURITY=y
> -CONFIG_JFS_FS=m
> -CONFIG_JFS_POSIX_ACL=y
> -CONFIG_JFS_SECURITY=y
> -CONFIG_XFS_FS=m
> -CONFIG_XFS_POSIX_ACL=y
> -CONFIG_GFS2_FS=m
> -CONFIG_AUTOFS_FS=m
> -CONFIG_ISO9660_FS=y
> -CONFIG_JOLIET=y
> -CONFIG_ZISOFS=y
> -CONFIG_UDF_FS=m
> -CONFIG_MSDOS_FS=y
> -CONFIG_VFAT_FS=y
> -CONFIG_PROC_KCORE=y
> -CONFIG_TMPFS=y
> -CONFIG_TMPFS_POSIX_ACL=y
> -CONFIG_CRAMFS=y
> -CONFIG_NFS_FS=y
> -CONFIG_NFS_V3=y
> -CONFIG_NFS_V3_ACL=y
> -CONFIG_NFS_V4=y
> -CONFIG_NFSD=m
> -CONFIG_NFSD_V3_ACL=y
> -CONFIG_NFSD_V4=y
> -CONFIG_RPCSEC_GSS_SPKM3=m
> -CONFIG_CIFS=m
> -CONFIG_CIFS_XATTR=y
> -CONFIG_CIFS_POSIX=y
> -CONFIG_NLS_CODEPAGE_437=y
> -CONFIG_NLS_ASCII=y
> -CONFIG_NLS_ISO8859_1=y
> -CONFIG_DLM=m
> -CONFIG_CRC_T10DIF=y
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DEBUG_FS=y
> -CONFIG_DEBUG_KERNEL=y
> -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> -CONFIG_LATENCYTOP=y
> -CONFIG_SYSCTL_SYSCALL_CHECK=y
> -CONFIG_DEBUG_STACKOVERFLOW=y
> -CONFIG_DEBUG_STACK_USAGE=y
> -CONFIG_CRYPTO_NULL=m
> -CONFIG_CRYPTO_TEST=m
> -CONFIG_CRYPTO_ECB=m
> -CONFIG_CRYPTO_PCBC=m
> -CONFIG_CRYPTO_HMAC=y
> -CONFIG_CRYPTO_MD4=m
> -CONFIG_CRYPTO_MICHAEL_MIC=m
> -CONFIG_CRYPTO_SHA256=m
> -CONFIG_CRYPTO_SHA512=m
> -CONFIG_CRYPTO_TGR192=m
> -CONFIG_CRYPTO_WP512=m
> -CONFIG_CRYPTO_AES=m
> -CONFIG_CRYPTO_ANUBIS=m
> -CONFIG_CRYPTO_ARC4=m
> -CONFIG_CRYPTO_BLOWFISH=m
> -CONFIG_CRYPTO_CAST6=m
> -CONFIG_CRYPTO_KHAZAD=m
> -CONFIG_CRYPTO_SEED=m
> -CONFIG_CRYPTO_SERPENT=m
> -CONFIG_CRYPTO_TEA=m
> -CONFIG_CRYPTO_TWOFISH=m
> -# CONFIG_CRYPTO_ANSI_CPRNG is not set
> -# CONFIG_CRYPTO_HW is not set
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 0cfb46d..236ab67 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -2,7 +2,6 @@ menu "Platform support"
>  
>  source "arch/powerpc/platforms/powernv/Kconfig"
>  source "arch/powerpc/platforms/pseries/Kconfig"
> -source "arch/powerpc/platforms/iseries/Kconfig"
>  source "arch/powerpc/platforms/chrp/Kconfig"
>  source "arch/powerpc/platforms/512x/Kconfig"
>  source "arch/powerpc/platforms/52xx/Kconfig"
> @@ -138,7 +137,7 @@ config MPIC_BROKEN_REGREAD
>  	  of the register contents in software.
>  
>  config IBMVIO
> -	depends on PPC_PSERIES || PPC_ISERIES
> +	depends on PPC_PSERIES
>  	bool
>  	default y
>  
> diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
> deleted file mode 100644
> index b57cda3..0000000
> --- a/arch/powerpc/platforms/iseries/Kconfig
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -config PPC_ISERIES
> -	bool "IBM Legacy iSeries"
> -	depends on PPC64 && PPC_BOOK3S
> -	select PPC_SMP_MUXED_IPI
> -	select PPC_INDIRECT_PIO
> -	select PPC_INDIRECT_MMIO
> -	select PPC_PCI_CHOICE if EXPERT
> -
> -menu "iSeries device drivers"
> -	depends on PPC_ISERIES
> -
> -config VIODASD
> -	tristate "iSeries Virtual I/O disk support"
> -	depends on BLOCK
> -	select VIOPATH
> -	help
> -	  If you are running on an iSeries system and you want to use
> -	  virtual disks created and managed by OS/400, say Y.
> -
> -config VIOCD
> -	tristate "iSeries Virtual I/O CD support"
> -	depends on BLOCK
> -	select VIOPATH
> -	help
> -	  If you are running Linux on an IBM iSeries system and you want to
> -	  read a CD drive owned by OS/400, say Y here.
> -
> -config VIOTAPE
> -	tristate "iSeries Virtual Tape Support"
> -	select VIOPATH
> -	help
> -	  If you are running Linux on an iSeries system and you want Linux
> -	  to read and/or write a tape drive owned by OS/400, say Y here.
> -
> -endmenu
> -
> -config VIOPATH
> -	bool
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 31f22c1..9c28847 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -72,7 +72,7 @@ config IO_EVENT_IRQ
>  
>  config LPARCFG
>  	bool "LPAR Configuration Data"
> -	depends on PPC_PSERIES || PPC_ISERIES
> +	depends on PPC_PSERIES
>  	help
>  	Provide system capacity information via human readable
>  	<key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
> -- 
> 1.7.9.1
> 
