Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsz5k1KjKzDqjK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 09:54:02 +1000 (AEST)
Date: Wed, 13 Sep 2017 16:53:59 -0700
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powerpc/kprobes: Do not suppress instruction
 emulation if a single run failed
Message-Id: <20170913165359.475cb23ca0f76f88c3626d31@kernel.org>
In-Reply-To: <a3a2ddbd004f0410943edb998011cfd31b97384e.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
References: <2bc413d679c563d3ee338c318066777318577ab2.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
 <a3a2ddbd004f0410943edb998011cfd31b97384e.1505336870.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Sep 2017 02:50:33 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Currently, we disable instruction emulation if emulate_step() fails for
> any reason. However, such failures could be transient and specific to a
> particular run. Instead, only disable instruction emulation if we have
> never been able to emulate this. If we had emulated this instruction
> successfully at least once, then we single step only this probe hit and
> continue to try emulating the instruction in subsequent probe hits.

Hmm, would this mean that the instruction is emulatable or not depends
on context? What kind of situation is considerable?

Thank you,

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index c2a6ab38a67f..e848fe2c93fb 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -261,9 +261,19 @@ static int try_to_emulate(struct kprobe *p, struct pt_regs *regs)
>  		 */
>  		printk("Can't step on instruction %x\n", insn);
>  		BUG();
> -	} else
> -		/* This instruction can't be boosted */
> -		p->ainsn.boostable = -1;
> +	} else {
> +		/*
> +		 * If we haven't previously emulated this instruction, then it
> +		 * can't be boosted. Note it down so we don't try to do so again.
> +		 *
> +		 * If, however, we had emulated this instruction in the past,
> +		 * then this is just an error with the current run. We return
> +		 * 0 so that this is now single-stepped, but continue to try
> +		 * emulating it in subsequent probe hits.
> +		 */
> +		if (unlikely(p->ainsn.boostable != 1))
> +			p->ainsn.boostable = -1;
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
