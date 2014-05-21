Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 03ED41A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 13:29:56 +1000 (EST)
Date: Wed, 21 May 2014 08:44:20 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v12 3/7] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20140521031420.GE21128@intel.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
 <1398261209-5578-4-git-send-email-a13xp0p0v88@gmail.com>
 <20140502170333.GJ32284@intel.com>
 <CAF0T0X6XBe-xcgXJ3M0QhxeHuK7H+H_neAWn_ChFxU6pr-QqXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF0T0X6XBe-xcgXJ3M0QhxeHuK7H+H_neAWn_ChFxU6pr-QqXQ@mail.gmail.com>
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

On Thu, May 08, 2014 at 01:49:20PM +0400, Alexander Popov wrote:
> >> +     case DMA_SLAVE_CONFIG:
> >> +             /*
> >> +              * Constraints:
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
> >> +             if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES ||
> >> +                 cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES ||
> > and why this limtation, doesnt seem covered above?
> I created this limitation because FIFO registers of LPC and SDHC
> support _only_ 4-byte access.
> 
> I tried to cover this limitation in the statement "minimal transfer chunk
> is 4 bytes". Should I make it more explicit?
expose these as capablities and try to use these in your client driver. Already
we have audio drivers using those...

-- 
~Vinod
