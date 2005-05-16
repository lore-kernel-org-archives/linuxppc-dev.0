Return-Path: <tony.ford@quadrics.com>
Received: from qserv01.quadrics.com (mailgate.quadrics.com [194.202.174.11])
	by ozlabs.org (Postfix) with ESMTP id A7E0F679F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 23:31:09 +1000 (EST)
Received: from exch01.quadrics.com (exch01.quadrics.com [194.202.174.9])
	by qserv01.quadrics.com (Postfix) with ESMTP id E08545B40A3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 13:12:19 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 16 May 2005 14:00:19 +0100
Message-ID: <30062B7EA51A9045B9F605FAAC1B4F628EA95A@exch01.quadrics.com>
From: <tony.ford@quadrics.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Ethernet on A&M Rattler 8248
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Sorry, you guys must have heard this a million times but...

I'm having problems pinging out once Linux has booted. I use the=20
same interface to tftp the kernel image in u-boot. The interface appears
on FCC1 and both the kernel messages and ifconfig confirm that the
IP params are set. When I try to ping out I see TXpackets and carrier
increment using ifconfig.

I've tried changing the config until I'm blue in the face but I'm
obviously missing something.
Any pointers would be appreciated. I've attached the console log and
config file for your information. (I've masked part of the IP but
believe me it's the same number everywhere)

Console Log:
-----------

U-Boot 1.1.3 (May  5 2005 - 13:24:54)

MPC8248 Reset Status: External Soft, External Hard

MPC8248 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq =
100-300
 - dfbrg 1, corecnf 0x0a, busdf 3, cpmdf 1, plldf 0, pllmf 3
 - vco_out  400000000, scc_clk  100000000, brg_clk   25000000
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  100000000
 - pci_clk   33333333

CPU:   MPC8248 (HiP7 Rev 13, Mask 0.0 0K50M) at 400 MHz
Board: Rattler Rev. D
DRAM:  32 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC1 ETHERNET
Hit any key to stop autoboot:  0=20
=3D> tftpboot fe050000 uImage
Using FCC1 ETHERNET device
TFTP from server 194.xxx.174.19; our IP address is 194.xxx.174.30
Filename 'uImage'.
Load address: 0xfe050000
Loading: =
#################################################################
         =
#################################################################
         ########
done
Bytes transferred =3D 702468 (ab804 hex)
=3D> mboot fe050000 fe100000
Unknown command 'mboot' - try 'help'
=3D> bootm fe050000 fe100000
## Booting image at fe050000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    702404 Bytes =3D 685.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at fe100000 ...
   Image Name:   Simple Embedded Linux Framework
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1400198 Bytes =3D  1.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 01a62000, end 01bb7d86 ... OK
Memory BAT mapping: BAT2=3D32Mb, BAT3=3D0Mb, residual: 0Mb
Linux version 2.4.25 (tony@foobar) (gcc version 3.3.3 (DENX ELDK 3.1.1 =
3.3.3-9)) #1 Fri May 1
3 14:19:00 BST 2005
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/ram rw =
ip=3D194.xxx.174.30:194.xxx.174.19:194.xxx.174.19:255.25
5.255.128:powerpc::
Warning: real time clock seems stuck!
Calibrating delay loop... 266.24 BogoMIPS
Memory: 29340k available (1204k kernel code, 408k data, 52k init, 0k =
highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
CPM UART driver version 0.01
ttyS0 on SMC1 at 0x0000, BRG7
ttyS1 on SMC2 at 0x0040, BRG8
ttyS2 on SCC1 at 0x8000, BRG1
ttyS3 on SCC2 at 0x8100, BRG2
pty: 256 Unix98 ptys configured
eth0: FCC1 ENET Version 0.4, 00:08:E5:11:22:33
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
IP-Config: Complete:
      device=3Deth0, addr=3D194.xxx.174.30, mask=3D255.255.255.128, =
gw=3D194.xxx.174.19,
     host=3Dpowerpc, domain=3D, nis-domain=3D(none),
     bootserver=3D194.xxx.174.19, rootserver=3D194.xxx.174.19, =
rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1367k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 52k init
### Application running ...


BusyBox v0.60.1 (2002.10.24-02:29+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:08:E5:11:22:33 =20
          inet addr:194.xxx.174.30  Bcast:194.xxx.174.127  =
Mask:255.255.255.128
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Base address:0x8400=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

/* ping myself - works */
# ping 194.xxx.174.30
194.xxx.174.30 is alive!

/* ping tftp server - don't works */
# ping 194.xxx.174.19
No response from 194.xxx.174.19
#=20
# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use =
Iface
194.xxx.174.0   *               255.255.255.128 U     0      0        0 =
eth0



Config file: (I've chopped sections where no config vars have been
              set to try to limit the size of this mail)
------------

#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
# CONFIG_HAVE_DEC_LOCK is not set

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
# CONFIG_ADVANCED_OPTIONS is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# Platform support
#
CONFIG_PPC=3Dy
CONFIG_PPC32=3Dy
CONFIG_6xx=3Dy
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E500 is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
CONFIG_8260=3Dy
CONFIG_PPC_STD_MMU=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SERIAL_TEXT_DEBUG=3Dy
# CONFIG_ATC is not set
# CONFIG_ADS8260 is not set
# CONFIG_EST8260 is not set
# CONFIG_PM826 is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
# CONFIG_TQM8260=3Dy
CONFIG_QS10G=3Dy
# CONFIG_CPU86 is not set
# CONFIG_MEG32 is not set
# CONFIG_WILLOW is not set
# CONFIG_SMP is not set
CONFIG_EMBEDDEDBOOT=3Dy

#
# General setup
#
# CONFIG_BIGPHYS_AREA is not set
# CONFIG_HIGHMEM is not set
CONFIG_HIGHMEM_START=3D0xfe000000
CONFIG_LOWMEM_SIZE=3D0x30000000
CONFIG_KERNEL_START=3D0xc0000000
CONFIG_TASK_SIZE=3D0x80000000
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
# CONFIG_PCI is not set
# CONFIG_8260_PCI9 is not set
# CONFIG_PC_KEYBOARD is not set
CONFIG_NET=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_KERNEL_ELF=3Dy
# CONFIG_BINFMT_MISC is not set
# CONFIG_OOM_KILLER is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dy
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=3Dy
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=3Dy

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dy
CONFIG_MTD_BLOCK=3Dy
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=3Dy
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
CONFIG_MTD_CFI_NOSWAP=3Dy
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
CONFIG_MTD_MAP_BANK_WIDTH_8=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_I4=3Dy
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=3Dy
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set,m=20
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy
# CONFIG_BLK_STATS is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=3Dy
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set


#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_GMAC is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy


#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_JFFS2_FS=3Dy
CONFIG_JFFS2_FS_DEBUG=3D0
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_RTIME=3Dy
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_LZO is not set
# CONFIG_JFFS2_LZARI is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=3Dy
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_PROC=3Dy
CONFIG_CRAMFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_DIRECTIO is not set
CONFIG_ROOT_NFS=3Dy
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# MPC8260 CPM Options
#
# CONFIG_SCC_CONSOLE is not set
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=3Dy
CONFIG_FCC1_ENET=3Dy
# CONFIG_FCC2_ENET is not set
# CONFIG_FCC3_ENET is not set
# CONFIG_USE_MDIO is not set
# CONFIG_FCC_LXT970 is not set
# CONFIG_FCC_LXT971 is not set
# CONFIG_FCC_QS6612 is not set
# CONFIG_FCC_AMD79C873 is not set
# CONFIG_FCC_DM9131 is not set
# CONFIG_CPM_SPI is not set

#
# SCC UART h/w handshaking options
#

#
#   SCC1
#
CONFIG_PORT_CTS1_NONE=3Dy
# CONFIG_CTS1_15 is not set
# CONFIG_CTS1_29 is not set
CONFIG_PORT_RTS1_NONE=3Dy
# CONFIG_UART_RTS_CONTROL_SCC1 is not set
CONFIG_PORT_CD1_NONE=3Dy
# CONFIG_UART_CD_CONTROL_SCC1 is not set
CONFIG_PORT_DTR1_NONE=3Dy
# CONFIG_PORT_DTR1_A is not set
# CONFIG_PORT_DTR1_B is not set
# CONFIG_PORT_DTR1_C is not set
# CONFIG_PORT_DTR1_D is not set

#
#   SCC2
#
CONFIG_PORT_CTS2_NONE=3Dy
# CONFIG_CTS2_13 is not set
# CONFIG_CTS2_28 is not set
CONFIG_PORT_RTS2_NONE=3Dy
# CONFIG_UART_RTS_CONTROL_SCC2 is not set
CONFIG_PORT_CD2_NONE=3Dy
# CONFIG_UART_CD_CONTROL_SCC2 is not set
CONFIG_PORT_DTR2_NONE=3Dy
# CONFIG_PORT_DTR2_A is not set
# CONFIG_PORT_DTR2_B is not set
# CONFIG_PORT_DTR2_C is not set
# CONFIG_PORT_DTR2_D is not set

#
#   SCC3
#
CONFIG_PORT_CTS3_NONE=3Dy
# CONFIG_UART_CTS_CONTROL_SCC3 is not set
CONFIG_PORT_RTS3_NONE=3Dy
# CONFIG_UART_RTS_CONTROL_SCC3 is not set
CONFIG_PORT_CD3_NONE=3Dy
# CONFIG_UART_CD_CONTROL_SCC3 is not set
CONFIG_PORT_DTR3_NONE=3Dy
# CONFIG_PORT_DTR3_A is not set
# CONFIG_PORT_DTR3_B is not set
# CONFIG_PORT_DTR3_C is not set
# CONFIG_PORT_DTR3_D is not set

#
#  SCC4
#
CONFIG_PORT_CTS4_NONE=3Dy
# CONFIG_UART_CTS_CONTROL_SCC4 is not set
CONFIG_PORT_RTS4_NONE=3Dy
# CONFIG_UART_RTS_CONTROL_SCC4 is not set
CONFIG_PORT_CD4_NONE=3Dy
# CONFIG_UART_CD_CONTROL_SCC4 is not set
CONFIG_PORT_DTR4_NONE=3Dy
# CONFIG_PORT_DTR4_A is not set
# CONFIG_PORT_DTR4_B is not set
# CONFIG_PORT_DTR4_C is not set
# CONFIG_PORT_DTR4_D is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
# CONFIG_REED_SOLOMON is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=3D0




--
