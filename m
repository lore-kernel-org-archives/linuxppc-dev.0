Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 387072C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 May 2013 02:05:28 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id g10so3441513pdj.22
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 09:05:26 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1368095819-11011-9-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
 <1368095819-11011-9-git-send-email-yefremov.denis@gmail.com>
Date: Fri, 17 May 2013 18:05:25 +0200
Message-ID: <CAMuHMdUU5+WJnYER8kO2Ne2iaBQESYp_bbBMTLDvTEJchDu15A@mail.gmail.com>
Subject: Re: [PATCH 20/21] powerpc/ps3: remove inline marking of EXPORT_SYMBOL
 functions
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Denis Efremov <yefremov.denis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geoff Levand <geoff@infradead.org>, Jiri Kosina <trivial@kernel.org>,
 ldv-project@linuxtesting.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 9, 2013 at 12:36 PM, Denis Efremov <yefremov.denis@gmail.com> wrote:
> EXPORT_SYMBOL and inline directives are contradictory to each other.
> The patch fixes this inconsistency.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/spu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> index e17fa14..a0bca05 100644
> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -143,7 +143,7 @@ static void _dump_areas(unsigned int spe_id, unsigned long priv2,
>         pr_debug("%s:%d: shadow:  %lxh\n", func, line, shadow);
>  }
>
> -inline u64 ps3_get_spe_id(void *arg)
> +u64 ps3_get_spe_id(void *arg)
>  {
>         return spu_pdata(arg)->spe_id;
>  }

FYI, this symbol is not used in mainline.

IIRC, it's used for profiling only. Any chance the profile code will
ever make it
in mainline?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
