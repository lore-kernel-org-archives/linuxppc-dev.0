Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1955BDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 07:44:09 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6ULjMUu011491
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 17:45:22 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6ULi6XB463340
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 17:44:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6ULi5hf029921
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 17:44:06 -0400
Date: Mon, 30 Jul 2007 16:44:04 -0500
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Message-ID: <20070730214404.GE4884@austin.ibm.com>
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707302046.10010.arnd@arndb.de> <46AE3C06.5060100@mvista.com>
	<200707302158.16530.arnd@arndb.de> <46AE4764.7020101@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46AE4764.7020101@mvista.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com, Arnd Bergmann <arnd@arndb.de>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2007 at 01:17:40PM -0700, Dave Jiang wrote:
> Arnd Bergmann wrote:
> > The best solution may be to look at how it's structured at the
> > register level. If the PCI EDAC registers are implemented separately
> > from the regular PCI registers, a device tree entry would be appropriate.
> > If not, your idea of registering a platform_device from fsl_add_bridge
> > is probably more sensible.
> > 
> 
> We can probably do either. From looking at the 8560 and 8548 manuals, the PCI
> error registers are 0xe00 offset of the start of PCI registers. For example,
> the PCI registers would start at 0x8000 offset. And the PCI error registers
> would be at 0xe00 offset from there and would be the very last block of
> registers. 

Anywhere I can easily get an overview of these "PCI error registers"?

Also: please note that the linux kernel has a pci error recovery
mechanism built in; its used by pseries and PCI-E. I'm not clear
on what any of this has to do with EDAC, which I thought was supposed 
to be for RAM only. (The EDAC project once talked about doing pci error 
recovery, but that was years ago, and there is a separate system for
that, now.)

--linas
