From: rshaw@graftononline.net
Message-ID: <001401c01eb2$48a92330$0100a8c0@nonewr2gx24hxi>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: CLLF with Hard Hat Lunix "Sending BOOTP requests" problem
Date: Thu, 14 Sep 2000 21:14:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to get a CLLF 860T to load a kernel normally.  I'm using Embedded
PowerPC Cross Development Kit Rev. 1.0 Hard Hat Linux.

I'm very new to Linux and networking.  I'm running Red Hat Linux 6.2.  When
I installed Red Hat Linux I choose GNOME Workstation.  I found out later
that I needed to install other packages.  I installed dhcpd, inetd, tftp,
bootparamd and bind packages off the Red Hat install CDROM. I also
uninstalled pump.

I ran

chkconfig dhcpd on

so that the DHCP daemon would be loaded on every boot.

While loading the kernel via tftp I found that in order for the boot process
to work I have to use both the 10 Mbps and 100 Mbps ports.  If I do not do
this it times out at "Sending BOOTP requests". I have had to execute the
following script before loading via tftp during which time the 10 Mbps port
is being used.

#!/bin/bash
arp -s 192.168.0.3 00:10:ec:00:00:00
/etc/rc.d/init.d/dhcpd restart
/etc/rc.d/init.d/nfs start

and it responds with

Shutting down dhcpd:                                       [  OK  ]
Starting dhcpd:                                            [  OK  ]
Starting NFS services:                                     [  OK  ]
Starting NFS quotas:                                       [  OK  ]
Starting NFS mountd:                                       [  OK  ]
Starting NFS daemon:                                       [  OK  ]

then when the line "Linux/PPC load: root=/dev/nfs rw" comes up in minicom I
execute the following script so the 100 Mbps port can be utilized

#!/bin/bash
arp -s 192.168.0.3 00:10:ec:80:00:00
/etc/rc.d/init.d/dhcpd restart
/etc/rc.d/init.d/nfs start

and it responds with

Shutting down dhcpd:                                       [  OK  ]
Starting dhcpd:                                            [  OK  ]
Starting NFS services:                                     [  OK  ]
Starting NFS quotas:
Starting NFS mountd:
Starting NFS daemon: nfssvc: Address already in use
                                                           [FAILED]

The following is a screen dump of the minicom session

DRAM1:wwwwwvvvvvCCCCCVVVVV CaV NVRAM: CaV
--------------------------------------------------
RPX Utility program, Copyright (C) 1998-1999, RPCg LLC, All Rights Reserved.
  Reset(0100): ExHard ExSoft, TESR:0000 Core.Pv/Cp=0020.0050/0004
  BCSR : OK
  RTC  : OK, battery LOW or absent, tics/sec=1, time = 5 sec
  SPIp : OK, I2Cp: OK, STTM: OK, 41.5c, EEcfg: OK, 256b, cs:1D55
  ENET : [zero], 0010EC000000, INET: C0A80003
  FLASH: OK, 1*16 Mb(32x8), id=01:53, cs:F95D es:F95D OK (FFF00000:FFF46200)
  NVRAM: OK, 0 Kb, NVR battery GOOD
  DRAM : OK, 16 Mb, 10 columns
===> RPX Main
     RPX-ClassicLF AY/BW 860T 50Mhz/8Mhz Ic ~Dc RPXU v1.46
  1  test BCSR                    A  Add-on board tests
  2  test dip switches            B  rpxBug command line (ctrl-B)
  3  test LEDs                    C  Configure EEPROM
  4  test SPI I2C STTM EEPR,CFG   L  Load RAM
  5  test FLASH firmware chksum   O  On-board I/O tests
  6  test NVRAM/SRAM              P  Program FLASH
  7  test DRAM (destructive)      R  hard Reset
  8                               S  Scan FLASH for executables
  9  run all tests                T  display Time & Temperature
RPX Main menu: press 123456789 or ABCLOPRST key : <?> : L
===> RPX Load: (ESC - returns to Main menu)
  1  Copy one memory range to another range
  2  Verify one memory range against another range
  3  Fill memory range with generated data
  4
  5  load   using S-records received from serial monitor port
  6  verify using S-records received from serial monitor port
  7  load   using tftp via Ethernet interface
  8  set a start address
  9  transfer control to start address
  T  tftp & start using config info with retries
RPX Load menu: press 123456789T key : <?> : T
 target IP address : C0A80002
 target file name  : z.cllf
 address bias      : 0
