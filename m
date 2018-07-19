Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ua0-f195.google.com (mail-ua0-f195.google.com
 [209.85.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WQzl6qnFzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 17:45:39 +1000 (AEST)
Received: by mail-ua0-f195.google.com with SMTP id w7-v6so4579089uan.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180714164906.GQ23412@localhost.localdomain>
 <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
In-Reply-To: <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Jul 2018 09:45:24 +0200
Message-ID: <CAMuHMdX3xiRYYdhQftHRDYFqob7xMHm-xxvh3NyoC1TowH4x8g@mail.gmail.com>
Subject: Re: Improvements for the PS3
To: geoff@infradead.org, noring@nocrew.org
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geoff, Frederik,

On Thu, Jul 19, 2018 at 12:40 AM Geoff Levand <geoff@infradead.org> wrote:
> On 07/14/2018 09:49 AM, Fredrik Noring wrote:
> > so I added a sleep with
> >
> > +     msleep(10000);

I can't see where you added the sleep, but 10s seems excessive.
If the real reason is the need to wait for an interrupt for ps3fb_sync_imag=
e(),
then waiting for 40 ms should be sufficient? Or am I missing something?

> > +
> >       return 0;
> >
> > et voil=C3=A0, the screen came alive and the kernel panic was revealed!=
 It seems
> > the kernel panics so fast that the PS3 frame buffer is unprepared. This=
 is,
> > of course, very unfortunate because trying to debug the boot process wi=
thout
> > a screen or any other means of obtaining console text is quite difficul=
t.
>
> We could add a fixed delay there, but I'd like to avoid waiting that
> long on every boot.  Why don't you add a kernel module_param named
> something like ps3fb_delay that takes a value in milliseconds and a
> default of zero.  See:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/video/fbdev/ps3fb.c?h=3Dv4.17#n260
>
> > I suppose the problem is that it relies on interrupts for ps3fb_sync_im=
age
> > to regularly copy the image, hence without them the screen isn't update=
d to
> > show kernel panics, etc. Perhaps one way to fix that is to implement th=
e
> > struct fb_tile_ops API, so that the console is synchronously updated? W=
ould
> > that be acceptable?
>
> I'm not sure if that would work or not.   Maybe Geert is more familiar wi=
th it.

That sounds like a complex solution, slowing down the console a lot.

What about letting ps3fb register a panic notifier to sync the screen, like
hyperv_fb does?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
