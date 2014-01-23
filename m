Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 2BBAD2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 22:40:43 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 31843-06 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 23 Jan 2014 11:40:38 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tony Prisk' <linux@prisktech.co.nz>, Yijing Wang <wangyijing@huawei.com>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 2/2] clocksource: Make clocksource register functions void
Date: Thu, 23 Jan 2014 11:40:35 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D46489C@AcuExch.aculab.com>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0C889.6000106@prisktech.co.nz>
In-Reply-To: <52E0C889.6000106@prisktech.co.nz>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "x86@kernel.org" <x86@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>,
 "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
 Sekhar Nori <nsekhar@ti.com>, Michal Simek <monstr@monstr.eu>,
 Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Richard
 Weinberger <richard@nod.at>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 David Brown <davidb@codeaurora.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike
 Frysinger <vapier@gentoo.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Jeff Dike <jdike@addtoit.com>,
 "davinci-linux-open-source@linux.davincidsp.com"
 <davinci-linux-open-source@linux.davincidsp.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "user-mode-linux-user@lists.sourceforge.net"
 <user-mode-linux-user@lists.sourceforge.net>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Jim Cromie <jim.cromie@gmail.com>,
 Hanjun Guo <guohanjun@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Bryan
 Huntsman <bryanh@codeaurora.org>, "uclinux-dist-devel@blackfin.uclinux.org"
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

From: Linuxppc-dev Tony Prisk
> On 23/01/14 20:12, Yijing Wang wrote:
> > Currently, clocksource_register() and __clocksource_register_scale()
> > functions always return 0, it's pointless, make functions void.
> > And remove the dead code that check the clocksource_register_hz()
> > return value.
> ......
> > -static inline int clocksource_register_hz(struct clocksource *cs, u32 =
hz)
> > +static inline void clocksource_register_hz(struct clocksource *cs, u32=
 hz)
> >   {
> >   	return __clocksource_register_scale(cs, 1, hz);
> >   }
>=20
> This doesn't make sense - you are still returning a value on a function
> declared void, and the return is now from a function that doesn't return
> anything either ?!?!
> Doesn't this throw a compile-time warning??

It depends on the compiler.
Recent gcc allow it.
I don't know if it is actually valid C though.

There is no excuse for it on lines like the above though.

	David
