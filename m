Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C71067B44
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 20:45:39 +1000 (EST)
In-Reply-To: <20060613034502.GA15130@kvasir.watson.ibm.com>
References: <20060613034502.GA15130@kvasir.watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <112BBF31-FF58-4435-8767-B398C285B9CD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix builtin command line interaction with firmware
Date: Tue, 13 Jun 2006 12:45:24 +0200
To: Amos Waterland <apw@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It seems that prom_init's early_cmdline_parse is broken on at least
> Apple 970 xserves and IBM JS20 blades with SLOF.  The firmware of  
> these
> machines returns -1 and 1 respectively when getprop is called for the
> bootargs property of /chosen, causing Linux to ignore its builtin
> command line in favor of a null string.  This patch makes Linux use  
> its
> builtin command line if getprop returns an error or a null string.

If the user gave no boot arguments on the boot command, -1 and 1
are the only two valid return values even, and -1 is only valid
if no "boot" or "load" command was used to load the kernel.
Makes me wonder what those XServe's do ;-)

(0 isn't valid as the property is encoded with encode-string, which
puts a trailing 0 byte on the empty string.  Doesn't hurt to check
for it anyway of course ;-) ).

> Signed-off-by: Amos Waterland <apw@us.ibm.com>

Looks good, thanks!

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


>
> ---
>
>  arch/powerpc/kernel/prom_init.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> 0f0caf0342f39b4437dcb3e9f2f1d62bfb4e3e7d
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/ 
> prom_init.c
> index f70bd09..2e63a90 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -574,7 +574,7 @@ static void __init early_cmdline_parse(v
>  	if ((long)_prom->chosen > 0)
>  		l = prom_getprop(_prom->chosen, "bootargs", p,  
> COMMAND_LINE_SIZE-1);
>  #ifdef CONFIG_CMDLINE
> -	if (l == 0) /* dbl check */
> +	if (l <= 0 || p[0] == '\0') /* dbl check */
>  		strlcpy(RELOC(prom_cmd_line),
>  			RELOC(CONFIG_CMDLINE), sizeof(prom_cmd_line));
>  #endif /* CONFIG_CMDLINE */
> -- 
> 1.0.4
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
