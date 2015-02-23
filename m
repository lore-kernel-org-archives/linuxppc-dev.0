Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 503221A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 21:28:15 +1100 (AEDT)
Received: by mail-ob0-f170.google.com with SMTP id va2so35563616obc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 02:28:12 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <5721217.aGU5oqfDWo@wuerfel>
References: <1424680402-3477-1-git-send-email-geert@linux-m68k.org>
 <5900255.NhXvduRnha@wuerfel>
 <CAMuHMdVMCvw1euM0c2AYrYibO4ObZLV6F_-CDPZZ6x44D6Hwug@mail.gmail.com>
 <5721217.aGU5oqfDWo@wuerfel>
Date: Mon, 23 Feb 2015 11:28:12 +0100
Message-ID: <CAMuHMdUTCvQw1q-dJcx9dAnFEXtfJYs+rbVS4KdZgi-3cbSC7g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.0-rc1
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Matthew Wilcox <willy@linux.intel.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 23, 2015 at 11:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 23 February 2015 10:14:55 Geert Uytterhoeven wrote:
>> On Mon, Feb 23, 2015 at 10:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> >   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2

> I checked the other architectures, and found that the same is missing on
> ARC, so we should add both:
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index ec35851e5b71..a24d496787d6 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -36,7 +36,7 @@ source "fs/nilfs2/Kconfig"
>  config FS_DAX
>         bool "Direct Access (DAX) support"
>         depends on MMU
> -       depends on !(ARM || MIPS || SPARC)
> +       depends on !(ARC || ARM || MIPS || SH || SPARC)
>         help
>           Direct Access (DAX) can be used on memory-backed block devices.
>           If the block device supports DAX and the filesystem supports DAX,
>
>
> It's also not implemented on c6x and blackfin, but both of them have
> MMU=n, so they are already excluded.

Exactly.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
