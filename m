Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91551DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 03:44:00 +1000 (EST)
Subject: Re: PCI IO range limitation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marian Balakowicz <m8@semihalf.com>
In-Reply-To: <46838B54.2010806@semihalf.com>
References: <46838B54.2010806@semihalf.com>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 03:43:54 +1000
Message-Id: <1183052634.5521.284.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-28 at 12:20 +0200, Marian Balakowicz wrote:
> Hi,
> 
> Trying to change PCI IO window base for 52xx target I found that
> we are pretty much limited to a "0" offset only.
> 
> pci_process_bridge_OF_ranges() will not process any IO range that has
> addresses set to anything else.
> 
> 956:      case 1:         /* I/O space */
> 957:               if (ranges[2] != 0)
> 958:                       break;
> 
> When this range[2] checking is removed from
> pci_process_bridge_OF_ranges() kernel boots ok with the non-zero PCI IO
> base, but the PCI device I am using (e100) will not work.
> 
> I guess that with the above dropping of non-zero based PCI IO ranges
> this is not supposed to be working. But does anyone know why?

We just fixed that for 64 bits but 32 bits still has the limitation.
Note that it's not a very good idea to have your IO range at !0 if
you're going to use anything ISA-like, such as a VGA video card or other
legacy devices behind a PCI southbridge or SuperIO.

Ben.
