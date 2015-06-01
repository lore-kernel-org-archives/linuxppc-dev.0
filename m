Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 934C91A004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 18:31:49 +1000 (AEST)
Received: by obbnx5 with SMTP id nx5so97701797obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 01:31:47 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20150531010138.309478365@telegraphics.com.au>
References: <20150531010132.289674310@telegraphics.com.au>
 <20150531010138.309478365@telegraphics.com.au>
Date: Mon, 1 Jun 2015 10:31:47 +0200
Message-ID: <CAMuHMdW3qrFqesRqR=YW8qEEbVZPtK8exG0jF+YyfVqokMiyNg@mail.gmail.com>
Subject: Re: [RFC 24/24] m68k: Dispatch nvram_ops calls to Atari or Mac
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

On Sun, May 31, 2015 at 3:01 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> A multi-platform kernel binary needs to decide at run-time how to dispatch
> the arch_nvram_ops calls. Add platform-independent arch_nvram_ops, for use
> when multiple platform-specific NVRAM ops implementations are needed.

Thanks for your series!

> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
>  arch/m68k/Kconfig                 |    2
>  arch/m68k/atari/nvram.c           |   22 +++++----
>  arch/m68k/include/asm/atarihw.h   |    6 ++
>  arch/m68k/include/asm/macintosh.h |    4 +
>  arch/m68k/kernel/setup_mm.c       |   89 ++++++++++++++++++++++++++++++++++++++
>  arch/m68k/mac/misc.c              |    8 ++-
>  6 files changed, 117 insertions(+), 14 deletions(-)
>
> Index: linux/arch/m68k/atari/nvram.c
> ===================================================================
> --- linux.orig/arch/m68k/atari/nvram.c  2015-05-31 11:01:21.000000000 +1000
> +++ linux/arch/m68k/atari/nvram.c       2015-05-31 11:01:29.000000000 +1000
> @@ -73,7 +73,7 @@ static void __nvram_set_checksum(void)

> +#ifndef CONFIG_MAC
>  const struct nvram_ops arch_nvram_ops = {
> -       .read           = nvram_read,
> -       .write          = nvram_write,
> -       .get_size       = nvram_get_size,
> -       .set_checksum   = nvram_set_checksum,
> -       .initialize     = nvram_initialize,
> +       .read           = atari_nvram_read,
> +       .write          = atari_nvram_write,
> +       .get_size       = atari_nvram_get_size,
> +       .set_checksum   = atari_nvram_set_checksum,
> +       .initialize     = atari_nvram_initialize,
>  };
>  EXPORT_SYMBOL(arch_nvram_ops);
> +#endif

IMHO, the #ifdef is ugly.

>  #ifdef CONFIG_PROC_FS
>  static struct {
> Index: linux/arch/m68k/mac/misc.c
> ===================================================================
> --- linux.orig/arch/m68k/mac/misc.c     2015-05-31 11:01:28.000000000 +1000
> +++ linux/arch/m68k/mac/misc.c  2015-05-31 11:01:29.000000000 +1000
> @@ -489,7 +489,7 @@ void pmu_shutdown(void)

> +#ifndef CONFIG_ATARI
>  const struct nvram_ops arch_nvram_ops = {
>         .read_byte      = mac_pram_read_byte,
>         .write_byte     = mac_pram_write_byte,
>         .get_size       = mac_pram_get_size,
>  };
>  EXPORT_SYMBOL(arch_nvram_ops);
> +#endif
>  #endif /* CONFIG_NVRAM */

Same here.

> Index: linux/arch/m68k/kernel/setup_mm.c
> ===================================================================
> --- linux.orig/arch/m68k/kernel/setup_mm.c      2015-05-31 11:00:59.000000000 +1000
> +++ linux/arch/m68k/kernel/setup_mm.c   2015-05-31 11:01:29.000000000 +1000

> @@ -568,3 +572,88 @@ static int __init adb_probe_sync_enable
>
>  __setup("adb_sync", adb_probe_sync_enable);
>  #endif /* CONFIG_ADB */
> +
> +#if IS_ENABLED(CONFIG_NVRAM) && defined(CONFIG_ATARI) && defined(CONFIG_MAC)

Likewise.

> +static ssize_t m68k_nvram_read(char *buf, size_t count, loff_t *ppos)
> +{
> +       if (MACH_IS_ATARI)
> +               return atari_nvram_read(buf, count, ppos);
> +       else if (MACH_IS_MAC) {
> +               ssize_t size = mac_pram_get_size();
> +               char *p = buf;
> +               loff_t i;
> +
> +               for (i = *ppos; count > 0 && i < size; --count, ++i, ++p)
> +                       *p = mac_pram_read_byte(i);
> +
> +               *ppos = i;
> +               return p - buf;
> +       }
> +       return -EINVAL;

Isn't this handled already by the nvram core, based on the available operations
in nvram_ops? Same for the other nvram abstractions in this file.

> +const struct nvram_ops arch_nvram_ops = {
> +       .read           = m68k_nvram_read,
> +       .write          = m68k_nvram_write,
> +       .read_byte      = m68k_nvram_read_byte,
> +       .write_byte     = m68k_nvram_write_byte,
> +       .get_size       = m68k_nvram_get_size,
> +       .set_checksum   = m68k_nvram_set_checksum,
> +       .initialize     = m68k_nvram_initialize,
> +};
> +EXPORT_SYMBOL(arch_nvram_ops);

Can't you just fill in the mach specific pointers in the generic structure,
and be done with it?

If you handle this right, I think you can do without the temporary "def_bool
(ATARI && !MAC) || (MAC && !ATARI)" in "[RFC 22/24] m68k/mac: Adopt nvram
module", too.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
