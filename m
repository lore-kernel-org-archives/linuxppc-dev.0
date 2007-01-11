Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2A4EDDF9D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 08:36:50 +1100 (EST)
Subject: Re: [PATCH 1/2] drivers/ata: PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200701111025.04927.arnd@arndb.de>
References: <200701110853.l0B8roEl018444@toshiba.co.jp>
	<200701111025.04927.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 08:36:39 +1100
Message-Id: <1168551400.22458.419.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Actually, an even stronger reason to use an abstraction is the
> fact that this is not really a PCI device and you therefore
> don't use readl/writel, but rather in_be32/out_be32.
> 
> If you think the code gets better by using the low-level calls,
> then it would be good if you also do the patch to implement them.
> 
> My feeling about your driver is that the amount of code duplication
> is far too much, and it should better be based on generalizing the
> existing libata code to deal with whatever you need to handle
> differently.

I've been having a quick look at it since at least another driver has a
similar issue (needing to replace the taskfile accessors for individual
register accesses). Right now, you can only re-implement the whole reset
handling, you can't have it just use different register accessors. I
think that's a waste.

Best way might be to have a hook for individual register access... the
reset code basically needs the control register and the LBA for the
signature (and status but there's already a hook for it).

Ben.
