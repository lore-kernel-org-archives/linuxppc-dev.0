Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zC1kx0cWFzDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 19:52:08 +1100 (AEDT)
Date: Thu, 4 Jan 2018 09:52:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, patches@groups.riscv.org,
 "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Cris <linux-cris-kernel@axis.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 27/67] dma-direct: add dma address sanity checks
Message-ID: <20180104085205.GC3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-28-hch@lst.de>
 <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 29, 2017 at 03:12:25PM +0100, Geert Uytterhoeven wrote:
> > +check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> > +               const char *caller)
> > +{
> > +       if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> > +               if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
> > +                       dev_err(dev,
> > +                               "%s: overflow %llx+%zu of device mask %llx\n",
> 
> Please use "%pad" to format dma_addr_t ...
> 
> > +                               caller, (long long)dma_addr, size,
> 
> ... and use &dma_addr.
> 
> > +                               (long long)*dev->dma_mask);
> 
> This cast is not needed, as u64 is unsigned long long in kernelspace on
> all architectures.

Thanks, fixed.
