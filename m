Return-Path: <bp@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CB631A05F4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 02:56:13 +1100 (AEDT)
Date: Fri, 11 Dec 2015 16:56:07 +0100
From: Borislav Petkov <bp@suse.de>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-edac@vger.kernel.org,
 Jia Hongtao <B38951@freescale.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] EDAC, mpc85xx: Make mpc85xx-pci-edac a platform device
Message-ID: <20151211155607.GA5461@pd.tnic>
References: <1449774432-18593-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1449774432-18593-1-git-send-email-scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2015 at 01:07:12PM -0600, Scott Wood wrote:
> Originally the mpc85xx-pci-edac driver bound directly to the PCI
> controller node.
> 
> Commit 905e75c46dba5f30 ("powerpc/fsl-pci: Unify pci/pcie
> initialization code") turned the PCI controller code into a platform
> device.  Since we can't have two drivers binding to the same device,
> the edac code was changed to be called into as a library-style
> submodule.  However, this doesn't work if the edac driver is built as a
> module.
> 
> Commit 8d8fcba6d1eab ("EDAC: Rip out the edac_subsys reference
> counting") exposed another problem with this approach --
> mpc85xx_pci_err_probe() was being called in the same early boot phase
> that the PCI controller is initialized, rather than in the
> device_initcall phase that the EDAC layer expects.  This caused a crash
> on boot.
> 
> To fix this, the PCI controller code now creates a child platform
> device specifically for EDAC, which the mpc85xx-pci-edac driver binds
> to.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: Jia Hongtao <B38951@freescale.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v3: Fix build with CONFIG_PCI disabled
> 
>  arch/powerpc/sysdev/fsl_pci.c | 28 +++++++++++++++++++++++++++-
>  arch/powerpc/sysdev/fsl_pci.h |  9 ---------
>  drivers/edac/mpc85xx_edac.c   | 38 +++++++++++++++++++++++++++++++++-----
>  include/linux/fsl/edac.h      |  8 ++++++++
>  4 files changed, 68 insertions(+), 15 deletions(-)
>  create mode 100644 include/linux/fsl/edac.h

Applied and rebased the tree so that this fix comes before the
rip-out-reference counting patch so that there's no hole during
bisection.

Thanks guys.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
