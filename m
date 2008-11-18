Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78F7BDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 21:29:27 +1100 (EST)
Subject: Re: [PATCH] powerpc: Silence timebase sync code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
References: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 21:27:17 +1100
Message-Id: <1227004037.7178.303.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-17 at 13:58 -0800, Trent Piepho wrote:
> It's over a dozen lines of output and doesn't appear to provide any useful
> information.  Even after looking at the code, I'm in the dark about what
> "score 299, offset 250" means.

Hah ! I had almost the same patch in my pile for some time :-)

> Signed-off-by: Trent Piepho <tpiepho@freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/smp-tbsync.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp-tbsync.c b/arch/powerpc/kernel/smp-tbsync.c
> index bc892e6..b590135 100644
> --- a/arch/powerpc/kernel/smp-tbsync.c
> +++ b/arch/powerpc/kernel/smp-tbsync.c
> @@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase(void)
>  {
>  	int i, score, score2, old, min=0, max=5000, offset=1000;
>  
> -	printk("Synchronizing timebase\n");
> +	pr_info("Synchronizing timebase\n");
>  
>  	/* if this fails then this kernel won't work anyway... */
>  	tbsync = kzalloc( sizeof(*tbsync), GFP_KERNEL );
> @@ -123,14 +123,10 @@ void __devinit smp_generic_give_timebase(void)
>  	while (!tbsync->ack)
>  		barrier();
>  
> -	printk("Got ack\n");
> -
>  	/* binary search */
>  	for (old = -1; old != offset ; offset = (min+max) / 2) {
>  		score = start_contest(kSetAndTest, offset, NUM_ITER);
>  
> -		printk("score %d, offset %d\n", score, offset );
> -
>  		if( score > 0 )
>  			max = offset;
>  		else
> @@ -140,8 +136,8 @@ void __devinit smp_generic_give_timebase(void)
>  	score = start_contest(kSetAndTest, min, NUM_ITER);
>  	score2 = start_contest(kSetAndTest, max, NUM_ITER);
>  
> -	printk("Min %d (score %d), Max %d (score %d)\n",
> -	       min, score, max, score2);
> +	pr_debug("Min %d (score %d), Max %d (score %d)\n",
> +		 min, score, max, score2);
>  	score = abs(score);
>  	score2 = abs(score2);
>  	offset = (score < score2) ? min : max;
> @@ -155,7 +151,7 @@ void __devinit smp_generic_give_timebase(void)
>  		if (score2 <= score || score2 < 20)
>  			break;
>  	}
> -	printk("Final offset: %d (%d/%d)\n", offset, score2, NUM_ITER );
> +	pr_debug("Final offset: %d (%d/%d)\n", offset, score2, NUM_ITER);
>  
>  	/* exiting */
>  	tbsync->cmd = kExit;
