From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AE7D14C.23780@bjapp7>
Date: Thu, 26 Apr 2001 15:42:04 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel panic when get ip through BOOTP!
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all,
	when i down hhl 2.2.14 to ram via tftp,then run from 0x200000.when kernel try to send bootp requests to network ,it always told me time out.
my host's DHCPD service is working(i even reinstall my linux again!),but not use.Is this stituation about the ethenet driver? if it is ,then should i do?

here is my output form minicom.cap;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


pSOSystem V2.5.0
Copyright (c) 1991 - 1998, Integrated Systems, Inc.
--------------------------------------------------------------------------
START-UP MODE:
  Boot into pROBE+ and wait for host debugger via a network connection
NETWORK INTERFACE PARAMETERS:
  IP address on LAN is 192.168.6.165
  LAN interface's subnet mask is 0xffffff00
HARDWARE PARAMETERS:
  Serial channels will use a baud rate of 9600
HARDWARE PARAMETERS:
  Processor     : MPC850 (Rev E.1), Running at 48Mhz
  Board Info    : MAXRIX Board (Rev-R)
  Board memory  : FLASH : 4Mbytes, 60ns, Enabled
                  DRAMs : 8Mbytes, 70ns, Enabled, EDO
  Board's Ethernet hardware address : 08:00:3E:22:33:55
  After board is reset, start-up code will wait 10 seconds
--------------------------------------------------------------------------
To change any of this, press any key within 10 seconds

(M)odify any of this or (C)ontinue? [M]

For each of the following questions, you can press <Return> to select the
value shown in braces, or you can enter a new value.

How should the board boot?
  1. pROBE+ stand-alone mode
  2. pROBE+ waiting for host debugger via serial connection
  3. pROBE+ waiting for host debugger via a network connection
  4. Run the TFTP Bootloader

Which one do you want? [3] 4

If connect to host debuger, which connection to use ?
  1. Serial Connection
  2. Network Connection

Which one do you want? [1]

NETWORK INTERFACE PARAMETERS:
Do you want a LAN interface?  [Y]
This board's LAN IP address(0.0.0.0 = RARP)? [192.168.6.165]
Subnet mask for LAN (0 for none)? [255.255.255.0]
Should there be a default gateway for packet routing?  [N]
HARDWARE PARAMETERS:
Baud rate for serial channels [9600]

HARDWARE PARAMETERS:
Do you want to change the board's Ethernet address? [N]
TFTP BOOTLOADER PARAMETERS:
IP address of the TFTP Boot server to boot from? [192.168.6.191]
Name of the file to load and start? [boot.srec]
How long (in seconds) should CPU delay before starting up? [10]

--------------------------------------------------------------------------
START-UP MODE:
  Run the TFTP Bootloader
HOST DEBUGGER CONNECTION (if activated):
  Serial channel 0x1
NETWORK INTERFACE PARAMETERS:
  IP address on LAN is 192.168.6.165
  LAN interface's subnet mask is 0xffffff00
HARDWARE PARAMETERS:
  Serial channels will use a baud rate of 9600
HARDWARE PARAMETERS:
  Processor     : MPC850 (Rev E.1), Running at 48Mhz
  Board Info    : MAXRIX Board (Rev-R)
  Board memory  : FLASH : 4Mbytes, 60ns, Enabled
                  DRAMs : 8Mbytes, 70ns, Enabled, EDO
  Board's Ethernet hardware address : 08:00:3E:22:33:55
TFTP BOOTLOADER PARAMETERS:
  Boot via the TFTP Bootloader
  IP address of the TFTP host is 192.168.6.191
  The file to download and start is boot.srec
  After board is reset, start-up code will wait 10 seconds
--------------------------------------------------------------------------
(M)odify any of this or (C)ontinue? [M] c
Updating parameter storage. This may take a while...Done

Downloading  "boot.srec" from HOST 192.168.6.191
.................................
TFTP download completed

Transferring control to the downloaded code


Unexpected Break                                   Running:  'ROOT' -#00020000
------------------------------------------------------------------------------
CR =40000000 XER=00000000 LR =0000E918
CTR=00000000 MSR=00001002
R0 =0000E918 0005F780 0000DFF0 00000000 0018B1F8 4082005C 34091CDE 00002C7F
R8 =02806580 00200000 00000000 001801C8 00000000 0000E918 00000000 00000000
R16=00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
R24=000A0000 00000200 00200004 0005F794 00009D60 00000847 00000000 00000000
IP =0000E918-0000E918: 00000000   .word     $00000000
pROBE+> gs 200000
HardHat Linux Kernel 2.2.14
Borad level Porting by ZhouChang
loaded at:     00200000 0020B1FC
relocated to:  00180000 0018B1FC
board data at: 001801C8 001801E4
relocated to:  00200100 0020011C
zimage at:     00206000 0026A245
avail ram:     0026B000 00800000

Linux/PPC load: root=/dev/nfs rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.14 (root@achang.EMS) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #21 Wed Apr 25 16:55:44 CST 2001
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 180000000/60
Calibrating delay loop... 47.51 BogoMIPS
Memory: 7056k available (736k kernel code, 364k data, 36k init) [c0000000,c0800000]
Dentry hash table entries: 1024 (order 1, 8k)
Buffer cache hash table entries: 8192 (order 3, 32k)
Page cache hash table entries: 2048 (order 1, 8k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 8192 bhash 8192)
Initializing RT netlink socket
Starting kswapd v 1.5
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
**********enet.c stop here**************eth0: CPM ENET Version 0.2, 08:00:3e:22:33:44
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
Sending BOOTP requests............eth0: transmit timed out.
 Ring data dump: cur_tx 030028d0 (full) cur_rx 030028b8.
9c00 0196 0015fe02
9c00 0196 0015fc02
9c00 0196 0015fa02
9c00 0196 0015f602
9c00 0196 0015f802
9c00 0196 0015f402
9c00 0196 0015f202
bc00 0196 0015f002
9c00 00ee 00166000
9c00 00f7 00166800
9c00 00e2 00165000
9c00 00ee 00165800
9c00 00f7 00164000
9c00 0040 00164800
9c00 00f7 00163000
bc00 00e2 00163800
eth0: tx queue full!.
.eth0: transmit timed out.
 Ring data dump: cur_tx 030028d0 (full) cur_rx 03002890.
9c00 0196 0015fe02
9c00 0196 0015fc02
9c00 0196 0015fa02
9c00 0196 0015f602
9c00 0196 0015f802
9c00 0196 0015f402
9c00 0196 0015f202
bc00 0196 0015f002
9c00 00ee 00166000
9c00 00f7 00166800
9c00 00e2 00165000
9c00 00ee 00165800
9c00 00f7 00164000
9c00 00f7 00164800
9c00 0076 00163000
bc00 0060 00163800


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
