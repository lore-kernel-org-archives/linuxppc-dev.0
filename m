Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp16.mail.mci.yahoo.co.jp (ybbsmtp16.mail.mci.yahoo.co.jp
	[210.80.241.190]) by ozlabs.org (Postfix) with SMTP id C0F8367A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 19:11:39 +1100 (EST)
Message-ID: <422969B9.6040303@ybb.ne.jp>
Date: Sat, 05 Mar 2005 17:11:37 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@jdub.homelinux.org>
References: <4226FF62.30007@jp.fujitsu.com>	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>	<42272B69.8000303@ybb.ne.jp>
	<20050303101146.A8869@cox.net>	<42282C83.9040707@jp.fujitsu.com>
	<1109982868.1479.22.camel@jdub.homelinux.org>
In-Reply-To: <1109982868.1479.22.camel@jdub.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Josh:

Thank you for your thorough review.

Josh Boyer wrote:
> This is slightly wrong.  Not all 4xx processors are BOOKE.  403 and 405
> aren't to be specific.  But it's not really that big of a deal I guess.
> 
>
I know this.
As you said, I regard this with minor thing.


>>+
>>+#ifdef CONFIG_WATCHDOG_NOWAYOUT
>>+static int nowayout = 1;
>>+#else
>>+static int nowayout = 0;
>>+#endif
> 
> 
> Couldn't you just use the #ifdef in the release function and not
> "disable" the watchdog?  It would save a global variable at least.
> 
At first, I examined to remove the release file operation
to eliminate this global variable.
On second thought, I decided to use this global variable as 
drivers/char/watchdog/wdt.c.
I think that the release file operation is necessary to control
so as not to open the device more than twice.
This behavior is commonly used in other watch dog drivers,
doesn't it?

>>+static int __init booke_wdt_init(void);
>>+static void __exit booke_wdt_exit(void);
> 
> 
> If you order these in the right way, you don't need to declare them in
> advance.
> 
Ok, I'll remove them.

> 
>>+/**
>>+ *      __booke_wdt_enable
>>+ *      Enable Watchdog
>>+ */
>>+static __inline__ void
>>+__booke_wdt_enable(void)
>>+{
>>+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|WDT_TCR_WDT_ENABLE));
>>+}
>>+/**
>>+ *      __booke_wdt_disable
>>+ *      Disable Watchdog
>>+ */
>>+static __inline__ void
>>+__booke_wdt_disable(void)
>>+{
>>+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(WDT_TCR_WDT_ENABLE))));
>>+}
> 
> 
> These two functions are somewhat misleading.  On 4xx the timer is
> essentially always enabled.  The bit you are setting and clearing here
> is just to enable the exception after the expiration of the 2nd WP.  The
> reason I bring this up is because if you ever set TCR[WRC] to something
> non-zero and this bit is off, the processor will just be reset after 3
> watchdog periods.  In other words, if TCR[WRC] is ever non-zero there is
> no such thing as disabling the timer.  You will always need to do the
> ping to keep the processor from resetting.
> 
  I agree that function names like XXX_wdt_enable(or disable) are not
reflected on precise meaning.

But in this driver, we set TCR[WRC] as zero.It is needed to detect and 
logging WDT timeout with software before MPU reset. I want to leave the 
way to find where the system hang up.
IMHO, this is the reason to use WDT in the system.
So, I will not support non-zero TCR[WRC].

 From the above-mentioned viewpoint, making WDT exception enabled (or 
disabled) means start/stop WDT itself in this driver.
This is the reason to adopt these names.

Please note that the system will panic before the CPU attempt to reset 
CPU when we use this driver.

Please let me hear it if there are some opinions.

> 
> Since you're using WDT_RESET_NONE, I think what you have here should
> work.  
>
Yes, however, it is implemented on purpose.
>>+/*
>>+ *  WP relevant values used in our driver.
>>+ *  Note:WDT period must be more than HZ(Timer ticks)
>>+ */
>>+#define WDT_WP                 WDT_WP3
> 
> 
> Most of this is in include/asm-ppc/reg_booke.h.  Could you use that
> instead of redefining most of it?
>
To tell the truth, this matter has been examined, but I forgot this.
Thank you for making it recall(^^

> 
> In include/linux/device.h there are dev_printk and dev_dbg macros that
> do pretty much the same thing.  Could you use those instead?
>
I did not know such thing.
I'll try to use them.

Regards,

-- 
Takeharu KATO
