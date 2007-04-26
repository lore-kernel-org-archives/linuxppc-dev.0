Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id ACB00DDF5E
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 02:48:20 +1000 (EST)
Date: Thu, 26 Apr 2007 11:48:36 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070426164835.GA14149@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<200704261055.33739.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261055.33739.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, paulus@samba.org,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 10:55:33AM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Olof Johansson wrote:
> 
> > I chose not to do this as an of_platform driver since it doesn't fit
> > that well with the cpufreq driver model; having 3 levels of init/probe
> > functions is excessive.
> 
> <snip>
> 
> > +	dn = of_find_compatible_node(NULL, "sdc", "1682m-sdc");
> > +	if (!dn)
> > +		goto out;
> > +	err = of_address_to_resource(dn, 0, &res);
> > +	of_node_put(dn);
> > +	if (err)
> > +		goto out;
> > +	sdcasr_mapbase = ioremap(res.start + SDCASR_OFFSET, 0x2000);
> > +	if (!sdcasr_mapbase) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	dn = of_find_compatible_node(NULL, "gizmo", "1682m-gizmo");
> > +	if (!dn) {
> > +		err = -ENODEV;
> > +		goto out_unmap_sdcasr;
> > +	}
> > +	err = of_address_to_resource(dn, 0, &res);
> > +	of_node_put(dn);
> > +	if (err)
> > +		goto out_unmap_sdcasr;
> > +	sdcpwr_mapbase = ioremap(res.start, 0x1000);
> > +	if (!sdcpwr_mapbase) {
> > +		err = -EINVAL;
> > +		goto out_unmap_sdcasr;
> > +	}
> 
> What are sdc and gizmo anyway? If they are both only used for cpufreq, maybe the
> easiest way to do this with an of_platform_driver would be to have a single
> node that has two register ranges.

SDC is the system and debug controller, it contains a number of smaller
devices such as the PIC, the PMU (Gizmo), RNG, and various debug
features. Some already have drivers submitted, others will later on.

Unfortunately the setting of the current active state is done to an SDC
register, while information of the states is in the PMU, so access to
both is needed in the driver.

That doesn't change the fact that making this an of_platform driver
is excessive:

* module_init to register an of_platform driver
* of_platform walks the tree, calls probes
* of_platform driver probe code to register the cpufreq driver
* cpufreq calls it's registered drivers
* the cpufreq driver in turn will do the inits

Compare to:
* module_init registers cpufreq driver if machine_is_compatible()
* cpufreq calls it's registered drivers
* the cpufreq driver in turn will do the inits

Don't get me wrong, of_platform drivers are often convenient, but I
don't see it being a benefit to use them in this case.


-Olof
