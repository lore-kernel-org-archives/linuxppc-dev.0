Date: Mon, 5 Nov 2001 10:27:35 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fixups for Longtrail (2.4.14-pre7)
In-Reply-To: <15333.58608.870439.900641@cargo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0111051027000.4975-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 5 Nov 2001, Paul Mackerras wrote:
> Tom Rini writes:
> > Hey all.  I pulled out my Longtrail to play again, and I found some
> > wierd problems.  If I keep the 'default' type cards in it (What I
> > _think_ are the original video & ethernet, or at least known-OF-happy
> > ones), the box actually works.  But If I throw in a PC video card
> > (Matrox Millennium 1 in this case) I get oopses all over the place.  I
> > think the problem is that the firmware doesn't go and set all of the
> > properties, so lots of strcmp's blow up.  The followig gets me both
>
> Instead of checking node->name everywhere, I would prefer that the
> prom.c code makes sure that node->name is never NULL.  That is a
> change in one place rather than N, and it will fix the places that you
> didn't find as well as the ones you did. :)
>
> The OF standard says that each node should have a name property, so I
> think it's reasonable for users of the device tree to assume that
> node->name is non-NULL.

So just make node->name point to one global "<NULL>" string.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
