Date: Sun, 4 Jun 2000 13:36:25 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: fbcon-cfb8.c
In-Reply-To: <Pine.LNX.4.05.10006041310010.514-100000@callisto.of.borg>
Message-ID: <Pine.OSF.4.02.10006041324050.7009-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 4 Jun 2000, Geert Uytterhoeven wrote:

> On Sun, 4 Jun 2000, Henning Loeser wrote:
> > trying to fix my console character displayment I wonder whether I'm
> > looking at the right place ?????
> > When in the console with 8bpp, fbcon-cfb8.c is the driver the kernel uses
> > right? Not the tdfxfb driver for the card?
>
> Tdxfb is accelerated. So unless you disable acceleration, it uses the
> operations in fbcon_banshee8 in tdxfb.c:
>
>     info->dispsw = noaccel ? fbcon_cfb8 : fbcon_banshee8
>
> Gr{oetje,eeting}s,
>
> 						Geert

Thanks, if I simply make it call fbcon-cfb8 no matter what the font
appears correctly. So I guess what I have to acctually do is to fix the
'do_putc' and 'do_putcs' functions in tdfxfb.c to diplay BIGENDIAN
characters correctly.
That's what your nibbletab_cfb8 does in fbcon-cfb8 right?

Henning
--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
