Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRK745Z2fzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:06:08 +1100 (AEDT)
Message-ID: <1487538354.23576.158.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm/hugetlb: Filter out hugepage size not
 supported by page table layout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 20 Feb 2017 08:05:54 +1100
In-Reply-To: <1487499527-16166-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487499527-16166-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-02-19 at 15:48 +0530, Aneesh Kumar K.V wrote:
> +#ifdef CONFIG_PPC_BOOK3S_64
> +       /*
> +        * We need to make sure that for different page sizes reported by
> +        * firmware we only add hugetlb support for page sizes that can be
> +        * supported by linux page table layout.
> +        * For now we have
> +        * Radix: 2M
> +        * Hash: 16M and 16G
> +        */
> +       if (radix_enabled()) {
> +               if (mmu_psize != MMU_PAGE_2M)
> +                       return -EINVAL;
> +       } else {
> +               if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
> +                       return -EINVAL;
> +       }

Hash could support others... Same with radix and PUD level pages.

Why do we need that ? Won't FW provide separate properties for hash and
radix page sizes anyway ?

Ben.
