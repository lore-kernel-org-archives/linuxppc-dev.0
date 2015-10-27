Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32F211A0475
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 09:20:19 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 16:20:17 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2D86638C8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 18:20:14 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RMKDop65405060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 22:20:14 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RMKBOd014645
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 18:20:13 -0400
Date: Tue, 27 Oct 2015 15:20:10 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: willy@linux.intel.com, keith.busch@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 david@gibson.dropbear.id.au, hch@infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151027222010.GD7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151026.182746.1323901353520152838.davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26.10.2015 [18:27:46 -0700], David Miller wrote:
> From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Date: Fri, 23 Oct 2015 13:54:20 -0700
> 
> > 1) add a generic dma_get_page_shift implementation that just returns
> > PAGE_SHIFT
> 
> I won't object to this patch series, but if I had implemented this I
> would have required the architectures to implement this explicitly,
> one-by-one.  I think it is less error prone and more likely to end
> up with all the architectures setting this correctly.

Well, looks like I should spin up a v4 anyways for the powerpc changes.
So, to make sure I understand your point, should I make the generic
dma_get_page_shift a compile-error kind of thing? It will only fail on
architectures that actually build the NVME driver (as the only caller).
But I'm not sure how exactly to achieve that, if you could give a bit
more detail I'd appreciate it!

Thanks,
Nish
