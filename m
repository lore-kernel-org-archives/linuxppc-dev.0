Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408P9c0RXszF1w6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 04:17:54 +1100 (AEDT)
Date: Sun, 25 Mar 2018 19:17:40 +0200
Message-ID: <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Shea Levy <shea@shealevy.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, openrisc@lists.librecores.org,
 nios2-dev@lists.rocketboards.org, linux-m68k@lists.linux-m68k.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-c6x-dev@linux-c6x.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd
 unloading logic.
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180324174458.26423-2-shea@shealevy.com>
In-Reply-To: <20180324174458.26423-2-shea@shealevy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shea Levy <shea@shealevy.com> a =C3=A9crit=C2=A0:

> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  init/initramfs.c | 7 +++++++
>  usr/Kconfig      | 4 ++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 7e99a0038942..de5ce873eb5a 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
>
> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
> +void free_initrd_mem(unsigned long start, unsigned long end)
> +{
> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
> +}
> +#endif

In powerpc this was an __init function. Why not also put the generic=20=20
one=20in __init section ?

Christophe


> +
>  static void __init free_initrd(void)
>  {
>  #ifdef CONFIG_KEXEC_CORE
> diff --git a/usr/Kconfig b/usr/Kconfig
> index 43658b8a975e..fd79d4d6fa26 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>  	default ".lzma" if RD_LZMA
>  	default ".bz2"  if RD_BZIP2
>  	default ""
> +
> +# Arches can select this for a generic initrd unloading codepath
> +config INITRAMFS_GENERIC_UNLOAD
> +	bool
> --
> 2.16.2
