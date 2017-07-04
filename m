Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x212C4tnrzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 20:48:35 +1000 (AEST)
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v6, 01/10] powerpc/pseries: Fix passing of pp0 in updatepp() and
 updateboltedpp()
Message-Id: <3x212C3KJYz9sNx@ozlabs.org>
Date: Tue,  4 Jul 2017 20:48:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-03 at 13:01:45 UTC, Michael Ellerman wrote:
> From: Balbir Singh <bsingharora@gmail.com>
> 
> Once upon a time there were only two PP (page protection) bits. In ISA
> 2.03 an additional PP bit was added, but because of the layout of the
> HPTE it could not be made contiguous with the existing PP bits.
> 
> The result is that we now have three PP bits, named pp0, pp1, pp2,
> where pp0 occupies bit 63 of dword 1 of the HPTE and pp1 and pp2
> occupy bits 1 and 0 respectively. Until recently Linux hasn't used
> pp0, however with the addition of _PAGE_KERNEL_RO we started using it.
> 
> The problem arises in the LPAR code, where we need to translate the PP
> bits into the argument for the H_PROTECT hypercall. Currently the code
> only passes bits 0-2 of newpp, which covers pp1, pp2 and N (no
> execute), meaning pp0 is not passed to the hypervisor at all.
> 
> We can't simply pass it through in bit 63, as that would collide with a
> different field in the flags argument, as defined in PAPR. Instead we
> have to shift it down to bit 8 (IBM bit 55).
> 
> Fixes: e58e87adc8bf ("powerpc/mm: Update _PAGE_KERNEL_RO")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> [mpe: Simplify the test, rework change log]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/e71ff982ae4c17d176e9f0132157d5

cheers
