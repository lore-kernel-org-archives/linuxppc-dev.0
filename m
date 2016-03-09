Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C97291A004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:51:38 +1100 (AEDT)
In-Reply-To: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: eeh_pci_enable(): fix checking of post-request state
Message-Id: <20160309125138.7B4AF140BB7@ozlabs.org>
Date: Wed,  9 Mar 2016 23:51:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-23-10 at 06:19:46 UTC, Andrew Donnellan wrote:
> In eeh_pci_enable(), after making the request to set the new options, we
> call eeh_ops->wait_state() to check that the request finished successfully.
> 
> At the moment, if eeh_ops->wait_state() returns 0, we return 0 without
> checking that it reflects the expected outcome. This can lead to callers
> further up the chain incorrectly assuming the slot has been successfully
> unfrozen and continuing to attempt recovery.
> 
> On powernv, this will occur if pnv_eeh_get_pe_state() or
> pnv_eeh_get_phb_state() return 0, which in turn occurs if the relevant OPAL
> call returns OPAL_EEH_STOPPED_MMIO_DMA_FREEZE or
> OPAL_EEH_PHB_ERROR respectively.
> 
> On pseries, this will occur if pseries_eeh_get_state() returns 0, which in
> turn occurs if RTAS reports that the PE is in the MMIO Stopped and DMA
> Stopped states.
> 
> Obviously, none of these cases represent a successful completion of a
> request to thaw MMIO or DMA.
> 
> Fix the check so that a wait_state() return value of 0 won't be considered
> successful for the EEH_OPT_THAW_MMIO or EEH_OPT_THAW_DMA cases.
> 
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/949e9b827eb4736d96df520c67

cheers
