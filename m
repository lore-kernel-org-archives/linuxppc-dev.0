Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id C840CDDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 18:06:07 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 6 May 2008 10:06:02 +0200
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [POWERPC] rtc_cmos_setup: assign interrupts only if
	there is i8259 PIC
Message-ID: <20080506080602.GA13650@iram.es>
References: <20080505185538.GA4906@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080505185538.GA4906@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 05, 2008 at 10:55:38PM +0400, Anton Vorontsov wrote:
> Sometimes (particularly on MPC8610HPCD) we want IRQ-less CMOS RTC for
> the boards without (or disabled) i8259 PICs.
> 
> We lookup the device tree for "chrp,iic" compatible devices, and if not
> found we do not assign RTC IRQ.

I suspect this will break on machines which have an RTC and the
interrupt line is not connected. 

These are PreP machines like MVME2[467]xxx (I have a bunch of them,
stilll running 2.2 kernels but on a private network). 
Interrupt 8 is connected, but not to the RTC...

I have no problems with the patch going in for now, it will have
to be revisited whenever (if ever) support for these machines is added
to the kernel (what is really needed to support these machines is a
residual data->device tree converter).

	Gabriel



> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/sysdev/rtc_cmos_setup.c |   21 +++++++++++++++------
>  1 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/rtc_cmos_setup.c b/arch/powerpc/sysdev/rtc_cmos_setup.c
> index c09ddc0..e5d0bcb 100644
> --- a/arch/powerpc/sysdev/rtc_cmos_setup.c
> +++ b/arch/powerpc/sysdev/rtc_cmos_setup.c
> @@ -21,6 +21,7 @@ static int  __init add_rtc(void)
>  	struct device_node *np;
>  	struct platform_device *pd;
>  	struct resource res[2];
> +	unsigned int num_res = 1;
>  	int ret;
>  
>  	memset(&res, 0, sizeof(res));
> @@ -41,14 +42,22 @@ static int  __init add_rtc(void)
>  	if (res[0].start != RTC_PORT(0))
>  		return -EINVAL;
>  
> -	/* Use a fixed interrupt value of 8 since on PPC if we are using this
> -	 * its off an i8259 which we ensure has interrupt numbers 0..15. */
> -	res[1].start = 8;
> -	res[1].end = 8;
> -	res[1].flags = IORESOURCE_IRQ;
> +	np = of_find_compatible_node(NULL, NULL, "chrp,iic");
> +	if (np) {
> +		of_node_put(np);
> +		/*
> +		 * Use a fixed interrupt value of 8 since on PPC if we are
> +		 * using this its off an i8259 which we ensure has interrupt
> +		 * numbers 0..15.
> +		 */
> +		res[1].start = 8;
> +		res[1].end = 8;
> +		res[1].flags = IORESOURCE_IRQ;
> +		num_res++;
> +	}
>  
>  	pd = platform_device_register_simple("rtc_cmos", -1,
> -					     &res[0], 2);
> +					     &res[0], num_res);
>  
>  	if (IS_ERR(pd))
>  		return PTR_ERR(pd);
> -- 
> 1.5.5.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
