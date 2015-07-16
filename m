Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FDDE1A1999
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 20:45:00 +1000 (AEST)
Date: Thu, 16 Jul 2015 12:43:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
cc: benh@kernel.crashing.org, Arnd Bergmann <arnd@arndb.de>,
 John Stultz <john.stultz@linaro.org>, peterz@infradead.org,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com, linux390@de.ibm.com, rth@twiddle.net,
 riel@redhat.com, cl@linux.com, tj@kernel.org,
 =?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH 6/6] cputime: Introduce
 cputime_to_timespec64()/timespec64_to_cputime()
In-Reply-To: <CAMz4kuKNVACNhwddXMyCqKGpOf_gsoHk=ZFZFuaY=8e4DCRwGw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1507161230400.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
 <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
 <alpine.DEB.2.11.1507151345060.18576@nanos>
 <CAMz4kuKNVACNhwddXMyCqKGpOf_gsoHk=ZFZFuaY=8e4DCRwGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Jul 2015, Baolin Wang wrote:
> On 15 July 2015 at 19:55, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 15 Jul 2015, Baolin Wang wrote:
> >
> >> On 15 July 2015 at 18:31, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > On Wed, 15 Jul 2015, Baolin Wang wrote:
> >> >
> >> >> The cputime_to_timespec() and timespec_to_cputime() functions are
> >> >> not year 2038 safe on 32bit systems due to that the struct timepsec
> >> >> will overflow in 2038 year.
> >> >
> >> > And how is this relevant? cputime is not based on wall clock time at
> >> > all. So what has 2038 to do with cputime?
> >> >
> >> > We want proper explanations WHY we need such a change.
> >>
> >> When converting the posix-cpu-timers, it call the
> >> cputime_to_timespec() function. Thus it need a conversion for this
> >> function.
> >
> > There is no requirement to convert posix-cpu-timers on their own. We
> > need to adopt the posix cpu timers code because it shares syscalls
> > with the other posix timers, but that still does not explain why we
> > need these functions.
> >
> 
> In posix-cpu-timers, it also defined some 'k_clock struct' variables,
> and we need to convert the callbacks of the 'k_clock struct' which are
> not year 2038 safe on 32bit systems. Some callbacks which need to
> convert call the cputime_to_timespec() function, thus we also want to
> convert the cputime_to_timespec() function to a year 2038 safe
> function to make all them ready for the year 2038 issue.

You are not getting it at all.

1) We need to change k_clock callbacks due to 2038 issues

2) posix cpu timers implement affected callbacks

3) posix cpu timers themself and cputime are NOT affected by 2038

So we have 2 options to change the code in posix cpu timers:

   A) Do the timespec/timespec64 conversion in the posix cpu timer
      callbacks and leave the cputime functions untouched.

   B) Implement cputime/timespec64 functions to avoid #A

   If you go for #B, you need to provide a reasonable explanation why
   it is better than #A. And that explanation has absolutely nothing
   to do with 2038 safety.

Not everything is a 2038 issue, just because the only tool you have is
a timespec64.

Thanks,

	tglx


   
