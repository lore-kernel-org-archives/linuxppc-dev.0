Return-Path: <lonsn2000@yahoo.com.cn>
Received: from web54005.mail.yahoo.com (web54005.mail.yahoo.com
	[206.190.36.229]) by ozlabs.org (Postfix) with SMTP id 735AC2BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 22:45:09 +1000 (EST)
Message-ID: <20040916123826.64676.qmail@web54005.mail.yahoo.com>
Date: Thu, 16 Sep 2004 20:38:26 +0800 (CST)
From: =?gb2312?q?rs=20L?= <lonsn2000@yahoo.com.cn>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-585884734-1095338306=:63590"
Subject: Hpt371 driver on CSB272 board
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-585884734-1095338306=:63590
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,Dear All,
  I tried to add a Rocket 133s card and a harddisk into the 
CSB272  card which is a demo card with PPC405GP and montavisa linux 3.0. I inserted  the Rocket 133s card(pci-to-ide card with hpt371 chip on it)to the CSB272  board PCI slot, and connected the IDE harddisk to it with special IDE line  and turn on the power.
   First I cross-compiled the hpt371 chip linux driver with 
ppc_405-gcc  and ppc_405-ld.Second I compiled the embedded linux kernel again with  ATA/IDE and SCSI supports(scsi harddisk support).Because the hpt371 driver is written by scsi mode, to insmod hpt371.o must modprobe sd_mod which  needed scsi.o and sd_mod.o. Then I started the embedded linux,but when I ran  the order: #insmod hpt371.o the error appeared.
   The system chocked at Partition check.The screen appear: 
