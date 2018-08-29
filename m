Return-Path: <mkubecek@suse.cz>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420j2X4tJxzF31Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 20:45:33 +1000 (AEST)
Date: Wed, 29 Aug 2018 12:45:28 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with
 KERNEL_XZ
Message-ID: <20180829104528.GA4444@unicorn.suse.cz>
References: <1535527943-32566-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535527943-32566-1-git-send-email-krzk@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2018 at 09:32:23AM +0200, Krzysztof Kozlowski wrote:
> After commit faa16bc404d7 ("lib: Use existing define with
> polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> directory thus any other user of this code should define proper include
> path.
> 
> This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
> 
>     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
>                      from ../arch/powerpc/boot/decompress.c:42:
>     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
> 
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Only compile tested.
> ---
>  arch/powerpc/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 0fb96c26136f..ba4182fb185d 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -63,7 +63,7 @@ ifeq ($(call cc-option-yn, -fstack-protector),y)
>  BOOTCFLAGS	+= -fno-stack-protector
>  endif
>  
> -BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
> +BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj) -I$(srctree)/include
>  
>  DTC_FLAGS	?= -p 1024
>  
> -- 
> 2.7.4
> 

With this patch 4.19-rc1 builds and boots on ppc64le. Thank you.

Tested-by: Michal Kubecek <mkubecek@suse.cz>
