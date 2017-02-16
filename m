Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58f4jstzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:46 +1100 (AEDT)
In-Reply-To: <20170130161259.25937-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Update PROTFAULT handling in the page fault path
Message-Id: <3vP58f3KLrz9s9Z@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-30 at 16:12:59 UTC, "Aneesh Kumar K.V" wrote:
> With radix, we can get page fault with DSISR_PROTFAULT value set in case of
> PROT_NONE or autonuma mapping. The PROT_NONE case in handled by the vma check
> where we consider the access bad. For autonuma we should fall through and fixup
> the access mask correctly.
> 
> Without this patch we trigger the WARN_ON() on radix. This code moves that
> WARN_ON() within a radix_enabled() check. I also moved the WARN_ON() outside
> the if condition making it apply for all type of faults (exec/write/read). It
> is also conditionalized for book3s, because BOOK3E can also get a PROTFAULT to
> handle the D/I cache sync.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/18061c17c8ecdbdbf1e7d1695ec44e

cheers
