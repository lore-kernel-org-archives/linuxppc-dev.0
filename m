Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 961CB1A0491
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 19:06:09 +1000 (AEST)
Date: Mon, 20 Jul 2015 10:06:00 +0100
From: Luis Henriques <luis.henriques@canonical.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh/ans-lcd: fix build failure after
 module_init/exit relocation
Message-ID: <20150720090600.GA2303@ares>
References: <1437139231-11812-1-git-send-email-luis.henriques@canonical.com>
 <20150718234517.GC4477@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150718234517.GC4477@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 18, 2015 at 07:45:17PM -0400, Paul Gortmaker wrote:
> [[PATCH] macintosh/ans-lcd: fix build failure after module_init/exit relocation] On 17/07/2015 (Fri 14:20) Luis Henriques wrote:
> 
> > After commit 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
> > ans-lcd module fails to build with:
> > 
> > drivers/macintosh/ans-lcd.c:201:1: warning: data definition has no type or storage class [enabled by default]
> >  module_init(anslcd_init);
> >  ^
> > drivers/macintosh/ans-lcd.c:201:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
> > drivers/macintosh/ans-lcd.c:201:1: warning: parameter names (without types) in function declaration [enabled by default]
> > drivers/macintosh/ans-lcd.c:202:1: warning: data definition has no type or storage class [enabled by default]
> >  module_exit(anslcd_exit);
> >  ^
> > drivers/macintosh/ans-lcd.c:202:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
> > drivers/macintosh/ans-lcd.c:202:1: warning: parameter names (without types) in function declaration [enabled by default]
> > drivers/macintosh/ans-lcd.c:155:1: warning: 'anslcd_init' defined but not used [-Wunused-function]
> >  anslcd_init(void)
> >  ^
> > drivers/macintosh/ans-lcd.c:195:1: warning: 'anslcd_exit' defined but not used [-Wunused-function]
> >  anslcd_exit(void)
> >  ^
> > 
> > This commit fixes it by replacing linux/init.h by linux/module.h.
> 
> Guess it was inevitable I miss at least one.   This old beast must not
> get coverage under any of the ppc defconfigs or allmodconfig, since I
> did both...  are you using a custom config for an older box?
>

I was actually just using a Debian config, which has CONFIG_ANSLCD=m

Cheers,
--
Luís

> Anyway, the thing is controlled by a tristate, so this is the right fix.
> 
> I don't have _any_ other fixes queued for that cleanup series, so I'm fine
> with this going via the ppc tree, since I'm sure there will be pending
> commits there.
> 
> Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Thanks,
> Paul.
> --
> 
> > 
> > Fixes: 0fd972a7d91d ("module: relocate module_init from init.h to module.h")
> > Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> > ---
> >  drivers/macintosh/ans-lcd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> > index 1a57e88a38f7..cd35079c8c98 100644
> > --- a/drivers/macintosh/ans-lcd.c
> > +++ b/drivers/macintosh/ans-lcd.c
> > @@ -7,7 +7,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/miscdevice.h>
> >  #include <linux/fcntl.h>
> > -#include <linux/init.h>
> > +#include <linux/module.h>
> >  #include <linux/delay.h>
> >  #include <linux/fs.h>
> >  
