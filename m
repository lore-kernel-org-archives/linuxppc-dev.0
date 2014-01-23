Return-Path: <linux@prisktech.co.nz>
Received: from server.prisktech.co.nz (server.prisktech.co.nz [115.188.14.127])
 by ozlabs.org (Postfix) with ESMTP id A3B852C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 18:54:36 +1100 (EST)
Message-ID: <52E0C889.6000106@prisktech.co.nz>
Date: Thu, 23 Jan 2014 20:45:13 +1300
From: Tony Prisk <linux@prisktech.co.nz>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>, John Stultz <john.stultz@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kevin Hilman <khilman@deeprootsystems.com>, linux@lists.openrisc.net,
 Sekhar Nori <nsekhar@ti.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Jeff Dike <jdike@addtoit.com>,
 Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org,
 user-mode-linux-user@lists.sourceforge.net, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 davinci-linux-open-source@linux.davincidsp.com,
 Michal Simek <monstr@monstr.eu>, Jim Cromie <jim.cromie@gmail.com>,
 microblaze-uclinux@itee.uq.edu.au, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Bryan Huntsman <bryanh@codeaurora.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/01/14 20:12, Yijing Wang wrote:
> Currently, clocksource_register() and __clocksource_register_scale()
> functions always return 0, it's pointless, make functions void.
> And remove the dead code that check the clocksource_register_hz()
> return value.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
......
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 67301a4..5a17c5e 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -282,7 +282,7 @@ static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
>   }
>   
>   
> -extern int clocksource_register(struct clocksource*);
> +extern void clocksource_register(struct clocksource *);
>   extern int clocksource_unregister(struct clocksource*);
>   extern void clocksource_touch_watchdog(void);
>   extern struct clocksource* clocksource_get_next(void);
> @@ -301,17 +301,17 @@ clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 minsec);
>    * Don't call __clocksource_register_scale directly, use
>    * clocksource_register_hz/khz
>    */
> -extern int
> +extern void
>   __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq);
>   extern void
>   __clocksource_updatefreq_scale(struct clocksource *cs, u32 scale, u32 freq);
>   
> -static inline int clocksource_register_hz(struct clocksource *cs, u32 hz)
> +static inline void clocksource_register_hz(struct clocksource *cs, u32 hz)
>   {
>   	return __clocksource_register_scale(cs, 1, hz);
>   }

This doesn't make sense - you are still returning a value on a function 
declared void, and the return is now from a function that doesn't return 
anything either ?!?!
Doesn't this throw a compile-time warning??

Regards
Tony Prisk
