From: "Gregory Goodwin" <greg.goodwin@sbcglobal.net>
To: "'Rune Torgersen'" <runet@innovsys.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 826x MCC
Date: Thu, 29 Jul 2004 23:55:51 -0500
Message-ID: <000001c475f1$7d8f7be0$240110ac@gregoryg>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB3B@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have created a MMC driver for Linux that you are free to use. The only
files without GPL headers are from Interphase and they are free to use but
really only good if you are using an Interphase 4538 or 5339F board.

I modeled the MMC driver to use the Generic HDLC interface.

# Frame relay (DTE SIDE)
insmod dlci
insmod syncppp
insmod hdlc
insmod mcc_hdlc
sethdlc hdlc0 t1 clock int rate 1536
#sethdlc hdlc0 e1 clock int rate 1948
sethdlc hdlc0 fr lmi ansi
sethdlc hdlc0 create 99
sethdlc hdlc0 create 91
ifconfig hdlc0 up
ifconfig pvc0 up
ifconfig pvc1 up
ifconfig pvc0 12.0.0.2 pointopoint 12.0.0.1
ifconfig pvc1 11.0.0.2 pointopoint 11.0.0.1

# Frame relay (DCE SIDE)
insmod dlci
insmod syncppp
insmod hdlc
insmod mcc_hdlc
sethdlc hdlc0 t1 clock int rate 1536
#sethdlc hdlc0 e1 clock int rate 1948
sethdlc hdlc0 fr lmi ansi dce
sethdlc hdlc0 create 99
sethdlc hdlc0 create 91
ifconfig hdlc0 up
ifconfig pvc0 up
ifconfig pvc1 up
ifconfig pvc0 12.0.0.1 pointopoint 12.0.0.2
ifconfig pvc1 11.0.0.1 pointopoint 11.0.0.2

SavvisIAD:~# ./frame_relay.sh
Using /lib/modules/2.4.20/kernel/drivers/net/wan/dlci.o
DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
Using /lib/modules/2.4.20/kernel/drivers/net/wan/syncppp.o
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
Using /lib/modules/2.4.20/kernel/drivers/net/wan/hdlc.o
HDLC support module revision 1.14
Using /lib/modules/2.4.20/kernel/drivers/misc/mcc_hdlc.o
mcc_hdlc.c: $Revision: 1.00 $ 07/19/2004 by \
 Greg Goodwin <greg.goodwin@savvis.net>
hdlc0: MCC HDLC, Interphase 4538 8260 PowerPC SBC
Bringing Frame Relay Up
hdlc0: IF_IFACE t1 : Clock Rate 1536 Slots 24
hdlc0: using 16-bit CRC-CCITT
mcc_hdlc_attach_device - encoding 0x1 parity 0x5
SavvisIAD:~# hdlc0: Link reliable
hdlc0: DLCI 91 [pvc1] new inactive
hdlc0: DLCI 99 [pvc0] new inactive
hdlc0: DLCI 91 [pvc1] active
hdlc0: DLCI 99 [pvc0] active

Encapsulated Ethernet with Frame Relay also works fine.

sethdlc hdlc0 create ether 99 <= will create ethpvc<x> device entries and
works with BRCTL "bridging" just fine!

I have just finished the driver so no real docs yet.

I bundle all the channels required using SIRAM. Since the QFALC uses the 1st
channel I mark the 1st channel as idle. Still I get near T1/E1 rates from
the driver.

SavvisIAD:~# ttcp -ts -fm 12.0.0.2

ttcp-t: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp  -> 12.0.0.2

ttcp-t: socket

ttcp-t: connect

ttcp-t: 16777216 bytes in 91.32 real seconds = 1.40 Mbit/sec +++

ttcp-t: 2048 I/O calls, msec/call = 45.66, calls/sec = 22.43

ttcp-t: 0.0user 0.3sys 1:31real 0% 0i+0d 0maxrss 0+2pf 0+0csw

The "sethdlc" utility is used to setup the card as needed. I use the clock
rate to set the maximum number of channels to bind.

sethdlc hdlc0 t1 clock int rate 1536 <= t1 full line rate
sethdlc hdlc0 e1 clock int rate 1948 <= e1 full line rate

I also have scripts I am using to set the throttle the rates using QOS but I
have not included those. Actually I am still testing them but they seem to
work fine.

There is some debug information available via the proc directory for how the
driver is doing.

There is also ioctl support for getting status from the driver that I use
for SNMP traps. Since I was lazy I actually created a "iad0" device so that
the calls would be compatible with my ATM driver calls as well.


SavvisIAD:~# cat /proc/driver/mcc_hdlc/stats

Clock Rate 1536 - Number of slots 24

FEC    CVC   EBC  RSIS  SIS  FRS0 FRS1 Signal
----   ----  ---- ----  ---- ---- ---- ------
0000   0000  0200   02    58   02   40    Yes

Global Events
QOV0 0 - RINT0 152 - TQOV 0 - TINT 127 - GUN 0 GOV 0

mcc_hdlc driver up for 00:00:39:49


The mmc_hdlc driver currently only supports one phy but for our use that is
all we need. The driver does include some of the frame-work to do multiple
channels if desired. Right now all the channels are bundled and I set the
logical channel to 1.

You may also run sethdlc to change from t1 to e1 on the fly. Setting
loop-back mode is also supported.

I am using 2.4.20 kernel with the Interphase 4538 and 5339F boards.

The tar balls for the kernel patches for the Interphase BSP I created as
well as the mcc_hdlc driver are located in the MISC folder in the link
below.

http://f1.pg.briefcase.yahoo.com/greg.goodwin@sbcglobal.net


Enjoy....

Gregory Goodwin
Email: greg.goodwin@sbcglobal.net


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Rune
Torgersen
Sent: Thursday, July 29, 2004 3:55 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: 826x MCC


Hi


Have anybody ever made a MCC driver for linux?
Trying to get something working that  will read HDLC (first,SS7 later)
off of a TDM.

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
