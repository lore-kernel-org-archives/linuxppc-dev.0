Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 960A71A02A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 03:30:27 +1100 (EST)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
 [209.85.213.181])
 by muin.pair.com (Postfix) with ESMTPSA id 116168FC20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 12:30:23 -0400 (EDT)
Received: by mail-ig0-f181.google.com with SMTP id r10so11074702igi.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 09:30:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412964307.13320.603.camel@snotra.buserror.net>
References: <1412923663-4374-1-git-send-email-B45475@freescale.com>
 <1412964307.13320.603.camel@snotra.buserror.net>
Date: Mon, 13 Oct 2014 11:30:22 -0500
Message-ID: <CAOZdJXUvqzex6oFTEoFRAXUCMfYHZ4GzSESQOvhx_9-vCC_C3Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] qe-uart: modify qe-uart to adapt both powerpc and arm
From: Timur Tabi <timur@tabi.org>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <B07421@freescale.com>, Zhao Qiang <B45475@freescale.com>,
 Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org,
 R63061@freescale.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2014 at 1:05 PM, Scott Wood <scottwood@freescale.com> wrote:
> There are many changes in here that ought to be separate patches with
> separate justification.
>
> Also, some of the QE changes seem to be reasonable cleanup, but not
> related to making the code work on ARM.

I agree with Scott.  This patch already makes significant code
changes, so you should have one patch that just makes the
out_be32->iowrite32be changes.  Changes to the QE library should NOT
be in the same patch as changes to ucc_uart.c.

In addition, changes like this:

-       iprop = of_get_property(np, "port-number", NULL);
-       if (!iprop) {
+       ret = of_property_read_u32_index(np, "port-number", 0, &val);
+       if (ret) {

should be changed to remove the OF dependency.  If you're going to
replace of_get_property, replace it with device_property_read_u32(),
to remove the OF dependency.

>> diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
>> index dff714d..a932f99 100644
>> --- a/arch/arm/include/asm/delay.h
>> +++ b/arch/arm/include/asm/delay.h
>> @@ -57,6 +57,22 @@ extern void __bad_udelay(void);
>>                       __const_udelay((n) * UDELAY_MULT)) :            \
>>         __udelay(n))
>>
>> +#define spin_event_timeout(condition, timeout, delay)                          \
>> +({                                                                             \
>> +     typeof(condition) __ret;                                               \
>> +     int i = 0;                                                             \
>> +     while (!(__ret = (condition)) && (i++ < timeout)) {                    \
>> +             if (delay)                                                     \
>> +                     udelay(delay);                                         \
>> +             else                                                           \
>> +                     cpu_relax();                                           \
>> +             udelay(1);                                                     \
>> +     }                                                                      \
>
> This will delay too long if "delay" is used.

Shouldn't ARM have a version of tb_ticks_since() by now?

>> +     if (!__ret)                                                            \
>> +             __ret = (condition);                                           \
>> +     __ret;                                                                 \
>
> Timur, do you remember why that final "if (!__ret) __ret = (condition);"
> is needed?

    powerpc: Fix spin_event_timeout() to be robust over context switches

    Current implementation of spin_event_timeout can be interrupted by an
    IRQ or context switch after testing the condition, but before checking
    the timeout.  This can cause the loop to report a timeout when the
    condition actually became true in the middle.

    This patch adds one final check of the condition upon exit of the loop
    if the last test of the condition was still false.
