Return-Path: <linuxppc-dev+bounces-22048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BA2CD6E6D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:12:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWSjJ64Mfz2yT0;
	Fri, 05 Jun 2026 01:12:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585940;
	cv=none; b=o0PT4KCrxHO9kguObuOGWDCMhRz/HjOQwHVhbpGKgtKumfBWpxzHLM0mnF+1Yj1AaBRxFfg5pbY9H+j0dcixlpv2SoJawZIj8KyL3OuWbGNpM6GthwHT9hl/pz5R1OVfcFZxDuD17BsDZTkx/YMMnik1W/A/BvyzP2XRzmLuRHwLJQL+dmOCP2bSPN3oRY2DhIDGNYT+KRVl4P1b6WuWkCTwAd4AlXWZL5wTBXqbfseAdsHtrukkSQnmqtK7RqSf2KSFmpWO8KAX9ArvwdoOYZfEQjouqb/G3L3+k+T5t/EUBrWeq4yh8QzuwBJdPHliWjIiLicD+4TER+yvqnWX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585940; c=relaxed/relaxed;
	bh=O1v9N3k9IDXCDyh5eR8X+ZRCQEucW1FGLyXUGWNzxUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgqUa/BaXRROWoh6P7VFirIAp2C937PTEjIyH36uq0faWozwcLuvcH8wPYcXy5AYspF0vfnDoWAc4nO/y3z+f7dRsaeDLnP8knF8GQVpJpD5qA9AFfSyBjcDHP8U+DqSbLzwolbx8k3iGhEUPiNG56gs0jwxHyTbXsrY1d+Xf4cCTKhfKtySAxKJ0D1qgFjqhdTUicnZZXkXSFcNvYoWzzLVgoXXI34WhBkHzj971iLmDmJYMpFqrZgmkUBbcSAGxHHmbPUaoZyUSezVPVNidI1Y5qFD8eBiez9fb4uSJTn1wnDl3d/EnwpWHDsDW4lRtq2eiI4pQVbOQBdSdJjyrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMgkbBUI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMgkbBUI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSjJ157Lz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:12:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F1B043D77;
	Thu,  4 Jun 2026 15:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11361F00893;
	Thu,  4 Jun 2026 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585938;
	bh=O1v9N3k9IDXCDyh5eR8X+ZRCQEucW1FGLyXUGWNzxUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PMgkbBUIw1mYhqspkEGhkKu2KoFiskrRf6e3QToP33i/x666zFLEnqXbOWityWgXj
	 Qtq1jrZEBjRs46SUSOnOpj4sMQJViSDIDLCq7cmT6ZXl0UlfxcBwUrKo5yrHg7vkGY
	 SJly3z8pRCzaAKfAJN9YyDA/cYSy6ocwuF44wE6+CAjcGBB8H98Mt+SG32UJANXhZz
	 DIHvebpbulR40AL3NOcdGWmyYwKpdsh0y8YTlIaKAUTDIBvhA872M+Sgd39ROSg8f3
	 hspdPQwkaCJHreAPDxrq45R3AlvOilwfg54L8ciaHVyyilHVmxgTCYawR8ZSQf6YFp
	 oVDjSKQFyHsug==
Message-ID: <644eed72-fe6b-4639-88d3-dcbba1f8209b@kernel.org>
Date: Thu, 4 Jun 2026 17:12:15 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/vtime: Initialize starttime at boot for native
 accounting
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: frederic@kernel.org
References: <20260604132429.297665-1-sshegde@linux.ibm.com>
 <e69ad352-6835-414b-845b-03f45fdd9a45@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <e69ad352-6835-414b-845b-03f45fdd9a45@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/06/2026 à 16:51, Christophe Leroy (CS GROUP) a écrit :
> 
> 
> Le 04/06/2026 à 15:24, Shrikanth Hegde a écrit :
>> It was observed that /proc/stat had very large value for one ore more
>> CPUs. It was more visible after recent code simplifications around
>> cpustats.
>>
>> System has 240 CPUs.
>>
>> cat /proc/uptime;
>> 194.18 46500.55
>> cat /proc/stat
>> cpu  5966 39 837032887 4650070 164 185 100 0 0 0
>> cpu0 108 0 837030890 19109 24 4 23 0 0 0
>>
>> Since uptime is 194s, system time of each CPU can't be more than 19400.
>> Sum of system time  of all CPUs can't be more than 19400*240 4656000.
>> In fact huge value is close to mftb(). Note mftb doesn't reset on powerVM
>> when the LPAR restart. It only resets when whole system resets. The same
>> issue exists for kexec too.
>>
>> This happens since starttime is not setup at init time. Once it is set
>> then subsequent vtime_delta will return the right delta.
>>
>> Fix it by initializing the starttime during CPU initialization. This
>> fixes the large times seen.
>>
>> cat /proc/uptime; cat /proc/stat
>> 15.78 3694.63
>> cpu  6035 35 1347 369479 23 144 49 0 0 0
>> cpu0 19 0 38 1508 0 1 14 0 0 0
>>
>> Now, system time is reported as expected.
>>
>> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> 
>> ---
>>
>> Christophe, I have taken the patch as is from the discussion we had.
>> Let me know if i should send it with your signed-off-by tag. I have just
>> written the changelog. I sent it like this since tag was not there.
> 
> Suggested-by is fine for me.
> 
>>
>> discussion thread:
>> https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fall%2Fcd10be19- 
>> e0bc-4e0c-8dac-4f1c05d0de8f%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C1702c7a5ff63417da4ef08dec248be1d%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639161814851391682%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DjLhS3imHryT613JPVG0mnkWjILSGGrt1tLvmqFHtVM%3D&reserved=0
>>
>> Also, does this warrant Fixes tag? I found these two likely candidates.
>> Likely this issues exists since beginning.
>> c223c90386bc powerpc32: provide VIRT_CPU_ACCOUNTING
> 
> You say system has 240 CPU so I suppose this is not ppc32. That commit 
> wsa not supposed to change anything for ppc64, did you identify anything 
> special in that commit related to ppc64 ?
> 
>> b38a181c11d0 powerpc/time: isolate scaled cputime accounting in 
>> dedicated functions.
> 
> This one is also pure code re-organisation, unless you've been able to 
> spot a particular issue ?

Maybe commit cf9efce0ce31 ("powerpc: Account time using timebase rather 
than PURR")

It removed snapshot_timebases() and I can't see anything to replace it.


> 
>>
>>   arch/powerpc/kernel/time.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 3460d1a5a97c..11145c40183d 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
>>       }
>>   }
>> -#ifdef CONFIG_NO_HZ_COMMON
>>   /**
>>    * vtime_reset - Fast forward vtime entry clocks
>>    *
>> @@ -394,6 +393,7 @@ void vtime_reset(void)
>>   #endif
>>   }
>> +#ifdef CONFIG_NO_HZ_COMMON
>>   /**
>>    * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
>>    *
>> @@ -933,6 +933,7 @@ static void __init set_decrementer_max(void)
>>   static void __init init_decrementer_clockevent(void)
>>   {
>>       register_decrementer_clockevent(smp_processor_id());
>> +    vtime_reset();
>>   }
>>   void secondary_cpu_time_init(void)
>> @@ -948,6 +949,7 @@ void secondary_cpu_time_init(void)
>>       /* FIME: Should make unrelated change to move snapshot_timebase
>>        * call here ! */
>>       register_decrementer_clockevent(smp_processor_id());
>> +    vtime_reset();
>>   }
>>   /*
> 


