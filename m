Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 01769DDEF1
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 14:41:57 +1000 (EST)
Date: Sat, 28 Apr 2007 23:42:37 -0500
To: paulus@samba.org, linuxppc-dev@ozlabs.org, egor@pasemi.com,
	arnd@arndb.de, cpufreq@lists.linux.org.uk
Subject: Re: [PATCH v3] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070429044237.GB7478@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<20070427054601.GB7755@lixom.net>
	<20070429025021.GC2781@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070429025021.GC2781@isilmar.linta.de>
From: olof@lixom.net (Olof Johansson)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 28, 2007 at 10:50:21PM -0400, Dominik Brodowski wrote:
> Hi,
> 
> On Fri, Apr 27, 2007 at 12:46:01AM -0500, Olof Johansson wrote:
> > +	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
> 
> (u32) or (32*) ?
> 
> > +	cur_astate = get_cur_astate(policy->cpu);
> 
> May the different cores have different settings at initalization? e.g.
> 
> core 0:		freq A
> core 1:		freq B
> 
> with (freq B > freq A)? If so, cur_astate is set wrongly, as the _effective_
> frequency would be freq B, right?

Firmware normally sets only cpu 0 (since cpu 1 isn't started until after
linux is loaded and started). So it'll works well by default.

> > +#ifndef CONFIG_PPC_PASEMI_CPUFREQ
> > +	printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
> > +	current_mode = 0;
> > +#endif
> > +
> 
> This confuses me a bit -- does something else than cpufreq not work if
> cpufreq is disabled?

After doze, we come back out in astate 0, so we need to raise it back
up. We do so by calling the restore_astate() function. If we don't have
it, and use idle=doze, we'll end up with a cpu running at astate 0 and
no way to raise it.

> Overall, the patch looks good to me.


Thanks,

-Olof
