Return-Path: <cpvjagadeesh@yahoo.com>
Received: from web50404.mail.yahoo.com (web50404.mail.yahoo.com
	[206.190.38.69]) by ozlabs.org (Postfix) with SMTP id 0BE766892D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 15:44:32 +1100 (EST)
Message-ID: <20051230044431.11637.qmail@web50404.mail.yahoo.com>
Date: Thu, 29 Dec 2005 20:44:31 -0800 (PST)
From: venkatajagadeesh p <cpvjagadeesh@yahoo.com>
To: linuxppc-embedded@ozlabs.org, Sinan Akman <sinan@writeme.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1297231242-1135917871=:7935"
Subject: Re: Porting Linux2.6.13 on MPC860T custom build board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1297231242-1135917871=:7935
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


We are seinding the details of porting Linux on MPC860T. 
  Initially we have enabled all the SMC/SCC devices these are conflicting with the console, the boot loader argument was wrong( connsole=ttyS1,57600 console=tty1 root=/dev/ram),and we have enabled CONFIG_VT. 
  Modifications :
  We have selected only SMC2, and changed the boot loader argument to connsole=ttyCPM2,57600 root=/dev/ram , and modified the drivers/char/Kconfig file
  
( original lines )
  config VT
  bool "Virtual terminal" if EMBEDDED
  select INPUT
  default y if !VIOCONS 
    
  ( Modified lines )
  
config VT
  bool "Virtual terminal" if EMBEDDED
  select INPUT
  default n
   
  These are the only modifications we have done to the config and Kconfig files.
    
Thanks 
Venakta jagadeesh.p
  > Hi Sinan Akman
>  
>                 Thanks for Your suggestion, Now linux is up and 
> booting. thanks for the community who contributed in this >porting.
  
>       I am glad it worked. I guess my reply to you didn't go >through 
>to 
>linuxppc-embedded.
>You might want to post the sequence of things you tried, what >worked 
>and 
>what didn't. This
>way someone else can find it through search, assuming it >wasn't in the 
>FAQ already.
   >   Regards
  >    Sinan Akman
  >  
> Thanks and one and all,
> Venkata jagadish.p
>
  
Sinan Akman <sinan@writeme.com> wrote:
Date: Thu, 29 Dec 2005 02:51:42 -0500
From: Sinan Akman <sinan@writeme.com>
To: venkatajagadeesh p <cpvjagadeesh@yahoo.com>
Subject: Re: Porting Linux2.6.13 on MPC860T custom build board
  venkatajagadeesh p wrote:
  > venkatajagadeesh p wrote:
> >/
> />/ Hi,
> />/ We are trying to port Linux-2.6.13 on Custom build MPC860T, 
> board,
> />/ We are unable to see any messages on console. We got the output given
> />/ below. Please help us in porting the kernel.
> />/ I am attaching the config file .
> />/ 
> />/ =>bootm 0x100000
> />/ ## Booting image at 00100000 ...
> />/ Image Name: Linux-2.6.13
> />/ Image Type: PowerPC Linux Kernel Image (gzip compressed)
> />/ Data Size: 958189 Bytes = 935.7 kB
> />/ Load Address: 00000000
> />/ Entry Point: 00000000
> />/ Verifying Checksum ... OK
> />/ Uncompressing Kernel Image ... gunzip function called
> />/ OK
> />/ do_bootm_linux called ...do_bootm_linux after ...part2 do_boot_linux
> />/ before RAM
> />/ Disk image loading ...
> />/ No initrd
> />/ ## Transferring control to Linux (at address 00000000) ...
> />/
> /> >Most probably, something odd with serial setup.
> > >You have enabled just all the stuff (SCC/SMC), but (on 8xx at least)
> >>they can hardly live together, having alternative - conflicting IO 
> pin configurations.
> 
> We enabling only SMC2, still it is showing the same problem. In U-boot 
> loader we have modified the default console to SMC2. We have not done 
> any modifications to the original linux-2.6.13 code.
> 
> I am sending config file as an attachment.
  
Try unsetting VT_CONSOLE. That is, uncheck "Support for console on 
virtual terminal" in
Character Devices. It looks like your console output is directed to a 
VT. You might also
want to specify console=ttyCPM2 in your bootloader argument.
  Hope this helps
  -- sinan
  > 
