Date: Wed, 15 Mar 2000 10:57:15 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Michel Lanners <mlan@cpu.lu>, mj@ucw.cz, bh40@calva.net,
        linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
In-Reply-To: <Pine.GSO.4.10.10003150959000.20855-100000@dandelion.sonytel.be>
Message-ID: <Pine.HPX.4.10.10003151038290.3396-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 15 Mar 2000, Geert Uytterhoeven wrote:

>
> On Tue, 14 Mar 2000, Michel Lanners wrote:
> > Flames, comments, cookies, ideas? Beer?
>
> #define _IO_BASE       0
>
> breaks CHRP and PReP boxes that use plain ISA drivers (inb() and friends).

Indeed, but that's unavoidable. Except that the breakage has to wait for
2.5 to be acceptable. Given the choice I prefer to break this and properly
use resources even for drivers which believe that they have to use fixed
addresses assigned by God, or rather the devil given the mess that the PC
`architecture' is.

Then all ISA drivers would have to ask with some function (a substitute
for request_region) for a resource and take te I/O address from the
resource.start field. This avoids useless code bloat in so many other
drivers which right now add 3 elements for most I/O accesses: _IO_BASE,
their own port base address, and a register offset.

out[wl] instructions are defined as inline assembly modifying volatile
memory and the compiler has to assume that this could modify any variable,
among them _IO_BASE, which means that it is reloaded between two succesive
outs for example and the address for the next out[wl] is recomputed from
scratch. This is one load + 2 adds at least since we force the address to
be in a register for st[hw]brx instructions. That's bloat and that's IMHO
the most important reason for which _IO_BASE should be killed.

This said if anybody knows a trick to avoid this kind of stupid code
generation from the compiler (I suspect a __builtin_byteswap will have to
be implemented sooner or later as well with compiler constraints to use
indexed addressing mode only which is needed anyway for Altivec).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
