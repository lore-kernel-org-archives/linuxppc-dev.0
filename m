Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 180921A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 16:10:07 +1100 (AEDT)
Date: Thu, 11 Feb 2016 15:39:37 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 5/6] KVM: PPC: Move reusable bits of H_PUT_TCE
 handler to helpers
Message-ID: <20160211043937.GC9757@oak.ozlabs.ibm.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453361977-19589-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 21, 2016 at 06:39:36PM +1100, Alexey Kardashevskiy wrote:
> Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
> will validate TCE (not to have unexpected bits) and IO address
> (to be within the DMA window boundaries).
> 
> This introduces helpers to validate TCE and IO address. The helpers are
> exported as they compile into vmlinux (to work in realmode) and will be
> used later by KVM kernel module in virtual mode.

Comments below...

> +/* Note on the use of page_address() in real mode,
> + *
> + * It is safe to use page_address() in real mode on ppc64 because
> + * page_address() is always defined as lowmem_page_address()
> + * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial

"arithmetic" not "arithmetial"

> + * operation and does not access page struct.
> + *
> + * Theoretically page_address() could be defined different
> + * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
> + * should be enabled.

"would have to be enabled" not "should be enabled"

Apart from those nits, the patch looks fine.

Paul.
