Return-Path: <arndbergmann@gmail.com>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VzwX68H8zF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 00:26:20 +1000 (AEST)
Received: by mail-lj1-x242.google.com with SMTP id f1-v6so2636569ljc.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 07:26:20 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
 <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
 <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Jul 2018 16:26:16 +0200
Message-ID: <CAK8P3a3azDB5WsQWTKOSmXNqycTxz0qXtowS61_=zUsnMo+EXg@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Meelis Roos <mroos@linux.ee>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2018 at 3:49 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 18 Jul 2018, Arnd Bergmann wrote:

>>
>> -static long via_read_time(void)
>> +static time64_t via_read_time(void)
>>  {
>>         union {
>>                 __u8 cdata[4];
>> -               long idata;
>> +               __u32 idata;
>>         } result, last_result;
>> +       time64_t ret;
>
> ret isn't used.
>
>>         int count = 1;
>>
>>         via_pram_command(0x81, &last_result.cdata[3]);
>> @@ -279,12 +280,8 @@ static long via_read_time(void)
>>                 via_pram_command(0x89, &result.cdata[1]);
>>                 via_pram_command(0x8D, &result.cdata[0]);
>>
>> -               if (result.idata == last_result.idata) {
>> -                       if (result.idata < RTC_OFFSET)
>> -                               result.idata += 0x100000000ull;
>> -
>> -                       return result.idata - RTC_OFFSET;
>> -               }
>> +               if (result.idata == last_result.idata)
>> +                       return (time64_t(result.idata) - RTC_OFFSET);
>>
>
> Did you mean to write,
>
>                         return (time64_t)result.idata - RTC_OFFSET;
>
> ?

Right, I should have at least tried to build it again.

      Arnd