Partition  check
sda:
but the driver can get some harddisk information at the beginnig of insmod hpt371.o,such as VenderID,DeviceID,and harddisk capacity(40G).I have compiled scsi  support,partition support,file type on the harddisk,but it didn't work. The  driver is good when I used it in the linux on my PC,it can find the partition information and files on the harddisk.I cannot find what problem in the kernel or the driver. Please tell me some important supports on compiling kernel or  selections about driver.
I have did as the HPT371 supporting worker told me(type the hdx=noprobe to avoid two 
driver loaded  for hpt371), but it didn't work.
The debug infomation follows below,my Linux version is > 2.4.18_mvl30-walnut.
> 
> U-Boot 1.1.1 (Sep  6 2004 - 11:32:49)
> 
> CPU:   IBM PowerPC 405GP Rev. E at 198 MHz (PLB=66, OPB=16, EBC=33 
MHz)
>        PCI sync clock at 33 MHz, internal PCI arbiter enabled
>        16 kB I-Cache 8 kB D-Cache
> BOARD: Cogent CSB272
> I2C:   ready
> DRAM:  64 MB
> FLASH: erase_region_count = 128 erase_region_size = 131072
> 32 MB
> In:    serial
> Out:   serial
> Err:   serial
> BEDBUG:ready
> Hit any key to stop autoboot:  5 
> u-boot=> run bootcmd
> ENET Speed is 100 Mbps - HALF duplex connection
> TFTP from server 10.96.10.215; our IP address is 10.96.10.216
> Filename 'zImage_scsi.bin'.
> Load address: 0x200000
> Loading: 
> *#################################################################
>   #################################################################
>   ################################
> done
> Bytes transferred = 829146 (ca6da hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux kernel Image
>    Created:      2004-09-14   8:22:26 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    829082 Bytes = 809.7 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Linux version 2.4.18_mvl30-walnut (root@Redhat) (gcc version 3.2.1 
20020930 
> (MontaVista)) #40 Tue Sep 14 16:19:49 CST 2004
> CSB272 (IBM405GP) Platform
> Port by MontaVista Software, Inc. (source@mvista.com)
> On node 0 totalpages: 15360
> zone(0): 15360 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: console=ttyS0,38400 hda=noprobe root=/dev/nfs rw 
> mem=60M nfsroot=10.96.10.215:/home/mvkit/ppc405/target 
> ip=10.96.10.216:10.96.10.215:10.96.10.254:255.255.255.0:red::off
> ide_setup: hda=noprobe -- BAD OPTION
> Calibrating delay loop... 197.83 BogoMIPS
> Memory: 58520k available (1376k kernel code, 468k data, 92k init, 0k 
> highmem)
> Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 0 of device 00:01.0
> PCI: Cannot allocate resource region 1 of device 00:01.0
> PCI: Cannot allocate resource region 2 of device 00:01.0
> PCI: Cannot allocate resource region 3 of device 00:01.0
> PCI: Cannot allocate resource region 4 of device 00:01.0
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> OCP uart ver 1.2 init complete
> Starting kswapd
> Disabling the Out Of Memory Killer
> Journalled Block Device driver loaded
> EFS: 1.0a - http://aeschi.ch.eu.org/efs/
> i2c-core.o: i2c core module version 2.6.2 (20011118)
> i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)
> i2c-proc.o version 2.6.2 (20011118)
> initialize_kbd: Keyboard reset failed, no ACK
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
> SERIAL_PCI enabled
> ttyS00 at 0xef600300 (irq = 0) is a 16550A
> ttyS01 at 0xef600400 (irq = 1) is a 16550A
> IBM gpio driver version 02.01.21.d
> GPIO #0 at 0xef600700
> PPC 405 watchdog driver v0.5
> block: 128 slots per queue, batch=32
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
> eth0: Phy @ 0x0, type LXT971A (0x001378e2)
> Reset ethernet interfaces
> SCSI subsystem driver Revision: 1.00
> request_module[scsi_hostadapter]: Root fs not mounted
> request_module[scsi_hostadapter]: Root fs not mounted
> IBM On-chip iic (i2c) algorithm module 2002.30.04
> iic_ibmocp_init: IBM on-chip iic adapter module
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 8192)
> opening eth0 on emac 0
> eth0: IBM EMAC: link up, 100 Mbps Half Duplex, auto-negotiation 
complete.
> eth0: IBM EMAC: MAC 00:0b:db:65:36:1f.
> eth0: IBM EMAC: open completed
> IP-Config: Complete:
>       device=eth0, addr=10.96.10.216, mask=255.255.255.0, 
gw=10.96.10.254,
>      host=red, domain=, nis-domain=(none),
>      bootserver=10.96.10.215, rootserver=10.96.10.215, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 10.96.10.215
> Looking up port of RPC 100005/1 on 10.96.10.215
> V/FS: Mounted rooeing unused kernel memory: 92k init
> INIT: version 2.78 booting
> nfs_refresh_inode: inode number mismatch
> expected (0x303/0x1e4109), got (0x303/0x7456b)
> Activating swap...
> Checking all file systems...
> Parallelizing fsck version 1.22 (22-Jun-2001)
> Calculating module dependencies... nfs_refresh_inode: inode number 
mismatch
> expected (0x303/0x22c67f), got (0x303/0x22c682)
> nfs_refresh_inode: inode number mismatch
> expected (0x303/0x22c680), got (0x303/0x22c683)
> depmod: *** Unrenfs_refresh_inode: inode number mismatch
> expected (0x303/0x22c681), got (0x303/0x22c684)
> nfs_refresh_inode: inode number mismatch
> expected (0x303/0x22c682), got (0x303/0x22c685)
> solved symbols infs_refresh_inode: inode number mismatch
> expected (0x303/0x22c683), got (0x303/0x22c67e)
> n /lib/modules/2.4.18_mvl30-walnut/kernel/fs/ext3/ext3.o
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18_mvl30-walnut/kernel/fs/jbd/jbd.o
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18_mvl30-walnut/kernel/fs/reiserfs/reiserfs.o
> done.
> Loading modules: 
> mkdir: cannot create directory `/dev/pts': File exists
> Mounting local filesystems...
> nothing was mounted
> Cleaning: /etc/network/ifstate.
> Setting up IP spoofing protection: rp_filter.
> Disable TCP/IP Explicit Congestion Notification: done.
> Configuring network interfaces: done.
> Starting portmap daemon: portmap.
> Cleaning: /tmp /var/lock /var/run.
> nfs_refresh_inode: inode number mismatch
> expected (0x303/0x1a868a), got (0x303/0x1a8aad)
> INIT: Entering runlevel: 3
> Starting system log daemon: syslogd klogd.
> Starting internet superserver: inetd.
> nfs_refresh_inode: inode number mismatch
> expected (0x303/0x7456e), got (0x303/0x7456b)
> 
> MontaVista Linux 3.0, Professional Edition
> 
> red login: root
> Last login: Thu Jan  1 00:00:15 1970 on console
> Linux red 2.4.18_mvl30-walnut #40 Tue Sep 14 16:19:49 CST 2004 ppc 
unknown
> root@red:~# ls
> chris  hello1  lichen  lily
> root@red:~# cd prog      /programs/
> root@red:/programs# ls
> chenny  hello.exe     hpt1.2  ldd2-samples-1.0.1  scsi.o
> demux  hello1        hpt371  mmap       sd_mod.o
> hello  hello2        hpt371.o  pro       v5series
> hello.c  helloworld.c  info.txt  replex       v6series
> root@red:/programs# cd hpt1.2
> root@red:/programs/hpt1.2# ls
> Makefile   command.h   glbdata.c  hpt3xx.c    idevice.c   readme.txt
> atapi.h    compiler.h  global.h   hpt3xx.h    ihpt3xx.c   stypes.h
> channel.c  device.c    hpt.c   hptproc.c   init.c   vdevice.c
> channel.h  device.h    hpt.o   hpttempl.h  osheader.h  vdevice.h
> chip.h    entry.c     hpt371.o   ichip.c     oslinux.h
> root@red:/programs/hpt1.2# insmod hpt37` 1.o
> HPT371 UDMA/ATA133 Controller driver
> Version 1.1, Compiled Sep 14 2004 16:34:33
> Scan for chips...
> hpt3xx: detected 33Mhz PCI clock
> Scan for devices...
> scsi0 : hpt371
> 
> hpt3xx_QueueCommand() 0/0/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
>   Vendor: MAXTOR 6  Model: L040J2            Rev: AR1.
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> 
> hpt3xx_QueueCommand() 0/1/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/2/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/3/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/4/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/5/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/6/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/7/0 cdb=(12000000-ff000000-13560ae8)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> 
> hpt3xx_QueueCommand() 0/0/0 cdb=(0-0-7db0)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> 
> hpt3xx_QueueCommand() 0/0/0 cdb=(25000000-0-7db0)
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
> SCSI device sda: 78177791 512-byte hdwr sectors (40027 MB)
> Partition check:
>  sda:
> hpt3xx_QueueCommand() 0/0/0 cdb=(28000000-0-8007db0)
> 
> //============
> 
> ----- Leaving hpt3xx_queueCommand() -----
> 
 By the way,
   Linux version is 2.4.18_mvl30-walnut on Power PC 405GP
   HPT371 Driver Opensouce Version is hpt371 1.1 attached in the accessory 
   I used ppc_405-gcc and ppc_405-ld for cross-compiling .
   Please help me to find where is the problem in compiling embedded linux
   kernel or U-boot or CSB272 board or hpt371 driver .Thank you very much!
          Zheng Hongchao
               2004.9.16