Starting tftp download:
inetARP(): OK
.1.2.4.8.16.32.64.128.256.512.1024.2048.4096.8192
load_tftp(): OK
1065943 data bytes, 13494 S-records, 2082 tftp blocks, 0 repeated blocks
start address = 00200000
load_tftp_toMem(): OK
Transferring control to downloaded program
loaded at:     00200000 0020C580
relocated to:  00100000 0010C580
board data at: 001001C4 001001E0
relocated to:  00200100 0020011C
zimage at:     00207000 0026810B
avail ram:     00269000 01000000

Linux/PPC load: root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (root@BOBLINUX) (gcc version 2.95.2 19991024 (release))
#50
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.82 BogoMIPS
Memory: 15160k available (736k kernel code, 452k data, 36k init)
[c0000000,c100]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured

loadFPGA successful!

RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
eth0: FEC ENET Version 0.1, 00:10:ec:80:00:00
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
fec: Phy @ 0x17, type 0x01814401
fec: link down
fec: 100 Mbps, Half-Duplex
fec: link down, 100 Mbps, Half-Duplex
Sending BOOTP requests....fec: link up, auto complete, 10 Mbps, Half-Duplex
. OK
IP-Config: Got BOOTP answer from 192.168.0.2, my address is 192.168.0.3
Looking up port of RPC 100003/2 on 192.168.0.2
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.2
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 36k init
INIT: version 2.77 bootiÿ
INIT: cannot execute "/etc/rc.sysinit"
INIT: Entering runlevel:.
sh-2.03#

OK, This gets us to a Linux shell prompt even though I had to execute the
script files using both the 10 Mbps and 100 Mbps ports, which I shouldn't
have to do. I'm hoping someone might be able to help me with why I need to
use both ports and execute these arp commands.  Is something wrong with my
DHCP configuration?

Here are some of my configuration files.

Here is /etc/dhcpd.conf file contents

allow bootp;
subnet 192.168.0.0 netmask 255.255.0.0 {
  default-lease-time 1209600;   #two weeks
  max-lease-time 31557600;   #one year
  group {
    host CLLFBOARD {
      hardware ethernet 00:10:EC:00:00:00;
      fixed-address 192.168.0.3;
      option root-path "/opt/hardhat/devkit/ppc/8xx/target";
    }
  }
}

Here is the /etc/hosts file contents

127.0.0.1 localhost.localdomain localhost
192.168.0.1 win2000 w2k
192.168.0.2     RANDYLINUX rlx
192.168.0.3     CLLFBOARD cllf

Here is the /etc/hosts.allow file contents

portmap: 192.168.0.

The /etc/hosts.deny file is empty

Here is the /etc/inetd.conf file contents

tftp dgram udp wait root /usr/sbin/tcpd in.tftpd
/opt/hardhat/devkit/ppc/8xx/target/boot
linuxconf stream tcp wait root /bin/linuxconf linuxconf --http
#swat      stream  tcp     nowait.400      root /usr/sbin/swat swat

Here is a minicom screen dump showing the CLLF EEPROM configuration

RPX Configure menu: press 123456789 key : <?> : 7
Board          : F CCP CCE                : <F>            :
Processor      : 821 855 860              : <860>          :
Variant        : SR EN T MH DT E SE P DP . : <T>            :
Freq cpu/xtal  : 40/8 50/8 66/8           : <50/8>         :
Enable Caches  : N I                      : <I>            :
DRAM columns   : 8 9 10 11 12 13          : <10>           :
DRAM1 size(Mb) : 0 4 16 32 64 128         : <16>           :
NVRAM size(Kb) : 0 32 128 512             : <0>            :
Ethernet addr  : [format:hex]             : <0010EC000000> :
IP address     : [format:hex]             : <C0A80003>     :
Mon Baud/100   : 3 12 24 96 384 576 1152  : <96>           :
STTM bias(C*10): [format:dec]             : <131>          :
AutoBoot name  : [format:asc]             : < >            :
TFTP IP addr   : [format:hex]             : <C0A80002>     :
TFTP filename  : [format:asc]             : <z.cllf>       :
low except vec : N Y                      : <[missing]>    :
no twirl prompt: N Y                      : <[missing]>    :
inv monitor SMC: N Y                      : <[missing]>    :
Lock KAPWR regs: N Y                      : <[missing]>    :
RPX Configure menu: press 123456789 key : <?> : ESC

Thanks for any help!

Randy Shaw <rshaw@graftononline.net>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
