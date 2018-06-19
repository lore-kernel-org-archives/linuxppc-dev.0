Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4193nr5McqzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 20:18:23 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id a13-v6so9176280lfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 03:18:23 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <87efh3hndq.fsf@igel.home>
References: <20180618140518.2920804-1-arnd@arndb.de>
 <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
 <87efh3hndq.fsf@igel.home>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Jun 2018 12:18:19 +0200
Message-ID: <CAK8P3a1_3UfYGnTcWJ7GS_gO+_WOhS90pUoC97yVAgkox9sQeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mac: fix rtc read functions
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Meelis Roos <mroos@linux.ee>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 10:04 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Jun 18 2018, Mathieu Malaterre <malat@debian.org> wrote:
>
>> Sadly, trying again today does not work anymore. Adding some printk
>> just before WARN_ON:
>>
>> +printk(KERN_ERR " rtc DBG pmu_get_time1: %lld %d %lld \n", now,
>> RTC_OFFSET, now - RTC_OFFSET );
>> +printk(KERN_ERR " rtc DBG pmu_get_time2: %x %x %x %x %d \n",
>> req.reply[0], req.reply[1], req.reply[2], req.reply[3] ,
>> req.reply_len);
>>
>> leads to:
>>
>> [    0.000000]  rtc DBG pmu_get_time1: 14096662 2082844800 -2068748138
>> [    0.000000]  rtc DBG pmu_get_time2: 0 d7 19 16 4
>
> A good value would have 0xd7 in the first byte.  The problem is that
> pmu_set_rtc_time is also broken, and leads to an invalid time value
> stored in the RTC.  Since pmu_request is a varargs function passing
> values of type time64_t without casting won't work.
>
> You need to reset your RTC before you can continue.
>
> I think the right fix is to change nowtime in pmu_set_rtc_time and
> cuda_set_rtc_time back to unsigned int (or to u32).

Thanks for the additional analysis. I'll do it like you suggest and send
an updated patch.

       Arnd
