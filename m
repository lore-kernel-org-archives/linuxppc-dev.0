Date: Sat, 9 Mar 2002 10:43:28 +0100
From: Harald Welte <laforge@gnumonks.org>
To: <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.18-ben0 on G4 SMP: do_IRQ waiting for irq lock
Message-ID: <20020309104328.F6936@sunbeam.de.gnumonks.org>
References: <20020308090750.W6936@sunbeam.de.gnumonks.org> <20020308183409.25542@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020308183409.25542@mailhost.mipsys.com>; from benh@kernel.crashing.org on Fri, Mar 08, 2002 at 07:34:09PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 08, 2002 at 07:34:09PM +0100, benh@kernel.crashing.org wrote:
> Could be a driver bug showing up, difficult to say. The problem definitely
> doesn't happen here (dual G4 450Mhz, 2x7400 CPU with highmem). The fact that
> the IRQ lock can be held by the other CPU is normal though, both CPUs don't
> take external IRQs but decrementer ones for example happen on both.
>
> That said, I don't know what is causing your problem.

I've now managed to get the kernel running - so far without any crashes for
one day.

The problem seemed connected with the cups daemon.  If I don't start (or use)
any part of the cups (common unix printing system), it runs fine.

I don't know what cups is trying to do, since there are no local printers
configured.  Everything it is supposed to do is to submit remote printjobs
to my printer server.

As of drivers, the only hardware driver (apart from standard pmu, aty128fb,
sungem) I'm using is tulip for a 21x4x network board.

But the problems are not related with this network interface, since I'm
heavily using it for NFS, etc.  I've also tried to pingflood the machine
on both network interfaces - no problem.

> Ben.

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
