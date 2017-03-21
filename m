Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3c4K9CzDqZp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:12 +1100 (AEDT)
In-Reply-To: <20170221023854.47493-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/powernv: Fix it_ops::get() callback to return in
 cpu endian
Message-Id: <3vnW3c2Chrz9s87@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-21 at 02:38:54 UTC, Alexey Kardashevskiy wrote:
> The iommu_table_ops callbacks are declared CPU endian as they take and
> return "unsigned long"; underlying hardware tables are big-endian.
> 
> However get() was missing be64_to_cpu(), this adds the missing conversion.
> 
> The only caller of this is crash dump at arch/powerpc/kernel/iommu.c,
> iommu_table_clear() which only compares TCE to zero so this change
> should not cause behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/81d5fe1a3b1acfaadc7921d08609e0

cheers
