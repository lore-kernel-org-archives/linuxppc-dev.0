Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65752DDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 08:01:23 +1100 (EST)
Subject: Re: [PATCH 1/2] POWERPC/fsl-pci: Better ATMU setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
References: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain
Date: Thu, 18 Dec 2008 07:59:11 +1100
Message-Id: <1229547551.16253.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-17 at 11:43 -0800, Trent Piepho wrote:
The default ATMU window can support a pci_mem_offset less than zero too,
but pci_mem_offset is unsigned.  One could say the abilities allowed a
powerpc pci_controller is neither subset nor a superset of the abilities of
a Freescale PCIe controller.  Thankfully, the most useful bits are in the
intersection of the two abilities.

That sign issue shouldn't be too hard to fix if there's a real need by
making sure everything is unsigned and of the same width, in which case,
an addition with the unsigned pci_mem_offset will properly result in a
substraction of the later is negative, even when everybody is
unsigned :-)

But I don't see any pressing need for that.

Ben.
