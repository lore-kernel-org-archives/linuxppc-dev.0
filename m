Message-ID: <3BD087D8.B9672791@midrivers.com>
Date: Fri, 19 Oct 2001 14:06:48 -0600
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging ppc4xx VM, part 2
References: <20011019192616.EC18510CD6@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> In message <3BD0616A.B5FE43C0@midrivers.com> you wrote:
> >
> > however, if I step or next, gdb never comes back; if I break out
> > and 'where' it looks like I've taken a fault ...
> >
> > I think I've set everything up for mmu support in the bdi --
> > there was 1 statement in the user's manual to:
> > 'If not automatically done by the kernel, setup the page table pointers
> > for the BDI.' -- I don't know from this what to check or what to do.
>
> Well, did you (a) follow the description in the  BDI2000  manual  and
> initialize  the  page  table  pointer  manually, or (b) did you use a
> kernel which has the necessary extension to do it automagically?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> ######## This message was made from 100% recycled electrons. ########
>

yes.

it looks like I've either got a gdb/bdi problem or a kernel build
problem:

in start_kernel() I've added a call gdb_spin() which simply spins,
waiting for a var to be set != 0 by gdb -- it gives me time to start
gdb and break in.  I can step / next in this function, returning to
start_kernel().

the next call is:
printk(linux_banner);

-- if I si twice, rc becomes set w/ a pointer to the format string
which looks reasonable.

the 3'rd si is the bl      0xc0012da4 <printk>
-- when I si to enter this func, and 'where' I get:
(gdb) where
#0  printk (fmt=0x32f050 <Address 0x32f050 out of bounds>) at printk.c:255
#1  0xc0002330 in start_here ()

-- no mention of the call from start_here() to start_kernel() -- and
printk's format ptr has become unreasonable.

tools & environment:
hhl-20 gdb for ppc405, ppc compiler which I've built; the target is
a custom mercury-based controller (405+FPU) and the abatron software
has been changed to work w/ this processor, but not heavily tested.
the rev of the 405-core used in the mercury is akin to a 405GP rev. C
which has some issues of its own.

the kernel is hhl-2.0 [2.4.2] for ppc405 which I'm attempting to get
running on this target.

["other than that, Mrs. Lincoln, how did you like the play?"]

has anyone seen anything like this kind of stack foulup w/
a simple bl?

I've used this debugger quite a bit w/o trouble debugging the boot/diags
package in real mode -- mmu off, no addr translation.

Mark


has anyone seen a probl
Mark





--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037

1-406-853-0433

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
