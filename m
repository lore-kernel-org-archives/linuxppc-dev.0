Date: Thu, 30 Mar 2000 11:36:22 -0500 (EST)
From: "Jo-Ellen F. Mathews" <joellen@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA Test for Wireless
Message-ID: <Pine.LNX.3.96.1000330105550.21002A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

First, I'd like to thank MontaVista, Magnus Damm and Embedded Planet for
all your wonderful help in getting modules and pcmcia card services
working on our RPX Lite 823.

We're still working on the port of our 11Mb wireless lan driver for Prism2
cards to the Power Mac and RPX platforms.  However, I've been using our
old 2Mb wireless driver to work out the module and pcmcia card services
issues I was experiencing.

Below is the beginning of the capture file (I'm using minicom) from the
RPX serial port when I ran a test.  The test results are the same
regardless of whether the wireless driver is compiled into the kernel or
loaded as a modules using pcmcia card services.

The test scenario is this:
* Station1 is a wireless station on the wireless network 192.168.151.0

* Station2 is a wired station on the wired network 192.168.100.0

* RPXLite823 is a station on both networks and routes the traffic
between the two networks.  Its root file system is mounted on wired
station 192.168.100.160.

We have a test script that repeatedly performs a 2MB ftp-get using wget.

I ran the test script simultaneously on both Station1 (ftp-get from
Station2) and Station2 (ftp-get from Station1) with RPXLite823 routing the
traffic between them.

The following partial capture shows some odd stuff I saw on the serial
port while the test was running up to the point where the ethernet
interface began failing.  Once the ethernet interface failed, the results
were the same for as long as the test ran with the occasional 'neighbour
table overflow' appearing.

The "exit" and "ping" commands appearing in the capture WERE NOT typed by
me or anyone else.  They were "automagically" pulled from the shell
history as the test was running.

Any comments on the strange serial behavior and why the ethernet interface
failed are welcome.  We're currently not too worried about all this for
this particular driver.  However, if the same behavior continues when we
complete the port of our 11Mb wireless driver to the RPX Lite 823, we'll
have a serious problem (ok, to be honest, we'll have an anxiety attack
;-).

Many thanks,
Jo-Ellen

---------------------------------------------------------
Jo-Ellen F. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: joellen@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294
---------------------------------------------------------
ttyS0: 1 input overrun(s)
exit
sh-2.03#
sh-2.03# ttyS0: 1 input overrun(s)
CPM ENET: BSY can't happen.
ttyS0: 2 input overrun(s)
ping 192.168.100.120ttyS0: 2 input overrun(s)
sh-2.03# ttyS0: 2 input overrun(s)
ttyS0: 2 input overrun(s)
ttyS0: 2 input overrun(s)
ttyS0: 2 input overrun(s)
ttyS0: 4 input overrun(s)
ping 192.168.151.90eth0: transmit timed out.
 Ring data dump: cur_tx fa2028e8 (full) cur_rx fa2028c0.
9c00 05ea 009f7812
9c00 05ea 009f7012
9c00 05ea 00a04812
9c00 05ea 009f6812
9c00 0042 0095ceb2
9c00 05ea 009f6012
9c00 05ea 00bb1012
bc00 00a6 00196da2
9c00 05ee 001db000
9c00 05ee 001db800
9c00 0046 001da000
9c00 05ee 001da800
9c00 05ee 001d9000
9c00 05ee 001d9800
9c00 05ee 001d8000
bc00 05ee 001d8800
eth0: tx queue full!.
nfs: server 192.168.100.160 not responding, still trying
eth0: transmit timed out.
 Ring data dump: cur_tx fa2028e8 (full) cur_rx fa202890.
9c00 05ea 009f7812
9c00 05ea 009f7012
9c00 05ea 00a04812
9c00 05ea 009f6812
9c00 0042 0095ceb2
9c00 05ea 009f6012
9c00 05ea 00bb1012
bc00 00a6 00196da2
9c00 05ee 001db000
9c00 05ee 001db800
9c00 0046 001da000
9c00 05ee 001da800
9c00 05ee 001d9000
9c00 05ee 001d9800
9c00 05ee 001d8000
bc00 05ee 001d8800
eth0: tx queue full!.
eth0: transmit timed out.
 Ring data dump: cur_tx fa2028e8 (full) cur_rx fa202898.
9c00 05ea 009f7812
9c00 05ea 009f7012
9c00 05ea 00a04812
9c00 05ea 009f6812
9c00 0042 0095ceb2
9c00 05ea 009f6012
9c00 05ea 00bb1012
bc00 00a6 00196da2
9c00 05ee 001db000
9c00 05ee 001db800
9c00 0046 001da000
9c00 05ee 001da800
9c00 05ee 001d9000
9c00 05ee 001d9800
9c00 05ee 001d8000
bc00 05ee 001d8800
eth0: tx queue full!.
neighbour table overflow
neighbour table overflow

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
