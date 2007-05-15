Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 417D9DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:09:05 +1000 (EST)
Subject: Re: [PATCH] Add -msoft-float to BOOTCFLAGS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1179190345.3420.74.camel@zod.rchland.ibm.com>
References: <1179190345.3420.74.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 15 May 2007 11:08:57 +1000
Message-Id: <1179191338.32247.142.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 19:52 -0500, Josh Boyer wrote:
> We want to avoid any float instructions that may occur in the wrapper that
> may be generated if the compiler isn't told not to.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/boot/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.orig/arch/powerpc/boot/Makefile
> +++ linux-2.6/arch/powerpc/boot/Makefile
> @@ -24,7 +24,7 @@ all: $(obj)/zImage
>  
>  HOSTCC		:= gcc
>  BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
> -		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
> +		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC -msoft-float
>  BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>  
>  ifeq ($(call cc-option-yn, -fstack-protector),y)
