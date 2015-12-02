Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 096CC1A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 19:24:03 +1100 (AEDT)
Message-ID: <1449044642.24750.4.camel@ellerman.id.au>
Subject: Re: [PATCH 16/19] powerpc: create giveup_all()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, cyrilbur@gmail.com,
 scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 02 Dec 2015 19:24:02 +1100
In-Reply-To: <1446079451-8774-17-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <1446079451-8774-17-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-29 at 11:44 +1100, Anton Blanchard wrote:

> Create a single function that gives everything up (FP, VMX, VSX, SPE).
> Doing this all at once means we only do one MSR write.
> 
> A context switch microbenchmark using yield():
> 
> http://ozlabs.org/~anton/junkcode/context_switch2.c
> 
> ./context_switch2 --test=yield --fp --altivec --vector 0 0
> 
> shows an improvement of 3% on POWER8.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/switch_to.h |  1 +
>  arch/powerpc/kernel/process.c        | 75 ++++++++++++++++++++++++++++--------
>  arch/powerpc/kvm/book3s_pr.c         | 17 +-------

books3s_pr.c can be a module, so we need giveup_all() to be EXPORT_SYMBOL.

I'll fix it up on my end.

cheers
