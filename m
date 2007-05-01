Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17974.50661.270389.178023@cargo.ozlabs.ibm.com>
Date: Tue, 1 May 2007 14:45:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
In-Reply-To: <200704261704.06790.arnd@arndb.de>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261100.25650.arnd@arndb.de>
	<20070426141902.GB29241@xyzzy.farnsworth.org>
	<200704261704.06790.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> What your glue code does is to find a backdoor into the device tree
> (through of_find_compatible_node) and create a second struct device
> for the same hardware, in an unrelated location in the linux device tree.

I disagree that of_find_compatible_node is a "backdoor".

He won't have an of_device already unless he has arranged for the
mv64x60 node to be scanned by of_platform_bus_probe.  Which he hasn't
AFAICS.

> This is very confusing if you look at sysfs, e.g. trying to find out
> which driver is attached to a given of_device.
> It also makes you lose the ability to autoload the driver module,
> because autoloading is not supported for a platform_driver (there
> is no MODULE_DEVICE_TABLE()).

There's nothing preventing autoloading of modules for platform
devices, if desired.

Paul.
