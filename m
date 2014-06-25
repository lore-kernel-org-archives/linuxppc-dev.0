Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 2B8631A000E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 02:05:26 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14486-07 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 25 Jun 2014 17:05:23 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: =?Windows-1252?Q?=27Uwe_Kleine-K=F6nig=27?=
 <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH v2] sched: Fix compiler warnings
Date: Wed, 25 Jun 2014 16:04:43 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17265E10@AcuExch.aculab.com>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de> <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de> <53AAE4D2.5020104@roeck-us.net>
 <063D6719AE5E284EB5DD2968C1650D6D17265D81@AcuExch.aculab.com>
 <20140625155259.GQ14781@pengutronix.de>
In-Reply-To: <20140625155259.GQ14781@pengutronix.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paul
 Mackerras <paulus@samba.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, 'Guenter Roeck' <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Uwe Kleine-K=F6nig=20
> Hello,
>=20
> On Wed, Jun 25, 2014 at 03:40:28PM +0000, David Laight wrote:
> > From: Guenter Roeck
> > > Actually turns out one can use __attribute_const__, and it is
> > >
> > > 	static inline int __attribute_const__ cpu_corepower_flags(void)
> > >
> > > which turns out to be widely used.
> > >
> > > I'll change that and resubmit after testing.
> >
> > You don't need to tell the compiler that for an inline function.
> I didn't check for the functions in question here, but in general your
> statement is wrong.
>=20
> For example:
>=20
> static inline unsigned int __attribute_const__ read_cpuid_id(void)
> {
> 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
> }
>=20
> from arch/arm/include/asm/cputype.h. The V7M_SCB_CPUID register never
> changes, but there is no way gcc can deduce that.

Hmm... it all rather depends on the order of the optimisations and=20
inlining.

I've tried to use 'restrict' on the parameters to an inline function
in an attempt to get 'noalias' - but the reverse inference never
seems to be applied.

	David
