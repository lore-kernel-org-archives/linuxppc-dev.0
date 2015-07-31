Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AE971A17B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 14:13:32 +1000 (AEST)
In-Reply-To: <1437139231-11812-1-git-send-email-luis.henriques@canonical.com>
To: Luis Henriques <luis.henriques@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh/ans-lcd: fix build failure after module_init/exit
 relocation
Message-Id: <20150731041332.09F9014031E@ozlabs.org>
Date: Fri, 31 Jul 2015 14:13:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-17-07 at 13:20:31 UTC, Luis Henriques wrote:
> After commit 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
> ans-lcd module fails to build with:
> 
> drivers/macintosh/ans-lcd.c:201:1: warning: data definition has no type or storage class [enabled by default]
>  module_init(anslcd_init);
>  ^
> drivers/macintosh/ans-lcd.c:201:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
> drivers/macintosh/ans-lcd.c:201:1: warning: parameter names (without types) in function declaration [enabled by default]
> drivers/macintosh/ans-lcd.c:202:1: warning: data definition has no type or storage class [enabled by default]
>  module_exit(anslcd_exit);
>  ^
> drivers/macintosh/ans-lcd.c:202:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
> drivers/macintosh/ans-lcd.c:202:1: warning: parameter names (without types) in function declaration [enabled by default]
> drivers/macintosh/ans-lcd.c:155:1: warning: 'anslcd_init' defined but not used [-Wunused-function]
>  anslcd_init(void)
>  ^
> drivers/macintosh/ans-lcd.c:195:1: warning: 'anslcd_exit' defined but not used [-Wunused-function]
>  anslcd_exit(void)
>  ^
> 
> This commit fixes it by replacing linux/init.h by linux/module.h.
> 
> Fixes: 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/120d200a86273d1840d0

cheers
