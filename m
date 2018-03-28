Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xF354LzF2M4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:21 +1100 (AEDT)
In-Reply-To: <20180213055135.25639-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/npu: Do not try invalidating 32bit table when
 64bit table is enabled
Message-Id: <40B8xF0QQmz9s1l@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 05:51:35 UTC, Alexey Kardashevskiy wrote:
> GPUs and the corresponding NVLink bridges get different PEs as they have
> separate translation validation entries (TVEs). We put these PEs to
> the same IOMMU group so they cannot be passed through separately.
> So the iommu_table_group_ops::set_window/unset_window for GPUs do set
> tables to the NPU PEs as well which means that iommu_table's list of
> attached PEs (iommu_table_group_link) has both GPU and NPU PEs linked.
> This list is used for TCE cache invalidation.
> 
> The problem is that NPU PE has just a single TVE and can be programmed
> to point to 32bit or 64bit windows while GPU PE has two (as any other PCI
> device). So we end up having an 32bit iommu_table struct linked to both
> PEs even though only the 64bit TCE table cache can be invalidated on NPU.
> And a relatively recent skiboot detects this and prints errors.
> 
> This changes GPU's iommu_table_group_ops::set_window/unset_window to make
> sure that NPU PE is only linked to the table actually used by the hardware.
> If there are two tables used by an IOMMU group, the NPU PE will use
> the last programmed one which with the current use scenarios is expected
> to be a 64bit one.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d41ce7b1bcc3e1d02cc9da3b83c0fe

cheers
