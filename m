Date: Wed, 6 Oct 1999 00:33:58 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: update on macserial/DMA
In-Reply-To: <19990930183542.004164@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991005234830.1210A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I re-wrote the serial DMA support code today and put the patch against
samba/vger linux-2.2.12 source trees (as of tonight) at
ftp://ppc.linux.or.jp/pub/users/toe/serial/.
I think the patch includes most of macserial patches (Ben's and Lou's
are in there, for sure) that I know of.

This code is much better than the previous one in which it was fairly easy
to cause frame/overrun errors, although it was far better than the vanila
macserial (w/o DMA support).  To get a feeling of the driver's
performance, I tried the following operations while downloading 10 MB+
files at 49 kbps receiving/33.6 kbps transmitting modem<->ISP and 115 kbps
PMac<->modem (ftp on ppp link):

A: "dd if=/dev/zero of=400MB count=409600 bs=1024; cp 400MB /tmp; rm
400MB"
B: planb+xawtv in grabdisplay mode (~10 fps, 640x480x4 bytes/frame)

With vanila macserial:
"A": ~200 overrun errors; ftp transfers were all aborted.

With previous DMA code:
"A": ~20 frame errors per ~600 packets
"B": a few frame errors per ~50 packets
"A+B": ~30 frame errors and a few overrun errors per ~600 packets

With this new DMA code:
"A" or "B" or "A+B": no error has been observed after about an hour of
trials (I did see a few frame errors when pppd started up once.)

These trials are pretty subjective, but I'm at least glad that it passed
all the tests I tried.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
