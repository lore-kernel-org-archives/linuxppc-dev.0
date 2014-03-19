Return-Path: <vinod.koul@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id C0CCE2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 01:14:37 +1100 (EST)
Date: Wed, 19 Mar 2014 19:38:57 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v9 2/6] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20140319140857.GG1976@intel.com>
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
 <1394624875-24411-3-git-send-email-a13xp0p0v88@gmail.com>
 <1394790471.28803.247.camel@smile.fi.intel.com>
 <CAF0T0X5egegHc3pheSbPRPuZaVaktMtdUiGPOLhcWZevH=pD=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF0T0X5egegHc3pheSbPRPuZaVaktMtdUiGPOLhcWZevH=pD=A@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2014 at 05:26:47PM +0400, Alexander Popov wrote:
> Hello Andy
> 
> 2014-03-14 13:47 GMT+04:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Wed, 2014-03-12 at 15:47 +0400, Alexander Popov wrote:
> >> +     case DMA_SLAVE_CONFIG:
> >> +             /* Constraints:
> >> +              *  - only transfers between a peripheral device and
> >> +              *     memory are supported;
> >> +              *  - minimal transfer chunk is 4 bytes and consequently
> >> +              *     source and destination addresses must be 4-byte aligned
> >> +              *     and transfer size must be aligned on (4 * maxburst)
> >> +              *     boundary;
> >> +              *  - during the transfer RAM address is being incremented by
> >> +              *     the size of minimal transfer chunk;
> >> +              *  - peripheral port's address is constant during the transfer.
> >> +              */
> >> +
> >> +             cfg = (void *)arg;
> >> +
> >> +             if (!is_slave_direction(cfg->direction))
> >> +                     return -EINVAL;
> >
> > As far as I understand the intention you have not to use direction field
> > in the dma_slave_config. It will be removed once.
> >
> >> +
> >> +             if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
> >> +                     cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> >> +                     return -EINVAL;
> >> +
> >> +             spin_lock_irqsave(&mchan->lock, flags);
> >> +
> >> +             if (cfg->direction == DMA_DEV_TO_MEM) {
> >> +                     mchan->per_paddr = cfg->src_addr;
> >> +                     mchan->tcd_nunits = cfg->src_maxburst;
> >> +             } else {
> >> +                     mchan->per_paddr = cfg->dst_addr;
> >> +                     mchan->tcd_nunits = cfg->dst_maxburst;
> >> +             }
> >
> > Ditto.
> 
> Excuse me, I don't understand this point.
> I have to use cfg->direction because in case of DMA_DEV_TO_MEM
> I use cfg->SRC_addr and cfg->SRC_maxburst and in case of
> DMA_MEM_TO_DEV I use cfg->DST_addr and cfg->DST_maxburst.
> Is it correct?
You store the complete config for both source and destination.
Then based on the descriptor direction you can retrive the values from channel
context and program

This way you _dont_ need to fix the direction and can use it both ways!

-- 
~Vinod
