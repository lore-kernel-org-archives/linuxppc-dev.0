Message-Id: <200112072352.AAA00762@piglet.grunz.lu>
Date: Sat, 8 Dec 2001 00:52:52 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: HIGHMEM + serial console + SMP + 2GB freeze on pmac
To: hozer@drgw.net
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011206182524.B23942@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   6 Dec, this message from Troy Benjegerdes echoed through cyberspace:
>
>> I'm going to try several other combinations of things, including taking
>> one memory stick out since this could actually be that the hardware
>> doesn't like that much memory.
>
> There is at least one problem with serial console on pmac.. I removed the
> memory (except for 1 512mb dimm)
>
>
> If I turn serial console on, I get a machine check in
> serial_console_write during the PCI probing.
>
> This only shows up if Xmon is NOT compiled in.. since xmon tries to use
> the port (and presumably dies also)

At one point there was a problem with Mac serial support doing a
kmalloc() (IIRC...), which would evidently fail at the very early
stages, such as when opening a serial console (one of the first things
done after the kernel runs) or maybe when using xmon early on, since the
VM subsystem is not yet initialized at that time.

BenH allegedly found a fix and commited it; at least his 2.4.12 rsync
and 2.4.16 kernel.org do run fine wth serial console here...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
