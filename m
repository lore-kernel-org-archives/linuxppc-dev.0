Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHT2JqNzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:19:01 +1000 (AEST)
In-Reply-To: <20170427052822.12666-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, stable@vger.kernel.org,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH-RESEND] cxl: Route eeh events to all drivers in
 cxl_pci_error_detected()
Message-Id: <3wJCHT1DQLz9s03@ozlabs.org>
Date: Thu,  4 May 2017 08:19:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-27 at 05:28:22 UTC, Vaibhav Jain wrote:
> Fix a boundary condition where in some cases an eeh event that results
> in card reset isn't passed on to a driver attached to the virtual PCI
> device associated with a slice. This will happen in case when a slice
> attached device driver returns a value other than
> PCI_ERS_RESULT_NEED_RESET from the eeh error_detected() callback. This
> would result in an early return from cxl_pci_error_detected() and
> other drivers attached to other AFUs on the card wont be notified.
> 
> The patch fixes this by making sure that all slice attached
> device-drivers are notified and the return values from
> error_detected() callback are aggregated in a scheme where request for
> 'disconnect' trumps all and 'none' trumps 'need_reset'.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9e8df8a21963("cxl: EEH support")
> Based-on: https://patchwork.ozlabs.org/patch/755799/
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f58f0bf155e87dda31a3088b1e107

cheers
