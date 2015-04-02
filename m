Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 707511A1864
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 09:15:15 +1100 (AEDT)
Date: Thu, 2 Apr 2015 18:15:05 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Message-ID: <20150402221505.GD15680@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150402214343.GA15680@oracle.com>
 <1428011820.20500.277.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428011820.20500.277.camel@kernel.crashing.org>
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

On (04/03/15 08:57), Benjamin Herrenschmidt wrote:
> 
> > > I only just noticed too, you completely dropped the code to honor
> > > the dma mask. Why that ? Some devices rely on this.

    /* Sowmini's comment about this coming from sparc origins.. */

> Probably, not that many devices have limits on DMA mask but they do
> exist. It becomes more important if we decide to create a very large
> IOMMU window that spans beyond 4G in order to support devices with
> 32-bit DMA masks. Otherwise it's older devices mostly with <32-bit
> masks.
> 
> In any case, for a generic piece of code, this should be supported.
> Basically, assume that if we have something in the powerpc code, we need
> it, if you remove it, we won't be able to use your code generically.

I see.

is the mask something that can be stored in the iommu_map_table as
part of the init? 

I can see that the align_order has to be an additional arg to 
iommu_tbl_range_alloc, not sure if mask falls in that category
as well.

--Sowmini
