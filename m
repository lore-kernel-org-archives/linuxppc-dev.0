Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CF22DDF52
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 12:57:07 +1000 (EST)
Date: Sat, 28 Apr 2007 22:50:21 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070429025021.GC2781@isilmar.linta.de>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<20070427054601.GB7755@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070427054601.GB7755@lixom.net>
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, paulus@samba.org, arnd@arndb.de,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Apr 27, 2007 at 12:46:01AM -0500, Olof Johansson wrote:
> +	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);

(u32) or (32*) ?

> +	cur_astate = get_cur_astate(policy->cpu);

May the different cores have different settings at initalization? e.g.

core 0:		freq A
core 1:		freq B

with (freq B > freq A)? If so, cur_astate is set wrongly, as the _effective_
frequency would be freq B, right?

> +#ifndef CONFIG_PPC_PASEMI_CPUFREQ
> +	printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
> +	current_mode = 0;
> +#endif
> +

This confuses me a bit -- does something else than cpufreq not work if
cpufreq is disabled?


Overall, the patch looks good to me.

	Dominik
