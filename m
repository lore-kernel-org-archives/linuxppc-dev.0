Return-Path: <keith.busch@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 0BA181A0272
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 00:46:27 +1100 (AEDT)
Date: Tue, 3 Nov 2015 13:46:25 +0000
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 1/1 v3] drivers/nvme: default to 4k device page size
Message-ID: <20151103134624.GG13904@localhost.localdomain>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151103131824.GA12232@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 03, 2015 at 05:18:24AM -0800, Christoph Hellwig wrote:
> On Fri, Oct 30, 2015 at 02:35:11PM -0700, Nishanth Aravamudan wrote:
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index ccc0c1f93daa..a9a5285bdb39 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -1717,7 +1717,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
> >  	u32 aqa;
> >  	u64 cap = readq(&dev->bar->cap);
> >  	struct nvme_queue *nvmeq;
> > -	unsigned page_shift = PAGE_SHIFT;
> > +	/*
> > +	 * default to a 4K page size, with the intention to update this
> > +	 * path in the future to accomodate architectures with differing
> > +	 * kernel and IO page sizes.
> > +	 */
> > +	unsigned page_shift = 12;
> >  	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
> >  	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
> 
> Looks good as a start.  Note that all the MPSMIN/MAX checking could
> be removed as NVMe devices must support 4k pages.

MAX can go, and while it's probably the case that all devices support 4k,
it's not a spec requirement, so we should keep the dev_page_min check.
