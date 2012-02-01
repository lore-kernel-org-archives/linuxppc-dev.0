Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 999A3B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 01:48:59 +1100 (EST)
Subject: Re: [RFC] dmaengine/dma_slave: add context parameter to
 prep_slave_sg callback
From: Vinod Koul <vinod.koul@intel.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.64.1202011234180.24739@axis700.grange>
References: <1327612946-29397-1-git-send-email-alexandre.bounine@idt.com>
 <1327915849.1527.17.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1202010022310.31226@axis700.grange>
 <1328075003.1610.6.camel@vkoul-udesk3>
 <Pine.LNX.4.64.1202011234180.24739@axis700.grange>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Feb 2012 20:09:35 +0530
Message-ID: <1328107175.1610.32.camel@vkoul-udesk3>
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

On Wed, 2012-02-01 at 12:58 +0100, Guennadi Liakhovetski wrote:
> > The two things are completely orthogonal and shouldn't be clubbed.
> > For your issue we need a separate debate on how to solve this... I am
> > open to ideas...
> 
> Well, I'm not sure whether they are necessarily always orthogonal, they 
> don't seem so in my case at least. We definitely can use our approach - 
> configure the channel during allocation. I _think_ we could also perform 
> the configuration on a per-transfer basis, during the prepare stage, as 
> this RFC is suggesting, but that definitely would require reworking the 
> driver somewhat and changing the concept. The current concept is a fixed 
> DMA channel allocation to slaves for as long as the slave is using DMA. 
> This is simpler, avoids some overhead during operation and fits well with 
> the dmaengine PRIVATE channel concept. So, given the choice, we would 
> prefer to perform the configuration during channel allocation.
> 
> Maybe there are cases, where the driver absolutely needs this additional 
> information during allocation, in which case my proposal would be the only 
> way to go for them.
what are you trying to address, sending controller specific information
at allocation or the channel allocation itself. I kind of sense both.
But apprach here is discussed is to pass paramters which are required
for each transfer, not static for a channel, hence the additional
controller specific parameter in respective prepare. 
> 
> I'll post an RFC soon - stay tuned:-) 
Patch is always the best idea :-)

-- 
~Vinod
