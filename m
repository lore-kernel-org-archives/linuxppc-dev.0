Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 6EE0867A2E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 22:37:07 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
Date: Sat, 9 Dec 2006 12:36:56 +0100
References: <20061208114113.2191e446@localhost>
	<1165618381.1103.89.camel@localhost.localdomain>
	<F6853CAA-5CBD-4BA8-A330-55D66AB3E853@kernel.crashing.org>
In-Reply-To: <F6853CAA-5CBD-4BA8-A330-55D66AB3E853@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612091236.57252.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 09 December 2006 11:04, Segher Boessenkool wrote:
> 
> > I'd like other people opinions here... But I'm tempted to remove the
> > "default" list of bus types here and have it always be passed by the
> > platform... just in case.

I think for the flat device tree, we often have only type=soc,
or compatible=soc anyway, and there is a limited number of
internal bus types we want to probe on top of that for real
OF implementations.

> That's probably best -- no sense in registering devices
> on buses that the platform doesn't know how to drive!

But the platform doesn't need how to drive them, the device driver
needs to. All the platform needs to know is the fact that it can
deal with SOC devices that are automatically probed.

I'd much prefer to have the list in the same file that drives the
devices in the first place. It's probably also good to register
them as MODULE_DEVICE_TABLE(), for documentation purposes, even
if the driver can't be built as a module yet.

	Arnd <><
