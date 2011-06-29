Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06A8AB6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 18:54:38 +1000 (EST)
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
In-Reply-To: <BANLkTimJD3U1kRkDKVomGVriykwqLBQasA@mail.gmail.com>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
	<BANLkTimJD3U1kRkDKVomGVriykwqLBQasA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 18:54:30 +1000
Message-ID: <1309337670.14501.69.camel@pasglop>
Mime-Version: 1.0
Cc: Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-29 at 12:40 +0400, Dmitry Eremin-Solenikov wrote:
> On 6/29/11, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > Before I comment on this last one, a quick Q. for Dave: Do you want to
> > handle this or should I merge it via powerpc.git ? (It depends on
> > another change to the arch code to expose the SCOM functions that it
> > uses, and that patch is going to be in my -next branch).
> >
> > Now some remaining small nits:
> >
> > On Fri, 2011-06-17 at 17:10 +0400, Dmitry Eremin-Solenikov wrote:
> >> Add simple cpufreq driver for Maple-based boards (ppc970fx evaluation
> >> kit and others). Driver is based on a cpufreq driver for 64-bit powermac
> >> boxes with all pmac-dependant features removed and simple cleanup
> >> applied.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >>  drivers/cpufreq/Kconfig         |    5 +
> >>  drivers/cpufreq/Kconfig.powerpc |    7 +
> >>  drivers/cpufreq/Makefile        |    5 +
> >>  drivers/cpufreq/maple-cpufreq.c |  314
> >> +++++++++++++++++++++++++++++++++++++++
> >
> > If we're going to have a Kconfig.powerpc, should we maybe just have a
> > powerpc subdirectory instead with the driver in it ?
> >
> > I'm happy at some later point to try moving some of my other ones there.
> 
> As Dave also isn't sure about subdirs, should I create cpufreq/powerpc
> directory,
> or not?

Don't bother, I can do it all at once if/when I chose to move the
powermac stuff there.

> > Do you get that property in your device-tree ? Or have you modified your
> > firmware ? If that requires a modified firmware, you should probably put
> > at least a link indicating where to get it somewhere and display a nicer
> > error code.
> 
> PIBS firmware (used on PPC970FX devkit/original Maple-D board) generates
> this property, if the board is started with dual CPUs (it can also be started
> with only one CPU selected). On the other hand SLOF firmware (used
> on JS2x blade servers) doesn't generate this property. It can be adapted
> however to generate it.

Ok.

> > Also this driver is specific to the Maple HW, you don't want it to kick
> > in and mess around on ... an Apple G5 for example. So stick somewhere a
> >
> > 	if (!machine_is(maple))
> > 		return 0;
> >
> >> +	printk(KERN_INFO "Registering G5 CPU frequency driver\n");
> >
> > s/G5/Maple
> 
> Hmmm. I'm actually thinking about doing it the other way: as this driver
> is mostly c&p of PowerMac G5 driver, as we are moving those from
> arch/powerpc to drivers/cpufreq, maybe I should merge two drivers (this
> one with cpufreq_64 from powermac)?

If you feel like it :-) The powermac one has quite a bit more plumbing
for voltage control etc... but it does make sense in the long run.

Maybe start with getting that maple driver in, and -then- merge ?

> >> +	printk(KERN_INFO "Frequency method: SCOM, Voltage method: none\n");
> >
> > This is useless.
> 
> Leftover from powermac thing.

Cheers,
Ben.
