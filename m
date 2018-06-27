Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41GGZF4wHKzF1Dg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 07:41:25 +1000 (AEST)
In-Reply-To: <20180625081509.32566-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org,
 Christophe Leroy <christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm/32: Fix pgtable_page_dtor call
Message-Id: <41GGZF3QVRz9s2B@ozlabs.org>
Date: Thu, 28 Jun 2018 07:41:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-06-25 at 08:15:09 UTC, "Aneesh Kumar K.V" wrote:
> Commit 667416f38554 ("powerpc/mm: Fix kernel crash on page table free")
> added a call for pgtable_page_dtor in the rcu page table free routine. We missed
> the fact that for 32 bit platforms we did call the 'dtor' early. Drop the extra
> call for pgtable_page_dtor. We remove the call from __pte_free_tlb so that we
> do the page table free and 'dtor' call together. This should help when we
> switch these platforms to pte fragments.
> 
> Fixes: 667416f38554 ("powerpc/mm: Fix kernel crash on page table free")
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/941c06d58503b9f2718b20bc45ee7f

cheers
