Message-ID: <38FE9D08.C116BA05@pandora.be>
Date: Thu, 20 Apr 2000 02:00:41 -0400
From: Daniel Gonzalez <daniel.gonzalez@pandora.be>
MIME-Version: 1.0
To: LinuxPPC Dev List <linuxppc-dev@lists.linuxppc.org>,
        Linux usb <linux-usb@suse.com>
Subject: USB problems on Lombard Powerbook ... and more
Content-Type: multipart/mixed;
 boundary="------------B5A1977C6C12BD3C0851DFF8"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B5A1977C6C12BD3C0851DFF8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear noctambules (and others too ...)

I am struggling with my USB port (I have a 1999 Lombard PowerBook G3
(PPC 750)).
What I want to have is a connection to my cool 250 Zip USB.

I have the following problems:

1.

(kernel 2.2.15pre17 compiles fine, with usb modules. I think the kernel
I am using
has a USB backport coming from 2.3. Actually I got these sources from
linuxcare - see point 2)

When I try to mount the Zip drive, it fails:

[root]# cat /etc/fstab
/dev/hda8               /                       ext2    defaults
1 1
/dev/hda12              swap                    swap    defaults
0 0
/dev/fd0                /mnt/floppy             ext2    noauto
0 0
/dev/cdrom              /mnt/cdrom              iso9660 noauto,ro
0 0
none                    /proc                   proc    defaults
0 0
none                    /dev/pts                devpts  mode=0622
0 0
/dev/hda10  /mnt/shared  hfs defaults 0 0
/dev/sda4  /mnt/usbzip  hfs noauto,user 0 0

