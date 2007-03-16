Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 31E3BDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 23:41:56 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [PPC32]  ADMA support for PPC 440SPe processors.
Date: Fri, 16 Mar 2007 13:44:01 +0100
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<1174033758.6861.41.camel@localhost.localdomain>
In-Reply-To: <1174033758.6861.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703161344.02510.sr@denx.de>
Cc: linux-raid@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 March 2007 09:29, Benjamin Herrenschmidt wrote:
> > +	/*
> > +	 * Map registers
> > +	 */
> > +	i2o_reg  = (i2o_regs_t *)ioremap64(I2O_MMAP_BASE, I2O_MMAP_SIZE);
> > +	dma_reg0 = (dma_regs_t *)ioremap64(DMA0_MMAP_BASE, DMA_MMAP_SIZE);
> > +	dma_reg1 = (dma_regs_t *)ioremap64(DMA1_MMAP_BASE, DMA_MMAP_SIZE);
> > +	xor_reg  = (xor_regs_t *)ioremap64(XOR_MMAP_BASE,XOR_MMAP_SIZE);
>
> You should test the result of these. Also, the move to arch/powerpc here
> as well will cleanup as ioremap will always take 64 bits resource_size_t
> (can't you make that working on arch/ppc too and use normal ioremap
> there as well ?).

It's quite easy: Just configure CONFIG_RESOURCES_64BIT and you can use 
the "normal" ioremap(). Wolfgang, please give it a try. It already works on 
the Katmai and Taishan.

> > +	/*
> > +	 * Configure h/w
> > +	 */
> > +
> > +	/* Reset I2O/DMA */
> > +	mtdcr(DCRN_SDR0_CFGADDR, 0x200);
> > +	mtdcr(DCRN_SDR0_CFGDATA, 0x10000);
> > +	mtdcr(DCRN_SDR0_CFGADDR, 0x200);
> > +	mtdcr(DCRN_SDR0_CFGDATA, 0x0);
>
> The above could use some symbolic constants... Is this the only piece of
> code to access the SDR0 indirect config registers ? If not, then some
> global locking is needed as well.

Please add

#define DCRN_SDR0_SRST0		0x200
#define SDR0_SRST_I2ODMA	(0x80000000 > 15)

to include/asm-ppc/ppc44x.h

and then use 

	SDR_WRITE(DCRN_SDR0_SRST0, SDR0_SRST_I2ODMA);
	SDR_WRITE(DCRN_SDR0_SRST0, 0);

here.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
=====================================================================
