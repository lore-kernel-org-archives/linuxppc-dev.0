Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D5951A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:27 +1100 (AEDT)
In-Reply-To: <1445476939-2995-2-git-send-email-weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 aik@ozlabs.ru, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [V7, 1/6] powerpc/powernv: don't enable SRIOV when VF BAR has non
 64bit-prefetchable BAR
Message-Id: <20160217124127.26B1914032B@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-22-10 at 01:22:14 UTC, Wei Yang wrote:
> On PHB3, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If a
> SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned from
> 64bit prefetchable window, which means M64 BAR can't work on it.
> 
> The reason is PCI bridges support only 2 memory windows and the kernel code
> programs bridges in the way that one window is 32bit-nonprefetchable and
> the other one is 64bit-prefetchable. So if devices' IOV BAR is 64bit and
> non-prefetchable, it will be mapped into 32bit space and therefore M64
> cannot be used for it.
> 
> This patch makes this explicit and truncate IOV resource in this case to
> save MMIO space.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0331854190e70b9d96d392572

cheers
