Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wJNZ0BNTzF2FK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 17:01:02 +1000 (AEST)
Date: Wed, 22 Aug 2018 09:02:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 10/20] powerpc/dma-noncoherent: don't disable irqs over
 kmap_atomic
Message-ID: <20180822070241.GD19284@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-11-hch@lst.de>
 <bfa22816fee0759cfee28705b427be3586c7d2e3.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfa22816fee0759cfee28705b427be3586c7d2e3.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2018 at 10:27:46AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> > The requirement to disable local irqs over kmap_atomic is long gone,
> > so remove those calls.
> 
> Really ? I'm trying to verify that and getting lost in a mess of macros
> from hell in the per-cpu stuff but if you look at our implementation
> of kmap_atomic_prot(), all it does is a preempt_disable(), and then
> it uses kmap_atomic_idx_push():
> 
> 	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
> 
> Note the use of __this_cpu_inc_return(), not this_cpu_inc_return(),
> ie this is the non-interrupt safe version...

Looks like the powerpc variant indeed isn't save.

I did look a bit more through the code and history, and it seems
like we remove the need to disable irqs when called from process
context a while ago, but we still require disabling irqs when called
from irq context.  Given that this code can also be called from
irq context we'll have to keep the local_irq_save.
