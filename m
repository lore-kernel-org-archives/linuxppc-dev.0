Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvzsq16yRzF0R7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:36:15 +1100 (AEDT)
In-Reply-To: <20180302020108.22174-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [v2] selftests/powerpc: Skip the subpage_prot tests if the
 syscall is unavailable
Message-Id: <3zvzsp4KpBz9sZk@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-02 at 02:01:08 UTC, Michael Ellerman wrote:
> The subpage_prot syscall is only functional when the system is using
> the Hash MMU. Since commit 5b2b80714796 ("powerpc/mm: Invalidate
> subpage_prot() system call on radix platforms") it returns ENOENT when
> the Radix MMU is active. Currently this just makes the test fail.
> 
> Additionally the syscall is not available if the kernel is built with
> 4K pages, or if CONFIG_PPC_SUBPAGE_PROT=n, in which case it returns
> ENOSYS because the syscall is missing entirely.
> 
> So check explicitly for ENOENT and ENOSYS and skip if we see either of
> those.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/cd4a6f3ab4d80cb919d15897eb3cbc

cheers
