Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74C861A00E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:19:26 +1000 (EST)
Message-ID: <1408486751.4058.37.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Make 256k pages depend on PPC32=n
From: Scott Wood <scottwood@freescale.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 19 Aug 2014 17:19:11 -0500
In-Reply-To: <1408484166-20711-1-git-send-email-bobby.prani@gmail.com>
References: <1408484166-20711-1-git-send-email-bobby.prani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, "open list:LINUX
 FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-19 at 17:36 -0400, Pranith Kumar wrote:
> 256k pages are not tested on PPC32. On a randconfig I got the following error:
> 
> arch/powerpc/kernel/misc_32.S:1171: Error: operand out of range (0x0000000000010000 is not between 0xffffffffffff8000 and 0x0000000000007fff)
> 
> Disable 256K pages if PPC32=y
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index da16ffe..6cc518f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -556,7 +556,7 @@ config PPC_64K_PAGES
>  
>  config PPC_256K_PAGES
>  	bool "256k page size" if 44x
> -	depends on !STDBINUTILS
> +	depends on !PPC32 && !STDBINUTILS
>  	help
>  	  Make the page size 256k.
>  

How will this ever be selected then?  44x is 32-bit only.

-Scott
