Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYVLD3hsrzDqhy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:22:28 +1000 (AEST)
In-Reply-To: <1495157865-12924-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com
Subject: Re: selftests/powerpc: Fix TM resched DSCR test with some compilers
Message-Id: <3wYVLD2nn7z9s8N@ozlabs.org>
Date: Thu, 25 May 2017 23:22:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-19 at 01:37:45 UTC, Michael Ellerman wrote:
> The tm-resched-dscr test has started failing sometimes, depending on
> what compiler it's built with, eg:
> 
>   test: tm_resched_dscr
>   Check DSCR TM context switch: tm-resched-dscr: tm-resched-dscr.c:76: test_body: Assertion `rv' failed.
>   !! child died by signal 6
> 
> When it fails we see that the compiler doesn't initialise rv to 1 before
> entering the inline asm block. Although that's counter intuitive, it
> is allowed because we tell the compiler that the inline asm will write
> to rv (using "=r"), meaning the original value is irrelevant.
> 
> Marking it as a read/write parameter would presumably work, but it seems
> simpler to fix it by setting the initial value of rv in the inline asm.
> 
> Fixes: 96d016108640 ("powerpc: Correct DSCR during TM context switch")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/fe06fe860250a4f01d0eaf70a2563b

cheers
