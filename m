Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFy2HhxzDqpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:06 +1100 (AEDT)
In-Reply-To: <20171016052135.24738-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/64s: Fix crashes on Power9 DD1 with radix MMU and
 STRICT_RWX
Message-Id: <3yblFx6tVxz9sP1@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-16 at 05:21:35 UTC, Balbir Singh wrote:
> When using the radix MMU on Power9 DD1, to work around a hardware
> problem, radix__pte_update() is required to do a two stage update of
> the PTE. First we write a zero value into the PTE, then we flush the
> TLB, and then we write the new PTE value.
> 
> In the normal case that works OK, but it does not work if we're
> updating the PTE that maps the code we're executing, because the
> mapping is removed by the TLB flush and we can no longer execute from
> it. Unfortunately the STRICT_RWX code needs to do exactly that.
> 
> The exact symptoms when we hit this case vary, sometimes we print an
> oops and then get stuck after that, but I've also seen a machine just
> get stuck continually page faulting with no oops printed. The variance
> is presumably due to the exact layout of the text and the page size
> used for the mappings. In all cases we are unable to boot to a shell.
> 
> There are possible solutions such as creating a second mapping of the
> TLB flush code, executing from that, and then jumping back to the
> original. However we don't want to add that level of complexity for a
> DD1 work around.
> 
> So just detect that we're running on Power9 DD1 and refrain from
> changing the permissions, effectively disabling STRICT_RWX on Power9
> DD1.
> 
> Fixes: 7614ff3 ("powerpc/mm/radix: Implement STRICT_RWX/mark_rodata_ro() for Radix")
> 
> Cc: stable@vger.kernel.org
> 
> Reported-by: Andrew Jeffery <andrew@aj.id.au>
> [Changelog as suggested by Michael Ellerman <mpe@ellerman.id.au>]
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f79ad50ea3c73fb1ea5b09e95c864e

cheers
