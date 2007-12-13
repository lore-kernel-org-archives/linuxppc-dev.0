Return-Path: <SRS0=/YIh=RE=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A4C09DE089
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 20:42:54 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Date: Thu, 13 Dec 2007 10:42:47 +0100
References: <20071213073851.C321FDDFC9@ozlabs.org>
In-Reply-To: <20071213073851.C321FDDFC9@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712131042.48354.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 December 2007, Benjamin Herrenschmidt wrote:
> This makes 4xx embedded platforms re-assign all PCI resources as we
> pretty much never care about what the various firmwares have done on
> these, it's generally not compatible with the way the kernel will map
> the bridges.
>
> We still need to also enable bus renumbering on some of them, but I
> will do that from a separate patch after I've fixed 4xx PCIe to handle
> all bus numbers.

I just applied this series on top of Paulus's for-2.6.25 branch and I
get the following error:

/home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c: In function 'kilauea_probe':
/home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: 'ppc_pci_flags' undeclared (first use in this function)
/home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: (Each undeclared identifier is reported only once
/home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: for each function it appears in.)
/home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: 'PPC_PCI_REASSIGN_ALL_RSRC' undeclared (first use in this function)
make[3]: *** [arch/powerpc/platforms/40x/kilauea.o] Error 1

Seems like the patch:

    powerpc: pci32: Add flags modifying the PCI code behaviour
    
    This adds to the 32 bits PCI code some flags, replacing the old
    pci_assign_all_busses global, that allow to control various
    aspects of the PCI probing, such as whether to re-assign all
    resources or not, or to not try to assign anything at all.
    
    This also adds the flag x86 already has to avoid ISA alignment
    on bridges that don't have ISA forwarding enabled (no legacy
    devices on the top level bus) and sets it for PowerMacs.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


is missing.

Thanks.

Ciao,
Stefan
