Date: Tue, 17 Jul 2001 16:35:32 +0100
Subject: sleepable delays from kernel code.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010717160446.D98BDDBA19@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

It would be very useful to have a "sleepable" kernel delay function with
better resolution than 10ms for some of the sound stuff.  10 or 100 us
resolution would be helpful.

This is because power-up/down (and some register accesses) of some of the
audio devices takes quite some time.

Also, it seems, that the keywest-i2c device only works in polled mode at the
moment (?? don't know if this is a real hardware fault or just waiting for a
fix).

To my mind there are too many u/mdelay() calls in the sound code at the
moment and I would like to replace as many as possible/appropriate with
sleeps on a timer.

any ideas how best to improve the resolution?

e.g.

increase HZ (could we stand a higher rate on PPC? - IIUC Alpha uses 1024)

add a front end into arch/ppc/kernel/time.c that exports a high(er)
resolution timer callback?

any help would be appreciated.
ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
