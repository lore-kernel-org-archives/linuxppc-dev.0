Date: Tue, 3 Aug 1999 15:52:38 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Wulf Hofbauer <wh@echo.chem.tu-berlin.de>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        SPARClinux CVS Repository Team <sparclinux-cvs@vger.rutgers.edu>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: Patches for endianess problems in atyfb (fwd)
In-Reply-To: <E11Afp1-00032N-00@mail.zrz.tu-berlin.de>
Message-ID: <Pine.LNX.4.10.9908031549060.14901-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 31 Jul 1999, Wulf Hofbauer wrote:
> I've found a fix that cures endianness problems with the ATI264VT
> framebuffer consoles. I don't really understand why, and I'm not sure
> if it affects the X server (XF68_FBDev doesn't work correctly with or
> without the patch).
> 
> Ok, so here's what I changed:
> --- atyfb.c.orig        Wed Jul 21 00:04:40 1999
> +++ atyfb.c     Sat Jul 31 21:45:51 1999
> @@ -1740,7 +1740,7 @@
>                                         
>      } else {
>         aty_set_pll_ct(info, &par->pll.ct);
> -       i = aty_ld_le32(MEM_CNTL, info) & 0xf30fffff;
> +       i = aty_ld_le32(MEM_CNTL, info) & 0xf00fffff;
>         if (!(Gx == VT_CHIP_ID && (Rev == 0x40 || Rev == 0x48)))
>             i |= info->mem_refresh_rate << 20;
>         switch (par->crtc.bpp) {
> 
> This still seems strange to me, and I suspect there is some confusion
> concerning byte swapping. Somehow I suspect the raw FB driver enables
> byte swapping, and drivers set on top of the framebuffer do the same again -
> but that's only gut feeling.
>
> Comments?

These 2 bits specify the byte swapping mode for the upper aperture:

   00 = Little endian: (no swapping)
   01 = Big endian: 16 bpp swapping
   10 = Big endian: 32 bpp swapping
   11 = (reserved)

So to me, it does seem correct to clear them to zero, before or'ing with the
correct value later.

Does this cure the problems on other machines with a Mach64 VT? Here I mainly
mean PowerMacs and UltraSPARC boxes.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
