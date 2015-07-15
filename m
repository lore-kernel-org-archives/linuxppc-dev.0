Return-Path: <baolin.wang@linaro.org>
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61ECB1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 21:42:29 +1000 (AEST)
Received: by ykeo3 with SMTP id o3so33384942yke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 04:42:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1507151226210.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
Date: Wed, 15 Jul 2015 19:42:26 +0800
Message-ID: <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
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

On 15 July 2015 at 18:31, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 15 Jul 2015, Baolin Wang wrote:
>
>> The cputime_to_timespec() and timespec_to_cputime() functions are
>> not year 2038 safe on 32bit systems due to that the struct timepsec
>> will overflow in 2038 year.
>
> And how is this relevant? cputime is not based on wall clock time at
> all. So what has 2038 to do with cputime?
>
> We want proper explanations WHY we need such a change.

When converting the posix-cpu-timers, it call the
cputime_to_timespec() function. Thus it need a conversion for this
function.
You can see that conversion in patch "posix-cpu-timers: Convert to
y2038 safe callbacks" from
https://git.linaro.org/people/baolin.wang/upstream_0627.git.
And I also will explain this in the changelog. Thanks for your comments.

>
> Thanks,
>
>         tglx
>
>


-- 
Baolin.wang
Best Regards
