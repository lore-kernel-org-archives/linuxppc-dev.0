Date: Mon, 8 May 2000 16:19:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "D.J. Barrow" <barrow_dj@yahoo.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help with cross-endian bitfields?
In-Reply-To: <20000508101331.16264.qmail@web204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10005081618471.1144-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 May 2000, D.J. Barrow wrote:
> struct blah
> {
>    unsigned a : 3;
>    unsigned b : 3;
>    unsigned c : 2;
> } __attribute__(packed);
>
> I personally would be expecting to use ((*((u8
> *)&blah[0]))&0x0e0)>>5 to get the info from blah.a on
> both little & big endian machines.

Which no longer works if a is longer than 8 bits and/or spans multiple bytes.
For PCI accesses, you can work around this by using {read,write}l(), which do
byte swapping on big-endian platforms as well.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
