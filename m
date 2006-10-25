Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 12/16] cell: add temperature to SPU and
	CPU sysfs entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
References: <20061024163113.694643000@arndb.de>
	<20061024163816.851732000@arndb.de>
	<20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 09:19:24 +1000
Message-Id: <1161818364.22582.145.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, arnd@arndb.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 10:00 +0200, Heiko Carstens wrote:
> On Tue, Oct 24, 2006 at 06:31:25PM +0200, arnd@arndb.de wrote:
> 
> > + * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
> 
> IBM Corp. instead of IBM DE? 2006?
> 
> > +static int __init thermal_init(void)
> > +{
> > +	init_default_values();
> > +
> > +	spu_add_sysdev_attr_group(&spu_attribute_group);
> > +	cpu_add_sysdev_attr_group(&ppe_attribute_group);
> > +
> > +	return 0;
> > +}
> 
> Same here: check for errors on spu_add_sysdev_attr_group and
> cpu_add_sysdev_attr_group.
> 
> > +static void __exit thermal_exit(void)
> > +{
> > +	spu_remove_sysdev_attr_group(&spu_attribute_group);
> > +	cpu_remove_sysdev_attr_group(&ppe_attribute_group);
> 
> Will crash if cpu_add_sysdev_attr_group failed...


Which is a total PITA. If this is the case, then we should modify the
add calls to at least initialize enough fields before they can fail for
the remove calls not to crash. You don't want to keep track precisely of
what file was added and what not and test all of that in your exit code
path, it's just insane.

Ben.
