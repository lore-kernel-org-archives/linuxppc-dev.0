Return-Path: <auke-jan.h.kok@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id EFCAB67B5B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 07:08:52 +1000 (EST)
Message-ID: <45354398.1000100@intel.com>
Date: Tue, 17 Oct 2006 13:56:56 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] e1000: Reset all functions after a PCI error
References: <20061017204206.GG6537@austin.ibm.com>
In-Reply-To: <20061017204206.GG6537@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> Please apply and forward upstream.

ACK

Jeff, please apply on top of today's fixes.

Auke


> --linas
> 
> During the handling of the PCI error recovery sequence,
> the current e1000 driver erroneously blocks a device reset
> for any but the first PCI function. It shouldn't -- this 
> is a cut-n-paste error from a different driver (which
> tolerated only one hardware reset per hardware card). 
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Auke Kok <auke-jan.h.kok@intel.com>
> 
> ----
>  drivers/net/e1000/e1000_main.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/drivers/net/e1000/e1000_main.c	2006-10-17 15:02:25.000000000 -0500
> +++ linux-2.6.19-rc1-git11/drivers/net/e1000/e1000_main.c	2006-10-17 15:03:35.000000000 -0500
> @@ -4914,10 +4914,6 @@ static pci_ers_result_t e1000_io_slot_re
>  	pci_enable_wake(pdev, PCI_D3hot, 0);
>  	pci_enable_wake(pdev, PCI_D3cold, 0);
>  
> -	/* Perform card reset only on one instance of the card */
> -	if (PCI_FUNC (pdev->devfn) != 0)
> -		return PCI_ERS_RESULT_RECOVERED;
> -
>  	e1000_reset(adapter);
>  	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
>  
