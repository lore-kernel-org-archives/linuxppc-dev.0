Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC48C1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 21:56:28 +1000 (AEST)
Date: Wed, 15 Jul 2015 13:55:53 +0200 (CEST)
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
In-Reply-To: <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1507151345060.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
 <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
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

On Wed, 15 Jul 2015, Baolin Wang wrote:

> On 15 July 2015 at 18:31, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Wed, 15 Jul 2015, Baolin Wang wrote:
> >
> >> The cputime_to_timespec() and timespec_to_cputime() functions are
> >> not year 2038 safe on 32bit systems due to that the struct timepsec
> >> will overflow in 2038 year.
> >
> > And how is this relevant? cputime is not based on wall clock time at
> > all. So what has 2038 to do with cputime?
> >
> > We want proper explanations WHY we need such a change.
> 
> When converting the posix-cpu-timers, it call the
> cputime_to_timespec() function. Thus it need a conversion for this
> function.

There is no requirement to convert posix-cpu-timers on their own. We
need to adopt the posix cpu timers code because it shares syscalls
with the other posix timers, but that still does not explain why we
need these functions.

> You can see that conversion in patch "posix-cpu-timers: Convert to
> y2038 safe callbacks" from
> https://git.linaro.org/people/baolin.wang/upstream_0627.git.

I do not care about your random git tree. I care about proper
changelogs. Your changelogs are just a copied boilerplate full of
errors.

Thanks,

	tglx
