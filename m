Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 131FF1A0B4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 20:35:57 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 "linux-arm-kernel\@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Kyle McMartin <kyle@mcmartin.ca>, RTCLINUX <rtc-linux@googlegroups.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] rtc: generic: allow building on all architectures
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
 <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
Date: Wed, 02 Mar 2016 10:28:40 +0100
In-Reply-To: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
 (Geert Uytterhoeven's message of "Wed, 2 Mar 2016 09:57:27 +0100")
Message-ID: <mvmwpplns8n.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> +#else
>> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
>> +#endif
>>
>>  static int __init generic_rtc_probe(struct platform_device *dev)
>>  {
>>         struct rtc_device *rtc;
>> +       const struct rtc_class_ops *ops;
>> +
>> +       ops = dev_get_platdata(&dev->dev);
>> +       if (!ops)
>> +               ops = &generic_rtc_ops;
>
> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
> undefined behavior?

Yes, that is guaranteed, the operations cancel each other (6.5.3.2#3: If
the operand is the result of a unary * operator, neither that operator
nor the & operator is evaluated and the result is as if both were
omitted).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
