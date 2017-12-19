Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1LlC0Xk5zF06W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 02:03:51 +1100 (AEDT)
Date: Tue, 19 Dec 2017 16:03:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/17] memremap: change devm_memremap_pages interface
 to use struct dev_pagemap
Message-ID: <20171219150347.GC13124@lst.de>
References: <20171215140947.26075-1-hch@lst.de>
 <20171215140947.26075-17-hch@lst.de>
 <CAPcyv4ixo=A949dN4c=LVc6x+Bdk67ERSO8xR5FQwHnL9mxQAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPcyv4ixo=A949dN4c=LVc6x+Bdk67ERSO8xR5FQwHnL9mxQAw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 17, 2017 at 10:51:56AM -0800, Dan Williams wrote:
> On Fri, Dec 15, 2017 at 6:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> > From: Logan Gunthorpe <logang@deltatee.com>
> >
> > This new interface is similar to how struct device (and many others)
> > work. The caller initializes a 'struct dev_pagemap' as required
> > and calls 'devm_memremap_pages'. This allows the pagemap structure to
> > be embedded in another structure and thus container_of can be used. In
> > this way application specific members can be stored in a containing
> > struct.
> >
> > This will be used by the P2P infrastructure and HMM could probably
> > be cleaned up to use it as well (instead of having it's own, similar
> > 'hmm_devmem_pages_create' function).
> >
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good, I notice that this does not initialize pgmap->type to
> MEMORY_DEVICE_HOST, but since that value is zero and likely won't
> change we're ok.

I'll add it jut for clarity.
