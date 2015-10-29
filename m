Return-Path: <keith.busch@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id A91761A0BC2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 04:20:48 +1100 (AEDT)
Date: Thu, 29 Oct 2015 17:20:43 +0000
From: "Busch, Keith" <keith.busch@intel.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151029172043.GA8343@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029155701.GJ7716@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 29, 2015 at 08:57:01AM -0700, Nishanth Aravamudan wrote:
> On 29.10.2015 [04:55:36 -0700], Christoph Hellwig wrote:
> > We had a quick cht about this issue and I think we simply should
> > default to a NVMe controler page size of 4k everywhere as that's the
> > safe default.  This is also what we do for RDMA Memory reigstrations and
> > it works fine there for SRP and iSER.
> 
> So, would that imply changing just the NVMe driver code rather than
> adding the dma_page_shift API at all? What about
> architectures that can support the larger page sizes? There is an
> implied performance impact, at least, of shifting the IO size down.

It is the safe option, but you're right that it might have a measurable
performance impact (can you run an experiment?). Maybe we should just
change the driver to always use MPSMIN for the moment in the interest
of time, and you can flush out the new API before the next merge window.
