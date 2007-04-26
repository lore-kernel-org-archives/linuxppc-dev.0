Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 1C036DDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:55:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Thu, 26 Apr 2007 02:55:03 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260221.20150.arnd@arndb.de>
	<20070426004302.GP4046@mag.az.mvista.com>
In-Reply-To: <20070426004302.GP4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260255.04490.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Mark A. Greer wrote:
> of_find_compatible_node() is not being called from a driver, its being
> called from platform code. =A0Its extracting info from the device tree and
> setting up the platform_data required by the driver.

Well, the idea of putting the device driver code into a platform specific
location is the smaller part of the problem. Even if it was the right
thing to scan the tree and then create platform_data instead of using
the of_device, that code would still belong into the device driver.

Note that the interrupt controller code in patch 6 is different, because
it is not possible to probe interrupt controllers using the Linux
driver model -- any device driver that gets initialized must assume
that the interrupt controller code and some other infrastructure is
already running.

	Arnd <><
