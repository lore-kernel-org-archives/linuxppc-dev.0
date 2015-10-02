Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3F131A0560
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 03:39:55 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 13:39:53 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BFE8038C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 13:39:51 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92HdpwB65208518
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 17:39:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92Hdm8I028776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 13:39:51 -0400
Date: Fri, 2 Oct 2015 10:39:47 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] drivers/nvme: default to the IOMMU page size on Power
Message-ID: <20151002173947.GA40695@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151002172313.GC41011@linux.vnet.ibm.com>
 <20151002172544.GA16139@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002172544.GA16139@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02.10.2015 [10:25:44 -0700], Christoph Hellwig wrote:
> Hi Nishanth,
> 
> please expose this value through the generic DMA API instead of adding
> architecture specific hacks to drivers.

Ok, I'm happy to do that instead -- what I struggled with is that I
don't have enough knowledge of the various architectures to provide the
right default implementation. It should be sufficient for the default to
return PAGE_SHIFT, and on Power just override that to return the IOMMU
table's page size? Since the only user will be the NVMe driver
currently, that should be fine?

Sorry for the less-than-ideal patch!

-Nish
