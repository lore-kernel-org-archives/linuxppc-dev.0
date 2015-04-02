Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86E371A09EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 09:19:57 +1100 (AEDT)
Message-ID: <1428013176.20500.285.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 03 Apr 2015 09:19:36 +1100
In-Reply-To: <20150402221505.GD15680@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402214343.GA15680@oracle.com>
 <1428011820.20500.277.camel@kernel.crashing.org>
 <20150402221505.GD15680@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-02 at 18:15 -0400, Sowmini Varadhan wrote:
> On (04/03/15 08:57), Benjamin Herrenschmidt wrote:
> > 
> > > > I only just noticed too, you completely dropped the code to honor
> > > > the dma mask. Why that ? Some devices rely on this.
> 
>     /* Sowmini's comment about this coming from sparc origins.. */
> 
> > Probably, not that many devices have limits on DMA mask but they do
> > exist. It becomes more important if we decide to create a very large
> > IOMMU window that spans beyond 4G in order to support devices with
> > 32-bit DMA masks. Otherwise it's older devices mostly with <32-bit
> > masks.
> > 
> > In any case, for a generic piece of code, this should be supported.
> > Basically, assume that if we have something in the powerpc code, we need
> > it, if you remove it, we won't be able to use your code generically.
> 
> I see.
> 
> is the mask something that can be stored in the iommu_map_table as
> part of the init? 
> 
No, the mask is per device and has to be retrieved from the device.
Additionally the mask used for dma_map_* can be different from the
consistent mask used for alloc_coherent (we have a bug there on powerpc
which I'm trying to fix btw).

So it should be passed as an argument by the caller.

> I can see that the align_order has to be an additional arg to 
> iommu_tbl_range_alloc, not sure if mask falls in that category
> as well.

It does.

Cheers,
Ben.
