Message-ID: <0D9416AE7F95D411A8710008C7332F3F054738@GUILDFORD4_NT>
From: Daniel Furse <daniel.furse@iptest.com>
To: wn.jacobs@signaal.nl, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Ethernet in PPCBOOT on STK860L does not work
Date: Tue, 6 Feb 2001 13:52:11 -0000 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We had exactly the same problem with our STK860L.

The solution was to remove the straps from connector X32. After that
the ethernet worked fine.

Dan

-----Original Message-----
From: WN.Jacobs [mailto:WN.Jacobs@net.HCC.nl]
Sent: 06 February 2001 13:22
To: linuxppc-embedded@lists.linuxppc.org
Cc: wn.jacobs@signaal.nl
Subject: Ethernet in PPCBOOT on STK860L does not work



We bought recently several TQC STK860L starter kits.
The STK860L is equipped with a 80 MHz MPC860T.

To build PPCBOOT for this board I have made a few changes in
include/config_TQM860L.h:
#define	TQM8xxL_80MHz			# was #undef
#define CONFIG_BAUDRATE	9600		# was 115200
#define	CFG_MONITOR_LEN (256 << 10)	# was (128 << 10)

and then
gmake TQM860L_config
gmake

With a Lauterbach BDM debugger I have loaded ppcboot in flash.

Ppcboot starts correctly:

ppcboot 0.8.1 (Feb  5 2001 - 16:14:04)

Initializing...
  CPU:   XPC860xxZPnnD3 at 80 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
  Board: ### No HW ID - assuming TQM8xxL
  DRAM:  16 MB
  FLASH:  8 MB
  In:    serial
  Out:   serial
  Err:   serial
Hit any key to stop autoboot:  0

In ppcboot I added manually:

setenv ethaddr 0:40:2f:0:4c:08
setenv serverip 192.7.1.206
setenv ipaddr 192.7.1.61
saveenv

=> bdinfo
  memstart    = 0x00000000
  memsize     = 0x01000000
  flashstart  = 0x40000000
  flashsize   = 0x00800000
  flashoffset = 0x00040000
  sramstart   = 0x00000000
  sramsize    = 0x00000000
  immr_base   = 0xfff00000
  bootflags   = 0x00000001
  intfreq     =     80 MHz
  busfreq     =     40 MHz
  ethaddr     = 00:40:2F:00:4C:08
  IP addr     = 192.7.1.61
  baudrate    =   9600 bps
  getc        = 0x00fd5f74
  tstc        = 0x00fd5fac
  putc        = 0x00fd5ee4
  puts        = 0x00fd5fcc
  printf      = 0x00fd2388
  install_hdlr= 0x00fd68d4
  free_hdlr   = 0x00fd695c
  malloc      = 0x00fc2694
  free        = 0x00fc2b98

=> tftp
ARP broadcast 1
TX timeout
ARP broadcast 2
TX not ready
TX timeout
ARP broadcast 4
TX not ready
etc.

I see the ethernet link comes up (yellow LED in RJ45 connector) when
ppcboot starts.

With the tftp command I see that ethernet frames are received (green LED
in RJ45 connector) - at least by the LXT905 chip, probably not by the
MPC860 - when I do a ping to the board, but I do not see any ethernet
frames send by ppcboot. The straps on the STK8xxL for ethernet (X12 -
14) are the default for SCC 1.

Any idea what is going wrong?

Regards,
---
willy
mailto:wn.jacobs@signaal.nl

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
