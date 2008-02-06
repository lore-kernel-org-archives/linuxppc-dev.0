Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A043ADDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 23:14:00 +1100 (EST)
Message-ID: <47A9A482.1060405@garzik.org>
Date: Wed, 06 Feb 2008 07:13:54 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] e1000: Fix for 32 bits platforms with 64 bits resources
References: <20071116073821.548CCDDDF4@ozlabs.org>
In-Reply-To: <20071116073821.548CCDDDF4@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, auke-jan.h.kok@intel.com, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> The e1000 driver stores the content of the PCI resources into
> unsigned long's before ioremapping. This breaks on 32 bits
> platforms that support 64 bits MMIO resources such as ppc 44x.
> 
> This fixes it by removing those temporary variables and passing
> directly the result of pci_resource_start/len to ioremap.
> 
> The side effect is that I removed the assignments to the netdev
> fields mem_start, mem_end and base_addr, which are totally useless
> for PCI devices.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --
> 
>  drivers/net/e1000/e1000_main.c |   18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

applied
