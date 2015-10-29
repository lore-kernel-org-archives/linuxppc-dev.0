Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCB5E1A0B6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 02:57:14 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 29 Oct 2015 11:57:11 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EF92C38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 11:57:07 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9TFv7Vt55181566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 15:57:07 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9TFu2LP004044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 11:56:05 -0400
Date: Thu, 29 Oct 2015 08:57:01 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Busch, Keith" <keith.busch@intel.com>, aik@ozlabs.ru,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 paulus@samba.org, sparclinux@vger.kernel.org, willy@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 david@gibson.dropbear.id.au
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151029155701.GJ7716@linux.vnet.ibm.com>
References: <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
 <20151027223643.GA25332@localhost.localdomain>
 <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029115536.GA28090@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.10.2015 [04:55:36 -0700], Christoph Hellwig wrote:
> On Wed, Oct 28, 2015 at 01:59:23PM +0000, Busch, Keith wrote:
> > The "new" interface for all the other architectures is the same as the
> > old one we've been using for the last 5 years.
> > 
> > I welcome x86 maintainer feedback to confirm virtual and DMA addresses
> > have the same offset at 4k alignment, but I have to insist we don't
> > break my currently working hardware to force their attention.
> 
> We had a quick cht about this issue and I think we simply should
> default to a NVMe controler page size of 4k everywhere as that's the
> safe default.  This is also what we do for RDMA Memory reigstrations and
> it works fine there for SRP and iSER.

So, would that imply changing just the NVMe driver code rather than
adding the dma_page_shift API at all? What about
architectures that can support the larger page sizes? There is an
implied performance impact, at least, of shifting the IO size down.

Sorry for the continuing questions -- I got lots of conflicting feedback
on the last series and want to make sure v4 is more acceptable.

Thanks,
Nish
