Date: Fri, 03 Oct 2003 15:51:00 +0200
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: Queston about Walnut
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <F886A68DA978614991E47D82EA26B542131C78@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> > I would suggest inspecting the timings for memory access.
> > If this is SDRAM, you must have had to program the UPM for
> > it, I suppose. Might be that VxWorks has it right, and you
> > have set it up differently.
> >
> > Also, writing to address 0 might be a Bad Ideam (tm), if you
> > have set this area to hold interrupt vectors.
> >
> > Did you try single write (say, "mw 100000 0") ?
>
>     Thanks for you suggestion. Not only single write, I can
> now write to anywhere except the first 1MB of SDRAM. I think
> it is occupied by u-boot?

Possibly, but you should check that for yourself. There is
documentation on what u-boot does to RAM upon power-on.

> So, I think memory is ok now.

Seems right.

>     Do you have any idea it hangs at __sti()?

As I said, I know next to nothing about the Walnut. My own
embedded uboot/Linux experience is as follows:

I had a 855T-based custom board, so I took u-boot, duplicated
the TQM855L-specific files into a custom directory *and checked
every single setting* against my own hardware. Once u-boot
started OK on my board, Linux followed almost without trouble.

Only problems were with a weird bootup IMMR address setting
(settled by modifying u-boot's startup code) and FEC MII
interrupt mishandling (settled by careful option setting in
the kernel).

You should ensure that you have access to both software (u-boot
and Linux) *and* hardware (both PPC and your board) resources.

HTH,

Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
