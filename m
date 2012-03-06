Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B3B98B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 18:11:57 +1100 (EST)
Message-ID: <1331017892.11728.96.camel@pasglop>
Subject: Re: [1/2] powerpc/44x: Fix PCI MSI support for APM821xx SoC and
 Bluestone board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
Date: Tue, 06 Mar 2012 18:11:32 +1100
In-Reply-To: <bluehawk-msi-use-upper-lower-32@mdm.bga.com>
References: <1331004581-23795-1-git-send-email-mla@apm.com>
 <bluehawk-msi-use-upper-lower-32@mdm.bga.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, open-source-review@apm.com,
 Tirumala R Marri <tmarri@apm.com>, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>,
 Mai La <mla@apm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-03-05 at 22:37 -0600, Milton Miller wrote:
> On Mon, 05 Mar 2012 about 17:29:41 -0000, Mai La wrote:
> >  
> > @@ -43,7 +43,12 @@
> >  #define PEIH_FLUSH0	0x30
> >  #define PEIH_FLUSH1	0x38
> >  #define PEIH_CNTRST	0x48
> > +
> > +#ifdef CONFIG_APM821xx
> > +#define NR_MSI_IRQS	8
> > +#else
> >  #define NR_MSI_IRQS	4
> > +#endif
> >  
> 
> does this need to go into the dts binding?

A compile time #define is definitely not acceptable as it would break a
multiplatform kernel.

Ben.

> >  struct ppc4xx_msi {
> >  	u32 msi_addr_lo;
> > @@ -150,12 +155,11 @@ static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> >  	if (!sdr_addr)
> >  		return -1;
> >  
> > -	SDR0_WRITE(sdr_addr, (u64)res.start >> 32);	 /*HIGH addr */
> > -	SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> > -
> > +	mtdcri(SDR0, *sdr_addr, (u64)res.start >> 32);	/*HIGH addr */
> > +	mtdcri(SDR0, *sdr_addr + 1, res.start & 0xFFFFFFFF);/* Low addr */
> 
> Please use upper_32_bits and lower_32_bits from linux/kernel.h
> 
> >  	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
> > -	if (msi->msi_dev)
> > +	if (!msi->msi_dev)
> >  		return -ENODEV;
> >  
> >  	msi->msi_regs = of_iomap(msi->msi_dev, 0);
> > @@ -167,9 +171,12 @@ static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
> >  		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
> >  
> >  	msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
> > -	msi->msi_addr_hi = 0x0;
> > -	msi->msi_addr_lo = (u32) msi_phys;
> > -	dev_dbg(&dev->dev, "PCIE-MSI: msi address 0x%x\n", msi->msi_addr_lo);
> > +	if (!msi_virt)
> > +		return -ENOMEM;
> > +	msi->msi_addr_hi = (u32)(msi_phys >> 32);
> > +	msi->msi_addr_lo = (u32)(msi_phys & 0xffffffff);
> 
> ditto
> 
> 
> milton
