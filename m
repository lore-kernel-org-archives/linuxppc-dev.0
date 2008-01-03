Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 08CEBDDE35
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 21:14:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Li Li <r64360@freescale.com>
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
Date: Thu, 3 Jan 2008 11:14:02 +0100
References: <1199272605.22416.8.camel@Guyver>
	<200801030914.12628.arnd@arndb.de> <1199349066.4437.5.camel@Guyver>
In-Reply-To: <1199349066.4437.5.camel@Guyver>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801031114.05981.arnd@arndb.de>
Cc: Phillips Kim <Kim.Phillips@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Tony <Tony.Li@freescale.com>, Wood Scott <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 January 2008, Li Li wrote:
> 
> > It's easy enough to just panic() if you find more than one primary
> > bus, 
> > since the information from the device tree is static enough that one 
> > will know how to fix this after seeing the error.
> > 
> 
> It is just a case. what about if do not find primary pci host.
> The current code can prevent this potential error and make system
> robust.

After some more research, I noticed that the distinction between
primary and secondary host bridges will go away _anyway_, so
I guess we shouldn't worry about it too much.

On powerpc64, we already don't care, as the arch/powerpc/kernel/isa-bridge.c
code takes care of legacy I/O areas there, instead of the PCI code.
It's only needed on machines with legacy ISA devices (PC keyboard,
floppy, ...), and those can be converted to use the isa-bridge code
at some point.

	Arnd <><
