Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VnMm3M22zF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 16:30:44 +1000 (AEST)
Date: Wed, 18 Jul 2018 16:29:58 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel] KVM: PPC: Fix hardware and emulated TCE tables
 matching
Message-ID: <20180718062958.GD27453@fergus>
References: <20180620084258.1155-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620084258.1155-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 06:42:58PM +1000, Alexey Kardashevskiy wrote:
> When attaching a hardware table to LIOBN in KVM, we match table parameters
> such as page size, table offset and table size. However the tables are
> created via very different paths - VFIO and KVM - and the VFIO path goes
> through the platform code which has minimum TCE page size requirement
> (which is 4K but since we allocate memory by pages and cannot avoid
> alignment anyway, we align to 64k pages for powernv_defconfig).
> 
> So when we match the tables, one might be bigger that the other which
> means the hardware table cannot get attached to LIOBN and DMA mapping
> fails.
> 
> This removes the table size alignment from the guest visible table.
> This does not affect the memory allocation which is still aligned -
> kvmppc_tce_pages() takes care of this.
> 
> This relaxes the check we do when attaching tables to allow the hardware
> table be bigger than the guest visible table.
> 
> Ideally we want the KVM table to cover the same space as the hardware
> table does but since the hardware table may use multiple levels, and
> all levels must use the same table size (IODA2 design), the area it can
> actually cover might get very different from the window size which
> the guest requested, even though the guest won't map it all.
> 
> Fixes: ca1fc489cf "KVM: PPC: Book3S: Allow backing bigger guest IOMMU pages with smaller physical pages"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
