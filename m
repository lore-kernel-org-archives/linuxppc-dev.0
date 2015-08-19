Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F4E1A005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:15 +1000 (AEST)
In-Reply-To: <1438212411-11368-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Disable automatically blocked PCI config
Message-Id: <20150819231415.0D8B6140783@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-29-07 at 23:26:51 UTC, Gavin Shan wrote:
> pcibios_set_pcie_reset_state() could be called to complete
> reset request when passing through PCI device, flag
> EEH_PE_ISOLATED is set before saving the PCI config sapce.
> On some Broadcom adapters, EEH_PE_CFG_BLOCKED is automatically
> set when the flag EEH_PE_ISOLATED is marked. It caused bogus
> data saved from the PCI config space, which will be restored
> to the PCI adapter after the reset. Eventually, the hardware
> can't work with corrupted data in PCI config space.
> 
> The patch fixes the issue with eeh_pe_state_mark_no_cfg(), which
> doesn't set EEH_PE_CFG_BLOCKED when seeing EEH_PE_ISOLATED on the
> PE, in order to avoid the bogus data saved and restored to the PCI
> config space.
> 
> Reported-by: Rajanikanth H. Adaveeshaiah <rajanikanth.ha@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39bfd715b4837433a86c

cheers
