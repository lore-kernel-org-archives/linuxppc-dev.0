Return-Path: <B25806@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 597932C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 18:50:25 +1000 (EST)
Message-ID: <505CD3A5.6080101@freescale.com>
Date: Fri, 21 Sep 2012 16:52:53 -0400
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
 <201208101327.47789.arnd@arndb.de>
In-Reply-To: <201208101327.47789.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Cc: kumar.gala@freescale.com, linux-mmc@vger.kernel.org, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2012 09:27 AM, Arnd Bergmann wrote:
> On Friday 10 August 2012, Chunhe Lan wrote:
>
>> +static inline void mmc_delay(unsigned int ms)
>> +{
>> +	if (ms < 1000 / HZ) {
>> +		cond_resched();
>> +		mdelay(ms);
>> +	} else {
>> +		msleep(ms);
>> +	}
>> +}
> I would actually question the point in this function to start with: The
> decision whether to call mdelay() or msleep() should only be based on
> whether you are allowed to sleep in the caller context. The idea of
>
>
> 	cond_resched();
> 	mdelay(ms);
>
> sets off alarm bells, and I would always replace that with msleep().
     I think that it does not replace with msleep().
     When the time of sleep is very short, program should not been scheduled
     in the context. Because it expends the more time.

     Thanks,
     Chunhe
>
> 	Arnd
>
