Return-Path: <vinod.koul@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 2ADC6B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 14:12:58 +1100 (EST)
Subject: RE: [RFC] dmaengine/dma_slave: add context parameter to
 prep_slave_sg callback
From: Vinod Koul <vinod.koul@intel.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E5520281DD5B@CORPEXCH1.na.ads.idt.com>
References: <1327612946-29397-1-git-send-email-alexandre.bounine@idt.com>
 <1327915849.1527.17.camel@vkoul-udesk3>
 <0CE8B6BE3C4AD74AB97D9D29BD24E5520281DD5B@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Jan 2012 08:44:00 +0530
Message-ID: <1327979640.1527.51.camel@vkoul-udesk3>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dan.j.williams@intel.com, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-01-30 at 08:55 -0800, Bounine, Alexandre wrote:
> On Monday, January 30, 2012 at 4:31 AM, Vinod Koul wrote:
> > 
> > On Thu, 2012-01-26 at 16:22 -0500, Alexandre Bounine wrote:
> > > As we agreed during our discussion about adding DMA Engine support for RapidIO
> > > subsystem, RapidIO and similar clients may benefit from adding an extra context
> > > parameter to device_prep_slave_sg() callback.
> > > See https://lkml.org/lkml/2011/10/24/275 for more details.
> > >
> > > Adding the context parameter will allow to pass client/target specific
> > > information associated with an individual data transfer request.
> > >
> > > In the case of RapidIO support this additional information consists of target
> > > destination ID and its buffer address (which is not mapped into the local CPU
> > > memory space). Because a single RapidIO-capable DMA channel may queue data
> > > transfer requests to different target devices, the per-request configuration
> > > is required.
> > >
> > > The proposed change eliminates need for new subsystem-specific API.
> > > Existing DMA_SLAVE clients will ignore the new parameter.
> > >
> > > This RFC only demonstrates the API change and does not include corresponding
> > > changes to existing DMA_SLAVE clients. Complete set of patches will be provided
> > > after (if) this API change is accepted.
> >
> > This looks good to me. But was thinking if we need to add this new
> > parameter for other slave calls (circular, interleaved, memcpy...)
> > 
> 
> I agree that cyclic and interleaved calls may benefit from adding that parameter as well.
> Benefits to the cyclic call are straightforward - same as dma_slave.
> Adding a context parameter to the interleaved transfers may be more future proofing option
> than an immediate need. Memcopy and other calls that deal with local memory transfers
> probably should be left untouched.
> 
> What if we limit modifications to:
> 1) three calls (slave, cyclic and interleaved) OR
> 2) two (slave and cyclic) at this moment?
> 
> I am just more focused on dma_slave just because it fits well to provide RDMA
> over RapidIO fabric.
> 
> If everybody agrees, I can go ahead and make changes to all three at once.
For now we need at least slave and cyclic, so pls go ahead and make these changes.
For interleaved, we might need it sooner [1], but I would think it would
need few more changes to the API, so it can be rolled as part of those
changes.

-- 
~Vinod

[1]: https://lkml.org/lkml/2012/1/30/48
