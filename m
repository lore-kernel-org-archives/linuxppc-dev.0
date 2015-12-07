Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70DC71A0D8C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 21:30:47 +1100 (AEDT)
In-Reply-To: <1446079451-8774-2-git-send-email-anton@samba.org>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, cyrilbur@gmail.com,
 scottwood@freescale.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [01/19] powerpc: Don't disable kernel FP/VMX/VSX MSR bits on
 context switch
Message-Id: <20151207103047.305AD1402D2@ozlabs.org>
Date: Mon,  7 Dec 2015 21:30:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-29-10 at 00:43:53 UTC, Anton Blanchard wrote:
> Writing the MSR is slow, so we want to avoid it whenever possible.
> 
> A subsequent patch will add a debug option that strictly manages the
> FP/VMX/VSX unavailable bits. For now just remove it, matching what
> we do in other areas of the kernel (eg enable_kernel_altivec()).
> 
> A context switch microbenchmark using yield():
> 
> http://ozlabs.org/~anton/junkcode/context_switch2.c
> 
> ./context_switch2 --test=yield --fp 0 0
> 
> shows an improvement of almost 3% on POWER8.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied all 19 patches to powerpc next, thanks.

http://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=next

cheers
