Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1428233914-4503-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
 <1428233914-4503-9-git-send-email-Julia.Lawall@lip6.fr>
Date: Sun, 5 Apr 2015 13:52:04 +0200
Message-ID: <CAMuHMdXDsk7P1siPZ=nW4j8gO0p16aYcqj4btg_rSqavZo+3oA@mail.gmail.com>
Subject: Re: [PATCH 9/9] sound/ppc/snd_ps3.c: fix error return code
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Cc: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Geoff Levand <geoff@infradead.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 5, 2015 at 1:38 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Initialize ret before returning on failure, as done elsewhere in the
> function.

> diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
> index 1aa52ef..9b18b52 100644
> --- a/sound/ppc/snd_ps3.c
> +++ b/sound/ppc/snd_ps3.c
> @@ -1040,6 +1040,7 @@ static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
>                                    GFP_KERNEL);
>         if (!the_card.null_buffer_start_vaddr) {
>                 pr_info("%s: nullbuffer alloc failed\n", __func__);
> +               ret = -ENOMEM;
>                 goto clean_preallocate;
>         }
>         pr_debug("%s: null vaddr=%p dma=%#llx\n", __func__,

This has already been applied in 2012?

commit c86b93628e5649fd7bb0574b570a51b2b02d586c
Author:     Julia Lawall <Julia.Lawall@lip6.fr>
AuthorDate: Sun Aug 19 09:02:59 2012 +0200
Commit:     Takashi Iwai <tiwai@suse.de>
CommitDate: Mon Aug 20 11:01:14 2012 +0200

    ALSA: sound/ppc/snd_ps3.c: fix error return code

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
