Date: Thu, 13 Jul 2000 13:17:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <20000712133107.23409@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10007131307230.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Benjamin Herrenschmidt wrote:
> >Well, some (control/platinum/valkyrie) will keep on using OF probing since
> >they're used on PowerMac only. But their initialization routine will no
> longer
> >be called by offb.
> >
> >Prepare to see an (untested, as usual :-) patch for this RSN...
>
> BTW. I didn't look in details yet what's wrong, but I noticed that with
> the current bk 2.4test3:
>
>  - video=ofonly doesn't work. We need to find some kludge to get this one
> back, as it's useful on some setup with broken video (and can be the only
> way to get the machine up)

I don't have the bk tree here at hand. Where is the check for `video=ofonly'?
In Linus' tree it's in offb. So the kernel argument should be
`video=offb:ofonly'.

It also depends on the frame buffer device you are using. Atyfb, aty128fb and
matroxfb are initialized before offb (controlfb etc. will be soon), so ofonly
can't work for these. There's one exception: if you have any `video=offb[:*]'
before any other video options, offb will be initialized first (through
pref_init_funcs[] in fbmem.c). Thanks to the resource management system, all
cards used by offb will be marked busy and e.g. atyfb will no longer try to use
the card.

Now my question: exactly what does BootX pass to the kernel if you specify `no
video driver', and where (before or after the other kernel arguments)?

If it passes `video=offb:ofonly' (or plain `video=offb') before any other
options, it should still work fine.
If it passes `video=ofonly', you need to add a test to video_setup() in
fbmem.c to move the initfunc for offb to the top of pref_init_funcs[] if that
option is specified.

Gr{oetje,eeting}s,

						Geert

P.S. Sorry, my patch is delayed until this evening.

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