> I am sending U-boot env varibles also
>
> =>printenv
> bootcmd=bootm;setenv bootargs root=/dev/ram rw
> bootdelay=5
> baudrate=57600
> loads_echo=1
> ethaddr=9a:52:63:15:85:25
> bootfile=uImage
> filesize=95f0a
> ipaddr=192.168.3.2
> serverip=192.168.3.6
> netdev=eth0
> netmask=255.255.255.0
> addip=setenv bootargs ${bootargs} 
> ip=${ipaddr}:${serverip}:${gatewayip}:${netmas
> k}:${hostname}:${netdev}:off
> ramargs=setenv bootargs root=/dev/ram rw
> kernel_addr=0xfc0a0000
> ramdisk_addr=0xfc160000
> flash_ram=run ramargs addip;bootm 0xfc0a0000 0xfc160000
> net_ram=tftpboot 0x100000 uImage;tftpboot 0x400000 rambb2;run ramargs 
> addip;boot
> m 0x100000 0x400000
> stdin=serial
> stdout=serial
> stderr=serial
> bootargs=root=/dev/ram rw
> Environment size: 638/262140 bytes
> 
> 
>
> ------------------------------------------------------------------------
> Yahoo! Photos
> Ring in the New Year with Photo Calendars 
> . 
> Add photos, events, holidays, whatever.
>
>------------------------------------------------------------------------
>
>#
># Automatically generated make config: don't edit
># Linux kernel version: 2.6.13
># Thu Dec 29 10:54:14 2005
>#
>CONFIG_MMU=y
>CONFIG_GENERIC_HARDIRQS=y
>CONFIG_RWSEM_XCHGADD_ALGORITHM=y
>CONFIG_GENERIC_CALIBRATE_DELAY=y
>CONFIG_HAVE_DEC_LOCK=y
>CONFIG_PPC=y
>CONFIG_PPC32=y
>CONFIG_GENERIC_NVRAM=y
>CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
>
>#
># Code maturity level options
>#
>CONFIG_EXPERIMENTAL=y
>CONFIG_CLEAN_COMPILE=y
>CONFIG_BROKEN_ON_SMP=y
>CONFIG_INIT_ENV_ARG_LIMIT=32
>
>#
># General setup
>#
>CONFIG_LOCALVERSION=""
># CONFIG_SWAP is not set
>CONFIG_SYSVIPC=y
># CONFIG_POSIX_MQUEUE is not set
># CONFIG_BSD_PROCESS_ACCT is not set
>CONFIG_SYSCTL=y
># CONFIG_AUDIT is not set
># CONFIG_HOTPLUG is not set
>CONFIG_KOBJECT_UEVENT=y
># CONFIG_IKCONFIG is not set
># CONFIG_EMBEDDED is not set
>CONFIG_KALLSYMS=y
># CONFIG_KALLSYMS_EXTRA_PASS is not set
>CONFIG_PRINTK=y
>CONFIG_BUG=y
>CONFIG_BASE_FULL=y
>CONFIG_FUTEX=y
>CONFIG_EPOLL=y
>CONFIG_SHMEM=y
>CONFIG_CC_ALIGN_FUNCTIONS=0
>CONFIG_CC_ALIGN_LABELS=0
>CONFIG_CC_ALIGN_LOOPS=0
>CONFIG_CC_ALIGN_JUMPS=0
># CONFIG_TINY_SHMEM is not set
>CONFIG_BASE_SMALL=0
>
>#
># Loadable module support
>#
># CONFIG_MODULES is not set
>
>#
># Processor
>#
># CONFIG_6xx is not set
># CONFIG_40x is not set
># CONFIG_44x is not set
># CONFIG_POWER3 is not set
># CONFIG_POWER4 is not set
>CONFIG_8xx=y
># CONFIG_E200 is not set
># CONFIG_E500 is not set
># CONFIG_MATH_EMULATION is not set
># CONFIG_KEXEC is not set
># CONFIG_CPU_FREQ is not set
># CONFIG_WANT_EARLY_SERIAL is not set
>CONFIG_EMBEDDEDBOOT=y
>CONFIG_NOT_COHERENT_CACHE=y
>
>#
># Platform options
>#
>CONFIG_FADS=y
># CONFIG_RPXLITE is not set
># CONFIG_RPXCLASSIC is not set
># CONFIG_BSEIP is not set
>CONFIG_MPC8XXFADS=y
># CONFIG_MPC86XADS is not set
># CONFIG_MPC885ADS is not set
># CONFIG_TQM823L is not set
># CONFIG_TQM850L is not set
># CONFIG_TQM855L is not set
># CONFIG_TQM860L is not set
># CONFIG_FPS850L is not set
># CONFIG_SPD823TS is not set
># CONFIG_IVMS8 is not set
># CONFIG_IVML24 is not set
># CONFIG_SM850 is not set
># CONFIG_HERMES_PRO is not set
># CONFIG_IP860 is not set
># CONFIG_LWMON is not set
># CONFIG_PCU_E is not set
># CONFIG_CCM is not set
># CONFIG_LANTEC is not set
># CONFIG_MBX is not set
># CONFIG_WINCEPT is not set
># CONFIG_HIGHMEM is not set
>CONFIG_HZ_100=y
># CONFIG_HZ_250 is not set
># CONFIG_HZ_1000 is not set
>CONFIG_HZ=100
>CONFIG_PREEMPT_NONE=y
># CONFIG_PREEMPT_VOLUNTARY is not set
># CONFIG_PREEMPT is not set
>CONFIG_SELECT_MEMORY_MODEL=y
>CONFIG_FLATMEM_MANUAL=y
># CONFIG_DISCONTIGMEM_MANUAL is not set
># CONFIG_SPARSEMEM_MANUAL is not set
>CONFIG_FLATMEM=y
>CONFIG_FLAT_NODE_MEM_MAP=y
>CONFIG_BINFMT_ELF=y
># CONFIG_BINFMT_MISC is not set
>CONFIG_CMDLINE_BOOL=y
>CONFIG_CMDLINE="console=ttyS1,57600 console=tty1 root=/dev/ram"
># CONFIG_PM is not set
>CONFIG_SECCOMP=y
>CONFIG_ISA_DMA_API=y
>
>#
># Bus options
>#
># CONFIG_PCI is not set
># CONFIG_PCI_DOMAINS is not set
># CONFIG_PCI_QSPAN is not set
>
>#
># PCCARD (PCMCIA/CardBus) support
>#
># CONFIG_PCCARD is not set
>
>#
># Advanced setup
>#
># CONFIG_ADVANCED_OPTIONS is not set
>
>#
># Default settings for advanced configuration options are used
>#
>CONFIG_HIGHMEM_START=0xfe000000
>CONFIG_LOWMEM_SIZE=0x30000000
>CONFIG_KERNEL_START=0xc0000000
>CONFIG_TASK_SIZE=0x80000000
>CONFIG_CONSISTENT_START=0xff100000
>CONFIG_CONSISTENT_SIZE=0x00200000
>CONFIG_BOOT_LOAD=0x00400000
>
>#
># Networking
>#
>CONFIG_NET=y
>
>#
># Networking options
>#
>CONFIG_PACKET=y
>CONFIG_PACKET_MMAP=y
>CONFIG_UNIX=y
># CONFIG_NET_KEY is not set
>CONFIG_INET=y
># CONFIG_IP_MULTICAST is not set
># CONFIG_IP_ADVANCED_ROUTER is not set
>CONFIG_IP_FIB_HASH=y
>CONFIG_IP_PNP=y
>CONFIG_IP_PNP_DHCP=y
>CONFIG_IP_PNP_BOOTP=y
>CONFIG_IP_PNP_RARP=y
># CONFIG_NET_IPIP is not set
># CONFIG_NET_IPGRE is not set
>CONFIG_ARPD=y
># CONFIG_SYN_COOKIES is not set
># CONFIG_INET_AH is not set
># CONFIG_INET_ESP is not set
># CONFIG_INET_IPCOMP is not set
># CONFIG_INET_TUNNEL is not set
>CONFIG_IP_TCPDIAG=y
>CONFIG_IP_TCPDIAG_IPV6=y
># CONFIG_TCP_CONG_ADVANCED is not set
>CONFIG_TCP_CONG_BIC=y
>CONFIG_IPV6=y
># CONFIG_IPV6_PRIVACY is not set
># CONFIG_INET6_AH is not set
># CONFIG_INET6_ESP is not set
># CONFIG_INET6_IPCOMP is not set
># CONFIG_INET6_TUNNEL is not set
># CONFIG_IPV6_TUNNEL is not set
># CONFIG_NETFILTER is not set
>
>#
># SCTP Configuration (EXPERIMENTAL)
>#
># CONFIG_IP_SCTP is not set
># CONFIG_ATM is not set
>CONFIG_BRIDGE=y
># CONFIG_VLAN_8021Q is not set
># CONFIG_DECNET is not set
># CONFIG_LLC2 is not set
># CONFIG_IPX is not set
># CONFIG_ATALK is not set
># CONFIG_X25 is not set
># CONFIG_LAPB is not set
># CONFIG_NET_DIVERT is not set
># CONFIG_ECONET is not set
># CONFIG_WAN_ROUTER is not set
># CONFIG_NET_SCHED is not set
># CONFIG_NET_CLS_ROUTE is not set
>
>#
># Network testing
>#
># CONFIG_NET_PKTGEN is not set
># CONFIG_HAMRADIO is not set
># CONFIG_IRDA is not set
># CONFIG_BT is not set
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
># CONFIG_FW_LOADER is not set
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
># CONFIG_BLK_DEV_COW_COMMON is not set
># CONFIG_BLK_DEV_LOOP is not set
># CONFIG_BLK_DEV_NBD is not set
>CONFIG_BLK_DEV_RAM=y
>CONFIG_BLK_DEV_RAM_COUNT=16
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
># CONFIG_IOSCHED_AS is not set
># CONFIG_IOSCHED_DEADLINE is not set
># CONFIG_IOSCHED_CFQ is not set
># CONFIG_ATA_OVER_ETH is not set
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
># CONFIG_FUSION is not set
>
>#
># IEEE 1394 (FireWire) support
>#
>
>#
># I2O device support
>#
>
>#
># Macintosh device drivers
>#
>
>#
># Network device support
>#
>CONFIG_NETDEVICES=y
># CONFIG_DUMMY is not set
># CONFIG_BONDING is not set
># CONFIG_EQUALIZER is not set
># CONFIG_TUN is not set
>
>#
># Ethernet (10 or 100Mbit)
>#
>CONFIG_NET_ETHERNET=y
>CONFIG_MII=y
>
>#
># Ethernet (1000 Mbit)
>#
>
>#
># Ethernet (10000 Mbit)
>#
>
>#
># Token Ring devices
>#
>
>#
># Wireless LAN (non-hamradio)
>#
># CONFIG_NET_RADIO is not set
>
>#
># Wan interfaces
>#
># CONFIG_WAN is not set
># CONFIG_PPP is not set
># CONFIG_SLIP is not set
># CONFIG_SHAPER is not set
># CONFIG_NETCONSOLE is not set
># CONFIG_NETPOLL is not set
># CONFIG_NET_POLL_CONTROLLER is not set
>
>#
># ISDN subsystem
>#
># CONFIG_ISDN is not set
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
># CONFIG_INPUT_EVDEV is not set
># CONFIG_INPUT_EVBUG is not set
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
># Hardware I/O ports
>#
># CONFIG_SERIO is not set
># CONFIG_GAMEPORT is not set
>
>#
># Character devices
>#
>CONFIG_VT=y
>CONFIG_VT_CONSOLE=y
>CONFIG_HW_CONSOLE=y
>CONFIG_SERIAL_NONSTANDARD=y
># CONFIG_COMPUTONE is not set
># CONFIG_ROCKETPORT is not set
># CONFIG_CYCLADES is not set
># CONFIG_DIGIEPCA is not set
># CONFIG_MOXA_INTELLIO is not set
># CONFIG_MOXA_SMARTIO is not set
># CONFIG_ISI is not set
># CONFIG_SYNCLINKMP is not set
># CONFIG_N_HDLC is not set
># CONFIG_RISCOM8 is not set
># CONFIG_SPECIALIX is not set
># CONFIG_SX is not set
># CONFIG_RIO is not set
># CONFIG_STALDRV is not set
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
>CONFIG_SERIAL_CPM=y
>CONFIG_SERIAL_CPM_CONSOLE=y
># CONFIG_SERIAL_CPM_SCC1 is not set
># CONFIG_SERIAL_CPM_SCC2 is not set
># CONFIG_SERIAL_CPM_SCC3 is not set
># CONFIG_SERIAL_CPM_SCC4 is not set
># CONFIG_SERIAL_CPM_SMC1 is not set
>CONFIG_SERIAL_CPM_SMC2=y
>CONFIG_UNIX98_PTYS=y
># CONFIG_LEGACY_PTYS is not set
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
>
>#
># Ftape, the floppy tape device driver
>#
># CONFIG_AGP is not set
># CONFIG_RAW_DRIVER is not set
>
>#
># TPM devices
>#
>
>#
># I2C support
>#
># CONFIG_I2C is not set
># CONFIG_I2C_SENSOR is not set
>
>#
># Dallas's 1-wire bus
>#
># CONFIG_W1 is not set
>
>#
># Hardware Monitoring support
>#
># CONFIG_HWMON is not set
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
># CONFIG_DVB is not set
>
>#
># Graphics support
>#
># CONFIG_FB is not set
>
>#
># Console display driver support
>#
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
># CONFIG_USB_ARCH_HAS_HCD is not set
># CONFIG_USB_ARCH_HAS_OHCI is not set
>
>#
># USB Gadget Support
>#
># CONFIG_USB_GADGET is not set
>
>#
># MMC/SD Card support
>#
># CONFIG_MMC is not set
>
>#
># InfiniBand support
>#
>
>#
># SN Devices
>#
>
>#
># File systems
>#
>CONFIG_EXT2_FS=y
>CONFIG_EXT2_FS_XATTR=y
>CONFIG_EXT2_FS_POSIX_ACL=y
>CONFIG_EXT2_FS_SECURITY=y
>CONFIG_EXT2_FS_XIP=y
>CONFIG_FS_XIP=y
># CONFIG_EXT3_FS is not set
># CONFIG_JBD is not set
>CONFIG_FS_MBCACHE=y
># CONFIG_REISERFS_FS is not set
># CONFIG_JFS_FS is not set
>CONFIG_FS_POSIX_ACL=y
>
>#
># XFS support
>#
># CONFIG_XFS_FS is not set
># CONFIG_MINIX_FS is not set
>CONFIG_ROMFS_FS=y
>CONFIG_INOTIFY=y
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
># CONFIG_PROC_KCORE is not set
>CONFIG_SYSFS=y
># CONFIG_DEVPTS_FS_XATTR is not set
># CONFIG_TMPFS is not set
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
># Network File Systems
>#
>CONFIG_NFS_FS=y
># CONFIG_NFS_V3 is not set
># CONFIG_NFS_V4 is not set
># CONFIG_NFS_DIRECTIO is not set
># CONFIG_NFSD is not set
>CONFIG_ROOT_NFS=y
>CONFIG_LOCKD=y
>CONFIG_NFS_COMMON=y
>CONFIG_SUNRPC=y
># CONFIG_RPCSEC_GSS_KRB5 is not set
># CONFIG_RPCSEC_GSS_SPKM3 is not set
># CONFIG_SMB_FS is not set
># CONFIG_CIFS is not set
># CONFIG_NCP_FS is not set
># CONFIG_CODA_FS is not set
># CONFIG_AFS_FS is not set
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
># CONFIG_NLS is not set
>
>#
># MPC8xx CPM Options
>#
># CONFIG_SCC_ENET is not set
>CONFIG_FEC_ENET=y
>CONFIG_USE_MDIO=y
>CONFIG_FEC_AM79C874=y
># CONFIG_FEC_LXT970 is not set
># CONFIG_FEC_LXT971 is not set
># CONFIG_FEC_QS6612 is not set
>CONFIG_ENET_BIG_BUFFERS=y
>
>#
># Generic MPC8xx Options
>#
># CONFIG_8xx_COPYBACK is not set
># CONFIG_8xx_CPU6 is not set
>CONFIG_NO_UCODE_PATCH=y
># CONFIG_USB_SOF_UCODE_PATCH is not set
># CONFIG_I2C_SPI_UCODE_PATCH is not set
># CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
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
># CONFIG_PRINTK_TIME is not set
># CONFIG_DEBUG_KERNEL is not set
>CONFIG_LOG_BUF_SHIFT=14
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
>#
># Hardware crypto devices
>#
> 
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
   
   

		
---------------------------------
Yahoo! Photos
 Ring in the New Year with Photo Calendars. Add photos, events, holidays, whatever.
