Date: Fri, 8 Mar 2002 09:07:50 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.18-ben0 on G4 SMP: do_IRQ waiting for irq lock
Message-ID: <20020308090750.W6936@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I've tried to run 2.4.18-ben0 on my G4 SMP (dual 450 MHz) box.

I've tried both, a kernel with all IRQ's routed to CPU0 - and a kernel
where both CPU's can handle IRQ's.

Unfortunately in both kernel images, I don't even get past all init scripts,
at some (random) point during bootup:

do_IRQ waiting for irq lock (holder=1)

occurs.

Any idea what's causing the problem?  I've already tried to boot in
single user mode - and it's working fine.  Then I've started every single
init script in /etc/rc2.d (it's debian) by hand - and the problem didn't
occur.

Am I right assuming that there is a deadlock where one CPU is holding
the IRQ lock while the other wants to grab it?

And how could this happen on a kernel where all IRQ's are routed to one
CPU ??

Thanks.

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
