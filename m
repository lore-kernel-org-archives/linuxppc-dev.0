Message-ID: <38FF1565.99905655@chpc.utah.edu>
Date: Thu, 20 Apr 2000 08:34:14 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: MiniDin9 serial pin outs to talk to DB9 UPS?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello folks,

I'm trying to connect the serial communications up between my PowerMac
7500 and my new BestPower Fortress 1050 UPS to get all the fancy smart
features going but it's not working. Anybody know what I'm doing wrong
or have any ideas? I tried looking again at the macserial.c kernel code
to see if I could make anything out from that but couldn't. Perhaps
someone who know this code better could however. Here's the details...

I'm using the PowerMac 7500 MiniDin9 serial printer port and connecting
it to a DB9 serial connector on my UPS. Unfortunately the setups I've
tried so far don't work. At best, the user and system load go high when
I try and talk with the UPS using the supplied ups terminal program. At
worst, ps hangs and can't be Ctrl-Z or Ctrl-C'd and then the system
can't finish an init 6 reboot without my power-cycling the Mac.
Apparantly the program seems to cycle waiting for something to happen
which I'm guessing needs to be fixed by connecting some other pin(s).

The cable I've made basically connects as follows:

 UPS (DB9)                          PowerMac7500 (MiniDin9)
 pin 1             recieve data     pin 3             TxD-
 pin 2             transmit data    pin 5             RxD-
 pin 4             common           pin 4             Gnd/Shield

The other UPS (DB9) pin outs are:

pin 3: normally open on battery contact
pin 5: normally open low battery alarm
pin 6: plug and play sense for Windows 95
pin 7: remote shutdown
pin 8: normally closed on battery contact
pin 9: unused

The other PowerMac 7500 (MiniDin9) pin outs are (and I had a hard time
finding this info from an Apple web site):

pin 1: SCLK(out)   ---- I'm assuming this is DTR
pin 2: Sync(in)/SCLK(in) ---- I'm assuming this is CTS
pin 6: TxD+
pin 7: Wakeup/TxHS ---- I'm assuming this is DCD
pin 8: RxD+
pin 9: +5V (power to pod) ---- what's a 'pod'?

I was told that the PC serial cable connects similarly sparsely except
that pins 4 and 6 on the PC end are jumpered together. That seems to be
a short between TxD+ and DTR. I tried doing the same for the
Mac MiniDin9 by jumpering MiniDin9 pins 1 and 6 together. This didn't
work. Nor did jumpering 1 to 8 or 1 to 7.

Thanks for any help!     --Lou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
