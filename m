Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 203FAB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:23:35 +1000 (EST)
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 92E71DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:23:34 +1000 (EST)
Message-ID: <4A8B1BD4.3000908@ruggedcom.com>
Date: Tue, 18 Aug 2009 17:23:32 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] qe_lib: Set gpio data before changing the direction to
	output
References: <4A8B164E.6030704@ruggedcom.com> <4A8B183D.2030202@freescale.com>
In-Reply-To: <4A8B183D.2030202@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Michael Barkowski wrote:
> 
>> diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
>> index 3485288..e7bf136 100644
>> --- a/arch/powerpc/sysdev/qe_lib/gpio.c
>> +++ b/arch/powerpc/sysdev/qe_lib/gpio.c
>> @@ -107,12 +107,11 @@ static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>>  
>>  	spin_lock_irqsave(&qe_gc->lock, flags);
>>  
>> +	qe_gpio_set(gc, gpio, val);
> 
> qe_gpio_set already calls spin_lock_irqsave(), so you'll have nested spinlocks, which will lock up on SMP.
> 
> Let me guess, you didn't test this on a dual-core system?

That is correct.  See v2 and please test, YMMV, etc

-- 
Michael Barkowski
