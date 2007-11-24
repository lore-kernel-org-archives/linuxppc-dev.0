Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35866DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 13:52:11 +1100 (EST)
Message-ID: <474791D3.1090607@pobox.com>
Date: Fri, 23 Nov 2007 21:52:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] e1000: Fix for 32 bits platforms with 64 bits resources
References: <20071116073821.548CCDDDF4@ozlabs.org>
In-Reply-To: <20071116073821.548CCDDDF4@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, auke-jan.h.kok@intel.com, linuxppc-dev@ozlabs.org
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

Looks good to me.  auke?
