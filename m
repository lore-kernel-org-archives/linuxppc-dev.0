Return-Path: <keith.busch@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 8FD6A1A0479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 09:38:42 +1100 (AEDT)
Date: Tue, 27 Oct 2015 22:36:43 +0000
From: "Busch, Keith" <keith.busch@intel.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: David Miller <davem@davemloft.net>, willy@linux.intel.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151027223643.GA25332@localhost.localdomain>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027222010.GD7716@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2015 at 03:20:10PM -0700, Nishanth Aravamudan wrote:
> On 26.10.2015 [18:27:46 -0700], David Miller wrote:
> > From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > Date: Fri, 23 Oct 2015 13:54:20 -0700
> > 
> > > 1) add a generic dma_get_page_shift implementation that just returns
> > > PAGE_SHIFT
> > 
> > I won't object to this patch series, but if I had implemented this I
> > would have required the architectures to implement this explicitly,
> > one-by-one.  I think it is less error prone and more likely to end
> > up with all the architectures setting this correctly.
> 
> Well, looks like I should spin up a v4 anyways for the powerpc changes.
> So, to make sure I understand your point, should I make the generic
> dma_get_page_shift a compile-error kind of thing? It will only fail on
> architectures that actually build the NVME driver (as the only caller).
> But I'm not sure how exactly to achieve that, if you could give a bit
> more detail I'd appreciate it!

If you're suggesting to compile-time break architectures that currently
work just fine with NVMe, let me stop you right there.
