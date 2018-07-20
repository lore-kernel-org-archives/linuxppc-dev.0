Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41X2lT4V3KzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 17:37:08 +1000 (AEST)
Received: by mail-ua0-f194.google.com with SMTP id x24-v6so6895030ual.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 00:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180714164906.GQ23412@localhost.localdomain>
 <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
 <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
 <20180719201415.GE8962@localhost.localdomain>
In-Reply-To: <20180719201415.GE8962@localhost.localdomain>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Jul 2018 09:36:53 +0200
Message-ID: <CAMuHMdXcbzDi07_AXUzwnzw39DYeoHpORk2aSn9W+jmBKeShOg@mail.gmail.com>
Subject: Re: Improvements for the PS3
To: noring@nocrew.org
Cc: Geoff Levand <geoff@infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fredrik,

On Thu, Jul 19, 2018 at 10:14 PM Fredrik Noring <noring@nocrew.org> wrote:
> > > > so I added a sleep with
> > > >
> > > > +     msleep(10000);
> >
> > I can't see where you added the sleep, but 10s seems excessive.
> > If the real reason is the need to wait for an interrupt for ps3fb_sync_image(),
> > then waiting for 40 ms should be sufficient? Or am I missing something?
>
> It's at the end of ps3fb_probe, as shown in the original post:
>
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/175771.html

Thanks, I had found that one in the mean time...

> I thought 100 ms or so would work, but evidently it didn't. In fact, 1 s
> for even 5 s didn't seem to work either. In any case, I would like to
> develop a solution that does not need to sleep at all, so that will be my
> first approach for a proper implementation.

Hmm...

> > > I suppose the problem is that it relies on interrupts for ps3fb_sync_image
> > > > to regularly copy the image, hence without them the screen isn't updated to
> > > > show kernel panics, etc. Perhaps one way to fix that is to implement the
> > > > struct fb_tile_ops API, so that the console is synchronously updated? Would
> > > > that be acceptable?
> > >
> > > I'm not sure if that would work or not.   Maybe Geert is more familiar with it.
> >
> > That sounds like a complex solution, slowing down the console a lot.
>
> Why would that be slow? I have implemented a similar technique for the
> PlayStation 2 frame buffer, and (without any measurements at hand now) it
> appears to be about as fast as is possible, and reasonably easy too. :)

[...]

OK, I retract my statement ;-)

> > What about letting ps3fb register a panic notifier to sync the screen, like
> > hyperv_fb does?
>
> That would not work with kernel freezes unfortunately. Debugging those with
> nondeterministicly invisible kernel prints would be painful, I believe.

Unfortunately AFAIK the PS3 doesn't have any other "synchronous" output we
can use for debugging (like flashing the power LED).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