---------------------------------
Do You Yahoo!?
œ”” œ‰Ã´–°£ø—≈ª¢µÁ” ◊‘÷˙¿©»›£°
--0-585884734-1095338306=:63590
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Hi,Dear All,<BR>&nbsp; I tried to add a Rocket 133s card and a harddisk into the <BR>CSB272&nbsp; card which is a demo card with PPC405GP and montavisa linux 3.0. I inserted&nbsp; the Rocket 133s card(pci-to-ide card with hpt371 chip on it)to the CSB272&nbsp; board PCI slot, and connected the IDE harddisk to it with special IDE line&nbsp; and turn on the power.<BR>&nbsp;&nbsp; First I cross-compiled the hpt371 chip linux driver with <BR>ppc_405-gcc&nbsp; and ppc_405-ld.Second I compiled the embedded linux kernel again with&nbsp;&nbsp;ATA/IDE and SCSI supports(scsi harddisk support).Because the hpt371 driver is&nbsp;written by scsi mode, to insmod hpt371.o must modprobe sd_mod which&nbsp; needed scsi.o and sd_mod.o. Then I started the embedded linux,but when I ran&nbsp; the order: #insmod hpt371.o the error appeared.<BR>&nbsp;&nbsp; The system chocked at Partition check.The screen appear: <BR>Partition&nbsp; check<BR>sda:<BR>but the driver can get some harddisk information at the
 beginnig of insmod hpt371.o,such as VenderID,DeviceID,and harddisk capacity(40G).I have compiled scsi&nbsp; support,partition support,file type on the harddisk,but it didn't work. The&nbsp; driver is good when I used it in the linux on my PC,it can find the partition information and files on the harddisk.I cannot find what problem in the kernel or the driver. Please tell me some important supports on compiling kernel or&nbsp; selections about driver.</DIV>
