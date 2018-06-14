Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416Ch96D7qzF0Pd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 05:03:37 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id h79-v6so6642416oig.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 12:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUswNnhB3=_Z0cbeAzDrcHZr=xg_nE5uUZuPXEk2RKNaABA@mail.gmail.com>
 <CAK8P3a3khJexs5FMzvn2+askoT8T1r-0eK6VAcZV3mQ9FPrc3w@mail.gmail.com>
In-Reply-To: <CAK8P3a3khJexs5FMzvn2+askoT8T1r-0eK6VAcZV3mQ9FPrc3w@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 14 Jun 2018 21:03:22 +0200
Message-ID: <CA+7wUsyy7tC7k1FT-ZpS=wW_NQ=PnYjTj0R-hbHuFY5m+55+RQ@mail.gmail.com>
Subject: Re: powerpc: use time64_t in read_persistent_clock
To: Arnd Bergmann <arnd@arndb.de>
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

On Thu, Jun 14, 2018 at 1:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 13, 2018 at 10:24 PM, Mathieu Malaterre <malat@debian.org> wrote:
> > Arnd,
> >
> > In 5bfd643583b2e I can see that you changed:
> >
> > $ git show 5bfd643583b2e -- arch/powerpc/platforms/powermac/time.c
> > [...]
> >  #ifdef CONFIG_ADB_PMU
> > -static unsigned long pmu_get_time(void)
> > +static time64_t pmu_get_time(void)
> >  {
> >         struct adb_request req;
> > -       unsigned int now;
> > +       time64_t now;
> >
> >         if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
> >                 return 0;
> > @@ -160,10 +151,10 @@ static unsigned long pmu_get_time(void)
> >                        req.reply_len);
> >         now = (req.reply[0] << 24) + (req.reply[1] << 16)
> >                 + (req.reply[2] << 8) + req.reply[3];
> > -       return ((unsigned long)now) - RTC_OFFSET;
> > +       return now - RTC_OFFSET;
> >  }
> > [...]
> >
> > As far as I can tell the old function would never return a negative
> > value and rely on unsigned long roll over. Now I am seeing negative
> > value being returned and it seems to break later on in the rtc
> > library.
> >
> > Could you comment why you removed the cast to (unsigned long) in your commit ?
>
> I'm sorry my patch caused a regression. Even with your bug report
> it took me a while to see what exactly went wrong, and how I got
> mixed up the integer conversion rules.
>
> I mistakenly assume that fiven
>
>        long long now;
>        unsigned char reply[4];
>        now = reply[0] << 24;
>
> we would always end up with a positive number, but since reply[0] is
> promoted to a signed integer, the right-hand side of the assignment
> ends up as a negative number for the usual contents of the RTC.

Ah right. My diagnosis was invalid.

> Can you confirm that this patch addresses your problem?

Yes !

Before:
[    5.986710] rtc-generic rtc-generic: hctosys: unable to read the
hardware clock

After:
[    5.579611] rtc-generic rtc-generic: setting system clock to
2018-06-14 18:57:00 UTC (1529002620)

So for the above:

Tested-by: Mathieu Malaterre <malat@debian.org>

> diff --git a/arch/powerpc/platforms/powermac/time.c
> b/arch/powerpc/platforms/powermac/time.c
> index 7c968e46736f..a7fdcd3051f9 100644
> --- a/arch/powerpc/platforms/powermac/time.c
> +++ b/arch/powerpc/platforms/powermac/time.c
> @@ -97,7 +97,7 @@ static time64_t cuda_get_time(void)
>         if (req.reply_len != 7)
>                 printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
>                        req.reply_len);
> -       now = (req.reply[3] << 24) + (req.reply[4] << 16)
> +       now = (u32)(req.reply[3] << 24) + (req.reply[4] << 16)
>                 + (req.reply[5] << 8) + req.reply[6];
>         return now - RTC_OFFSET;
>  }
> @@ -140,7 +140,7 @@ static time64_t pmu_get_time(void)
>         if (req.reply_len != 4)
>                 printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
>                        req.reply_len);
> -       now = (req.reply[0] << 24) + (req.reply[1] << 16)
> +       now = (u32)(req.reply[0] << 24) + (req.reply[1] << 16)
>                 + (req.reply[2] << 8) + req.reply[3];
>         return now - RTC_OFFSET;
>  }
>
> On a related note, we do have some freedom in how we want to
> interpret values beyond year 2038/2040 when the RTC does wrap
> around.
>
> - With the original code, we converted the time into a signed
>   32-bit integer based on the 1970 Unix epoch, converting RTC
>   years 2038 through 2040 into Linux years 1902 through 1904,
>   which doesn't seem very helpful.
>
> - With my fix above, we would interpret the numbers as documented,
>   with 2040 wrapping around to 1904.
>
> - If we want, we could reinterpret the 1904-1970 range as later
>   times between 2040 and 2106, like this:
>
> --- a/arch/powerpc/platforms/powermac/time.c
> +++ b/arch/powerpc/platforms/powermac/time.c
> @@ -88,7 +88,7 @@ long __init pmac_time_init(void)
>  static time64_t cuda_get_time(void)
>  {
>         struct adb_request req;
> -       time64_t now;
> +       u32 now;
>
>         if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
>                 return 0;
> @@ -132,7 +132,7 @@ static int cuda_set_rtc_time(struct rtc_time *tm)
>  static time64_t pmu_get_time(void)
>  {
>         struct adb_request req;
> -       time64_t now;
> +       u32 now;
>
>         if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
>                 return 0;
>
> On the upside, this would possibly extend the life of some machines
> by another 66 years, on the downside it might cause issues when
> an empty RTC battery causes the initial system time to be
> above the 32-bit TIME_T_MAX (instead of going back to 1904).

I would submit the first patch and add the above as comment. I doubt
anyone would still have a running system by then.

Thanks
