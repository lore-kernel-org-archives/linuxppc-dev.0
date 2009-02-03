Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by ozlabs.org (Postfix) with ESMTP id A9697DDF21
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 02:48:05 +1100 (EST)
Date: Tue, 3 Feb 2009 16:47:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: [Patch] fix lcd panel driver build failure
Message-ID: <20090203154756.GF12398@1wt.eu>
References: <49885F9A.6040703@in.ibm.com> <20090203152502.GC12398@1wt.eu>
	<4988658A.1060306@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4988658A.1060306@in.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Sachin !

Greg, could you please merge this one into your staging tree ?

Thanks,
Willy

On Tue, Feb 03, 2009 at 09:10:58PM +0530, Sachin P. Sant wrote:
> * Fix build break for lcd panel driver.
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>

Signed-off-by: Willy Tarreau <w@1wt.eu>

> ---
> 
> 

> * Fix build break for lcd panel driver.
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> ---
> 
> diff -Naurp a/drivers/staging/panel/panel.c b/drivers/staging/panel/panel.c
> --- a/drivers/staging/panel/panel.c	2009-02-03 23:34:18.000000000 +0530
> +++ b/drivers/staging/panel/panel.c	2009-02-03 23:33:16.000000000 +0530
> @@ -622,7 +622,7 @@ static int set_ctrl_bits(void)
>  }
>  
>  /* sets ctrl & data port bits according to current signals values */
> -static void set_bits(void)
> +static void panel_set_bits(void)
>  {
>  	set_data_bits();
>  	set_ctrl_bits();
> @@ -707,12 +707,12 @@ static void lcd_send_serial(int byte)
>  	 */
>  	for (bit = 0; bit < 8; bit++) {
>  		bits.cl = BIT_CLR;	/* CLK low */
> -		set_bits();
> +		panel_set_bits();
>  		bits.da = byte & 1;
> -		set_bits();
> +		panel_set_bits();
>  		udelay(2);	/* maintain the data during 2 us before CLK up */
>  		bits.cl = BIT_SET;	/* CLK high */
> -		set_bits();
> +		panel_set_bits();
>  		udelay(1);	/* maintain the strobe during 1 us */
>  		byte >>= 1;
>  	}
> @@ -727,7 +727,7 @@ static void lcd_backlight(int on)
>  	/* The backlight is activated by seting the AUTOFEED line to +5V  */
>  	spin_lock(&pprt_lock);
>  	bits.bl = on;
> -	set_bits();
> +	panel_set_bits();
>  	spin_unlock(&pprt_lock);
>  }
>  
