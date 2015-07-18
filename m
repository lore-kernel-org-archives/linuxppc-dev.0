Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00F0E1A045F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 13:04:48 +1000 (AEST)
Date: Sat, 18 Jul 2015 19:45:17 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Luis Henriques <luis.henriques@canonical.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macintosh/ans-lcd: fix build failure after
 module_init/exit relocation
Message-ID: <20150718234517.GC4477@windriver.com>
References: <1437139231-11812-1-git-send-email-luis.henriques@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1437139231-11812-1-git-send-email-luis.henriques@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[[PATCH] macintosh/ans-lcd: fix build failure after module_init/exit relocation] On 17/07/2015 (Fri 14:20) Luis Henriques wrote:

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

Guess it was inevitable I miss at least one.   This old beast must not
get coverage under any of the ppc defconfigs or allmodconfig, since I
did both...  are you using a custom config for an older box?

Anyway, the thing is controlled by a tristate, so this is the right fix.

I don't have _any_ other fixes queued for that cleanup series, so I'm fine
with this going via the ppc tree, since I'm sure there will be pending
commits there.

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks,
Paul.
--

> 
> Fixes: 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> ---
>  drivers/macintosh/ans-lcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> index 1a57e88a38f7..cd35079c8c98 100644
> --- a/drivers/macintosh/ans-lcd.c
> +++ b/drivers/macintosh/ans-lcd.c
> @@ -7,7 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/miscdevice.h>
>  #include <linux/fcntl.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  
