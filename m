Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id CF6A467B6D
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 09:24:39 +1100 (EST)
Date: Sun, 3 Dec 2006 23:24:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, paulus@samba.org,
	dmalek@jlc.net
Subject: Re: [PATCH] ppc: cs4218_tdm remove extra brace
Message-ID: <20061203222441.GD3442@stusta.de>
References: <200611301348.59401.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611301348.59401.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

old-2.6-bkcvs says this trivial compile error was introduced by:

commit 196819fdfaf3b38965f9dade80a19fdc6225120a
Author: akpm <akpm>
Date:   Tue Nov 5 22:54:51 2002 +0000

    [PATCH] initialize timers under arch/
    
    This completes the kernel-wide audit.


Considering that noone seems to have tried to compile this driver during 
the last 4 years, are there any objections against removing it?

cu
Adrian


On Thu, Nov 30, 2006 at 01:48:58PM +0100, Mariusz Kozlowski wrote:
> Hello,
> 
> 	I tried to find where does this line come from. Googled a bit with
> no luck. Probably somewhere between 2.5.10 and 2.5.20 some patch generated
> this leftover.
> 
> 
> static struct timer_list beep_timer = {
>         function: cs_nosound
> };
> 
> changed to:
> 
> static struct timer_list beep_timer = TIMER_INITIALIZER(cs_nosound, 0, 0);
> };
> 
> 
> The patch below removes this extra line.
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
>  arch/ppc/8xx_io/cs4218_tdm.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-2.6.19-rc6-mm2-a/arch/ppc/8xx_io/cs4218_tdm.c	2006-11-28 12:16:29.000000000 +0100
> +++ linux-2.6.19-rc6-mm2-b/arch/ppc/8xx_io/cs4218_tdm.c	2006-11-29 16:12:22.000000000 +0100
> @@ -1379,7 +1379,6 @@ static void cs_nosound(unsigned long xx)
>  }
>  
>  static DEFINE_TIMER(beep_timer, cs_nosound, 0, 0);
> -};
>  
>  static void cs_mksound(unsigned int hz, unsigned int ticks)
>  {
> 
> 
> -- 
> Regards,
> 
> 	Mariusz Kozlowski
