Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 5CCAADDE33
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 19:14:46 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Li Li <r64360@freescale.com>
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
Date: Thu, 3 Jan 2008 09:14:11 +0100
References: <1199272605.22416.8.camel@Guyver>
	<200801021253.08280.arnd@arndb.de>
	<1199342440.7375.29.camel@Guyver>
In-Reply-To: <1199342440.7375.29.camel@Guyver>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801030914.12628.arnd@arndb.de>
Cc: Wood Scott <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Phillips Kim <Kim.Phillips@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 January 2008, Li Li wrote:
> > * The detection method for the primary bus is somewhat fragile,
> > because 
> > we depend on the order of the nodes in the device tree, which is not 
> > specified to have a meaning. /Maybe/ there could be a property in 
> > (at most) one of the PCI host bridge nodes saying that this specific
> > bus 
> > is the primary one.
> > 
> 
> Put this primary in code is more save than in dts.
> The dts lacks error checking function. If provide error dts such as two
> pci hosts both has primary property will occur chaos.

It's easy enough to just panic() if you find more than one primary bus,
since the information from the device tree is static enough that one
will know how to fix this after seeing the error.

	Arnd <><
