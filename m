Return-Path: <B10716@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9468AB6F81
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2011 18:30:55 +1000 (EST)
Message-ID: <4E5F42CE.1060502@freescale.com>
Date: Thu, 1 Sep 2011 11:31:10 +0300
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/time: When starting the decrementer don't zero
	the other bits in TCR
References: <1314274795-4966-1-git-send-email-Laurentiu.Tudor@freescale.com>
	<9A0167AA-E19D-4492-8D65-6FA4518ABE98@kernel.crashing.org>
In-Reply-To: <9A0167AA-E19D-4492-8D65-6FA4518ABE98@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/1/2011 9:27 AM, Kumar Gala wrote:
>
> On Aug 25, 2011, at 7:19 AM, Laurentiu Tudor wrote:
>
>> Clearing the other TCR bits might break code that sets them (e.g. to setup
>> the watchdog or fixed interval timer) before start_cpu_decrementer() gets
>> called.
>
> Can you be more specific about the case you're concerned about.  I'm not sure we want to leave the FIT enabled if it was previously.  Watchdog I could possibly see leaving alone.

My particular case was this: I was experimenting with having the 
watchdog enabled during the boot process, in case something goes wrong 
before the normal watchdog mechanism kicks in. That didn't work without 
making this modification.
Then, thinking that having a function start_cpu_decrementer() touching 
the other timers and not only the decrementer as its name implies might 
not be good. So I submitted this patch to the public mailing list to let 
the community decide if it's useful.

>> Signed-off-by: Laurentiu Tudor<Laurentiu.Tudor@freescale.com>
>> ---
>> arch/powerpc/kernel/time.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 03b29a6..e8b5cdc 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -721,7 +721,7 @@ void start_cpu_decrementer(void)
>> 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
>>
>> 	/* Enable decrementer interrupt */
>> -	mtspr(SPRN_TCR, TCR_DIE);
>> +	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_DIE);
>> #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
>> }
>>
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
