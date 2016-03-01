Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 055E51A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 09:21:20 +1100 (AEDT)
In-Reply-To: <1454988763-5580-5-git-send-email-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [4/4] powerpc/mm: Split hash page table sizing heuristic into a
 helper
Message-Id: <20160301222119.D4717140326@ozlabs.org>
Date: Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 03:32:43 UTC, David Gibson wrote:
> htab_get_table_size() either retrieve the size of the hash page table (HPT)
> from the device tree - if the HPT size is determined by firmware - or
> uses a heuristic to determine a good size based on RAM size if the kernel
> is responsible for allocating the HPT.
> 
> To support a PAPR extension allowing resizing of the HPT, we're going to
> want the memory size -> HPT size logic elsewhere, so split it out into a
> helper function.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5c3c7ede2bdcb85fa2fd51c814

I reworded one comment a little, from:

	/* 2^11 PTEGS / 2^18 bytes is the minimum htab size permitted
	 * by the architecture */

to:
	/*
	 * 2^11 PTEGS of 128 bytes each, ie. 2^18 bytes is the minimum htab
	 * size permitted by the architecture.
	 */

To avoid any confusion about the "/" referring to division.

cheers
