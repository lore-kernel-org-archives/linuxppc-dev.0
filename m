Return-Path: <tnt@246tNt.com>
Received: from outmx018.isp.belgacom.be (outmx018.isp.belgacom.be
	[195.238.2.117]) by ozlabs.org (Postfix) with ESMTP id 31CA72BF0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 12:27:06 +1100 (EST)
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
	by outmx018.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iB81Qts5030589
	for <linuxppc-embedded@ozlabs.org>; Wed, 8 Dec 2004 02:26:55 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41B6583D.5000604@246tNt.com>
Date: Wed, 08 Dec 2004 02:26:21 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: ivica@asist-traffic.com
References: <41B5F22F.2020403@asist-traffic.com>
In-Reply-To: <41B5F22F.2020403@asist-traffic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: booting linux-2.5-mpc52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Your problem look like a serial misconfig.

Before looking for a more complex problem, check that
the kernel command line u-boot gives to the kernel contains 'console=ttyS0'


Sylvain


ivica@asist-traffic.com wrote:

> Hi!
>
> I have a lite5200 "clone" board on which I successfully booted several 
> 2.4 kernels.
> -kernel from DENX ELDK 3.1
> -kernel from DENX CVS
> -metrowerks 2.4 kernel
> The only problem was I couldn't get first two kernels to boot file 
> system over NFS.
> Third one worked.
>
> Looks like I will have to write support for RX-8025 RTC chip which is 
> I2C bus
> interface-compliant. This will be my first attempt to write a kernel 
> driver so I'm
> taking all the curves I can. And I'm in a hurry.(aren't we all :D )
> While looking trough menuconfig of Sylvain's kernel tree I noticed a 
> chip from
> Epson(8564) that is also a RTC based on I2C. I though I would take it 
> as a base
> and change the code according to my specs. Also I like the nice 
> structure of 2.6
> tree(I2C dir). It makes things much more clear for a first timer. But 
> I could be
> wrong of course  and implementing it with 2.4 could be easier.
>
> Anyway, first I need to boot the 2.6 kernel. After countless 
> menuconfigs and compiles I'm still
> stuck at the beginning. This is the point I get to:
> ----------------------------------------------------------------------------------------------- 
>
> => bootm 200000
> ## Booting image at 00200000 ...
>   Image Name:   Linux-2.6.10-rc2
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    598930 Bytes = 584.9 kB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> setup_arch: enter
> setup_arch: bootmem
> ocp: exit
> arch: exit
>
> ---------------------------------------------------------------------------------------------------- 
>
>            I found out this are the last functions in 
> arc/ppc/kernel/setup.c .
> Where does the startup process go from here? What could be causing 
> problems?
> Any help would be greatly appreciated. I'm kind of stuck here.
> I will attach my config file.
>
> TIA,
> Ivica
>
>------------------------------------------------------------------------
>
>#
># Automatically generated make config: don't edit
># Linux kernel version: 2.6.10-rc2
># Tue Dec  7 19:06:28 2004
>#
>CONFIG_MMU=y
>CONFIG_GENERIC_HARDIRQS=y
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_HAVE_DEC_LOCK=y
>CONFIG_PPC=y
>CONFIG_PPC32=y
>CONFIG_GENERIC_NVRAM=y
>
>#
># Code maturity level options
>#
>CONFIG_EXPERIMENTAL=y
>CONFIG_CLEAN_COMPILE=y
>CONFIG_BROKEN_ON_SMP=y
>
>#
># General setup
>#
>CONFIG_LOCALVERSION=""
>CONFIG_SWAP=y
>CONFIG_SYSVIPC=y
>CONFIG_BSD_PROCESS_ACCT=y
># CONFIG_BSD_PROCESS_ACCT_V3 is not set
>CONFIG_SYSCTL=y
># CONFIG_AUDIT is not set
>CONFIG_LOG_BUF_SHIFT=14
># CONFIG_HOTPLUG is not set
># CONFIG_IKCONFIG is not set
># CONFIG_EMBEDDED is not set
>CONFIG_KALLSYMS=y
># CONFIG_KALLSYMS_EXTRA_PASS is not set
>CONFIG_FUTEX=y
>CONFIG_EPOLL=y
># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>CONFIG_SHMEM=y
>CONFIG_CC_ALIGN_FUNCTIONS=0
>CONFIG_CC_ALIGN_LABELS=0
>CONFIG_CC_ALIGN_LOOPS=0
>CONFIG_CC_ALIGN_JUMPS=0
># CONFIG_TINY_SHMEM is not set
>
>#
># Loadable module support
>#
># CONFIG_MODULES is not set
>
>#
># Processor
>#
>CONFIG_6xx=y
># CONFIG_40x is not set
># CONFIG_44x is not set
># CONFIG_POWER3 is not set
># CONFIG_POWER4 is not set
># CONFIG_8xx is not set
># CONFIG_E500 is not set
># CONFIG_ALTIVEC is not set
># CONFIG_TAU is not set
># CONFIG_CPU_FREQ is not set
>CONFIG_FSL_OCP=y
>CONFIG_PPC_STD_MMU=y
>
>#
># Platform options
>#
># CONFIG_PPC_MULTIPLATFORM is not set
># CONFIG_APUS is not set
># CONFIG_WILLOW is not set
># CONFIG_PCORE is not set
># CONFIG_POWERPMC250 is not set
># CONFIG_EV64260 is not set
># CONFIG_SPRUCE is not set
># CONFIG_LOPEC is not set
># CONFIG_MCPN765 is not set
># CONFIG_MVME5100 is not set
># CONFIG_PPLUS is not set
># CONFIG_PRPMC750 is not set
># CONFIG_PRPMC800 is not set
># CONFIG_SANDPOINT is not set
># CONFIG_ADIR is not set
># CONFIG_K2 is not set
># CONFIG_PAL4 is not set
># CONFIG_GEMINI is not set
># CONFIG_EST8260 is not set
># CONFIG_SBC82xx is not set
># CONFIG_SBS8260 is not set
># CONFIG_RPX8260 is not set
># CONFIG_TQM8260 is not set
># CONFIG_ADS8272 is not set
>CONFIG_LITE5200=y
>CONFIG_PPC_MPC52xx=y
># CONFIG_SMP is not set
># CONFIG_PREEMPT is not set
># CONFIG_HIGHMEM is not set
>CONFIG_BINFMT_ELF=y
># CONFIG_BINFMT_MISC is not set
>CONFIG_CMDLINE_BOOL=y
>CONFIG_CMDLINE="console=ttyS0 root=/dev/ram0 rw"
>
>#
># Bus options
>#
>CONFIG_GENERIC_ISA_DMA=y
>CONFIG_PCI=y
>CONFIG_PCI_DOMAINS=y
># CONFIG_PCI_LEGACY_PROC is not set
># CONFIG_PCI_NAMES is not set
>
>#
># Advanced setup
>#
>CONFIG_ADVANCED_OPTIONS=y
>CONFIG_HIGHMEM_START=0xfe000000
># CONFIG_LOWMEM_SIZE_BOOL is not set
>CONFIG_LOWMEM_SIZE=0x30000000
># CONFIG_KERNEL_START_BOOL is not set
>CONFIG_KERNEL_START=0xc0000000
># CONFIG_TASK_SIZE_BOOL is not set
>CONFIG_TASK_SIZE=0x80000000
># CONFIG_BOOT_LOAD_BOOL is not set
>CONFIG_BOOT_LOAD=0x00800000
>
>#
># Device Drivers
>#
>
>#
># Generic Driver Options
>#
>CONFIG_STANDALONE=y
>CONFIG_PREVENT_FIRMWARE_BUILD=y
>
>#
># Memory Technology Devices (MTD)
>#
># CONFIG_MTD is not set
>
>#
># Parallel port support
>#
># CONFIG_PARPORT is not set
>
>#
># Plug and Play support
>#
>
>#
># Block devices
>#
># CONFIG_BLK_DEV_FD is not set
># CONFIG_BLK_CPQ_DA is not set
># CONFIG_BLK_CPQ_CISS_DA is not set
># CONFIG_BLK_DEV_DAC960 is not set
># CONFIG_BLK_DEV_UMEM is not set
># CONFIG_BLK_DEV_LOOP is not set
># CONFIG_BLK_DEV_SX8 is not set
>CONFIG_BLK_DEV_RAM=y
>CONFIG_BLK_DEV_RAM_SIZE=4096
>CONFIG_BLK_DEV_INITRD=y
>CONFIG_INITRAMFS_SOURCE=""
># CONFIG_LBD is not set
># CONFIG_CDROM_PKTCDVD is not set
>
>#
># IO Schedulers
>#
>CONFIG_IOSCHED_NOOP=y
>CONFIG_IOSCHED_AS=y
>CONFIG_IOSCHED_DEADLINE=y
>CONFIG_IOSCHED_CFQ=y
>
>#
># ATA/ATAPI/MFM/RLL support
>#
># CONFIG_IDE is not set
>
>#
># SCSI device support
>#
># CONFIG_SCSI is not set
>
>#
># Multi-device support (RAID and LVM)
>#
># CONFIG_MD is not set
>
>#
># Fusion MPT device support
>#
>
>#
># IEEE 1394 (FireWire) support
>#
># CONFIG_IEEE1394 is not set
>
>#
># I2O device support
>#
># CONFIG_I2O is not set
>
>#
># Macintosh device drivers
>#
>
>#
># Networking support
>#
># CONFIG_NET is not set
># CONFIG_NETPOLL is not set
># CONFIG_NET_POLL_CONTROLLER is not set
>
>#
># ISDN subsystem
>#
>
>#
># Telephony Support
>#
># CONFIG_PHONE is not set
>
>#
># Input device support
>#
>CONFIG_INPUT=y
>
>#
># Userland interfaces
>#
>CONFIG_INPUT_MOUSEDEV=y
>CONFIG_INPUT_MOUSEDEV_PSAUX=y
>CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
># CONFIG_INPUT_JOYDEV is not set
># CONFIG_INPUT_TSDEV is not set
>CONFIG_INPUT_EVDEV=y
>CONFIG_INPUT_EVBUG=y
>
>#
># Input I/O drivers
>#
># CONFIG_GAMEPORT is not set
>CONFIG_SOUND_GAMEPORT=y
>CONFIG_SERIO=y
># CONFIG_SERIO_I8042 is not set
>CONFIG_SERIO_SERPORT=y
># CONFIG_SERIO_CT82C710 is not set
># CONFIG_SERIO_PCIPS2 is not set
># CONFIG_SERIO_RAW is not set
>
>#
># Input Device Drivers
>#
># CONFIG_INPUT_KEYBOARD is not set
># CONFIG_INPUT_MOUSE is not set
># CONFIG_INPUT_JOYSTICK is not set
># CONFIG_INPUT_TOUCHSCREEN is not set
># CONFIG_INPUT_MISC is not set
>
>#
># Character devices
>#
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>CONFIG_HW_CONSOLE=y
># CONFIG_SERIAL_NONSTANDARD is not set
>
>#
># Serial drivers
>#
># CONFIG_SERIAL_8250 is not set
>
>#
># Non-8250 serial port support
>#
>CONFIG_SERIAL_CORE=y
>CONFIG_SERIAL_CORE_CONSOLE=y
>CONFIG_SERIAL_MPC52xx=y
>CONFIG_SERIAL_MPC52xx_CONSOLE=y
>CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=9600
>CONFIG_UNIX98_PTYS=y
>CONFIG_LEGACY_PTYS=y
>CONFIG_LEGACY_PTY_COUNT=256
>
>#
># IPMI
>#
># CONFIG_IPMI_HANDLER is not set
>
>#
># Watchdog Cards
>#
># CONFIG_WATCHDOG is not set
># CONFIG_NVRAM is not set
># CONFIG_GEN_RTC is not set
># CONFIG_DTLK is not set
># CONFIG_R3964 is not set
># CONFIG_APPLICOM is not set
>
>#
># Ftape, the floppy tape device driver
>#
># CONFIG_AGP is not set
># CONFIG_DRM is not set
># CONFIG_RAW_DRIVER is not set
>
>#
># I2C support
>#
>CONFIG_I2C=y
>CONFIG_I2C_CHARDEV=y
>
>#
># I2C Algorithms
>#
>CONFIG_I2C_ALGOBIT=y
>CONFIG_I2C_ALGOPCF=y
>CONFIG_I2C_ALGOPCA=y
>
>#
># I2C Hardware Bus support
>#
># CONFIG_I2C_ALI1535 is not set
># CONFIG_I2C_ALI1563 is not set
># CONFIG_I2C_ALI15X3 is not set
># CONFIG_I2C_AMD756 is not set
># CONFIG_I2C_AMD8111 is not set
># CONFIG_I2C_I801 is not set
># CONFIG_I2C_I810 is not set
># CONFIG_I2C_ISA is not set
>CONFIG_I2C_MPC=y
># CONFIG_I2C_NFORCE2 is not set
># CONFIG_I2C_PARPORT_LIGHT is not set
># CONFIG_I2C_PIIX4 is not set
># CONFIG_I2C_PROSAVAGE is not set
># CONFIG_I2C_SAVAGE4 is not set
># CONFIG_SCx200_ACB is not set
># CONFIG_I2C_SIS5595 is not set
># CONFIG_I2C_SIS630 is not set
># CONFIG_I2C_SIS96X is not set
># CONFIG_I2C_VIA is not set
># CONFIG_I2C_VIAPRO is not set
># CONFIG_I2C_VOODOO3 is not set
># CONFIG_I2C_PCA_ISA is not set
>
>#
># Hardware Sensors Chip support
>#
># CONFIG_I2C_SENSOR is not set
># CONFIG_SENSORS_ADM1021 is not set
># CONFIG_SENSORS_ADM1025 is not set
># CONFIG_SENSORS_ADM1031 is not set
># CONFIG_SENSORS_ASB100 is not set
># CONFIG_SENSORS_DS1621 is not set
># CONFIG_SENSORS_FSCHER is not set
># CONFIG_SENSORS_GL518SM is not set
># CONFIG_SENSORS_IT87 is not set
># CONFIG_SENSORS_LM63 is not set
># CONFIG_SENSORS_LM75 is not set
># CONFIG_SENSORS_LM77 is not set
># CONFIG_SENSORS_LM78 is not set
># CONFIG_SENSORS_LM80 is not set
># CONFIG_SENSORS_LM83 is not set
># CONFIG_SENSORS_LM85 is not set
># CONFIG_SENSORS_LM87 is not set
># CONFIG_SENSORS_LM90 is not set
># CONFIG_SENSORS_MAX1619 is not set
># CONFIG_SENSORS_PC87360 is not set
># CONFIG_SENSORS_SMSC47M1 is not set
># CONFIG_SENSORS_VIA686A is not set
># CONFIG_SENSORS_W83781D is not set
># CONFIG_SENSORS_W83L785TS is not set
># CONFIG_SENSORS_W83627HF is not set
>
>#
># Other I2C Chip support
>#
># CONFIG_SENSORS_EEPROM is not set
># CONFIG_SENSORS_PCF8574 is not set
># CONFIG_SENSORS_PCF8591 is not set
># CONFIG_SENSORS_RTC8564 is not set
># CONFIG_I2C_DEBUG_CORE is not set
># CONFIG_I2C_DEBUG_ALGO is not set
># CONFIG_I2C_DEBUG_BUS is not set
># CONFIG_I2C_DEBUG_CHIP is not set
>
>#
># Dallas's 1-wire bus
>#
># CONFIG_W1 is not set
>
>#
># Misc devices
>#
>
>#
># Multimedia devices
>#
># CONFIG_VIDEO_DEV is not set
>
>#
># Digital Video Broadcasting Devices
>#
>
>#
># Graphics support
>#
># CONFIG_FB is not set
>
>#
># Console display driver support
>#
>CONFIG_VGA_CONSOLE=y
>CONFIG_DUMMY_CONSOLE=y
>
>#
># Sound
>#
># CONFIG_SOUND is not set
>
>#
># USB support
>#
># CONFIG_USB is not set
>CONFIG_USB_ARCH_HAS_HCD=y
>CONFIG_USB_ARCH_HAS_OHCI=y
>
>#
># USB Gadget Support
>#
># CONFIG_USB_GADGET is not set
>
>#
># File systems
>#
># CONFIG_EXT2_FS is not set
># CONFIG_EXT3_FS is not set
># CONFIG_JBD is not set
># CONFIG_REISERFS_FS is not set
># CONFIG_JFS_FS is not set
># CONFIG_XFS_FS is not set
># CONFIG_MINIX_FS is not set
># CONFIG_ROMFS_FS is not set
># CONFIG_QUOTA is not set
>CONFIG_DNOTIFY=y
># CONFIG_AUTOFS_FS is not set
># CONFIG_AUTOFS4_FS is not set
>
>#
># CD-ROM/DVD Filesystems
>#
># CONFIG_ISO9660_FS is not set
># CONFIG_UDF_FS is not set
>
>#
># DOS/FAT/NT Filesystems
>#
># CONFIG_MSDOS_FS is not set
># CONFIG_VFAT_FS is not set
># CONFIG_NTFS_FS is not set
>
>#
># Pseudo filesystems
>#
>CONFIG_PROC_FS=y
>CONFIG_PROC_KCORE=y
>CONFIG_SYSFS=y
># CONFIG_DEVFS_FS is not set
># CONFIG_DEVPTS_FS_XATTR is not set
>CONFIG_TMPFS=y
># CONFIG_TMPFS_XATTR is not set
># CONFIG_HUGETLB_PAGE is not set
>CONFIG_RAMFS=y
>
>#
># Miscellaneous filesystems
>#
># CONFIG_ADFS_FS is not set
># CONFIG_AFFS_FS is not set
># CONFIG_HFS_FS is not set
># CONFIG_HFSPLUS_FS is not set
># CONFIG_BEFS_FS is not set
># CONFIG_BFS_FS is not set
># CONFIG_EFS_FS is not set
># CONFIG_CRAMFS is not set
># CONFIG_VXFS_FS is not set
># CONFIG_HPFS_FS is not set
># CONFIG_QNX4FS_FS is not set
># CONFIG_SYSV_FS is not set
># CONFIG_UFS_FS is not set
>
>#
># Partition Types
>#
># CONFIG_PARTITION_ADVANCED is not set
>CONFIG_MSDOS_PARTITION=y
>
>#
># Native Language Support
>#
>CONFIG_NLS=y
>CONFIG_NLS_DEFAULT="iso8859-1"
># CONFIG_NLS_CODEPAGE_437 is not set
># CONFIG_NLS_CODEPAGE_737 is not set
># CONFIG_NLS_CODEPAGE_775 is not set
># CONFIG_NLS_CODEPAGE_850 is not set
># CONFIG_NLS_CODEPAGE_852 is not set
># CONFIG_NLS_CODEPAGE_855 is not set
># CONFIG_NLS_CODEPAGE_857 is not set
># CONFIG_NLS_CODEPAGE_860 is not set
># CONFIG_NLS_CODEPAGE_861 is not set
># CONFIG_NLS_CODEPAGE_862 is not set
># CONFIG_NLS_CODEPAGE_863 is not set
># CONFIG_NLS_CODEPAGE_864 is not set
># CONFIG_NLS_CODEPAGE_865 is not set
># CONFIG_NLS_CODEPAGE_866 is not set
># CONFIG_NLS_CODEPAGE_869 is not set
># CONFIG_NLS_CODEPAGE_936 is not set
># CONFIG_NLS_CODEPAGE_950 is not set
># CONFIG_NLS_CODEPAGE_932 is not set
># CONFIG_NLS_CODEPAGE_949 is not set
># CONFIG_NLS_CODEPAGE_874 is not set
># CONFIG_NLS_ISO8859_8 is not set
># CONFIG_NLS_CODEPAGE_1250 is not set
># CONFIG_NLS_CODEPAGE_1251 is not set
># CONFIG_NLS_ASCII is not set
>CONFIG_NLS_ISO8859_1=y
># CONFIG_NLS_ISO8859_2 is not set
># CONFIG_NLS_ISO8859_3 is not set
># CONFIG_NLS_ISO8859_4 is not set
># CONFIG_NLS_ISO8859_5 is not set
># CONFIG_NLS_ISO8859_6 is not set
># CONFIG_NLS_ISO8859_7 is not set
># CONFIG_NLS_ISO8859_9 is not set
># CONFIG_NLS_ISO8859_13 is not set
># CONFIG_NLS_ISO8859_14 is not set
># CONFIG_NLS_ISO8859_15 is not set
># CONFIG_NLS_KOI8_R is not set
># CONFIG_NLS_KOI8_U is not set
># CONFIG_NLS_UTF8 is not set
>
>#
># Library routines
>#
># CONFIG_CRC_CCITT is not set
># CONFIG_CRC32 is not set
># CONFIG_LIBCRC32C is not set
>
>#
># Profiling support
>#
># CONFIG_PROFILING is not set
>
>#
># Kernel hacking
>#
># CONFIG_DEBUG_KERNEL is not set
>CONFIG_SERIAL_TEXT_DEBUG=y
>CONFIG_PPC_OCP=y
>
>#
># Security options
>#
># CONFIG_KEYS is not set
># CONFIG_SECURITY is not set
>
>#
># Cryptographic options
>#
># CONFIG_CRYPTO is not set
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
