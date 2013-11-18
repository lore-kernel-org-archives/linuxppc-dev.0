Return-Path: <scottwood@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7E182C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 06:29:39 +1100 (EST)
Message-ID: <1384802965.1403.304.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Don't use ELFv2 ABI to build the kernel
From: Scott Wood <scottwood@freescale.com>
To: Alistair Popple <alistair@popple.id.au>
Date: Mon, 18 Nov 2013 13:29:25 -0600
In-Reply-To: <1384755694-30293-1-git-send-email-alistair@popple.id.au>
References: <1384755694-30293-1-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-18 at 17:21 +1100, Alistair Popple wrote:
> The kernel doesn't build correctly using the ELFv2 ABI.  This patch
> ensures that the ELFv1 ABI is used when building a kernel with an
> ELFv2 enabled compiler.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 607acf5..8a24636 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -111,6 +111,7 @@ endif
>  endif
>  
>  CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no -mcall-aixdesc
> +CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,-mminimal-toc)
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
>  CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)

How hard would it be to get the kernel to work with the new ABI?

Do you know where I can find a document for it?

-Scott
