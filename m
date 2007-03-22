Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (loki.aehr.com [207.168.29.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEA17DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 14:44:46 +1100 (EST)
Received: from tmaenner.aehr.com (tmaenner.aehr.com [198.49.134.37])
	by loki.aehr.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	l2M3ifHp013097
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Mar 2007 20:44:42 -0700
From: Thomas Maenner <tmaenner@aehr.com>
To: linuxppc-embedded@ozlabs.org
Subject: TQM 860L, 64MB RAM, ELDK4.1, TQM860L, Kernel 2.6.19
Date: Wed, 21 Mar 2007 20:44:40 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703212044.40611.tmaenner@aehr.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone,

need from the experts on the list again.
The CPU freezes after the ramdisk gets loaded!

Trying get a working kernel: boot from flash and use ramdisk from flash with 
the following configuration:
TQM 860L, 64MB RAM (not 16MB as the standard module)
ELDK4.1
Kernel 2.6.19 from ELDK
u-boot 1.1.6

u-boot environment:
=> printenv
bootcmd=run flash_self
bootdelay=5
baudrate=115200
loads_echo=1
preboot=echo;echo TQ-Module Bootloader for ABTS;echo Type "run flash_nfs" to 
mount root filesystem over NFS;echo
netdev=eth0
nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath}
addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:
${netmask}:${hostname}:${netdev}:off panic=1
flash_nfs=run nfsargs addip;bootm ${kernel_addr}
flash_self=run ramargs addip;bootm ${kernel_addr} ${ramdisk_addr}
net_nfs=tftp 200000 ${bootfile};run nfsargs addip;bootm
rootpath=/opt/eldk/ppc_8xx
kernel_addr=40040000
serial#=TQM860LDDBA3-P80.210 11090659
ethaddr=00:D0:93:04:DC:1B
eth1addr=00:D0:93:04:DC:1B
ethprime=FEC ETHERNET
bootfile=/TQM860L/uImage
fileaddr=100000
ramdisk_addr=40200000
ramargs=setenv bootargs ramdisk_size=6144 root=/dev/ram rw
initrd_high=30000000
stdin=serial
stdout=serial
stderr=serial
ethact=FEC ETHERNET
bootcount=39

Environment size: 928/16379 bytes
-----

Output after u-boot boot:
=> boot
## Booting image at 40040000 ...
   Image Name:   Linux-2.6.19.2
   Created:      2007-03-22   3:22:04 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    738664 Bytes = 721.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 40200000 ...
   Image Name:   Simple Embedded Linux Framework
   Created:      2007-01-20  23:09:28 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1589504 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 03e24000, end 03fa8100 ... OK
<<< CPU / module freezes after that >>>

kernel .config:
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_BLOCK=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_8xx=y
CONFIG_MATH_EMULATION=y
CONFIG_EMBEDDEDBOOT=y
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_TQM860L=y
CONFIG_TQM8xxL=y
CONFIG_CPM1=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_PREEMPT_NONE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_BINFMT_ELF=y
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x00400000
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_ROM=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_TQM8XXL=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=6144
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_USE_MDIO=y
CONFIG_INPUT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
CONFIG_SERIAL_CPM_SMC1=y
CONFIG_UNIX98_PTYS=y
CONFIG_GEN_RTC=y
CONFIG_HWMON=y
CONFIG_EXT2_FS=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_DNOTIFY=y
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SCC_ENET=y
CONFIG_SCC2_ENET=y
CONFIG_FEC_ENET=y
CONFIG_FEC_LXT971=y
CONFIG_ENET_BIG_BUFFERS=y
CONFIG_8xx_COPYBACK=y
CONFIG_I2C_SPI_UCODE_PATCH=y
CONFIG_UCODE_PATCH=y
CONFIG_PLIST=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_LOG_BUF_SHIFT=14
---

Sorry for the long post and thanks in advance
Tom

-- 
Thomas Maenner
E-Mail: mailto:tmaenner@aehr.com
