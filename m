Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id B71B9DDEE7
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 05:58:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Date: Mon, 30 Jul 2007 21:58:15 +0200
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707302046.10010.arnd@arndb.de> <46AE3C06.5060100@mvista.com>
In-Reply-To: <46AE3C06.5060100@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707302158.16530.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 30 July 2007, Dave Jiang wrote:
> I don't believe that EDAC core has been loaded at the time of 85xx PCI
> initialization. Plus, the EDAC driver can be loaded as a kernel module. So that
> probably won't work....

ok, good point.

> Also, instead of having centralized EDAC chip driver, 
> now you have things scattered over various places. One probably needs to add
> 83xx and 86xx code as well and whatever else eventually.
> 
> Maybe we are just better off adding entries in the DTS to get around this
> problem....

The best solution may be to look at how it's structured at the
register level. If the PCI EDAC registers are implemented separately
from the regular PCI registers, a device tree entry would be appropriate.
If not, your idea of registering a platform_device from fsl_add_bridge
is probably more sensible.

	Arnd <><
