Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0380DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 06:46:20 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: Fix IO space on PCI busses created from
	of_platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200705151524.39805.arnd.bergmann@de.ibm.com>
References: <20070515041656.41CE7DDECA@ozlabs.org>
	<200705151524.39805.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Wed, 16 May 2007 06:46:09 +1000
Message-Id: <1179261969.32247.195.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 15:24 +0200, Arnd Bergmann wrote:
> 
> I think this still needs some logic to make sure we have at least one
> primary PHB in the system. On a board that has all phbs probed by
> of_platform code, we never set the pci_io_base variable.

Point, I need to fix that too.

> The easiest solution might be to statically initialize pci_io_base
> to PHBS_IO_BASE. If it is different from that, we are already broken
> because we would get _negative_ I/O port numbers for PHBs below
> pci_io_base. 

If we do that we need to clear it in iSeries code though.

Ben.
