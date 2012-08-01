Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 440512C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 03:49:15 +1000 (EST)
In-Reply-To: <F5E29818-CC20-444E-A125-249E5E3BA365@kernel.crashing.org>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <F5E29818-CC20-444E-A125-249E5E3BA365@kernel.crashing.org>
Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <OFAE3C73EB.2E7A2805-ONC1257A4D.0060EE3C-C1257A4D.00613F46@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 1 Aug 2012 19:42:11 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>
> On Jul 26, 2012, at 7:30 AM, Jia Hongtao wrote:
>
> > We unified the Freescale pci/pcie initialization by changing the fsl_pci
> > to a platform driver. In previous PCI code architecture the initialization
> > routine is called at board_setup_arch stage. Now the initialization is done
> > in probe function which is architectural better. Also It's convenient for
> > adding PM support for PCI controller in later patch.
> >
> > One issue introduced by this architecture is the timing of swiotlb_init.
> > During PCI initialization the need of swiotlb is determined and this should
> > be done before swiotlb_init. So a new function to determine swiotlb by
> > parsing pci ranges is made. This function is called at board_setup_arch
> > stage which is earlier than swiotlb_init.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Changed for V3:
> > - Rebase the patch set on the latest tree
> > - merge PCI unify and swiotlb patch into one
> >
> > arch/powerpc/sysdev/fsl_pci.c |  155 ++++++++++++++++++++++++++++++++---------
> > arch/powerpc/sysdev/fsl_pci.h |    9 +--
> > 2 files changed, 125 insertions(+), 39 deletions(-)
>
> I'd like the SWIOTLB refactoring as a separate patch.  Additionally, the order of patches should be as follows:
>
> 1. refactor PCI node parsing code
> 2. add pci_determine_swiotlb (should rename to fsl_pci_determine_swiotlb)
> 3. Determine primary bus by looking for ISA node
> 4. convert all boards over to fsl_pci_init
> 5. convert fsl pci to platform driver (edac and other fixes should be merged in here)
> 6. PM support

Could you add:
7. Fix PPC_INDIRECT_TYPE_NO_PCIE_LINK issue. The link is only probed at init and a subsequent
pci/rescan does not change that. See mail thread titled:
  mpc8xxx PCIe hotplug needs fixing, some clues ..

 Jocke
