Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17974.51466.726817.973235@cargo.ozlabs.ibm.com>
Date: Tue, 1 May 2007 14:58:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
In-Reply-To: <200704280305.26312.arnd@arndb.de>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261704.06790.arnd@arndb.de>
	<20070427235040.GA29498@xyzzy.farnsworth.org>
	<200704280305.26312.arnd@arndb.de>
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

> We've had discussions about of_platform_bus_probe() on the mailing
> lists and on IRC before. My idea of the long-term goal is that we
> should not call it from the platform specific code, but instead
> globally and add all the devices we find, with exceptions for
> stuff that works differently, like PCI.

I really don't think that is a good idea.

> I think it would be bad to have to add another exception for
> mv64x60 just because the drivers work different from the others.

I don't think it's fair to require extra work now for the sake of
something that will probably never happen.  Creating a platform_device
seems reasonable to me given that the driver is shared between mips
and powerpc.

More generally, the fact that we require a device tree shouldn't be
taken to imply that every device driver should be an
of_platform_driver.

Paul.
