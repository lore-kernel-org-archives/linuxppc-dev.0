Mime-Version: 1.0
Message-Id: <p04330104b67ba37f7ad9@[206.6.156.5]>
Date: Fri, 5 Jan 2001 12:19:26 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: back to whack (2.2.18 and interrupts)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My previous "whacked 2.2.18" series of posts to the dev list, which
transformed to several different subject headers involving IRQs, has
returned.

The original problem was that in my 6-card PowerTowerPro
(9500-clone), which specifically includes a 2940UW card, was
panicking on boot. This began somewhere during the linux-pmac-stable
2.2.18pre series of kernels, and nothing I did fixed it. But it was
clear from a large number of experiments that the panic was due to a
failed __ioremap call from the aic7xxx driver. 2.2.17
linux-pmac-stable and 2.2.17 kernel.org did not show this behavior.

I had to wait for the kernel.org 2.2.18 final before I could build a
kernel that didn't display this problem. When it came I graduated to
the followup issues w.r.t. the 2940 and my Orangelink USB card
sharing an interrupt but doing so improperly, which allowed me to use
the mouse only during disk access. [BTW, I did finally find an order
for the 6 cards that allowed me to have separate interrupts on the
2940 and the USB card, and still have functionality on the Mac side].

-Somewhere- in there, the linuxppc_2_2 bk kernel began to work (did
not show the kernel panic). I've stuck with this bk kernel because of
recent changes Tom Rini made in configuring the kernel build for ADB
machines using the input layer.

Which brings me to last night, when for the first time I added
DEC_ELCP support for a particular ethernet card I'm using in the box.
Boom, the kernel panic has suddenly returned. I checked, and the
kernel.org 2.2.18 does not panic with DEC_ELCP support, other things
equal, whereas the linuxppc_2_2 bk kernel does panic, again other
things equal.

So I'm almost back to square one again on this particular PowerTower.
The panic is apparently "caused" by the presence of the 2940 card,
but I suspect the larger problem is the whole "interrupt situation"
on these 6-slot machines. I'm going to try compiling the tulip
support as a module to work around it, but I don't know yet whether
that will work.

I'm curious about the recent thread on the Umax S900 PCI bridge
thread. I am wondering if the patch given in

<http://lists.linuxppc.org/listarcs/linuxppc-dev/200101/msg00035.html>

could in any way be relevant to me, and whether the patch is intended
as a full working patch or just part of a larger one.


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
