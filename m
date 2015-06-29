Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BB401A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 17:25:50 +1000 (AEST)
Received: by oigb199 with SMTP id b199so112095555oig.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 00:25:47 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150628014205.532621991@telegraphics.com.au>
References: <20150628014159.732792697@telegraphics.com.au>
 <20150628014205.532621991@telegraphics.com.au>
Date: Mon, 29 Jun 2015 09:25:47 +0200
Message-ID: <CAMuHMdX0c3BjhkSMv4fUe1WVWDHhqRMHz=K15750EBatwkJisQ@mail.gmail.com>
Subject: Re: [RFC v3 24/24] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

> A multi-platform kernel binary needs to decide at run-time how to dispatch
> the arch_nvram_ops calls. Add platform-independent arch_nvram_ops, for use
> when multiple platform-specific NVRAM ops implementations are needed.
>
> Enable CONFIG_HAVE_ARCH_NVRAM_OPS for Macs.

Thanks for your patch!

On Sun, Jun 28, 2015 at 3:42 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> --- linux.orig/arch/m68k/kernel/setup_mm.c      2015-06-28 11:41:27.000000000 +1000
> +++ linux/arch/m68k/kernel/setup_mm.c   2015-06-28 11:41:56.000000000 +1000

> @@ -568,3 +569,109 @@ static int __init adb_probe_sync_enable
>
>  __setup("adb_sync", adb_probe_sync_enable);
>  #endif /* CONFIG_ADB */
> +
> +#if IS_ENABLED(CONFIG_NVRAM)
> +extern unsigned char mac_pram_read_byte(int);
> +extern void mac_pram_write_byte(unsigned char, int);
> +extern ssize_t mac_pram_get_size(void);
> +
> +extern ssize_t atari_nvram_read(char *, size_t, loff_t *);
> +extern ssize_t atari_nvram_write(char *, size_t, loff_t *);
> +extern long atari_nvram_set_checksum(void);
> +extern long atari_nvram_initialize(void);
> +extern ssize_t atari_nvram_get_size(void);

Forward declarations belong in a header file, to be included by both
producers and consumers.

> --- linux.orig/arch/m68k/Kconfig        2015-06-28 11:41:39.000000000 +1000
> +++ linux/arch/m68k/Kconfig     2015-06-28 11:41:56.000000000 +1000
> @@ -72,7 +72,7 @@ config PGTABLE_LEVELS
>         default 3
>
>  config HAVE_ARCH_NVRAM_OPS
> -       def_bool ATARI
> +       def_bool ATARI || MAC

For maintainability, it's better to just have "bool" here, and let both the
ATARI and MAC config symbols select HAVE_ARCH_NVRAM_OPS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
