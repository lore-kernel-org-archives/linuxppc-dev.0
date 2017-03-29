Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtgrg3YRrzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 08:29:38 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id f193so2113970oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 14:29:38 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170329133318.16189-1-msuchanek@suse.de>
References: <20170329133318.16189-1-msuchanek@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 29 Mar 2017 23:29:36 +0200
Message-ID: <CAK8P3a1qh5YA6-UZnoxVVO_HBp_sbZ_UEwzBnTVtRgYwJg09QQ@mail.gmail.com>
Subject: Re: [PATCH] macintosh: Do not arbitrarily limit architecture for
 macintosh drivers.
To: Michal Suchanek <msuchanek@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 29, 2017 at 3:33 PM, Michal Suchanek <msuchanek@suse.de> wrote:
> The mac mouse emulation is neat solution for notebooks with suboptimal
> touchpads. For historical reason this is available on x86 but not arm or
> mips so remove the limitation.
>
> The other more specific drivers depend on various platform drivers
> anyway so users will not select those by accident.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/macintosh/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> index 97a420c11eed..c23c040bc668 100644
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -1,7 +1,6 @@
>
>  menuconfig MACINTOSH_DRIVERS
>         bool "Macintosh device drivers"
> -       depends on PPC || MAC || X86
>         default y if (PPC_PMAC || MAC)
>         ---help---
>           Say Y here to get to see options for devices used with Macintosh
> --

Why not move the mac_hid module to drivers/input instead so
it no longer depends on MACINTOSH_DRIVERS?

For the other mac drivers, it may be helpful to to add '|| COMPILE_TEST'
to the dependency line here to allow building them on ARM (after
you have verified that we can in fact build them all without warnings),
but that would be unrelated.

         Arnd
