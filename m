Return-Path: <B25806@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C49972C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 13:18:24 +1000 (EST)
Message-ID: <50607A5A.3060103@freescale.com>
Date: Mon, 24 Sep 2012 11:20:58 -0400
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
 <201208101327.47789.arnd@arndb.de> <505CD3A5.6080101@freescale.com>
 <201209211233.54545.arnd@arndb.de>
In-Reply-To: <201209211233.54545.arnd@arndb.de>
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

On 09/21/2012 08:33 AM, Arnd Bergmann wrote:
> On Friday 21 September 2012, Chunhe Lan wrote:
>> On 08/10/2012 09:27 AM, Arnd Bergmann wrote:
>>> On Friday 10 August 2012, Chunhe Lan wrote:
>>>
>>>        cond_resched();
>>>        mdelay(ms);
>>>
>>> sets off alarm bells, and I would always replace that with msleep().
>>       I think that it does not replace with msleep().
>>       When the time of sleep is very short, program should not been scheduled
>>       in the context. Because it expends the more time.
>>
> A time measured in miliseconds is never "very short" for the scheduler,
> a lot of things can happen during that time span. The code I quoted
> also does not care too much about accuracy, otherwise it would adapt
> the time in the mdelay based on whether the cond_resched() actually
> schedules to another thread.
    OK. As you have mentioned, it would been modified to such:

static inline void mmc_delay(unsigned int ms)
{
         if (ms < 1000 / HZ) {
                 cond_resched();
                 msleep(ms);
         } else {
                 msleep(ms);
         }
}

OR such:

static inline void mmc_delay(unsigned int ms)
{
                 msleep(ms);
}

OR other code?

Thanks,
Chunhe
>
> 	Arnd
>
