Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84114B6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 13:28:40 +1000 (EST)
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Dave Jones
	<davej@redhat.com>
In-Reply-To: <1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 13:28:30 +1000
Message-ID: <1309318110.32158.520.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before I comment on this last one, a quick Q. for Dave: Do you want to
handle this or should I merge it via powerpc.git ? (It depends on
another change to the arch code to expose the SCOM functions that it
uses, and that patch is going to be in my -next branch).

Now some remaining small nits:

On Fri, 2011-06-17 at 17:10 +0400, Dmitry Eremin-Solenikov wrote:
> Add simple cpufreq driver for Maple-based boards (ppc970fx evaluation
> kit and others). Driver is based on a cpufreq driver for 64-bit powermac
> boxes with all pmac-dependant features removed and simple cleanup
> applied.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/cpufreq/Kconfig         |    5 +
>  drivers/cpufreq/Kconfig.powerpc |    7 +
>  drivers/cpufreq/Makefile        |    5 +
>  drivers/cpufreq/maple-cpufreq.c |  314 +++++++++++++++++++++++++++++++++++++++

If we're going to have a Kconfig.powerpc, should we maybe just have a
powerpc subdirectory instead with the driver in it ?

I'm happy at some later point to try moving some of my other ones there.

 .../...

> +	/* Look for the powertune data in the device-tree */
> +	maple_pmode_data = of_get_property(cpunode, "power-mode-data", &psize);
> +	if (!maple_pmode_data) {
> +		DBG("No power-mode-data !\n");
> +		goto bail_noprops;
> +	}
> +	maple_pmode_max = psize / sizeof(u32) - 1;

Do you get that property in your device-tree ? Or have you modified your
firmware ? If that requires a modified firmware, you should probably put
at least a link indicating where to get it somewhere and display a nicer
error code.

Also this driver is specific to the Maple HW, you don't want it to kick
in and mess around on ... an Apple G5 for example. So stick somewhere a

	if (!machine_is(maple))
		return 0;

> +	printk(KERN_INFO "Registering G5 CPU frequency driver\n");

s/G5/Maple

> +	printk(KERN_INFO "Frequency method: SCOM, Voltage method: none\n");

This is useless.

Cheers,
Ben.
