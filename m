Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418XHL0gPmzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 23:38:37 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id i15-v6so24718634lfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 06:38:37 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CA+7wUsyy7tC7k1FT-ZpS=wW_NQ=PnYjTj0R-hbHuFY5m+55+RQ@mail.gmail.com>
References: <CA+7wUswNnhB3=_Z0cbeAzDrcHZr=xg_nE5uUZuPXEk2RKNaABA@mail.gmail.com>
 <CAK8P3a3khJexs5FMzvn2+askoT8T1r-0eK6VAcZV3mQ9FPrc3w@mail.gmail.com>
 <CA+7wUsyy7tC7k1FT-ZpS=wW_NQ=PnYjTj0R-hbHuFY5m+55+RQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Jun 2018 15:38:33 +0200
Message-ID: <CAK8P3a33E=mqfC10PoL4ySnj92Ni+crwnh-C5uu06-vmSe7sKA@mail.gmail.com>
Subject: Re: powerpc: use time64_t in read_persistent_clock
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Meelis Roos <mroos@linux.ee>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 14, 2018 at 9:03 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Thu, Jun 14, 2018 at 1:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Jun 13, 2018 at 10:24 PM, Mathieu Malaterre <malat@debian.org> wrote:
>
>> Can you confirm that this patch addresses your problem?
>
> Yes !
>
> Before:
> [    5.986710] rtc-generic rtc-generic: hctosys: unable to read the
> hardware clock
>
> After:
> [    5.579611] rtc-generic rtc-generic: setting system clock to
> 2018-06-14 18:57:00 UTC (1529002620)
>
> So for the above:
>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Thanks a lot!

>> --- a/arch/powerpc/platforms/powermac/time.c
>> +++ b/arch/powerpc/platforms/powermac/time.c
>> @@ -88,7 +88,7 @@ long __init pmac_time_init(void)
>>  static time64_t cuda_get_time(void)
>>  {
>>         struct adb_request req;
>> -       time64_t now;
>> +       u32 now;
>>
>>         if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
>>                 return 0;
>> @@ -132,7 +132,7 @@ static int cuda_set_rtc_time(struct rtc_time *tm)
>>  static time64_t pmu_get_time(void)
>>  {
>>         struct adb_request req;
>> -       time64_t now;
>> +       u32 now;
>>
>>         if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
>>                 return 0;
>>
>> On the upside, this would possibly extend the life of some machines
>> by another 66 years, on the downside it might cause issues when
>> an empty RTC battery causes the initial system time to be
>> above the 32-bit TIME_T_MAX (instead of going back to 1904).
>
> I would submit the first patch and add the above as comment. I doubt
> anyone would still have a running system by then.

I was about to send a similar patch to the first one for m68k macs, which have
basically the same code. My patch had the same bug, so I'm glad I had
not sent it yet, but I also noticed that I made the opposite decision on m68k
as that code had already been using 'unsigned long' in the conversion (but
then of course would wrap it during the conversion to 'time_t). I've picked
the same approach for both now, using the 1904..2040 range.

       Arnd
