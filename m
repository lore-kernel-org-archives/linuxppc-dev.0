Mime-Version: 1.0
Message-Id: <p04330100b63b9e07574a@[192.168.0.1]>
In-Reply-To: <200011060712.IAA00775@piglet.grunz.lu>
References: <200011060712.IAA00775@piglet.grunz.lu>
Date: Fri, 17 Nov 2000 22:12:31 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: whacked out 2.2.18pre21?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Last week I called this "whacked out 2.2.18pre17?"

I'm the one with the 6 cards in the PowerTowerPro, who can compile
2.2.18preX (linux-pmac-stable from penguinppc.org or
ppc.linuxcare.com or ppc.samba.org) but not boot it without a kernel
panic. I know that some think I should remove cards, but I've been
able to narrow things down a bit, and no longer do I think I have a
BootX problem, and I'm not so sure this is a PCI issue (although
maybe still).

Upgrading to BootX 1.2.2 didn't make a difference in any boot issues.

Always compiling the kernel for both video cards (imstt and matrox)
finally allowed BootX to pay attn to its no-video checkbox. Problem
solved.

Compiling without the "early BootX text" switch (or whatever that is)
eliminated all my freezes at "booting..." Problem solved.

Next I will start removing cards :-(, but I am highly suspicious of
the code involving the 2940UW card in the box. The -only- drives I
have are 2 9G atlases connected to the 2940. All 2.2.17 kernels I've
tried work fine. OTOH, every linux-pmac-stable 2.2.18preX kernel
panics just as it is beginning to register (poll? discover?) the SCSI
devices, at the same place where 2.2.17 properly recognizes the 2
drives and the 2940.

I have the pertinent debug info (backtrace, other registers,
System.map). Can I just post them here? I've never tried analyzing
one of these things. From what little sense I can make of it, it sure
looks like the panic has something to do with the aic7xxx code, or
related code. Roughly speaking, just after the fd0 (floppy) message
appears in the boot, I get :

Machine check in kernel mode
Caused by (from srr1): Unknown values in srr1
<debug info>
[kernel panic]

I'm compiling the kernel with default settings, other than including
the matrox driver. How might I compile the kernel differently w.r.t.
aic7xxx to try to nail this one down, if at all?

Once during the 2.2.17 linux-pmac-stable series, I got exactly this
srr1 error. I waited a couple of days and rsynced again and it was
gone. I always assumed that was due to some obscure bug creeping in
and then back out again. I feel in my bones this is the same
situation. I've written to Paul a couple of times about this, but I'm
sure to be low on his radar. Meanwhile, I rsync and try again each
day, without luck. BTW, I've tried this same troublesome 2.2.18
kernel on similar PowerTowerPro that I use and it works fine. That
PTP doesn't have a 2940 card in it, but it doesn't have all the PCI
slots filled either.

Any and all ideas welcome.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