<DIV>I have did as the HPT371 supporting worker told me(type the hdx=noprobe to avoid two <BR>driver loaded&nbsp; for hpt371), but it didn't work.<BR>The debug infomation follows below,my Linux version is &gt; 2.4.18_mvl30-walnut.<BR>&gt; <BR>&gt; U-Boot 1.1.1 (Sep&nbsp; 6 2004 - 11:32:49)<BR>&gt; <BR>&gt; CPU:&nbsp;&nbsp; IBM PowerPC 405GP Rev. E at 198 MHz (PLB=66, OPB=16, EBC=33 <BR>MHz)<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI sync clock at 33 MHz, internal PCI arbiter enabled<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 kB I-Cache 8 kB D-Cache<BR>&gt; BOARD: Cogent CSB272<BR>&gt; I2C:&nbsp;&nbsp; ready<BR>&gt; DRAM:&nbsp; 64 MB<BR>&gt; FLASH: erase_region_count = 128 erase_region_size = 131072<BR>&gt; 32 MB<BR>&gt; In:&nbsp;&nbsp;&nbsp; serial<BR>&gt; Out:&nbsp;&nbsp; serial<BR>&gt; Err:&nbsp;&nbsp; serial<BR>&gt; BEDBUG:ready<BR>&gt; Hit any key to stop autoboot:&nbsp; 5 <BR>&gt; u-boot=&gt; run bootcmd<BR>&gt; ENET Speed is 100 Mbps - HALF duplex
 connection<BR>&gt; TFTP from server 10.96.10.215; our IP address is 10.96.10.216<BR>&gt; Filename 'zImage_scsi.bin'.<BR>&gt; Load address: 0x200000<BR>&gt; Loading: <BR>&gt; *#################################################################<BR>&gt; &nbsp; #################################################################<BR>&gt; &nbsp; ################################<BR>&gt; done<BR>&gt; Bytes transferred = 829146 (ca6da hex)<BR>&gt; ## Booting image at 00200000 ...<BR>&gt;&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux kernel Image<BR>&gt;&nbsp;&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2004-09-14&nbsp;&nbsp; 8:22:26 UTC<BR>&gt;&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR>&gt;&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 829082 Bytes = 809.7 kB<BR>&gt;&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR>&gt;&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>&gt;&nbsp;&nbsp;&nbsp; Verifying Checksum ... OK<BR>&gt;&nbsp;&nbsp;&nbsp;
 Uncompressing Kernel Image ... OK<BR>&gt; Linux version 2.4.18_mvl30-walnut (<A href="mailto:root@Redhat">root@Redhat</A>) (gcc version 3.2.1 <BR>20020930 <BR>&gt; (MontaVista)) #40 Tue Sep 14 16:19:49 CST 2004<BR>&gt; CSB272 (IBM405GP) Platform<BR>&gt; Port by MontaVista Software, Inc. (<A href="mailto:source@mvista.com">source@mvista.com</A>)<BR>&gt; On node 0 totalpages: 15360<BR>&gt; zone(0): 15360 pages.<BR>&gt; zone(1): 0 pages.<BR>&gt; zone(2): 0 pages.<BR>&gt; Kernel command line: console=ttyS0,38400 hda=noprobe root=/dev/nfs rw <BR>&gt; mem=60M nfsroot=10.96.10.215:/home/mvkit/ppc405/target <BR>&gt; ip=10.96.10.216:10.96.10.215:10.96.10.254:255.255.255.0:red::off<BR>&gt; ide_setup: hda=noprobe -- BAD OPTION<BR>&gt; Calibrating delay loop... 197.83 BogoMIPS<BR>&gt; Memory: 58520k available (1376k kernel code, 468k data, 92k init, 0k <BR>&gt; highmem)<BR>&gt; Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)<BR>&gt; Inode-cache hash table entries: 4096 (order: 3,
 32768 bytes)<BR>&gt; Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)<BR>&gt; Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)<BR>&gt; Page-cache hash table entries: 16384 (order: 4, 65536 bytes)<BR>&gt; POSIX conformance testing by UNIFIX<BR>&gt; PCI: Probing PCI hardware<BR>&gt; PCI: Cannot allocate resource region 0 of device 00:01.0<BR>&gt; PCI: Cannot allocate resource region 1 of device 00:01.0<BR>&gt; PCI: Cannot allocate resource region 2 of device 00:01.0<BR>&gt; PCI: Cannot allocate resource region 3 of device 00:01.0<BR>&gt; PCI: Cannot allocate resource region 4 of device 00:01.0<BR>&gt; Linux NET4.0 for Linux 2.4<BR>&gt; Based upon Swansea University Computer Society NET3.039<BR>&gt; Initializing RT netlink socket<BR>&gt; OCP uart ver 1.2 init complete<BR>&gt; Starting kswapd<BR>&gt; Disabling the Out Of Memory Killer<BR>&gt; Journalled Block Device driver loaded<BR>&gt; EFS: 1.0a - <A
 href="http://aeschi.ch.eu.org/efs/">http://aeschi.ch.eu.org/efs/</A><BR>&gt; i2c-core.o: i2c core module version 2.6.2 (20011118)<BR>&gt; i2c-dev.o: i2c /dev entries driver module version 2.6.2 (20011118)<BR>&gt; i2c-proc.o version 2.6.2 (20011118)<BR>&gt; initialize_kbd: Keyboard reset failed, no ACK<BR>&gt; Detected PS/2 Mouse Port.<BR>&gt; pty: 256 Unix98 ptys configured<BR>&gt; Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ <BR>&gt; SERIAL_PCI enabled<BR>&gt; ttyS00 at 0xef600300 (irq = 0) is a 16550A<BR>&gt; ttyS01 at 0xef600400 (irq = 1) is a 16550A<BR>&gt; IBM gpio driver version 02.01.21.d<BR>&gt; GPIO #0 at 0xef600700<BR>&gt; PPC 405 watchdog driver v0.5<BR>&gt; block: 128 slots per queue, batch=32<BR>&gt; RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize<BR>&gt; Uniform Multi-Platform E-IDE driver Revision: 6.31<BR>&gt; ide: Assuming 33MHz system bus speed for PIO modes; override with <BR>idebus=xx<BR>&gt; eth0: Phy @ 0x0, type
 LXT971A (0x001378e2)<BR>&gt; Reset ethernet interfaces<BR>&gt; SCSI subsystem driver Revision: 1.00<BR>&gt; request_module[scsi_hostadapter]: Root fs not mounted<BR>&gt; request_module[scsi_hostadapter]: Root fs not mounted<BR>&gt; IBM On-chip iic (i2c) algorithm module 2002.30.04<BR>&gt; iic_ibmocp_init: IBM on-chip iic adapter module<BR>&gt; NET4: Linux TCP/IP 1.0 for NET4.0<BR>&gt; IP Protocols: ICMP, UDP, TCP, IGMP<BR>&gt; IP: routing cache hash table of 512 buckets, 4Kbytes<BR>&gt; TCP: Hash tables configured (established 4096 bind 8192)<BR>&gt; opening eth0 on emac 0<BR>&gt; eth0: IBM EMAC: link up, 100 Mbps Half Duplex, auto-negotiation <BR>complete.<BR>&gt; eth0: IBM EMAC: MAC 00:0b:db:65:36:1f.<BR>&gt; eth0: IBM EMAC: open completed<BR>&gt; IP-Config: Complete:<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=10.96.10.216, mask=255.255.255.0, <BR>gw=10.96.10.254,<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; host=red, domain=,
 nis-domain=(none),<BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootserver=10.96.10.215, rootserver=10.96.10.215, rootpath=<BR>&gt; NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.<BR>&gt; Looking up port of RPC 100003/2 on 10.96.10.215<BR>&gt; Looking up port of RPC 100005/1 on 10.96.10.215<BR>&gt; V/FS: Mounted rooeing unused kernel memory: 92k init<BR>&gt; INIT: version 2.78 booting<BR>&gt; nfs_refresh_inode: inode number mismatch<BR>&gt; expected (0x303/0x1e4109), got (0x303/0x7456b)<BR>&gt; Activating swap...<BR>&gt; Checking all file systems...<BR>&gt; Parallelizing fsck version 1.22 (22-Jun-2001)<BR>&gt; Calculating module dependencies... nfs_refresh_inode: inode number <BR>mismatch<BR>&gt; expected (0x303/0x22c67f), got (0x303/0x22c682)<BR>&gt; nfs_refresh_inode: inode number mismatch<BR>&gt; expected (0x303/0x22c680), got (0x303/0x22c683)<BR>&gt; depmod: *** Unrenfs_refresh_inode: inode number mismatch<BR>&gt; expected (0x303/0x22c681), got (0x303/0x22c684)<BR>&gt;
 nfs_refresh_inode: inode number mismatch<BR>&gt; expected (0x303/0x22c682), got (0x303/0x22c685)<BR>&gt; solved symbols infs_refresh_inode: inode number mismatch<BR>&gt; expected (0x303/0x22c683), got (0x303/0x22c67e)<BR>&gt; n /lib/modules/2.4.18_mvl30-walnut/kernel/fs/ext3/ext3.o<BR>&gt; depmod: *** Unresolved symbols in <BR>&gt; /lib/modules/2.4.18_mvl30-walnut/kernel/fs/jbd/jbd.o<BR>&gt; depmod: *** Unresolved symbols in <BR>&gt; /lib/modules/2.4.18_mvl30-walnut/kernel/fs/reiserfs/reiserfs.o<BR>&gt; done.<BR>&gt; Loading modules: <BR>&gt; mkdir: cannot create directory `/dev/pts': File exists<BR>&gt; Mounting local filesystems...<BR>&gt; nothing was mounted<BR>&gt; Cleaning: /etc/network/ifstate.<BR>&gt; Setting up IP spoofing protection: rp_filter.<BR>&gt; Disable TCP/IP Explicit Congestion Notification: done.<BR>&gt; Configuring network interfaces: done.<BR>&gt; Starting portmap daemon: portmap.<BR>&gt; Cleaning: /tmp /var/lock /var/run.<BR>&gt; nfs_refresh_inode: inode number
 mismatch<BR>&gt; expected (0x303/0x1a868a), got (0x303/0x1a8aad)<BR>&gt; INIT: Entering runlevel: 3<BR>&gt; Starting system log daemon: syslogd klogd.<BR>&gt; Starting internet superserver: inetd.<BR>&gt; nfs_refresh_inode: inode number mismatch<BR>&gt; expected (0x303/0x7456e), got (0x303/0x7456b)<BR>&gt; <BR>&gt; MontaVista Linux 3.0, Professional Edition<BR>&gt; <BR>&gt; red login: root<BR>&gt; Last login: Thu Jan&nbsp; 1 00:00:15 1970 on console<BR>&gt; Linux red 2.4.18_mvl30-walnut #40 Tue Sep 14 16:19:49 CST 2004 ppc <BR>unknown<BR>&gt; <A href="mailto:root@red">root@red</A>:~# ls<BR>&gt; chris&nbsp; hello1&nbsp; lichen&nbsp; lily<BR>&gt; <A href="mailto:root@red">root@red</A>:~# cd prog      /programs/<BR>&gt; <A href="mailto:root@red:/programs">root@red:/programs</A># ls<BR>&gt; chenny&nbsp; hello.exe&nbsp;&nbsp;&nbsp;&nbsp; hpt1.2&nbsp; ldd2-samples-1.0.1&nbsp; scsi.o<BR>&gt; demux&nbsp; hello1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpt371&nbsp;
 mmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sd_mod.o<BR>&gt; hello&nbsp; hello2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpt371.o&nbsp; pro&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v5series<BR>&gt; hello.c&nbsp; helloworld.c&nbsp; info.txt&nbsp; replex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v6series<BR>&gt; <A href="mailto:root@red:/programs">root@red:/programs</A># cd hpt1.2<BR>&gt; <A href="mailto:root@red:/programs/hpt1.2">root@red:/programs/hpt1.2</A># ls<BR>&gt; Makefile&nbsp;&nbsp; command.h&nbsp;&nbsp; glbdata.c&nbsp; hpt3xx.c&nbsp;&nbsp;&nbsp; idevice.c&nbsp;&nbsp; readme.txt<BR>&gt; atapi.h&nbsp;&nbsp;&nbsp; compiler.h&nbsp; global.h&nbsp;&nbsp; hpt3xx.h&nbsp;&nbsp;&nbsp; ihpt3xx.c&nbsp;&nbsp; stypes.h<BR>&gt; channel.c&nbsp; device.c&nbsp;&nbsp;&nbsp; hpt.c&nbsp;&nbsp; hptproc.c&nbsp;&nbsp; init.c&nbsp;&nbsp; vdevice.c<BR>&gt; channel.h&nbsp; device.h&nbsp;&nbsp;&nbsp; hpt.o&nbsp;&nbsp; hpttempl.h&nbsp; osheader.h&nbsp; vdevice.h<BR>&gt; chip.h&nbsp;&nbsp;&nbsp;
 entry.c&nbsp;&nbsp;&nbsp;&nbsp; hpt371.o&nbsp;&nbsp; ichip.c&nbsp;&nbsp;&nbsp;&nbsp; oslinux.h<BR>&gt; <A href="mailto:root@red:/programs/hpt1.2">root@red:/programs/hpt1.2</A># insmod hpt37` 1.o<BR>&gt; HPT371 UDMA/ATA133 Controller driver<BR>&gt; Version 1.1, Compiled Sep 14 2004 16:34:33<BR>&gt; Scan for chips...<BR>&gt; hpt3xx: detected 33Mhz PCI clock<BR>&gt; Scan for devices...<BR>&gt; scsi0 : hpt371<BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/0/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt;&nbsp;&nbsp; Vendor: MAXTOR 6&nbsp; Model: L040J2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rev: AR1.<BR>&gt;&nbsp;&nbsp; Type:&nbsp;&nbsp; Direct-Access&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ANSI SCSI revision: 00<BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/1/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; -----
 Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/2/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/3/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/4/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/5/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/6/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/7/0 cdb=(12000000-ff000000-13560ae8)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; Attached scsi disk sda at scsi0, channel 0, id 0, lun 0<BR>&gt;
 <BR>&gt; hpt3xx_QueueCommand() 0/0/0 cdb=(0-0-7db0)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; <BR>&gt; hpt3xx_QueueCommand() 0/0/0 cdb=(25000000-0-7db0)<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; <BR>&gt; SCSI device sda: 78177791 512-byte hdwr sectors (40027 MB)<BR>&gt; Partition check:<BR>&gt;&nbsp; sda:<BR>&gt; hpt3xx_QueueCommand() 0/0/0 cdb=(28000000-0-8007db0)<BR>&gt; <BR>&gt; //============<BR>&gt; <BR>&gt; ----- Leaving hpt3xx_queueCommand() -----<BR>&gt; </DIV>
<DIV>&nbsp;By the way,<BR>&nbsp;&nbsp; Linux version is 2.4.18_mvl30-walnut on Power PC 405GP<BR>&nbsp;&nbsp; HPT371 Driver Opensouce Version is hpt371 1.1 attached in the accessory <BR>&nbsp;&nbsp; I used ppc_405-gcc and ppc_405-ld for cross-compiling .<BR>&nbsp;&nbsp; Please help me to find where is the problem in compiling embedded linux<BR>&nbsp;&nbsp; kernel or U-boot or CSB272 board or hpt371 driver .Thank you very much!<BR>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Zheng Hongchao<BR>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2004.9.16</DIV><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/10m/*http://cn.mail.yahoo.com/event/10m.html" target=blank>œ”” œ‰Ã´–°£ø—≈ª¢µÁ” ◊‘÷˙¿©»›£°</a>
--0-585884734-1095338306=:63590--
