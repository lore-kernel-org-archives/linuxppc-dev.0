Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73CA71A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:39:18 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id l127so18784890iof.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Mar 2016 01:39:18 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <mvmwpplns8n.fsf@hawking.suse.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
 <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
 <mvmwpplns8n.fsf@hawking.suse.de>
Date: Wed, 2 Mar 2016 10:39:15 +0100
Message-ID: <CAMuHMdX2Jc4dT5omKmiie7GK+xDYDgJwm34hwANx3HzHt7LzxA@mail.gmail.com>
Subject: Re: [PATCH 1/6] rtc: generic: allow building on all architectures
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Kyle McMartin <kyle@mcmartin.ca>,
 RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 2, 2016 at 10:28 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>>> +#else
>>> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
>>> +#endif
>>>
>>>  static int __init generic_rtc_probe(struct platform_device *dev)
>>>  {
>>>         struct rtc_device *rtc;
>>> +       const struct rtc_class_ops *ops;
>>> +
>>> +       ops = dev_get_platdata(&dev->dev);
>>> +       if (!ops)
>>> +               ops = &generic_rtc_ops;
>>
>> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
>> undefined behavior?
>
> Yes, that is guaranteed, the operations cancel each other (6.5.3.2#3: If
> the operand is the result of a unary * operator, neither that operator
> nor the & operator is evaluated and the result is as if both were
> omitted).

Thanks for confirming.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