--0-1297231242-1135917871=:7935
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div><BR>We are seinding the details of porting Linux on MPC860T. </div>  <div>Initially we have enabled all the SMC/SCC devices these are conflicting with the console, the boot loader argument was wrong( connsole=ttyS1,57600 console=tty1 root=/dev/ram),and we have enabled CONFIG_VT. </div>  <div>Modifications :</div>  <div>We have selected only SMC2, and changed the boot loader argument to connsole=ttyCPM2,57600 root=/dev/ram , and modified the drivers/char/Kconfig file</div>  <div><BR>( original lines )</div>  <div>config VT</div>  <div>bool "Virtual terminal" if EMBEDDED</div>  <div>select INPUT</div>  <div>default y if !VIOCONS </div>  <div>&nbsp; </div>  <div>( Modified lines )</div>  <div><BR>config VT</div>  <div>bool "Virtual terminal" if EMBEDDED</div>  <div>select INPUT</div>  <div>default n</div>  <div>&nbsp;</div>  <div>These are the only modifications we have done to the config and Kconfig files.</div>  <div>&nbsp; <BR>Thanks <BR>Venakta jagadeesh.p</div>  <div>&gt; Hi
 Sinan Akman<BR>&gt;&nbsp; <BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for Your suggestion, Now linux is up and <BR>&gt; booting. thanks for the community who contributed in this &gt;porting.</div>  <div><BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am glad it worked. I guess my reply to you didn't go &gt;through <BR>&gt;to <BR>&gt;linuxppc-embedded.<BR>&gt;You might want to post the sequence of things you tried, what &gt;worked <BR>&gt;and <BR>&gt;what didn't. This<BR>&gt;way someone else can find it through search, assuming it &gt;wasn't in the <BR>&gt;FAQ already.</div>  <div>&nbsp;&gt;&nbsp;&nbsp; Regards</div>  <div>&gt;&nbsp;&nbsp;&nbsp; Sinan Akman</div>  <div>&gt;&nbsp; <BR>&gt; Thanks and one and all,<BR>&gt; Venkata jagadish.p<BR>&gt;</div>  <div><BR>Sinan Akman &lt;<A href="mailto:sinan@writeme.com">sinan@writeme.com</A>&gt; wrote:<BR>Date: Thu, 29 Dec 2005 02:51:42 -0500<BR>From: Sinan Akman &lt;<A
 href="mailto:sinan@writeme.com">sinan@writeme.com</A>&gt;<BR>To: venkatajagadeesh p &lt;<A href="mailto:cpvjagadeesh@yahoo.com">cpvjagadeesh@yahoo.com</A>&gt;<BR>Subject: Re: Porting Linux2.6.13 on MPC860T custom build board</div>  <div>venkatajagadeesh p wrote:</div>  <div>&gt; venkatajagadeesh p wrote:<BR>&gt; &gt;/<BR>&gt; /&gt;/ Hi,<BR>&gt; /&gt;/ We are trying to port Linux-2.6.13 on Custom build MPC860T, <BR>&gt; board,<BR>&gt; /&gt;/ We are unable to see any messages on console. We got the output given<BR>&gt; /&gt;/ below. Please help us in porting the kernel.<BR>&gt; /&gt;/ I am attaching the config file .<BR>&gt; /&gt;/ <BR>&gt; /&gt;/ =&gt;bootm 0x100000<BR>&gt; /&gt;/ ## Booting image at 00100000 ...<BR>&gt; /&gt;/ Image Name: Linux-2.6.13<BR>&gt; /&gt;/ Image Type: PowerPC Linux Kernel Image (gzip compressed)<BR>&gt; /&gt;/ Data Size: 958189 Bytes = 935.7 kB<BR>&gt; /&gt;/ Load Address: 00000000<BR>&gt; /&gt;/ Entry Point: 00000000<BR>&gt; /&gt;/ Verifying Checksum ...
 OK<BR>&gt; /&gt;/ Uncompressing Kernel Image ... gunzip function called<BR>&gt; /&gt;/ OK<BR>&gt; /&gt;/ do_bootm_linux called ...do_bootm_linux after ...part2 do_boot_linux<BR>&gt; /&gt;/ before RAM<BR>&gt; /&gt;/ Disk image loading ...<BR>&gt; /&gt;/ No initrd<BR>&gt; /&gt;/ ## Transferring control to Linux (at address 00000000) ...<BR>&gt; /&gt;/<BR>&gt; /&gt; &gt;Most probably, something odd with serial setup.<BR>&gt; &gt; &gt;You have enabled just all the stuff (SCC/SMC), but (on 8xx at least)<BR>&gt; &gt;&gt;they can hardly live together, having alternative - conflicting IO <BR>&gt; pin configurations.<BR>&gt; <BR>&gt; We enabling only SMC2, still it is showing the same problem. In U-boot <BR>&gt; loader we have modified the default console to SMC2. We have not done <BR>&gt; any modifications to the original linux-2.6.13 code.<BR>&gt; <BR>&gt; I am sending config file as an attachment.</div>  <div><BR>Try unsetting VT_CONSOLE. That is, uncheck "Support for console on
 <BR>virtual terminal" in<BR>Character Devices. It looks like your console output is directed to a <BR>VT. You might also<BR>want to specify console=ttyCPM2 in your bootloader argument.</div>  <div>Hope this helps</div>  <div>-- sinan</div>  <div>&gt; <BR>&gt; I am sending U-boot env varibles also<BR>&gt;<BR>&gt; =&gt;printenv<BR>&gt; bootcmd=bootm;setenv bootargs root=/dev/ram rw<BR>&gt; bootdelay=5<BR>&gt; baudrate=57600<BR>&gt; loads_echo=1<BR>&gt; ethaddr=9a:52:63:15:85:25<BR>&gt; bootfile=uImage<BR>&gt; filesize=95f0a<BR>&gt; ipaddr=192.168.3.2<BR>&gt; serverip=192.168.3.6<BR>&gt; netdev=eth0<BR>&gt; netmask=255.255.255.0<BR>&gt; addip=setenv bootargs ${bootargs} <BR>&gt; ip=${ipaddr}:${serverip}:${gatewayip}:${netmas<BR>&gt; k}:${hostname}:${netdev}:off<BR>&gt; ramargs=setenv bootargs root=/dev/ram rw<BR>&gt; kernel_addr=0xfc0a0000<BR>&gt; ramdisk_addr=0xfc160000<BR>&gt; flash_ram=run ramargs addip;bootm 0xfc0a0000 0xfc160000<BR>&gt; net_ram=tftpboot 0x100000 uImage;tftpboot
 0x400000 rambb2;run ramargs <BR>&gt; addip;boot<BR>&gt; m 0x100000 0x400000<BR>&gt; stdin=serial<BR>&gt; stdout=serial<BR>&gt; stderr=serial<BR>&gt; bootargs=root=/dev/ram rw<BR>&gt; Environment size: 638/262140 bytes<BR>&gt; <BR>&gt; <BR>&gt;<BR>&gt; ------------------------------------------------------------------------<BR>&gt; Yahoo! Photos<BR>&gt; Ring in the New Year with Photo Calendars <BR>&gt; . <BR>&gt; Add photos, events, holidays, whatever.<BR>&gt;<BR>&gt;------------------------------------------------------------------------<BR>&gt;<BR>&gt;#<BR>&gt;# Automatically generated make config: don't edit<BR>&gt;# Linux kernel version: 2.6.13<BR>&gt;# Thu Dec 29 10:54:14
 2005<BR>&gt;#<BR>&gt;CONFIG_MMU=y<BR>&gt;CONFIG_GENERIC_HARDIRQS=y<BR>&gt;CONFIG_RWSEM_XCHGADD_ALGORITHM=y<BR>&gt;CONFIG_GENERIC_CALIBRATE_DELAY=y<BR>&gt;CONFIG_HAVE_DEC_LOCK=y<BR>&gt;CONFIG_PPC=y<BR>&gt;CONFIG_PPC32=y<BR>&gt;CONFIG_GENERIC_NVRAM=y<BR>&gt;CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y<BR>&gt;<BR>&gt;#<BR>&gt;# Code maturity level options<BR>&gt;#<BR>&gt;CONFIG_EXPERIMENTAL=y<BR>&gt;CONFIG_CLEAN_COMPILE=y<BR>&gt;CONFIG_BROKEN_ON_SMP=y<BR>&gt;CONFIG_INIT_ENV_ARG_LIMIT=32<BR>&gt;<BR>&gt;#<BR>&gt;# General setup<BR>&gt;#<BR>&gt;CONFIG_LOCALVERSION=""<BR>&gt;# CONFIG_SWAP is not set<BR>&gt;CONFIG_SYSVIPC=y<BR>&gt;# CONFIG_POSIX_MQUEUE is not set<BR>&gt;# CONFIG_BSD_PROCESS_ACCT is not set<BR>&gt;CONFIG_SYSCTL=y<BR>&gt;# CONFIG_AUDIT is not set<BR>&gt;# CONFIG_HOTPLUG is not set<BR>&gt;CONFIG_KOBJECT_UEVENT=y<BR>&gt;# CONFIG_IKCONFIG is not set<BR>&gt;# CONFIG_EMBEDDED is not set<BR>&gt;CONFIG_KALLSYMS=y<BR>&gt;# CONFIG_KALLSYMS_EXTRA_PASS is not
 set<BR>&gt;CONFIG_PRINTK=y<BR>&gt;CONFIG_BUG=y<BR>&gt;CONFIG_BASE_FULL=y<BR>&gt;CONFIG_FUTEX=y<BR>&gt;CONFIG_EPOLL=y<BR>&gt;CONFIG_SHMEM=y<BR>&gt;CONFIG_CC_ALIGN_FUNCTIONS=0<BR>&gt;CONFIG_CC_ALIGN_LABELS=0<BR>&gt;CONFIG_CC_ALIGN_LOOPS=0<BR>&gt;CONFIG_CC_ALIGN_JUMPS=0<BR>&gt;# CONFIG_TINY_SHMEM is not set<BR>&gt;CONFIG_BASE_SMALL=0<BR>&gt;<BR>&gt;#<BR>&gt;# Loadable module support<BR>&gt;#<BR>&gt;# CONFIG_MODULES is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Processor<BR>&gt;#<BR>&gt;# CONFIG_6xx is not set<BR>&gt;# CONFIG_40x is not set<BR>&gt;# CONFIG_44x is not set<BR>&gt;# CONFIG_POWER3 is not set<BR>&gt;# CONFIG_POWER4 is not set<BR>&gt;CONFIG_8xx=y<BR>&gt;# CONFIG_E200 is not set<BR>&gt;# CONFIG_E500 is not set<BR>&gt;# CONFIG_MATH_EMULATION is not set<BR>&gt;# CONFIG_KEXEC is not set<BR>&gt;# CONFIG_CPU_FREQ is not set<BR>&gt;# CONFIG_WANT_EARLY_SERIAL is not set<BR>&gt;CONFIG_EMBEDDEDBOOT=y<BR>&gt;CONFIG_NOT_COHERENT_CACHE=y<BR>&gt;<BR>&gt;#<BR>&gt;# Platform
 options<BR>&gt;#<BR>&gt;CONFIG_FADS=y<BR>&gt;# CONFIG_RPXLITE is not set<BR>&gt;# CONFIG_RPXCLASSIC is not set<BR>&gt;# CONFIG_BSEIP is not set<BR>&gt;CONFIG_MPC8XXFADS=y<BR>&gt;# CONFIG_MPC86XADS is not set<BR>&gt;# CONFIG_MPC885ADS is not set<BR>&gt;# CONFIG_TQM823L is not set<BR>&gt;# CONFIG_TQM850L is not set<BR>&gt;# CONFIG_TQM855L is not set<BR>&gt;# CONFIG_TQM860L is not set<BR>&gt;# CONFIG_FPS850L is not set<BR>&gt;# CONFIG_SPD823TS is not set<BR>&gt;# CONFIG_IVMS8 is not set<BR>&gt;# CONFIG_IVML24 is not set<BR>&gt;# CONFIG_SM850 is not set<BR>&gt;# CONFIG_HERMES_PRO is not set<BR>&gt;# CONFIG_IP860 is not set<BR>&gt;# CONFIG_LWMON is not set<BR>&gt;# CONFIG_PCU_E is not set<BR>&gt;# CONFIG_CCM is not set<BR>&gt;# CONFIG_LANTEC is not set<BR>&gt;# CONFIG_MBX is not set<BR>&gt;# CONFIG_WINCEPT is not set<BR>&gt;# CONFIG_HIGHMEM is not set<BR>&gt;CONFIG_HZ_100=y<BR>&gt;# CONFIG_HZ_250 is not set<BR>&gt;# CONFIG_HZ_1000 is not
 set<BR>&gt;CONFIG_HZ=100<BR>&gt;CONFIG_PREEMPT_NONE=y<BR>&gt;# CONFIG_PREEMPT_VOLUNTARY is not set<BR>&gt;# CONFIG_PREEMPT is not set<BR>&gt;CONFIG_SELECT_MEMORY_MODEL=y<BR>&gt;CONFIG_FLATMEM_MANUAL=y<BR>&gt;# CONFIG_DISCONTIGMEM_MANUAL is not set<BR>&gt;# CONFIG_SPARSEMEM_MANUAL is not set<BR>&gt;CONFIG_FLATMEM=y<BR>&gt;CONFIG_FLAT_NODE_MEM_MAP=y<BR>&gt;CONFIG_BINFMT_ELF=y<BR>&gt;# CONFIG_BINFMT_MISC is not set<BR>&gt;CONFIG_CMDLINE_BOOL=y<BR>&gt;CONFIG_CMDLINE="console=ttyS1,57600 console=tty1 root=/dev/ram"<BR>&gt;# CONFIG_PM is not set<BR>&gt;CONFIG_SECCOMP=y<BR>&gt;CONFIG_ISA_DMA_API=y<BR>&gt;<BR>&gt;#<BR>&gt;# Bus options<BR>&gt;#<BR>&gt;# CONFIG_PCI is not set<BR>&gt;# CONFIG_PCI_DOMAINS is not set<BR>&gt;# CONFIG_PCI_QSPAN is not set<BR>&gt;<BR>&gt;#<BR>&gt;# PCCARD (PCMCIA/CardBus) support<BR>&gt;#<BR>&gt;# CONFIG_PCCARD is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Advanced setup<BR>&gt;#<BR>&gt;# CONFIG_ADVANCED_OPTIONS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Default settings for
 advanced configuration options are used<BR>&gt;#<BR>&gt;CONFIG_HIGHMEM_START=0xfe000000<BR>&gt;CONFIG_LOWMEM_SIZE=0x30000000<BR>&gt;CONFIG_KERNEL_START=0xc0000000<BR>&gt;CONFIG_TASK_SIZE=0x80000000<BR>&gt;CONFIG_CONSISTENT_START=0xff100000<BR>&gt;CONFIG_CONSISTENT_SIZE=0x00200000<BR>&gt;CONFIG_BOOT_LOAD=0x00400000<BR>&gt;<BR>&gt;#<BR>&gt;# Networking<BR>&gt;#<BR>&gt;CONFIG_NET=y<BR>&gt;<BR>&gt;#<BR>&gt;# Networking options<BR>&gt;#<BR>&gt;CONFIG_PACKET=y<BR>&gt;CONFIG_PACKET_MMAP=y<BR>&gt;CONFIG_UNIX=y<BR>&gt;# CONFIG_NET_KEY is not set<BR>&gt;CONFIG_INET=y<BR>&gt;# CONFIG_IP_MULTICAST is not set<BR>&gt;# CONFIG_IP_ADVANCED_ROUTER is not set<BR>&gt;CONFIG_IP_FIB_HASH=y<BR>&gt;CONFIG_IP_PNP=y<BR>&gt;CONFIG_IP_PNP_DHCP=y<BR>&gt;CONFIG_IP_PNP_BOOTP=y<BR>&gt;CONFIG_IP_PNP_RARP=y<BR>&gt;# CONFIG_NET_IPIP is not set<BR>&gt;# CONFIG_NET_IPGRE is not set<BR>&gt;CONFIG_ARPD=y<BR>&gt;# CONFIG_SYN_COOKIES is not set<BR>&gt;# CONFIG_INET_AH is not set<BR>&gt;# CONFIG_INET_ESP is not
 set<BR>&gt;# CONFIG_INET_IPCOMP is not set<BR>&gt;# CONFIG_INET_TUNNEL is not set<BR>&gt;CONFIG_IP_TCPDIAG=y<BR>&gt;CONFIG_IP_TCPDIAG_IPV6=y<BR>&gt;# CONFIG_TCP_CONG_ADVANCED is not set<BR>&gt;CONFIG_TCP_CONG_BIC=y<BR>&gt;CONFIG_IPV6=y<BR>&gt;# CONFIG_IPV6_PRIVACY is not set<BR>&gt;# CONFIG_INET6_AH is not set<BR>&gt;# CONFIG_INET6_ESP is not set<BR>&gt;# CONFIG_INET6_IPCOMP is not set<BR>&gt;# CONFIG_INET6_TUNNEL is not set<BR>&gt;# CONFIG_IPV6_TUNNEL is not set<BR>&gt;# CONFIG_NETFILTER is not set<BR>&gt;<BR>&gt;#<BR>&gt;# SCTP Configuration (EXPERIMENTAL)<BR>&gt;#<BR>&gt;# CONFIG_IP_SCTP is not set<BR>&gt;# CONFIG_ATM is not set<BR>&gt;CONFIG_BRIDGE=y<BR>&gt;# CONFIG_VLAN_8021Q is not set<BR>&gt;# CONFIG_DECNET is not set<BR>&gt;# CONFIG_LLC2 is not set<BR>&gt;# CONFIG_IPX is not set<BR>&gt;# CONFIG_ATALK is not set<BR>&gt;# CONFIG_X25 is not set<BR>&gt;# CONFIG_LAPB is not set<BR>&gt;# CONFIG_NET_DIVERT is not set<BR>&gt;# CONFIG_ECONET is not set<BR>&gt;# CONFIG_WAN_ROUTER is
 not set<BR>&gt;# CONFIG_NET_SCHED is not set<BR>&gt;# CONFIG_NET_CLS_ROUTE is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Network testing<BR>&gt;#<BR>&gt;# CONFIG_NET_PKTGEN is not set<BR>&gt;# CONFIG_HAMRADIO is not set<BR>&gt;# CONFIG_IRDA is not set<BR>&gt;# CONFIG_BT is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Device Drivers<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Generic Driver Options<BR>&gt;#<BR>&gt;CONFIG_STANDALONE=y<BR>&gt;CONFIG_PREVENT_FIRMWARE_BUILD=y<BR>&gt;# CONFIG_FW_LOADER is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Memory Technology Devices (MTD)<BR>&gt;#<BR>&gt;# CONFIG_MTD is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Parallel port support<BR>&gt;#<BR>&gt;# CONFIG_PARPORT is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Plug and Play support<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Block devices<BR>&gt;#<BR>&gt;# CONFIG_BLK_DEV_FD is not set<BR>&gt;# CONFIG_BLK_DEV_COW_COMMON is not set<BR>&gt;# CONFIG_BLK_DEV_LOOP is not set<BR>&gt;# CONFIG_BLK_DEV_NBD is not
 set<BR>&gt;CONFIG_BLK_DEV_RAM=y<BR>&gt;CONFIG_BLK_DEV_RAM_COUNT=16<BR>&gt;CONFIG_BLK_DEV_RAM_SIZE=4096<BR>&gt;CONFIG_BLK_DEV_INITRD=y<BR>&gt;CONFIG_INITRAMFS_SOURCE=""<BR>&gt;# CONFIG_LBD is not set<BR>&gt;# CONFIG_CDROM_PKTCDVD is not set<BR>&gt;<BR>&gt;#<BR>&gt;# IO Schedulers<BR>&gt;#<BR>&gt;CONFIG_IOSCHED_NOOP=y<BR>&gt;# CONFIG_IOSCHED_AS is not set<BR>&gt;# CONFIG_IOSCHED_DEADLINE is not set<BR>&gt;# CONFIG_IOSCHED_CFQ is not set<BR>&gt;# CONFIG_ATA_OVER_ETH is not set<BR>&gt;<BR>&gt;#<BR>&gt;# ATA/ATAPI/MFM/RLL support<BR>&gt;#<BR>&gt;# CONFIG_IDE is not set<BR>&gt;<BR>&gt;#<BR>&gt;# SCSI device support<BR>&gt;#<BR>&gt;# CONFIG_SCSI is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Multi-device support (RAID and LVM)<BR>&gt;#<BR>&gt;# CONFIG_MD is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Fusion MPT device support<BR>&gt;#<BR>&gt;# CONFIG_FUSION is not set<BR>&gt;<BR>&gt;#<BR>&gt;# IEEE 1394 (FireWire) support<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# I2O device support<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;#
 Macintosh device drivers<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Network device support<BR>&gt;#<BR>&gt;CONFIG_NETDEVICES=y<BR>&gt;# CONFIG_DUMMY is not set<BR>&gt;# CONFIG_BONDING is not set<BR>&gt;# CONFIG_EQUALIZER is not set<BR>&gt;# CONFIG_TUN is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Ethernet (10 or 100Mbit)<BR>&gt;#<BR>&gt;CONFIG_NET_ETHERNET=y<BR>&gt;CONFIG_MII=y<BR>&gt;<BR>&gt;#<BR>&gt;# Ethernet (1000 Mbit)<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Ethernet (10000 Mbit)<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Token Ring devices<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Wireless LAN (non-hamradio)<BR>&gt;#<BR>&gt;# CONFIG_NET_RADIO is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Wan interfaces<BR>&gt;#<BR>&gt;# CONFIG_WAN is not set<BR>&gt;# CONFIG_PPP is not set<BR>&gt;# CONFIG_SLIP is not set<BR>&gt;# CONFIG_SHAPER is not set<BR>&gt;# CONFIG_NETCONSOLE is not set<BR>&gt;# CONFIG_NETPOLL is not set<BR>&gt;# CONFIG_NET_POLL_CONTROLLER is not set<BR>&gt;<BR>&gt;#<BR>&gt;# ISDN subsystem<BR>&gt;#<BR>&gt;#
 CONFIG_ISDN is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Telephony Support<BR>&gt;#<BR>&gt;# CONFIG_PHONE is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Input device support<BR>&gt;#<BR>&gt;CONFIG_INPUT=y<BR>&gt;<BR>&gt;#<BR>&gt;# Userland interfaces<BR>&gt;#<BR>&gt;CONFIG_INPUT_MOUSEDEV=y<BR>&gt;CONFIG_INPUT_MOUSEDEV_PSAUX=y<BR>&gt;CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024<BR>&gt;CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768<BR>&gt;# CONFIG_INPUT_JOYDEV is not set<BR>&gt;# CONFIG_INPUT_TSDEV is not set<BR>&gt;# CONFIG_INPUT_EVDEV is not set<BR>&gt;# CONFIG_INPUT_EVBUG is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Input Device Drivers<BR>&gt;#<BR>&gt;# CONFIG_INPUT_KEYBOARD is not set<BR>&gt;# CONFIG_INPUT_MOUSE is not set<BR>&gt;# CONFIG_INPUT_JOYSTICK is not set<BR>&gt;# CONFIG_INPUT_TOUCHSCREEN is not set<BR>&gt;# CONFIG_INPUT_MISC is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Hardware I/O ports<BR>&gt;#<BR>&gt;# CONFIG_SERIO is not set<BR>&gt;# CONFIG_GAMEPORT is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Character
 devices<BR>&gt;#<BR>&gt;CONFIG_VT=y<BR>&gt;CONFIG_VT_CONSOLE=y<BR>&gt;CONFIG_HW_CONSOLE=y<BR>&gt;CONFIG_SERIAL_NONSTANDARD=y<BR>&gt;# CONFIG_COMPUTONE is not set<BR>&gt;# CONFIG_ROCKETPORT is not set<BR>&gt;# CONFIG_CYCLADES is not set<BR>&gt;# CONFIG_DIGIEPCA is not set<BR>&gt;# CONFIG_MOXA_INTELLIO is not set<BR>&gt;# CONFIG_MOXA_SMARTIO is not set<BR>&gt;# CONFIG_ISI is not set<BR>&gt;# CONFIG_SYNCLINKMP is not set<BR>&gt;# CONFIG_N_HDLC is not set<BR>&gt;# CONFIG_RISCOM8 is not set<BR>&gt;# CONFIG_SPECIALIX is not set<BR>&gt;# CONFIG_SX is not set<BR>&gt;# CONFIG_RIO is not set<BR>&gt;# CONFIG_STALDRV is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Serial drivers<BR>&gt;#<BR>&gt;# CONFIG_SERIAL_8250 is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Non-8250 serial port support<BR>&gt;#<BR>&gt;CONFIG_SERIAL_CORE=y<BR>&gt;CONFIG_SERIAL_CORE_CONSOLE=y<BR>&gt;CONFIG_SERIAL_CPM=y<BR>&gt;CONFIG_SERIAL_CPM_CONSOLE=y<BR>&gt;# CONFIG_SERIAL_CPM_SCC1 is not set<BR>&gt;# CONFIG_SERIAL_CPM_SCC2 is not set<BR>&gt;#
 CONFIG_SERIAL_CPM_SCC3 is not set<BR>&gt;# CONFIG_SERIAL_CPM_SCC4 is not set<BR>&gt;# CONFIG_SERIAL_CPM_SMC1 is not set<BR>&gt;CONFIG_SERIAL_CPM_SMC2=y<BR>&gt;CONFIG_UNIX98_PTYS=y<BR>&gt;# CONFIG_LEGACY_PTYS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# IPMI<BR>&gt;#<BR>&gt;# CONFIG_IPMI_HANDLER is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Watchdog Cards<BR>&gt;#<BR>&gt;# CONFIG_WATCHDOG is not set<BR>&gt;# CONFIG_NVRAM is not set<BR>&gt;# CONFIG_GEN_RTC is not set<BR>&gt;# CONFIG_DTLK is not set<BR>&gt;# CONFIG_R3964 is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Ftape, the floppy tape device driver<BR>&gt;#<BR>&gt;# CONFIG_AGP is not set<BR>&gt;# CONFIG_RAW_DRIVER is not set<BR>&gt;<BR>&gt;#<BR>&gt;# TPM devices<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# I2C support<BR>&gt;#<BR>&gt;# CONFIG_I2C is not set<BR>&gt;# CONFIG_I2C_SENSOR is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Dallas's 1-wire bus<BR>&gt;#<BR>&gt;# CONFIG_W1 is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Hardware Monitoring support<BR>&gt;#<BR>&gt;# CONFIG_HWMON is
 not set<BR>&gt;<BR>&gt;#<BR>&gt;# Misc devices<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# Multimedia devices<BR>&gt;#<BR>&gt;# CONFIG_VIDEO_DEV is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Digital Video Broadcasting Devices<BR>&gt;#<BR>&gt;# CONFIG_DVB is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Graphics support<BR>&gt;#<BR>&gt;# CONFIG_FB is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Console display driver support<BR>&gt;#<BR>&gt;CONFIG_DUMMY_CONSOLE=y<BR>&gt;<BR>&gt;#<BR>&gt;# Sound<BR>&gt;#<BR>&gt;# CONFIG_SOUND is not set<BR>&gt;<BR>&gt;#<BR>&gt;# USB support<BR>&gt;#<BR>&gt;# CONFIG_USB_ARCH_HAS_HCD is not set<BR>&gt;# CONFIG_USB_ARCH_HAS_OHCI is not set<BR>&gt;<BR>&gt;#<BR>&gt;# USB Gadget Support<BR>&gt;#<BR>&gt;# CONFIG_USB_GADGET is not set<BR>&gt;<BR>&gt;#<BR>&gt;# MMC/SD Card support<BR>&gt;#<BR>&gt;# CONFIG_MMC is not set<BR>&gt;<BR>&gt;#<BR>&gt;# InfiniBand support<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# SN Devices<BR>&gt;#<BR>&gt;<BR>&gt;#<BR>&gt;# File
 systems<BR>&gt;#<BR>&gt;CONFIG_EXT2_FS=y<BR>&gt;CONFIG_EXT2_FS_XATTR=y<BR>&gt;CONFIG_EXT2_FS_POSIX_ACL=y<BR>&gt;CONFIG_EXT2_FS_SECURITY=y<BR>&gt;CONFIG_EXT2_FS_XIP=y<BR>&gt;CONFIG_FS_XIP=y<BR>&gt;# CONFIG_EXT3_FS is not set<BR>&gt;# CONFIG_JBD is not set<BR>&gt;CONFIG_FS_MBCACHE=y<BR>&gt;# CONFIG_REISERFS_FS is not set<BR>&gt;# CONFIG_JFS_FS is not set<BR>&gt;CONFIG_FS_POSIX_ACL=y<BR>&gt;<BR>&gt;#<BR>&gt;# XFS support<BR>&gt;#<BR>&gt;# CONFIG_XFS_FS is not set<BR>&gt;# CONFIG_MINIX_FS is not set<BR>&gt;CONFIG_ROMFS_FS=y<BR>&gt;CONFIG_INOTIFY=y<BR>&gt;# CONFIG_QUOTA is not set<BR>&gt;CONFIG_DNOTIFY=y<BR>&gt;# CONFIG_AUTOFS_FS is not set<BR>&gt;# CONFIG_AUTOFS4_FS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# CD-ROM/DVD Filesystems<BR>&gt;#<BR>&gt;# CONFIG_ISO9660_FS is not set<BR>&gt;# CONFIG_UDF_FS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# DOS/FAT/NT Filesystems<BR>&gt;#<BR>&gt;# CONFIG_MSDOS_FS is not set<BR>&gt;# CONFIG_VFAT_FS is not set<BR>&gt;# CONFIG_NTFS_FS is not
 set<BR>&gt;<BR>&gt;#<BR>&gt;# Pseudo filesystems<BR>&gt;#<BR>&gt;CONFIG_PROC_FS=y<BR>&gt;# CONFIG_PROC_KCORE is not set<BR>&gt;CONFIG_SYSFS=y<BR>&gt;# CONFIG_DEVPTS_FS_XATTR is not set<BR>&gt;# CONFIG_TMPFS is not set<BR>&gt;# CONFIG_HUGETLB_PAGE is not set<BR>&gt;CONFIG_RAMFS=y<BR>&gt;<BR>&gt;#<BR>&gt;# Miscellaneous filesystems<BR>&gt;#<BR>&gt;# CONFIG_ADFS_FS is not set<BR>&gt;# CONFIG_AFFS_FS is not set<BR>&gt;# CONFIG_HFS_FS is not set<BR>&gt;# CONFIG_HFSPLUS_FS is not set<BR>&gt;# CONFIG_BEFS_FS is not set<BR>&gt;# CONFIG_BFS_FS is not set<BR>&gt;# CONFIG_EFS_FS is not set<BR>&gt;# CONFIG_CRAMFS is not set<BR>&gt;# CONFIG_VXFS_FS is not set<BR>&gt;# CONFIG_HPFS_FS is not set<BR>&gt;# CONFIG_QNX4FS_FS is not set<BR>&gt;# CONFIG_SYSV_FS is not set<BR>&gt;# CONFIG_UFS_FS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Network File Systems<BR>&gt;#<BR>&gt;CONFIG_NFS_FS=y<BR>&gt;# CONFIG_NFS_V3 is not set<BR>&gt;# CONFIG_NFS_V4 is not set<BR>&gt;# CONFIG_NFS_DIRECTIO is not set<BR>&gt;#
 CONFIG_NFSD is not set<BR>&gt;CONFIG_ROOT_NFS=y<BR>&gt;CONFIG_LOCKD=y<BR>&gt;CONFIG_NFS_COMMON=y<BR>&gt;CONFIG_SUNRPC=y<BR>&gt;# CONFIG_RPCSEC_GSS_KRB5 is not set<BR>&gt;# CONFIG_RPCSEC_GSS_SPKM3 is not set<BR>&gt;# CONFIG_SMB_FS is not set<BR>&gt;# CONFIG_CIFS is not set<BR>&gt;# CONFIG_NCP_FS is not set<BR>&gt;# CONFIG_CODA_FS is not set<BR>&gt;# CONFIG_AFS_FS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Partition Types<BR>&gt;#<BR>&gt;# CONFIG_PARTITION_ADVANCED is not set<BR>&gt;CONFIG_MSDOS_PARTITION=y<BR>&gt;<BR>&gt;#<BR>&gt;# Native Language Support<BR>&gt;#<BR>&gt;# CONFIG_NLS is not set<BR>&gt;<BR>&gt;#<BR>&gt;# MPC8xx CPM Options<BR>&gt;#<BR>&gt;# CONFIG_SCC_ENET is not set<BR>&gt;CONFIG_FEC_ENET=y<BR>&gt;CONFIG_USE_MDIO=y<BR>&gt;CONFIG_FEC_AM79C874=y<BR>&gt;# CONFIG_FEC_LXT970 is not set<BR>&gt;# CONFIG_FEC_LXT971 is not set<BR>&gt;# CONFIG_FEC_QS6612 is not set<BR>&gt;CONFIG_ENET_BIG_BUFFERS=y<BR>&gt;<BR>&gt;#<BR>&gt;# Generic MPC8xx Options<BR>&gt;#<BR>&gt;# CONFIG_8xx_COPYBACK
 is not set<BR>&gt;# CONFIG_8xx_CPU6 is not set<BR>&gt;CONFIG_NO_UCODE_PATCH=y<BR>&gt;# CONFIG_USB_SOF_UCODE_PATCH is not set<BR>&gt;# CONFIG_I2C_SPI_UCODE_PATCH is not set<BR>&gt;# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Library routines<BR>&gt;#<BR>&gt;# CONFIG_CRC_CCITT is not set<BR>&gt;# CONFIG_CRC32 is not set<BR>&gt;# CONFIG_LIBCRC32C is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Profiling support<BR>&gt;#<BR>&gt;# CONFIG_PROFILING is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Kernel hacking<BR>&gt;#<BR>&gt;# CONFIG_PRINTK_TIME is not set<BR>&gt;# CONFIG_DEBUG_KERNEL is not set<BR>&gt;CONFIG_LOG_BUF_SHIFT=14<BR>&gt;<BR>&gt;#<BR>&gt;# Security options<BR>&gt;#<BR>&gt;# CONFIG_KEYS is not set<BR>&gt;# CONFIG_SECURITY is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Cryptographic options<BR>&gt;#<BR>&gt;# CONFIG_CRYPTO is not set<BR>&gt;<BR>&gt;#<BR>&gt;# Hardware crypto devices<BR>&gt;#<BR>&gt;
 <BR>&gt;<BR>&gt;------------------------------------------------------------------------<BR>&gt;<BR>&gt;_______________________________________________<BR>&gt;Linuxppc-embedded mailing list<BR>&gt;<A href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A><BR>&gt;<A href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A><BR>&gt;</div>  <div>&nbsp;</div>  <div>&nbsp;</div><p>
		<hr size=1>Yahoo! Photos<br> 
Ring in the New Year with <a href="http://us.rd.yahoo.com/mail_us/taglines/photos/*http://pg.photos.yahoo.com/ph//page?.file=calendar_splash.html&.dir=">Photo Calendars</a>. Add photos, events, holidays, whatever.
--0-1297231242-1135917871=:7935--
