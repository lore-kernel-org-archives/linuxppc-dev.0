Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D3A0DDF40
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 02:08:01 +1000 (EST)
Date: Thu, 26 Apr 2007 20:07:32 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH][RFC] i2c: adds support for i2c bus on 8xx
Message-ID: <20070426200732.529eddc7@vitb.ru.mvista.com>
In-Reply-To: <20070426175438.391157a1@hyperion.delvare>
References: <20070420082714.4f10f186@localhost.localdomain>
	<20070421095707.6b42a312@hyperion.delvare>
	<20070422152937.7332fc31@localhost.localdomain>
	<20070423111950.129856eb@hyperion.delvare>
	<462F8A82.40604@kernel.crashing.org>
	<20070426175438.391157a1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Apr 2007 17:54:38 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Vitaly,
> 
> On Wed, 25 Apr 2007 21:06:10 +0400, Vitaly Bordug wrote:
> > Jean Delvare wrote:
> > >>>> +/* Structure for a device driver */
> > >>>> +static struct device_driver i2c_rpx_driver = {
> > >>>> +	.name = "fsl-i2c-cpm",
> > >>>> +	.bus = &platform_bus_type,
> > >>>> +	.probe = i2c_rpx_probe,
> > >>>> +	.remove = i2c_rpx_remove,
> > >>>> +};
> > >>>>         
> > >>> Why don't you declare it as a struct platform_driver, register it with
> > >>> platform_driver_register() and unregister it with
> > >>> platform_driver_unregister()?
> > >>>       
> > >> Well. This stuff belongs to CPM1, of the mpc8xx family, but the
> > >> target boards are different, and they may/should provide board
> > >> specific inits and filling of platform data. With
> > >> platform_driver_register we may end up with ifdef stuff here
> > >> (which is evil).
> > >>     
> > >
> > > I don't follow you here, sorry. Platform devices are declared by
> > > board-specific code which can include all the needed initialization.
> > > And device-specific data can be carried to the platform driver for
> > > further use. The platform device/driver infrastructure is meant to
> > > handle that kind of situation, so there really is no excuse that I can
> > > see not to use it. i2c-omap and i2c-mpc use it. As a matter of fact you
> > > _are_ declaring a platform driver (.bus = &platform_bus_type), just not
> > > using the standard way.
> > >
> > >   
> > Standard way here - platform devices got registered from elsewhere - 
> > from arch/ppc/ppc_sys.c if arch/ppc or from 
> > arch/powerpc/sysdev/fsl_soc.c if powerpc.
> > Every way (powerpc is more flexible since is pulling the information 
> > from the firmware-passed device tree) fills in the resources and 
> > platform data, and
> > is capable with device/drive bound you are talking about.
> 
> This doesn't explain why you can't use platform_driver_register(),
> which is the right way to register a platform driver.

Ahm, I clearly confused myself (with device/driver stuff), sorry.

Anyway I think we'll look at of_device for this, to reduce extract from OF->insert platform device overhead.


-- 
Sincerely, 
Vitaly
