Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0E3F42C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 15:35:35 +1000 (EST)
Received: by vcqp16 with SMTP id p16so1801012vcq.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2012 22:35:32 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1346908671-7464-4-git-send-email-mikey@neuling.org>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
 <1346908671-7464-4-git-send-email-mikey@neuling.org>
Date: Thu, 6 Sep 2012 07:35:32 +0200
Message-ID: <CAMuHMdU=UjkU3BRV7Aouu-m=vKaSPWH93Rkh6L3RWev4oM5jYA@mail.gmail.com>
Subject: Re: [PATCH 4/5] powerpc: Rework set_dabr so it can take a DABRX value
 as well
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 6, 2012 at 7:17 AM, Michael Neuling <mikey@neuling.org> wrote:
> Rework set_dabr to take a DABRX value as well. We are not actually
> changing any functionality at this stage, just preparing for that.

You are changing functionality.

>  #define   DABRX_USER   (1UL << 0)
>  #define   DABRX_KERNEL (1UL << 1)
> +#define   DABRX_HYP    (1UL << 2)
> +#define   DABRX_BTI    (1UL << 3)
> +#define   DABRX_ALL     (DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DABRX_USER)

> --- a/arch/powerpc/platforms/cell/beat.c
> +++ b/arch/powerpc/platforms/cell/beat.c
> @@ -136,9 +136,9 @@ ssize_t beat_nvram_get_size(void)
>         return BEAT_NVRAM_SIZE;
>  }
>
> -int beat_set_xdabr(unsigned long dabr)
> +int beat_set_xdabr(unsigned long dabr, unsigned long dabrx)
>  {
> -       if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
> +       if (beat_set_dabr(dabr, dabrx))
>                 return -1;
>         return 0;
>  }

> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -184,11 +184,9 @@ early_param("ps3flash", early_parse_ps3flash);
>  #define prealloc_ps3flash_bounce_buffer()      do { } while (0)
>  #endif
>
> -static int ps3_set_dabr(unsigned long dabr)
> +static int ps3_set_dabr(unsigned long dabr, unsigned long dabrx)
>  {
> -       enum {DABR_USER = 1, DABR_KERNEL = 2,};
> -
> -       return lv1_set_dabr(dabr, DABR_KERNEL | DABR_USER) ? -1 : 0;
> +       return lv1_set_dabr(dabr, dabrx) ? -1 : 0;
>  }

> -               set_dabr(dabr.address | (dabr.enabled & 7));
> +               set_dabr(dabr.address | (dabr.enabled & 7), DABRX_ALL);

Before, beat_set_dabr() and lv1_set_dabr() would have been called with dabrx = 3
(DABRX_KERNEL | DABRX_USER). Now they're called with dabrx = 15
(DABRX_ALL = DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DABRX_USER).

No idea what's the impact of this...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
