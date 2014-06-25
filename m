Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 239E91A000E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 01:53:38 +1000 (EST)
Date: Wed, 25 Jun 2014 17:52:59 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2] sched: Fix compiler warnings
Message-ID: <20140625155259.GQ14781@pengutronix.de>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de>
 <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de>
 <53AAE4D2.5020104@roeck-us.net>
 <063D6719AE5E284EB5DD2968C1650D6D17265D81@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17265D81@AcuExch.aculab.com>
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 'Guenter Roeck' <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Jun 25, 2014 at 03:40:28PM +0000, David Laight wrote:
> From: Guenter Roeck
> > Actually turns out one can use __attribute_const__, and it is
> > 
> > 	static inline int __attribute_const__ cpu_corepower_flags(void)
> > 
> > which turns out to be widely used.
> > 
> > I'll change that and resubmit after testing.
> 
> You don't need to tell the compiler that for an inline function.
I didn't check for the functions in question here, but in general your
statement is wrong.

For example:

static inline unsigned int __attribute_const__ read_cpuid_id(void)
{
	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
}

from arch/arm/include/asm/cputype.h. The V7M_SCB_CPUID register never
changes, but there is no way gcc can deduce that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
