Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2F9772C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 21:40:28 +1000 (EST)
Subject: Re: [PATCH 2/2][v2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
 CONFIG_PPC_FSL_BOOK3E
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <ED492CCEAF882048BC2237DE806547C9079802C6@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Tue, 10 Jul 2012 06:40:23 -0500
Message-Id: <AFA5C641-783C-4B61-ACCF-6A776BF75B24@kernel.crashing.org>
References: <1336714420-2394-1-git-send-email-Shaohui.Xie@freescale.com>
 <ED492CCEAF882048BC2237DE806547C9079802C6@039-SN2MPN1-013.039d.mgd.msft.net>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 10, 2012, at 5:22 AM, Xie Shaohui-B21989 wrote:

> Hi, All,
> 
> Is there any concern for this patch, it's been a long time.
> Thanks!
> 
> 
> Best Regards, 
> Shaohui Xie 

As commented, we should use PPC_FSL_BOOK3E, not CONFIG_PPC_FSL_BOOK3E.

- k

> 
> 
>> -----Original Message-----
>> From: Xie Shaohui-B21989
>> Sent: Friday, May 11, 2012 1:34 PM
>> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Cc: Xie Shaohui-B21989
>> Subject: [PATCH 2/2][v2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
>> CONFIG_PPC_FSL_BOOK3E
>> 
>> CONFIG_FSL_BOOKE is only defined in 32-bit, CONFIG_PPC_FSL_BOOK3E is
>> defined in both 32-bit and 64-bit, so use CONFIG_PPC_FSL_BOOK3E to make
>> driver work in 32-bit & 64-bit.
>> 
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> ---
>> changes for v2:
>> use PPC_FSL_BOOK3E instead of FSL_SOC_BOOKE.
>> 
>> drivers/watchdog/Kconfig     |    8 ++++----
>> drivers/watchdog/booke_wdt.c |    4 ++--
>> 2 files changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>> 3709624..4373ca0 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1094,10 +1094,10 @@ config BOOKE_WDT  config BOOKE_WDT_DEFAULT_TIMEOUT
>> 	int "PowerPC Book-E Watchdog Timer Default Timeout"
>> 	depends on BOOKE_WDT
>> -	default 38 if FSL_BOOKE
>> -	range 0 63 if FSL_BOOKE
>> -	default 3 if !FSL_BOOKE
>> -	range 0 3 if !FSL_BOOKE
>> +	default 38 if PPC_FSL_BOOK3E
>> +	range 0 63 if PPC_FSL_BOOK3E
>> +	default 3 if !PPC_FSL_BOOK3E
>> +	range 0 3 if !PPC_FSL_BOOK3E
>> 	help
>> 	  Select the default watchdog timer period to be used by the PowerPC
>> 	  Book-E watchdog driver.  A watchdog "event" occurs when the bit
>> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
>> index ce0ab44..338a437 100644
>> --- a/drivers/watchdog/booke_wdt.c
>> +++ b/drivers/watchdog/booke_wdt.c
>> @@ -37,7 +37,7 @@
>> u32 booke_wdt_enabled;
>> u32 booke_wdt_period = CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT;
>> 
>> -#ifdef	CONFIG_FSL_BOOKE
>> +#ifdef	CONFIG_PPC_FSL_BOOK3E
>> #define WDTP(x)		((((x)&0x3)<<30)|(((x)&0x3c)<<15))
>> #define WDTP_MASK	(WDTP(0x3f))
>> #else
>> @@ -190,7 +190,7 @@ static long booke_wdt_ioctl(struct file *file,
>> 	case WDIOC_SETTIMEOUT:
>> 		if (get_user(tmp, p))
>> 			return -EFAULT;
>> -#ifdef	CONFIG_FSL_BOOKE
>> +#ifdef	CONFIG_PPC_FSL_BOOK3E
>> 		/* period of 1 gives the largest possible timeout */
>> 		if (tmp > period_to_sec(1))
>> 			return -EINVAL;
>> --
>> 1.6.4
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
