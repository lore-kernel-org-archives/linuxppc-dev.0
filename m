Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1D5B62C0178
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:25:53 +1000 (EST)
Message-ID: <1370762745.14883.11.camel@pasglop>
Subject: Re: [PATCH 2/5] powerpc/tm: Fix 32 bit non-rt signals
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
Date: Sun, 09 Jun 2013 17:25:45 +1000
In-Reply-To: <1370601390-29065-2-git-send-email-mikey@neuling.org>
References: <1370601390-29065-1-git-send-email-mikey@neuling.org>
 <1370601390-29065-2-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 20:36 +1000, Michael Neuling wrote:
> Currently sys_sigreturn() is TM unaware.  Therefore, if we take a 32 bit signal
> without SIGINFO (non RT) inside a transaction, on signal return we don't
> restore the signal frame correctly.
> 
> This checks if the signal frame being restoring is an active transaction, and
> if so, it copies the additional state to ptregs so it can be restored.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---

 .../...

> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	mcp = (struct mcontext __user *)&sf->mctx;
> +	tm_mcp = (struct mcontext __user *)&sf->mctx_transact;
> +	if (__get_user(msr_hi, &tm_mcp->mc_gregs[PT_MSR]))
>  		goto badframe;
> +	if MSR_TM_ACTIVE(msr_hi<<32) {

Mising ( and ). I'll apply that fix locally.

Appart from that, I suppose it's ok. I don't see any exposure
coming from users "cooking" the tm_frame and calling sigreturn,
so as long as we are confident userspace generally only uses
sigreturn with frames it got from an actual signal, and doesn't
try to "generate" frames by hand, we should be ok.

Cheers,
Ben.
