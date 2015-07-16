Return-Path: <baolin.wang@linaro.org>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6CEA1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 12:22:45 +1000 (AEST)
Received: by ykax123 with SMTP id x123so53231350yka.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 19:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1507151345060.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
 <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
 <alpine.DEB.2.11.1507151345060.18576@nanos>
Date: Thu, 16 Jul 2015 10:22:43 +0800
Message-ID: <CAMz4kuKNVACNhwddXMyCqKGpOf_gsoHk=ZFZFuaY=8e4DCRwGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] cputime: Introduce
 cputime_to_timespec64()/timespec64_to_cputime()
From: Baolin Wang <baolin.wang@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: benh@kernel.crashing.org, Arnd Bergmann <arnd@arndb.de>,
 John Stultz <john.stultz@linaro.org>, peterz@infradead.org, paulus@samba.org,
 mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com,
 tj@kernel.org, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15 July 2015 at 19:55, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 15 Jul 2015, Baolin Wang wrote:
>
>> On 15 July 2015 at 18:31, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Wed, 15 Jul 2015, Baolin Wang wrote:
>> >
>> >> The cputime_to_timespec() and timespec_to_cputime() functions are
>> >> not year 2038 safe on 32bit systems due to that the struct timepsec
>> >> will overflow in 2038 year.
>> >
>> > And how is this relevant? cputime is not based on wall clock time at
>> > all. So what has 2038 to do with cputime?
>> >
>> > We want proper explanations WHY we need such a change.
>>
>> When converting the posix-cpu-timers, it call the
>> cputime_to_timespec() function. Thus it need a conversion for this
>> function.
>
> There is no requirement to convert posix-cpu-timers on their own. We
> need to adopt the posix cpu timers code because it shares syscalls
> with the other posix timers, but that still does not explain why we
> need these functions.
>

In posix-cpu-timers, it also defined some 'k_clock struct' variables,
and we need to convert the callbacks of the 'k_clock struct' which are
not year 2038 safe on 32bit systems. Some callbacks which need to
convert call the cputime_to_timespec() function, thus we also want to
convert the cputime_to_timespec() function to a year 2038 safe
function to make all them ready for the year 2038 issue.

>> You can see that conversion in patch "posix-cpu-timers: Convert to
>> y2038 safe callbacks" from
>> https://git.linaro.org/people/baolin.wang/upstream_0627.git.
>
> I do not care about your random git tree. I care about proper
> changelogs. Your changelogs are just a copied boilerplate full of
> errors.
>
> Thanks,
>
>         tglx



-- 
Baolin.wang
Best Regards
