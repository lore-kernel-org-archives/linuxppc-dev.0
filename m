Return-Path: <dalias@aerifal.cx>
Received: from brightrain.aerifal.cx (216-12-86-13.cv.mvl.ntelos.net
 [216.12.86.13])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rKklM2kj8zDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 07:58:55 +1000 (AEST)
Date: Wed, 1 Jun 2016 17:58:14 -0400
From: Rich Felker <dalias@libc.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 geert@linux-m68k.org, gregkh@linuxfoundation.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dhowells@redhat.com,
 linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 04/16] rtc: sh: provide rtc_class_ops directly
Message-ID: <20160601215814.GE10893@brightrain.aerifal.cx>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
 <1464634684-1248135-5-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464634684-1248135-5-git-send-email-arnd@arndb.de>
Sender: Rich Felker <dalias@aerifal.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 30, 2016 at 08:57:52PM +0200, Arnd Bergmann wrote:
> The rtc-generic driver provides an architecture specific
> wrapper on top of the generic rtc_class_ops abstraction,
> and on sh, that goes through another indirection using
> the rtc_sh_get_time/rtc_sh_set_time functions.
> 
> This changes the sh rtc-generic device to provide its
> rtc_class_ops directly, skipping one of the abstraction
> levels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I haven't tested any of this, but based on our discussion of the
previous version, I'm satisfied that it makes sense.

Acked-by: Rich Felker <dalias@libc.org>

> ---
>  arch/sh/include/asm/rtc.h | 11 -----------
>  arch/sh/kernel/time.c     | 33 ++++++++++++++++++++-------------
>  drivers/rtc/rtc-generic.c |  2 +-
>  3 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
> index 52b0c2dba979..f7b010d48af7 100644
> --- a/arch/sh/include/asm/rtc.h
> +++ b/arch/sh/include/asm/rtc.h
> @@ -6,17 +6,6 @@ extern void (*board_time_init)(void);
>  extern void (*rtc_sh_get_time)(struct timespec *);
>  extern int (*rtc_sh_set_time)(const time_t);
>  
> -/* some dummy definitions */
> -#define RTC_BATT_BAD 0x100	/* battery bad */
> -#define RTC_SQWE 0x08		/* enable square-wave output */
> -#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
> -#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
> -#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
> -
> -struct rtc_time;
> -unsigned int get_rtc_time(struct rtc_time *);
> -int set_rtc_time(struct rtc_time *);
> -
>  #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
>  
>  struct sh_rtc_platform_info {
> diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
> index d6d0a986c6e9..a4a7862b489a 100644
> --- a/arch/sh/kernel/time.c
> +++ b/arch/sh/kernel/time.c
> @@ -50,27 +50,31 @@ int update_persistent_clock(struct timespec now)
>  }
>  #endif
>  
> -unsigned int get_rtc_time(struct rtc_time *tm)
> +static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>  {
> -	if (rtc_sh_get_time != null_rtc_get_time) {
> -		struct timespec tv;
> +	struct timespec tv;
>  
> -		rtc_sh_get_time(&tv);
> -		rtc_time_to_tm(tv.tv_sec, tm);
> -	}
> -
> -	return RTC_24H;
> +	rtc_sh_get_time(&tv);
> +	rtc_time_to_tm(tv.tv_sec, tm);
> +	return 0;
>  }
> -EXPORT_SYMBOL(get_rtc_time);
>  
> -int set_rtc_time(struct rtc_time *tm)
> +static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned long secs;
>  
>  	rtc_tm_to_time(tm, &secs);
> -	return rtc_sh_set_time(secs);
> +	if ((rtc_sh_set_time == null_rtc_set_time) ||
> +	    (rtc_sh_set_time(secs) < 0))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL(set_rtc_time);
> +
> +static const struct rtc_class_ops rtc_generic_ops = {
> +	.read_time = rtc_generic_get_time,
> +	.set_time = rtc_generic_set_time,
> +};
>  
>  static int __init rtc_generic_init(void)
>  {
> @@ -79,7 +83,10 @@ static int __init rtc_generic_init(void)
>  	if (rtc_sh_get_time == null_rtc_get_time)
>  		return -ENODEV;
>  
> -	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
> +					     &rtc_generic_ops,
> +					     sizeof(rtc_generic_ops));
> +
>  
>  	return PTR_ERR_OR_ZERO(pdev);
>  }
> diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
> index d726c6aa96a8..3958e87a05fa 100644
> --- a/drivers/rtc/rtc-generic.c
> +++ b/drivers/rtc/rtc-generic.c
> @@ -10,7 +10,7 @@
>  #include <linux/rtc.h>
>  
>  #if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
> -    defined(CONFIG_PPC) || defined(CONFIG_SUPERH32)
> +    defined(CONFIG_PPC)
>  #include <asm/rtc.h>
>  
>  static int generic_get_time(struct device *dev, struct rtc_time *tm)
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
