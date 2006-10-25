Return-Path: <heiko.carstens@de.ibm.com>
Date: Wed, 25 Oct 2006 10:00:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: arnd@arndb.de
Subject: Re: [PATCH 12/16] cell: add temperature to SPU and CPU sysfs entries
Message-ID: <20061025080048.GB7090@osiris.boeblingen.de.ibm.com>
References: <20061024163113.694643000@arndb.de>
	<20061024163816.851732000@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061024163816.851732000@arndb.de>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 24, 2006 at 06:31:25PM +0200, arnd@arndb.de wrote:

> + * (C) Copyright IBM Deutschland Entwicklung GmbH 2005

IBM Corp. instead of IBM DE? 2006?

> +static int __init thermal_init(void)
> +{
> +	init_default_values();
> +
> +	spu_add_sysdev_attr_group(&spu_attribute_group);
> +	cpu_add_sysdev_attr_group(&ppe_attribute_group);
> +
> +	return 0;
> +}

Same here: check for errors on spu_add_sysdev_attr_group and
cpu_add_sysdev_attr_group.

> +static void __exit thermal_exit(void)
> +{
> +	spu_remove_sysdev_attr_group(&spu_attribute_group);
> +	cpu_remove_sysdev_attr_group(&ppe_attribute_group);

Will crash if cpu_add_sysdev_attr_group failed...
