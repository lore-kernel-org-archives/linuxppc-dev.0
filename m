Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 02CAC2C03C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 07:41:55 +1100 (EST)
Date: Wed, 5 Feb 2014 21:40:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 2/2] clocksource: Make clocksource register functions void
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
Message-ID: <alpine.DEB.2.02.1402052139560.24986@ionos.tec.linutronix.de>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0C889.6000106@prisktech.co.nz>
 <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "x86@kernel.org" <x86@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>,
 "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
 Sekhar Nori <nsekhar@ti.com>, Michal Simek <monstr@monstr.eu>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Yijing Wang <wangyijing@huawei.com>,
 Daniel Walker <dwalker@fifo99.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Richard Weinberger <richard@nod.at>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Tony Lindgren <tony@atomide.com>,
 Ingo Molnar <mingo@redhat.com>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 David Brown <davidb@codeaurora.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Jeff Dike <jdike@addtoit.com>,
 "davinci-linux-open-source@linux.davincidsp.com"
 <davinci-linux-open-source@linux.davincidsp.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 "user-mode-linux-user@lists.sourceforge.net"
 <user-mode-linux-user@lists.sourceforge.net>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Jim Cromie <jim.cromie@gmail.com>,
 Hanjun Guo <guohanjun@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, 'Tony Prisk' <linux@prisktech.co.nz>,
 Bryan Huntsman <bryanh@codeaurora.org>,
 "uclinux-dist-devel@blackfin.uclinux.org"
 <uclinux-dist-devel@blackfin.uclinux.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yijing,

On Thu, 23 Jan 2014, David Laight wrote:

> From: Linuxppc-dev Tony Prisk
> > On 23/01/14 20:12, Yijing Wang wrote:
> > > Currently, clocksource_register() and __clocksource_register_scale()
> > > functions always return 0, it's pointless, make functions void.
> > > And remove the dead code that check the clocksource_register_hz()
> > > return value.
> > ......
> > > -static inline int clocksource_register_hz(struct clocksource *cs, u32 hz)
> > > +static inline void clocksource_register_hz(struct clocksource *cs, u32 hz)
> > >   {
> > >   	return __clocksource_register_scale(cs, 1, hz);
> > >   }
> > 
> > This doesn't make sense - you are still returning a value on a function
> > declared void, and the return is now from a function that doesn't return
> > anything either ?!?!
> > Doesn't this throw a compile-time warning??
> 
> It depends on the compiler.
> Recent gcc allow it.
> I don't know if it is actually valid C though.
> 
> There is no excuse for it on lines like the above though.

Can you please resend with that fixed against 3.14-rc1 ?

Thanks,

	tglx
