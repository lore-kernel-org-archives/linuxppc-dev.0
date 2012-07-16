Return-Path: <Lu.Jiang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18E642C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2012 12:07:38 +1000 (EST)
Message-ID: <50037762.4000800@windriver.com>
Date: Mon, 16 Jul 2012 10:07:30 +0800
From: "Lu.Jiang" <lu.jiang@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
References: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
 <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
In-Reply-To: <D5792F52-7BE6-4B86-A3FD-B756DE3A165D@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: lu.jiang@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2012年07月13日 19:50, Kumar Gala 写道:
> On Jul 12, 2012, at 9:44 PM, Jiang Lu wrote:
>
>> On PPC44x core, the WRC(Watchdog-timer Reset Control) field of TCR
>> of timer can not reset by software after set to a non-zero value.
>> Which means software can not reset the timeout behaviour of watchdog timer.
>>
>> This patch selects WATCHDOG_NOWAYOUT option for 44x platforms to
>> indicate the watchdog timer can not be disabled once fired.
>>
>> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
>> ---
>> drivers/watchdog/Kconfig |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
> I believe this is not 44x specific, but how Book-E watchdog is architected.
>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 3709624..41f3dff 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1084,6 +1084,7 @@ config PIKA_WDT
>> config BOOKE_WDT
>> 	tristate "PowerPC Book-E Watchdog Timer"
>> 	depends on BOOKE || 4xx
>> +	select WATCHDOG_NOWAYOUT if 44x
> This should probably be 'select WATCHDOG_NOWAYOUT if BOOKE'

On ppc44x's processor, if we disabled 'WATCHDOG_NOWAYOUT ' option. The 
driver's release routine will try to disable the watchdog , by clearing 
the WIE & WTDP field in TCR.
Since the ppc44x's watch dog can not reset by software, such operation 
only set the timeout value(WDTP) to minimum, and cause the system reboot 
immediately.

I checked ppc 476, 405 & 450's manual, these document said the 
WRC(Watchdog-timer Reset Control) field of TCR of timer
can not reset by software after set to a non-zero value. I think all 
ppc44x core should got same limitation.

While on FSL's platform, we did not met such issue. So I think we should 
select 'WATCHDOG_NOWAYOUT' option for 44x platform.

Regards,
Jiang Lu

>
>> 	---help---
>> 	  Watchdog driver for PowerPC Book-E chips, such as the Freescale
>> 	  MPC85xx SOCs and the IBM PowerPC 440.
>> -- 
>> 1.7.7
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
