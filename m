Return-Path: <olof@lixom.net>
Date: Fri, 27 Apr 2007 00:32:20 -0500
To: Akinobu Mita <mita@fixstars.com>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: cbe_cpufreq cleanup and crash fix
Message-ID: <20070427053220.GA7718@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704260147.35878.arnd@arndb.de>
	<20070426065644.GA24799@lixom.net>
	<20070426230754.GB30000@lixom.net>
	<20070427052206.GA5486@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070427052206.GA5486@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2007 at 02:22:06PM +0900, Akinobu Mita wrote:
> On Thu, Apr 26, 2007 at 06:07:54PM -0500, Olof Johansson wrote:
> > @@ -303,6 +303,9 @@ static int __init cbe_cpufreq_init(void)
> >  {
> >  	struct device_node *np;
> >  
> > +	if (!machine_is(cell))
> > +		return 0;
> > +
> 
> Please return -ENODEV to prevent loading module.
> 
> Otherwise it will cause crash when unloading the module
> because of cpufreq_unregister_driver() with unregistered driver.

It won't crash due to the checks in cpufreq_unregister_driver(), but
it's still better to return failure.


Thanks,

-Olof
