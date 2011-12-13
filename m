Return-Path: <acrux_it@libero.it>
Received: from outrelay07.libero.it (outrelay07.libero.it [212.52.84.111])
 by ozlabs.org (Postfix) with ESMTP id D42F71007D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2011 07:13:51 +1100 (EST)
Date: Tue, 13 Dec 2011 21:13:44 +0100
From: acrux <acrux_it@libero.it>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: sam460ex, rtc-m41t80 incorrect behaviour with kernel
 >=linux-2.6.38
Message-Id: <20111213211344.e1a8157d.acrux_it@libero.it>
In-Reply-To: <1323730073.4078.97.camel@work-vm>
References: <9365263.8063121322965766294.JavaMail.defaultUser@defaultHost>
 <1323730073.4078.97.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Bigga <ab@mycable.de>,
 rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Dec 2011 14:47:53 -0800
John Stultz <john.stultz@linaro.org> wrote:

> On Sun, 2011-12-04 at 03:29 +0100, acrux_it@libero.it wrote:
> > Acube Sam460ex is a 460ex SoC (PowerPC) based board with m41t81
> > like RTC. The wrong beahviour it seems to be caused this commit:
> > 
> > Thu, 3 Feb 2011 21:02:35 +0000 (13:02 -0800)
> > commit	16380c153a69c3784d2afaddfe0a22f353046cf6
> > RTC: Convert rtc drivers to use the alarm_irq_enable method
> > http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;
> > h=16380c153a69c3784d2afaddfe0a22f353046cf6
> 
> Yea. This was reported earlier, but it seems none of the proposed
> solutions have been implemented.
> 
> The cause is that the m41t80 driver's alarm functionality is somehow
> broken. The alarm mode is actually now used for UIE, so where before
> 2.6.38, UIE mode returned -EINVAL, it will now succeed, setting the
> alarm to fire a second away.
> 
> However, since the alarm code is broken, no alarm arrives and you get
> the timeout you see.
> 
> Could you test the following patch to see if it resolves the issue for
> you? If it does, I'll queue it for inclusion.
> 
> thanks
> -john
> 


hallo John,
CC to linuxppc-dev@lists.ozlabs.org


thanks for your time, this escamotage works fine.
I tested your patch against linux-2.6.38.8 and linux-3.1.5.

Tested-by: Nico Macrionitis <acrux@cruxppc.org>


cheers,
Nico



> 
> [PATCH] rtc: m41t80: Workaround broken alarm functionality
> 
> The m41t80 driver doesn't seem to have a functional alarm.
> 
> This causes failures when the generic core sees alarm functions,
> but then cannot use them properly for things like UIE mode.
> 
> Disabling the alarm functions allows proper error reporting,
> and possible fallback to emulated modes. Once someone fixes
> the alarm functions, this can be restored.
> 
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/rtc/rtc-m41t80.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index eda128f..64aedd8 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -357,10 +357,19 @@ static int m41t80_rtc_read_alarm(struct device
> *dev, struct rtc_wkalrm *t) static struct rtc_class_ops
> m41t80_rtc_ops = { .read_time = m41t80_rtc_read_time,
>  	.set_time = m41t80_rtc_set_time,
> +	/*
> +	 * XXX - m41t80 alarm functionality is reported broken.
> +	 * until it is fixed, don't register alarm functions.
> +	 *
>  	.read_alarm = m41t80_rtc_read_alarm,
>  	.set_alarm = m41t80_rtc_set_alarm,
> +	*/
>  	.proc = m41t80_rtc_proc,
> +	/*
> +	 * See above comment on broken alarm
> +	 *
>  	.alarm_irq_enable = m41t80_rtc_alarm_irq_enable,
> +	*/
>  };
>  
>  #if defined(CONFIG_RTC_INTF_SYSFS) || defined
>  #(CONFIG_RTC_INTF_SYSFS_MODULE)
> -- 
> 1.7.3.2.146.gca209
> 
> 
> 


-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/