[root]# mount /mnt/usbzip/
mount: the kernel does not recognize /dev/sda4 as a block device
       (maybe `insmod driver'?)


The drive is powered up, connected to the USB port, with a Zip
drive in it (I am not sure if the password protection is active or
not ... If this is an issue for my current problem, I will verify it)

BTW, I use hfs as filesystem because I am in a mac environment.


Here you have some command outputs:
[root]ls -l  /proc/bus/usb
dr-xr-xr-x   2 root     root            0 Apr 20 01:06 001
dr-xr-xr-x   2 root     root            0 Apr 20 01:06 002
-r--r--r--   1 root     root            0 Apr 20 01:06 devices
-r--r--r--   1 root     root            0 Apr 20 01:06 drivers

[root@dhcp-213-224-41-154]# ls 001

(empty)

[root]# ls 002
001
[root]# cat 002/001

(empty)

[root@dhcp-213-224-41-154]# cat devices
T:  Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  0 Spd=12  MxCh= 2
D:  Ver= 0.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 0 #Cfgs=  0
P:  Vendor=0000 ProdID=0000 Rev= 0.00
T:  Lev=01 Prnt=00 Port=00 Cnt=01 Dev#= -1 Spd=12  MxCh= 0
D:  Ver=10.01 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  0
P:  Vendor=0000 ProdID=0000 Rev= 0.00

[root]# cat drivers
usb_scsi
hub

I check the scsi tree:
[root]# cat /proc/scsi/scsi
Attached devices: none
Since nothing is there, I issue the command mentioned in
"The Linux USB sub-system" document:
[root]#  echo "scsi add-single-device 1 0 0 0" > /proc/scsi/scsi
[root]# cat /proc/scsi/scsi
Attached devices: none

... So the command had no effect (sb knows why???)


More output in case it is useful:

[root]# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 29 fb
 56 adb
108 ppp
128 ptm
136 pts
180 usb

Block devices:
  1 ramdisk
  3 ide0
  7 loop
 22 ide1

[root]# cat /proc/filesystems
 ext2
nodev proc
nodev nfs
 hfs
nodev autofs
nodev devpts

[root]# lsmod
Module                  Size  Used by
usb-scsi               16068   1
usb-ohci-hcd           21916   0  (unused)
usb-ohci               27236   1
hub                     5100   0  (unused)
usbcore                31456   0  [usb-scsi usb-ohci-hcd usb-ohci hub]

I also attach the /var/log/messages output.

BTW,  I see a message in that log which says:
'Check your kern.debug logs for the bulk of it.'

Where is this kern.debug file ?



2. (For the PPC people) I have rsynced with linuxcare:
rsync -avz --delete linuxcare.com.au::linux-pmac-devel .
When I try to compile I get the attached log (compile.log)

Why is this ?

3.  The so often-mentioned usbdevfs is not available in my system.
In the The Linux USB sub-system" document they mention that
I should issue the command:

mount -t usbdevfs none /proc/bus/usb

I can not because I don't have usbdevfs (you can see that in a previous
output).
But this seems not to be an issue since my /proc/bus/usb directory looks
fine.

Here you have a list of my mounted volumes. Why is/proc/bus/usb not
mentioned?

[root]# mount
/dev/hda8 on / type ext2 (rw)
none on /proc type proc (rw)
none on /dev/pts type devpts (rw,mode=0622)
/dev/hda10 on /mnt/shared type hfs (rw)



4. Info:
I am not very happy with my decission of installing LinuxPPC in my
machine.
The installation is a nightmare (the X installer does not work, the
wrong X server
gets installed ...) Besides, I got two CDs, one with the installation
bulk and another
with the sources. Five days ago I tried to read the sources ... The
CD is completely
empty !!! So I have more or less wasted my money ... thanks to my cable
connection
I am able to easily download source code.

5. Curiosity:
Is the linux tree completely centralized? I mean, the intel, Alpha, PPC
... sources
are all kept, mantained and developed in a centralized way, or do we
have several
linuxes wandering around ?



Regards and have a nice night ...

Daniel


--------------B5A1977C6C12BD3C0851DFF8
Content-Type: text/plain; charset=us-ascii;
 name="var_log_messages"
Content-Disposition: inline;
 filename="var_log_messages"
Content-Transfer-Encoding: 7bit

Apr 20 00:33:33 dhcp-213-224-41-154 syslogd 1.3-3: restart.
Apr 20 00:33:34 dhcp-213-224-41-154 syslog: syslogd startup succeeded
Apr 20 00:33:34 dhcp-213-224-41-154 syslog: klogd startup succeeded
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: klogd 1.3-3, log source = /proc/kmsg started.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Inspecting /boot/System.map-2.2.15pre17
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Loaded 17289 symbols from /boot/System.map-2.2.15pre17.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Symbols match kernel version 2.2.15.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: No module symbols loaded.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: device tree used 39980 bytes
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Total memory = 64MB; using 256kB for hash table (at c0280000)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Linux version 2.2.15pre17 (root@dhcp-213-224-41-154.kabel.pandora.be) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #2 Thu Apr 20 00:02:22 EDT 2000
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: PCI bus 0 controlled by pci at 80000000
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Registered 1 feature controller(s)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: PMU driver initialized for 1999 PowerBook G3
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: System has 64 possible interrupts
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: via_calibrate_decr: decrementer_count = 167046 (1002277 ticks)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Console: colour dummy device 80x25
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Calibrating delay loop... 666.83 BogoMIPS
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Memory: 62140k available (1428k kernel code, 1824k data, 144k init) [c0000000,c4000000]
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Dentry hash table entries: 8192 (order 4, 64k)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Buffer cache hash table entries: 65536 (order 6, 256k)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Page cache hash table entries: 16384 (order 4, 64k)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: POSIX conformance testing by UNIFIX
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: PCI: Probing PCI hardware
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: pmac nvram is core99: 0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: nvram: OF partition at 0x140
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: nvram: XP partition at 0x11b0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: nvram: NR partition at 0x12b0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: media bay 0 contains a CD-ROM drive
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Registered 1 media-bay(s)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Linux NET4.0 for Linux 2.2
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Based upon Swansea University Computer Society NET3.039
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: TCP: Hash tables configured (ehash 65536 bhash 65536)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Starting kswapd v 1.5
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: MacOS display is /pci/ATY,LTProParent/ATY,264LTProA
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: atyfb: 3D RAGE LT PRO [0x4c49 rev 0xdc] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: 7b33a140 87010182 14651a7b e0000c01     03000300      003a060f   00d805d0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: PLL ad d5 3c 64 c8 03 00 c6 8e 9e 65 11 a6 1b 00 00
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: atyfb: monitor sense=62b, maps to mode 6
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Console: switching to colour frame buffer device 128x48
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: fb0: ATY Mach64 frame buffer device on /pci/ATY,LTProParent
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: ADB keyboard at 2, handler 1
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: ADB mouse at 3, handler set to 4 (trackpad)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: PowerMac Z8530 serial driver version 2.0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: tty00 at 0x80813020 (irq = 15) is a Z8530 ESCC (cobalt modem)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: tty01 at 0x80813000 (irq = 16) is a Z8530 ESCC (IrDA)
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: pty: 256 Unix98 ptys configured
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Macintosh ADB mouse driver installed.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Macintosh non-volatile memory driver v1.0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: RAM disk driver initialized:  16 RAM disks of 4096K size
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: loop: registered device at major 7
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: pmac_ide: enabling IDE bus ID 0
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: hda: FUJITSU MHH2048AT, ATA DISK drive
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: hdc: MATSHITA CR-175, ATAPI CDROM drive
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: ide0 at 0x82820000-0x82820007,0x82820160 on irq 13
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: ide1 at 0x82821000-0x82821007,0x82821160 on irq 14
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: hda: Enabling MultiWord DMA 2
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: hda: FUJITSU MHH2048AT, 4645MB w/512kB Cache, CHS=10068/15/63, (U)DMA
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: hdc: Enabling MultiWord DMA 2
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Uniform CDROM driver Revision: 2.56
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: scsi0 : MESH
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: scsi : 1 host.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: scsi : detected total.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: PPP generic driver version 2.4.1
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: eth0: BMAC+ at 00:50:e4:e6:57:53
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Partition check:
Apr 20 00:33:34 dhcp-213-224-41-154 kernel:  hda: hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Freeing unused kernel memory: 144k init 32k prep
Apr 20 00:33:34 dhcp-213-224-41-154 kernel: Adding Swap: 51196k swap-space (priority -1)
Apr 20 00:33:20 dhcp-213-224-41-154 date: Thu Apr 20 00:33:20 EDT 2000
Apr 20 00:33:20 dhcp-213-224-41-154 rc.sysinit: Setting clock : Thu Apr 20 00:33:20 EDT 2000 succeeded
Apr 20 00:33:20 dhcp-213-224-41-154 rc.sysinit: Enabling swap space succeeded
Apr 20 00:33:20 dhcp-213-224-41-154 init: Entering runlevel: 5
Apr 20 00:33:21 dhcp-213-224-41-154 network: Bringing up interface lo succeeded
Apr 20 00:33:22 dhcp-213-224-41-154 ifup: Determining IP information for eth0...
Apr 20 00:33:22 dhcp-213-224-41-154 pumpd[173]: starting at Thu Apr 20 00:33:22 2000
Apr 20 00:33:31 dhcp-213-224-41-154 ifup:  done.
Apr 20 00:33:32 dhcp-213-224-41-154 ifup: search pandora.be
Apr 20 00:33:32 dhcp-213-224-41-154 network: Bringing up interface eth0 succeeded
Apr 20 00:33:33 dhcp-213-224-41-154 portmap: portmap startup succeeded
Apr 20 00:33:33 dhcp-213-224-41-154 netfs: Mounting other filesystems succeeded
Apr 20 00:33:33 dhcp-213-224-41-154 random: Initializing random number generator succeeded
Apr 20 00:33:35 dhcp-213-224-41-154 atd: atd startup succeeded
Apr 20 00:33:36 dhcp-213-224-41-154 crond: crond startup succeeded
Apr 20 00:33:36 dhcp-213-224-41-154 rc: Starting pcmcia succeeded
Apr 20 00:33:36 dhcp-213-224-41-154 inet: inetd startup succeeded
Apr 20 00:33:37 dhcp-213-224-41-154 lpd: lpd startup succeeded
Apr 20 00:33:37 dhcp-213-224-41-154 nfs: Starting NFS services:  succeeded
Apr 20 00:33:38 dhcp-213-224-41-154 nfs: rpc.statd startup succeeded
Apr 20 00:33:38 dhcp-213-224-41-154 nfs: rpc.rquotad startup succeeded
Apr 20 00:33:39 dhcp-213-224-41-154 nfs: rpc.mountd startup succeeded
Apr 20 00:33:39 dhcp-213-224-41-154 nfs: rpc.nfsd startup succeeded
Apr 20 00:33:39 dhcp-213-224-41-154 keytable: Loading keymap:
Apr 20 00:33:40 dhcp-213-224-41-154 keytable: /etc/rc.d/rc5.d/S75keytable: /etc/sysconfig/keyboard: line 2: unexpected EOF while looking for matching `"'
Apr 20 00:33:40 dhcp-213-224-41-154 keytable: /etc/rc.d/rc5.d/S75keytable: /etc/sysconfig/keyboard: line 3: syntax error: unexpected end of file
Apr 20 00:33:40 dhcp-213-224-41-154 keytable: Loading system font:
Apr 20 00:33:40 dhcp-213-224-41-154 rc: Starting keytable succeeded
Apr 20 00:33:41 dhcp-213-224-41-154 sendmail: sendmail startup succeeded
Apr 20 00:33:41 dhcp-213-224-41-154 gpm: gpm startup succeeded
Apr 20 00:33:42 dhcp-213-224-41-154 PAM_pwdb[430]: (su) session opened for user xfs by (uid=0)
Apr 20 00:33:43 dhcp-213-224-41-154 PAM_pwdb[430]: (su) session closed for user xfs
Apr 20 00:33:43 dhcp-213-224-41-154 xfs: xfs startup succeeded
Apr 20 00:33:43 dhcp-213-224-41-154 rc: Starting local succeeded
Apr 20 00:33:56 dhcp-213-224-41-154 PAM_pwdb[460]: (gdm) session opened for user gonvaled by (uid=0)
Apr 20 00:34:05 dhcp-213-224-41-154 gnome-name-server[523]: starting
Apr 20 00:34:05 dhcp-213-224-41-154 gnome-name-server[523]: name server starting
Apr 20 00:34:05 dhcp-213-224-41-154 gnome-name-server[529]: starting
Apr 20 00:34:05 dhcp-213-224-41-154 gnome-name-server[529]: name server was running on display, exiting
Apr 20 00:34:28 dhcp-213-224-41-154 PAM_pwdb[551]: (su) session opened for user root by gonvaled(uid=500)
Apr 20 00:36:44 dhcp-213-224-41-154 modprobe: can't locate module block-major-8
Apr 20 00:42:05 dhcp-213-224-41-154 PAM_pwdb[551]: (su) session closed for user root
Apr 20 00:43:40 dhcp-213-224-41-154 PAM_pwdb[662]: (su) session opened for user root by gonvaled(uid=500)
Apr 20 00:45:17 dhcp-213-224-41-154 PAM_pwdb[700]: (su) session opened for user root by gonvaled(uid=500)
Apr 20 00:45:38 dhcp-213-224-41-154 kernel: usbcore: Registered new driver hub
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: OHCI USB Driver loading
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: usb-ohci: Warning! Gobs of debugging output has been enabled.
Apr 20 00:45:52 dhcp-213-224-41-154 kernel:           Check your kern.debug logs for the bulk of it.
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: New USB bus registered, assigned bus number 1
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: usb-ohci: host controller operational
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: USB new device connect, assigned device number 1
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: Manufacturer:
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: Product:
Apr 20 00:45:52 dhcp-213-224-41-154 kernel: SerialNumber:
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC found  ohci: irq= 28 membase= 80882000
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC reset_hc: b8 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: New USB bus registered, assigned bus number 2
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC fminterval: 27782edf
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC periodicstart: 2a2f
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC lsthresh: 628
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC control: bf
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstata: a000202
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstatb: 0
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstatu: 0
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB new device connect, assigned device number 1
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  0 cmd(8):  80 06 00 01 00 00 08 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  0 cmd(8):  00 05 01 00 00 00 00 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  80 06 00 01 00 00 12 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  80 06 00 02 00 00 08 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  80 06 00 02 00 00 19 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  00 09 01 00 00 00 00 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB hub found
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  a0 06 00 29 00 00 04 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  a0 06 00 29 00 00 09 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: 2 ports detected
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: ganged power switching
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: standalone hub
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: global over-current protection
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: power on to power good time: 20ms
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: hub controller current requirement: 0mA
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub:  port 1 is removable
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub:  port 2 is removable
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  a0 00 00 00 00 00 04 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: local power source is good
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: no over-current condition exists
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: enabling power on all ports
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  23 03 08 00 01 00 00 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  23 03 08 00 02 00 00 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 30101
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC-RH IRQ>>>: RH every 255 ms
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: usbcore: USB disconnect on device 1
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  a3 00 00 00 01 00 04 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 100103
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: hub: port 1 reset change
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  23 01 14 00 01 00 00 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 103
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB root hub: adr:  1 cmd(8):  a3 00 00 00 02 00 04 00 ;
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat1: 103
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB HC roothubstat2: 100
Apr 20 00:46:00 dhcp-213-224-41-154 kernel: USB new device connect, assigned device number 1
Apr 20 00:46:01 dhcp-213-224-41-154 kernel: ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8
Apr 20 00:46:05 dhcp-213-224-41-154 last message repeated 4 times
Apr 20 00:46:05 dhcp-213-224-41-154 kernel: usbcore: USB device not responding, giving up (error=-101)
Apr 20 00:46:05 dhcp-213-224-41-154 kernel: usbcore: Registered new driver usb_scsi
Apr 20 00:46:05 dhcp-213-224-41-154 kernel: USB SCSI support registered.
Apr 20 00:47:16 dhcp-213-224-41-154 modprobe: can't locate module block-major-8

--------------B5A1977C6C12BD3C0851DFF8
Content-Type: text/plain; charset=us-ascii;
 name="compile.log"
Content-Disposition: inline;
 filename="compile.log"
Content-Transfer-Encoding: 7bit

[root linux]# make zImage
make[1]: Entering directory `/usr/src/linux-2.3.99-pre6/arch/ppc/kernel'
gcc -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__KERNEL__ -fno-builtin -o checks checks.c
checks.c: In function `main':
checks.c:39: warning: implicit declaration of function `printf'
./checks
Task size        : 960 bytes
Tss size         : 288 bytes
pt_regs size     : 176 bytes
Kernel stack size: 7232 bytes
make[1]: Leaving directory `/usr/src/linux-2.3.99-pre6/arch/ppc/kernel'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float
 -ffixed-r2 -Wno-uninitialized -mmultiple -mstring  -c -o init/main.o init

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -f
rame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float
 -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DUTS_MACHINE='"ppc"' -
nit/version.o init/version.c
make -C  kernel
make[1]: Entering directory `/usr/src/linux-2.3.99-pre6/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.3.99-pre6/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -f
rame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float
 -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DEXPORT_SYMTAB -c si
signal.c: In function `do_sigaction':
signal.c:914: fixed or forbidden register 68 (0) was spilled for class CR0
This may be due to a compiler bug or to impossible asm
statements or clauses.
cpp: output pipe has been closed
make[2]: *** [signal.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.3.99-pre6/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.3.99-pre6/kernel'
make: *** [_dir_kernel] Error 2


--------------B5A1977C6C12BD3C0851DFF8--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
