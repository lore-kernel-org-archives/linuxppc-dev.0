Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 890A72C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 07:41:30 +1100 (EST)
Date: Wed, 5 Feb 2014 21:39:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
In-Reply-To: <52E0D575.5050702@linaro.org>
Message-ID: <alpine.DEB.2.02.1402052138170.24986@ionos.tec.linutronix.de>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0D575.5050702@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, Kevin Hilman <khilman@deeprootsystems.com>,
 linux@lists.openrisc.net, Sekhar Nori <nsekhar@ti.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Yijing Wang <wangyijing@huawei.com>, Daniel Walker <dwalker@fifo99.com>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Jeff Dike <jdike@addtoit.com>,
 Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org,
 John Stultz <john.stultz@linaro.org>,
 user-mode-linux-user@lists.sourceforge.net, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 davinci-linux-open-source@linux.davincidsp.com,
 Michal Simek <monstr@monstr.eu>, Jim Cromie <jim.cromie@gmail.com>,
 microblaze-uclinux@itee.uq.edu.au, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Jan 2014, Daniel Lezcano wrote:
> On 01/23/2014 08:12 AM, Yijing Wang wrote:
> > Currently, clocksource_register() and __clocksource_register_scale()
> > functions always return 0, it's pointless, make functions void.
> > And remove the dead code that check the clocksource_register_hz()
> > return value.
> > 
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> Well, do we really want to change all these files to not take care of a return
> value ? What about is we have to check it again later ?
> 
> I would recommend to investigate __clocksource_register_scale and the
> underneath functions if there is not an error to be returned in the call stack
> somewhere which is ignored today.
> 
> The same applies for clocksource_register.

There is really no point in making it fail. It's so low level that
anything more than a proper printk/BUG/WARN is overkill.

Thanks,

	tglx
