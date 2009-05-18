Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73E89DE048
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:05:22 +1000 (EST)
Subject: Re: [PATCH v2] powerpc/pci: clean up direct access to sysdata by
	iseries platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <8530F7E1-6EA9-4DA3-9130-DDA1C6E4B510@kernel.crashing.org>
References: <1242391640-18826-1-git-send-email-galak@kernel.crashing.org>
	<8530F7E1-6EA9-4DA3-9130-DDA1C6E4B510@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 May 2009 17:05:05 +1000
Message-Id: <1242630305.18075.49.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-15 at 07:50 -0500, Kumar Gala wrote:
> On May 15, 2009, at 7:47 AM, Kumar Gala wrote:
> 
> > We shouldn't directly access sysdata to get the device node.  We  
> > should
> > be calling pci_device_to_OF_node().
> >
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > * Updated based on sfr's iseries pci fix patch
> >
> > arch/powerpc/platforms/iseries/iommu.c |    2 +-
> > arch/powerpc/platforms/iseries/pci.c   |    8 ++++----
> > 2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Stephen if you can test this version that would be great.

Fails with:

/home/benh/linux-powerpc-test/arch/powerpc/platforms/iseries/iommu.c: In function ‘pci_dma_dev_setup_iseries’:
/home/benh/linux-powerpc-test/arch/powerpc/platforms/iseries/iommu.c:180: error: ‘dev’ undeclared (first use in this function)
/home/benh/linux-powerpc-test/arch/powerpc/platforms/iseries/iommu.c:180: error: (Each undeclared identifier is reported only once
/home/benh/linux-powerpc-test/arch/powerpc/platforms/iseries/iommu.c:180: error: for each function it appears in.)

(I suspect it should have been "pdev" instead of "dev")

Cheers,
Ben.
