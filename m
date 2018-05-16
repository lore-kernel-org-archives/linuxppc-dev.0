Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFrj5VlGzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:38:45 +1000 (AEST)
In-Reply-To: <20180416143905.2716-2-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aik@ozlabs.ru, paulus@samba.org
Subject: Re: [2/5] powerpc/lib: Fix feature fixup test of external branch
Message-Id: <40mFrj4Z7Bz9s3B@ozlabs.org>
Date: Wed, 16 May 2018 23:38:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-16 at 14:39:02 UTC, Michael Ellerman wrote:
> The expected case for this test was wrong, the source of the alternate
> code sequence is:
> 
>   FTR_SECTION_ELSE
>   2:	or	2,2,2
>   	PPC_LCMPI	r3,1
>   	beq	3f
>   	blt	2b
>   	b	3f
>   	b	1b
>   ALT_FTR_SECTION_END(0, 1)
>   3:	or	1,1,1
>   	or	2,2,2
>   4:	or	3,3,3
> 
> So when it's patched the '3' label should still be on the 'or 1,1,1',
> and the 4 label is irrelevant and can be removed.
> 
> Fixes: 362e7701fd18 ("powerpc: Add self-tests of the feature fixup code")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Patches 2-5 applied to powerpc next.

https://git.kernel.org/powerpc/c/32810d91325ec76b8ef4df463f8a0e

cheers
