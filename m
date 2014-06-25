Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id CFDC31A000E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 01:03:59 +1000 (EST)
Message-ID: <53AAE4D2.5020104@roeck-us.net>
Date: Wed, 25 Jun 2014 08:03:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] sched: Fix compiler warnings
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de> <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de>
In-Reply-To: <20140625144955.GP14781@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 07:49 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Wed, Jun 25, 2014 at 07:27:47AM -0700, Guenter Roeck wrote:
>>> Maybe the author's intention was:
>>>
>>> 	static inline int cpu_corepower_flags(void) __attribute__((const));
>>>
>>> ?
>>> This specifies that the function has no side effects and the return value
>>> only depends on the (here non-existing) function arguments.
>>>
>>
>> Possibly, but either I am missing something or this doesn't compile.
> You need to do a separate declaration:
>
> 	static inline int cpu_corepower_flags(void) __attribute__((const));
> 	static inline int cpu_corepower_flags(void)
> 	{
> 		...

Actually turns out one can use __attribute_const__, and it is

	static inline int __attribute_const__ cpu_corepower_flags(void)

which turns out to be widely used.

I'll change that and resubmit after testing.

Guenter
