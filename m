Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418xnn23F7zDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:47:56 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id a141-v6so17073189oii.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 22:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180618140518.2920804-1-arnd@arndb.de>
 <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
 <87efh3hndq.fsf@igel.home>
In-Reply-To: <87efh3hndq.fsf@igel.home>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 19 Jun 2018 07:47:41 +0200
Message-ID: <CA+7wUsx+M1PE_ZcyT0JokY3r8hFLZfufUyFGX7kYX-fAZ524Fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mac: fix rtc read functions
To: schwab@linux-m68k.org
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, gerg@linux-m68k.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org,
 Meelis Roos <mroos@linux.ee>,
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

On Mon, Jun 18, 2018 at 10:04 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jun 18 2018, Mathieu Malaterre <malat@debian.org> wrote:
>
> > Sadly, trying again today does not work anymore. Adding some printk
> > just before WARN_ON:
> >
> > +printk(KERN_ERR " rtc DBG pmu_get_time1: %lld %d %lld \n", now,
> > RTC_OFFSET, now - RTC_OFFSET );
> > +printk(KERN_ERR " rtc DBG pmu_get_time2: %x %x %x %x %d \n",
> > req.reply[0], req.reply[1], req.reply[2], req.reply[3] ,
> > req.reply_len);
> >
> > leads to:
> >
> > [    0.000000]  rtc DBG pmu_get_time1: 14096662 2082844800 -2068748138
> > [    0.000000]  rtc DBG pmu_get_time2: 0 d7 19 16 4
>
> A good value would have 0xd7 in the first byte.  The problem is that
> pmu_set_rtc_time is also broken, and leads to an invalid time value
> stored in the RTC.  Since pmu_request is a varargs function passing
> values of type time64_t without casting won't work.
>
> You need to reset your RTC before you can continue.

Indeed that was silly, I was not paying attention. I'll try again tonight.

> I think the right fix is to change nowtime in pmu_set_rtc_time and
> cuda_set_rtc_time back to unsigned int (or to u32).
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
