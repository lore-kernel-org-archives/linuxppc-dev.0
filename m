Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EF6DDE491
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 01:31:44 +1000 (EST)
Message-Id: <352560B5-24A4-47B8-8A1F-5900957470FC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20080708055449.EDFDADDEF5@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Date: Wed, 9 Jul 2008 10:31:31 -0500
References: <20080708055449.EDFDADDEF5@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 8, 2008, at 12:54 AM, Benjamin Herrenschmidt wrote:

> This is some preliminary work to improve TLB management on SW loaded
> TLB powerpc platforms. This introduce support for non-atomic PTE
> operations in pgtable-ppc32.h and removes write back to the PTE from
> the TLB miss handlers. In addition, the DSI interrupt code no longer
> tries to fixup write permission, this is left to generic code, and
> _PAGE_HWWRITE is gone.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> This is a first step, plan is to do the same for FSL BookE, 405 and
> possibly 8xx too. From there, I want to rework a bit the execute
> permission handling to avoid multiple faults, add support for
> _PAGE_EXEC (no executable mappings), for prefaulting (especially
> for kmap) and proper SMP support for future SMP capable BookE
> platforms.
>
> v2. This version fixes a couple of typos, add a few comments and
> change use of flush_instruction_cache() to flush_icache_range()
> which will be more appropriate if there is ever an SMP variant.
>
> v3. Relying on the generic code to fixup _PAGE_ACCESSED doesn't
> work for exec faults because our cache coherency code in
> do_page_fault() will never go all the way to the generic code
> for these. We fix it up by always setting _PAGE_ACCESSED when
> setting _PAGE_HWEXEC in there.
> This version of the patch is rebased on top of -next

shouldn't you remove _PAGE_HWWRITE from 40x?  (I'm still seeing it in  
pgtable-ppc32.h and head_40x.S)

- k
