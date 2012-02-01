Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 058FEB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 16:42:29 +1100 (EST)
Subject: Re: [RFC] dmaengine/dma_slave: add context parameter to
 prep_slave_sg callback
From: Vinod Koul <vinod.koul@intel.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.64.1202010022310.31226@axis700.grange>
References: <1327612946-29397-1-git-send-email-alexandre.bounine@idt.com>
 <1327915849.1527.17.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1202010022310.31226@axis700.grange>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Feb 2012 11:13:23 +0530
Message-ID: <1328075003.1610.6.camel@vkoul-udesk3>
Mime-Version: 1.0
Cc: Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
 Alexandre Bounine <alexandre.bounine@idt.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, dan.j.williams@intel.com,
 Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-01 at 01:09 +0100, Guennadi Liakhovetski wrote:
> On Mon, 30 Jan 2012, Vinod Koul wrote:
> 
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
> > This looks good to me. But was thinking if we need to add this new
> > parameter for other slave calls (circular, interleaved, memcpy...)
> 
> Yes, we (shdma.c) also need to pass additional slave configuration 
> information to the dmaengine driver and I also was thinking about 
> extending the existing API, but my ideas were going more in the direction 
> of adding a parameter to __dma_request_channel() along the lines of
So your question is more on the lines of channel mapping/allocation?
The approach here is to pass controller specific parameters which are
required to setup the respective transfer. Since this is dependent on
each transfer, this needs to be passed in respective prepare.

The two things are completely orthogonal and shouldn't be clubbed.
For your issue we need a separate debate on how to solve this... I am
open to ideas...


-- 
~Vinod
