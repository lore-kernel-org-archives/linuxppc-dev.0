Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lLkK4nfHzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 03:15:20 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc/tm: Print 64-bits MSR
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
References: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
 <1533648900-7933-1-git-send-email-leitao@debian.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <95db63eb-6fb7-eed3-1ce8-8b2c053dff47@c-s.fr>
Date: Tue, 7 Aug 2018 19:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <1533648900-7933-1-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/08/2018 à 15:35, Breno Leitao a écrit :
> On a kernel TM Bad thing program exception, the Machine State Register
> (MSR) is not being properly displayed. The exception code dumps a 32-bits
> value but MSR is a 64 bits register for all platforms that have HTM
> enabled.
> 
> This patch dumps the MSR value as a 64-bits value instead of 32 bits. In
> order to do so, the 'reason' variable could not be used, since it trimmed
> MSR to 32-bits (int).

reason is not always regs->msr, see get_reason(), allthough in your case 
it is.

I think it would be better to change 'reason' to 'unsigned long' instead 
of replacing it by regs->msr for the printk.

Christophe


> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   arch/powerpc/kernel/traps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 0e17dcb48720..cd561fd89532 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1402,7 +1402,7 @@ void program_check_exception(struct pt_regs *regs)
>   			goto bail;
>   		} else {
>   			printk(KERN_EMERG "Unexpected TM Bad Thing exception "
> -			       "at %lx (msr 0x%x)\n", regs->nip, reason);
> +			       "at %lx (msr 0x%lx)\n", regs->nip, regs->msr);
>   			die("Unrecoverable exception", regs, SIGABRT);
>   		}
>   	}
> 
