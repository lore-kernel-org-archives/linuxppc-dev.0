Message-ID: <392527F3.D5CB2F06@raleigh.ibm.com>
Date: Fri, 19 May 2000 07:39:31 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting LinuxPPC
References: <00May19.143130est.115267@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel,

Although I am not an expert, I really think the lowest kernel base is
0x80000000.

This is because the Linux which we have assumes that we have memory from
0x0 - 0x7fffffff
avaliable for tasks. So I think the kernel will have to move above
0x80000000.

Chip


Daniel Wu wrote:
>
> Hi,
>
> I have a question about the embedded ppc port of Linux which I hope you can
> help me with.
>
> I compiled the mpc8xx-2.2.13 sources using the attached configuration for a
> MPC860T based board with 32MB of RAM. The output vmlinux file was downloaded to
>
> the target using a BDM debugger. I changed the KERNELLOAD and KERNELBASE to
> 1000000 instead of c0000000 so that the code is located at the start of the
> 16MB region.
>
> When I step through the code (.../arch/ppc/kernel/head.S), I see that the code
> is crashing after the rfi. The PC is 0x02000000 (32MB), which is greater than
> the available RAM. But I checked the value of r0 and it looks reasonable, ie.
> where the start_here is defined.
>
> *** Line 1753 ***
>
>         lis     r0,start_here@h
>         ori     r0,r0,start_here@l
> 1010:   mtspr   SRR0,r0
>         SYNC
>         rfi                             /* enables MMU */
>
> #ifdef CONFIG_SMP
>         .globl  __secondary_start_psurge
> __secondary_start_psurge:
>         li      r24,1                   /* cpu # */
>         b       __secondary_start
>
> etc.
>
> Do you have any suggestions to how to track down this problem? Is this
> introduced by the fact that I changed the address of the KERNELBASE?
>
> I hope you can help me here or point me in the right direction for
> documentation.
>
> Thanks in advance for your comments.
>
> Kind regards,
> Daniel
>
> PS. Please reply directly to me as I am not subscribed to the mailing list.
>
>   ------------------------------------------------------------------------
> #
> # Automatically generated make config: don't edit
> #
>
> #
> # Platform support
> #
> CONFIG_PPC=y
> # CONFIG_6xx is not set
> # CONFIG_PPC64 is not set
> CONFIG_8xx=y
> # CONFIG_MPC821 is not set
> # CONFIG_MPC823 is not set
> # CONFIG_MPC850 is not set
> # CONFIG_MPC860 is not set
> CONFIG_MPC860T=y
> CONFIG_SERIAL_CONSOLE=y
> # CONFIG_PMAC is not set
> # CONFIG_PREP is not set
> # CONFIG_CHRP is not set
> # CONFIG_ALL_PPC is not set
> # CONFIG_APUS is not set
> CONFIG_MBX=y
> # CONFIG_RPXLITE is not set
> # CONFIG_RPXCLASSIC is not set
> # CONFIG_BSEIP is not set
> # CONFIG_SMP is not set
> CONFIG_MACH_SPECIFIC=y
>
> #
> # General setup
> #
> # CONFIG_EXPERIMENTAL is not set
> CONFIG_MODULES=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> # CONFIG_PCI is not set
> # CONFIG_PCI_QUIRKS is not set
> CONFIG_NET=y
> CONFIG_SYSCTL=y
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_BINFMT_ELF=y
> CONFIG_KERNEL_ELF=y
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_BINFMT_JAVA is not set
> # CONFIG_PARPORT is not set
> # CONFIG_VGA_CONSOLE is not set
> # CONFIG_FB is not set
>
> #
> # Plug and Play support
> #
> # CONFIG_PNP is not set
>
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_BLK_DEV_IDE=y
>
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_IDE_CHIPSETS is not set
>
> #
> # Additional Block Devices
> #
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_MD is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_INITRD=y
> # CONFIG_BLK_DEV_XD is not set
> CONFIG_PARIDE_PARPORT=y
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_DEV_HD is not set
>
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_NETLINK=y
> # CONFIG_RTNETLINK is not set
> # CONFIG_NETLINK_DEV is not set
> # CONFIG_FIREWALL is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_IP_ROUTER is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> CONFIG_IP_ALIAS=y
> # CONFIG_SYN_COOKIES is not set
>
> #
> # (it is safe to leave these untouched)
> #
> CONFIG_INET_RARP=y
> CONFIG_SKB_LARGE=y
>
> #
> #
> #
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
>
> #
> # SCSI support
> #
> # CONFIG_SCSI is not set
> # CONFIG_SCSI_G_NCR5380_PORT is not set
> # CONFIG_SCSI_G_NCR5380_MEM is not set
>
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
>
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_SB1000 is not set
>
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_MACE is not set
> # CONFIG_BMAC is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_NET_ISA is not set
> # CONFIG_NET_EISA is not set
> # CONFIG_NET_POCKET is not set
> # CONFIG_FDDI is not set
> CONFIG_PPP=y
>
> #
> # CCP compressors for PPP are only built as modules.
> #
> CONFIG_SLIP=y
> # CONFIG_SLIP_COMPRESSED is not set
> # CONFIG_SLIP_SMART is not set
> # CONFIG_SLIP_MODE_SLIP6 is not set
> # CONFIG_NET_RADIO is not set
>
> #
> # Token ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
>
> #
> # Wan interfaces
> #
> # CONFIG_HOSTESS_SV11 is not set
> # CONFIG_COSA is not set
> # CONFIG_SEALEVEL_4021 is not set
> # CONFIG_DLCI is not set
> # CONFIG_WAN_DRIVERS is not set
> # CONFIG_SBNI is not set
>
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>
> #
> # Console drivers
> #
>
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> # CONFIG_SERIAL is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> # CONFIG_MOUSE is not set
> # CONFIG_QIC02_TAPE is not set
> # CONFIG_WATCHDOG is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
>
> #
> # Video For Linux
> #
> # CONFIG_VIDEO_DEV is not set
>
> #
> # Joystick support
> #
> # CONFIG_JOYSTICK is not set
> # CONFIG_DTLK is not set
>
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_FT_NORMAL_DEBUG is not set
> # CONFIG_FT_FULL_DEBUG is not set
> # CONFIG_FT_NO_TRACE is not set
> # CONFIG_FT_NO_TRACE_AT_ALL is not set
> # CONFIG_FT_STD_FDC is not set
> # CONFIG_FT_MACH2 is not set
> # CONFIG_FT_PROBE_FC10 is not set
> # CONFIG_FT_ALT_FDC is not set
>
> #
> # USB drivers - not for the faint of heart
> #
>
> #
> # Filesystems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=y
> # CONFIG_ISO9660_FS is not set
> # CONFIG_JOLIET is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=y
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
>
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> CONFIG_NFS_FS=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> # CONFIG_SMB_FS is not set
> # CONFIG_NCP_FS is not set
>
> #
> # Partition Types
> #
> # CONFIG_BSD_DISKLABEL is not set
> # CONFIG_MAC_PARTITION is not set
> # CONFIG_SMD_DISKLABEL is not set
> # CONFIG_SOLARIS_X86_PARTITION is not set
> CONFIG_NLS=y
>
> #
> # Native Language Support
> #
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=y
> # CONFIG_NLS_KOI8_R is not set
>
> #
> # Sound
> #
> # CONFIG_SOUND is not set
>
> #
> # MPC8xx CPM Options
> #
> # CONFIG_SCC_ENET is not set
> # CONFIG_FEC_ENET is not set
> # CONFIG_CPM_IIC is not set
> # CONFIG_UCODE_PATCH is not set
> # CONFIG_RPXLCD is not set
>
> #
> # Kernel hacking
> #
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_KGDB is not set
> # CONFIG_XMON is not set

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
