From: okorpil@fh-landshut.de
Date: Wed, 31 Mar 2004 14:08:45 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial Console / Booting Linux with the PPCbug on MVME2100?
Message-ID: <Pine.LNX.4.58.0403311359540.21912@ppcproject1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm currently trying to boot Linux 2.4.25 on a Motorola VME 2100 board,
featuring a MPC8240 controller.

I want to use the PPCbug monitor to boot Linux via TFTP - the download
step completes successfully:



PPC5-Bug>nbo
Network Booting from: DEC21143, Controller 0, Device 0
Device Name: /pci@fec00000/pci1011,19@e,0:0,0
Loading: images/zImage-2.4.25.prep

Client IP Address      = 192.168.1.3
Server IP Address      = 192.168.1.1
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = images/zImage-2.4.25.prep
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&954298, Bytes Loaded =&954298
Bytes/Second   =&954298, Elapsed Time =1 Second(s)

Residual-Data Located at: $01F5511C



And then the system seems to hang - it will no longer react to the ABT
(ABORT) interrupt switch, and will only work again on a cold reset (RST).

PreP Netboot is enabled in the ENV of the PPCbug.

The kernel has the following command line args compiled in:
Initial kernel command string:
"console=ttyS0,9600 root=/dev/nfs
nfsroot=192.168.1.1:/home/korpo/praktikum/mvme2100/rootfs ip=192.168.1.3:192.168.1.1::255.255.255.0:mvme2100::off"

(without the wraparound, of course)

Serial console support is builtin, no PMC VGA controller is onboard.

Why don't I at least get a serial console output??


Thanks a lot in advance,
Oliver Korpilla
CS student at the University of Applied Sciences at Landshut, Germany

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
