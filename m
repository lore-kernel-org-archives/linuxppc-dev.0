Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01BB71A0CCE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 08:35:18 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 15:35:16 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 18390C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:23:24 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9ULZDhU57475166
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 21:35:13 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9ULZCfW006111
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 17:35:12 -0400
Date: Fri, 30 Oct 2015 14:35:11 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: "Busch, Keith" <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-ID: <20151030213511.GK7716@linux.vnet.ibm.com>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029172043.GA8343@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.10.2015 [17:20:43 +0000], Busch, Keith wrote:
> On Thu, Oct 29, 2015 at 08:57:01AM -0700, Nishanth Aravamudan wrote:
> > On 29.10.2015 [04:55:36 -0700], Christoph Hellwig wrote:
> > > We had a quick cht about this issue and I think we simply should
> > > default to a NVMe controler page size of 4k everywhere as that's the
> > > safe default.  This is also what we do for RDMA Memory reigstrations and
> > > it works fine there for SRP and iSER.
> > 
> > So, would that imply changing just the NVMe driver code rather than
> > adding the dma_page_shift API at all? What about
> > architectures that can support the larger page sizes? There is an
> > implied performance impact, at least, of shifting the IO size down.
> 
> It is the safe option, but you're right that it might have a
> measurable performance impact (can you run an experiment?). Maybe we
> should just change the driver to always use MPSMIN for the moment in
> the interest of time, and you can flush out the new API before the
> next merge window.

Given that it's 4K just about everywhere by default (and sort of
implicitly expected to be, I guess), I think I'd prefer we default to
4K. That should mitigate the performance impact (I'll ask our IO team to
do some runs, but since this impacts functionality on some hardware, I
don't think it's too relevant for now). Unless there are NVMe devcies
with a MPSMAX < 4K? 

Something like the following?



We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).

The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).

In this particular case of page sizes, we clearly want to use the
IOMMU's page size in the driver. And generally, the NVMe driver in this
function should be using the IOMMU's page size for the default device
page size, rather than the kernel's page size. There is not currently an
API to obtain the IOMMU's page size across all architectures and in the
interest of a stop-gap fix to this functional issue, default the NVMe
device page size to 4K, with the intent of adding such an API and
implementation across all architectures in the next merge window.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
v1 -> v2:
  Based upon feedback from Christoph Hellwig, implement the IOMMU page
  size lookup as a generic DMA API, rather than an architecture-specific
  hack.

v2 -> v3:
  In the interest of fixing the functional problem in the short-term,
  just force the device page size to 4K and work on adding the new API
  in the next merge window.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ccc0c1f93daa..a9a5285bdb39 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1717,7 +1717,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u32 aqa;
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
-	unsigned page_shift = PAGE_SHIFT;
+	/*
+	 * default to a 4K page size, with the intention to update this
+	 * path in the future to accomodate architectures with differing
+	 * kernel and IO page sizes.
+	 */
+	unsigned page_shift = 12;
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
 	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
 




-Nish
