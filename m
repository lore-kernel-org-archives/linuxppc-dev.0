Return-Path: <arndbergmann@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Bsnw5dBWzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 18:54:43 +1000 (AEST)
Received: by mail-lf0-x243.google.com with SMTP id q11-v6so7994920lfc.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 01:54:43 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.LNX.2.21.1806221455570.14@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <alpine.LNX.2.21.1806221455570.14@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Jun 2018 10:54:39 +0200
Message-ID: <CAK8P3a2chXVhz+UJ+ujg8QMqyMmJ4zGj9XKuFZ+MsJ=dGqb3eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>, Mathieu Malaterre <malat@debian.org>,
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

On Fri, Jun 22, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 19 Jun 2018, Arnd Bergmann wrote:
>
>> The real-time clock on m68k (and powerpc) mac systems uses an unsigned
>> 32-bit value starting in 1904, which overflows in 2040, about two years
>> later than everyone else, but this gets wrapped around in the Linux code
>> in 2038 already because of the deprecated usage of time_t and/or long in
>> the conversion.
>>
>> Getting rid of the deprecated interfaces makes it work until 2040 as
>> documented, and it could be easily extended by reinterpreting the
>> resulting time64_t as a positive number. For the moment, I'm adding a
>> WARN_ON() that triggers if we encounter a time before 1970 or after 2040
>> (the two are indistinguishable).
>>
>
> I really don't like the WARN_ON(), but I'd prefer to address that in a
> separate patch rather than impede the progress of this patch (or of this
> series, since 3/3 seems to be unrelated).
>
> BTW, have you considered using the same wrap-around test (i.e. YY < 70)
> that we use for the year register in the other RTC chips?

That wrap-around test would have the same effect as the my original
version (aside from the two bugs I now fixed), doing rougly

-        return time - RTC_OFFSET;
+        return (u32)(time - RTC_OFFSET);

or some other variation of that will give us an RTC that supports all dates
between 1970 and 2106. I don't think anyone so far had a strong
preference here, so I went with what Mathieu suggested and kept the
original Mac behavior, but added the WARN_ON().

>> This brings it in line with the corresponding code that we have on
>> powerpc macintosh.
>>
>
> Your recent patches to the Mac RTC routines (which are duplicated under
> arch/m68k and arch/powerpc) conflict with my recent patch that
> deduplicates the same code. So I will rebase and resubmit after someone
> merges these fixes.
>
> Apparently the PowerMac routines work now, which is sufficient testing for
> me; the PowerMac routines will get tested on m68k Macs when that code gets
> deduplicated again.

Sorry about introducing that conflict, and thanks for bearing with me on the
rebase. One thing to watch out for (if you haven't noticed already) is that the
powerpc version now depends on rtc_time64_to_tm/rtc_tm_to_time64 which
are only available if CONFIG_RTC_LIB is enabled but simplifies the code a
bit. I did not want to introduce that as a global dependency on m68k which
is rather limited on code size already, but it probably doesn't hurt to require
RTC_LIB on m68k-mac.

        Arnd
