Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K3Pp056KzF3KD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 11:29:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/traps: merge unrecoverable_exception() and
 nonrecoverable_exception()
In-Reply-To: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
References: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
Date: Tue, 25 Sep 2018 11:29:01 +1000
Message-ID: <875zyu5pr6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 6ab66a88db14..4567eeb6524e 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -2090,8 +2082,9 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
>   */
>  void unrecoverable_exception(struct pt_regs *regs)
>  {
> -	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
> -	       regs->trap, regs->nip);
> +	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
> +		 regs->trap, regs->nip, regs->msr);
> +	debugger(regs);
>  	die("Unrecoverable exception", regs, SIGABRT);

die() already calls debugger() if the trap is != 0x100.

I don't think we want to call it twice?

cheers
