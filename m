Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLGPc58nYzDsy2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 11:45:56 +1100 (AEDT)
Subject: Re: [PATCH 02/13] powerpc/64: Provide functions for accessing POWER9
 partition table
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a08edf29-2d09-0482-f870-18c8b44ace47@gmail.com>
Date: Sat, 19 Nov 2016 11:45:52 +1100
MIME-Version: 1.0
In-Reply-To: <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#ifdef CONFIG_PPC_BOOK3S_64
> +void mmu_partition_table_init(void)
> +{
> +	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
> +
> +	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");

This should be 36 (12 + 24)

> +	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
> +						MEMBLOCK_ALLOC_ANYWHERE));
> +

Balbir
