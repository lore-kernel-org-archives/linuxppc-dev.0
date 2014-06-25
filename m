Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C989A1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 00:50:42 +1000 (EST)
Date: Wed, 25 Jun 2014 16:49:55 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] sched: Fix compiler warnings
Message-ID: <20140625144955.GP14781@pengutronix.de>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de>
 <53AADC63.8080106@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <53AADC63.8080106@roeck-us.net>
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

Hello Guenter,

On Wed, Jun 25, 2014 at 07:27:47AM -0700, Guenter Roeck wrote:
> >Maybe the author's intention was:
> >
> >	static inline int cpu_corepower_flags(void) __attribute__((const));
> >
> >?
> >This specifies that the function has no side effects and the return value
> >only depends on the (here non-existing) function arguments.
> >
> 
> Possibly, but either I am missing something or this doesn't compile.
You need to do a separate declaration:

	static inline int cpu_corepower_flags(void) __attribute__((const));
	static inline int cpu_corepower_flags(void)
	{
		...

Does this help?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
