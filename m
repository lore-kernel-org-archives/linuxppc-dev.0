Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 465B61A0384
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 16:47:56 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F30AA1402B8
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 16:47:55 +1100 (AEDT)
Subject: Re: [PATCH 5/6] powerpc/kconfig: Move cpu options after platform
 options
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <1444338557-14988-5-git-send-email-mpe@ellerman.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56175506.1040702@redhat.com>
Date: Fri, 9 Oct 2015 07:47:50 +0200
MIME-Version: 1.0
In-Reply-To: <1444338557-14988-5-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/15 23:09, Michael Ellerman wrote:
> In general platforms are a more important configuration decision than
> cpus, so the platforms should come first.
> 
> My basis for saying that is that our cpu selection options are generally
> just about tuning for a cpu, rather than enabling/disabling support for
> a cpu. On the other hand disabling a platform means you can't boot on
> those machines, and any associated cpu options should vanish.
> 
> With this applied the start of menuconfig looks like:
> 
>      [*] 64-bit kernel
>          Endianness selection (Build little endian kernel)
>          General setup
>      [*] Enable loadable module support
>      -*- Enable the block layer
>          Platform support
>          Processor support
>          Kernel options
>          Bus options
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index ea9377259f15..0f8c51279147 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -34,8 +34,6 @@ config CPU_LITTLE_ENDIAN
>  
>  endchoice
>  
> -source "arch/powerpc/platforms/Kconfig.cputype"
> -
>  config PPC32
>  	bool
>  	default y if !PPC64
> @@ -339,6 +337,7 @@ source "init/Kconfig"
>  source "kernel/Kconfig.freezer"
>  
>  source "arch/powerpc/platforms/Kconfig"
> +source "arch/powerpc/platforms/Kconfig.cputype"
>  
>  menu "Kernel options"
>  

Reviewed-by: Thomas Huth <thuth@redhat.com>
