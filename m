Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kxT16gz7zDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 11:17:25 +1000 (AEST)
Message-ID: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: Print 64-bits MSR
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 Aug 2018 11:17:25 +1000
In-Reply-To: <1533601964-20157-1-git-send-email-leitao@debian.org>
References: <1533601964-20157-1-git-send-email-leitao@debian.org>
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

On Mon, 2018-08-06 at 21:32 -0300, Breno Leitao wrote:
> On a kernel TM Bad thing program exception, the MSR is not being properly
> displayed, since it dumps a 32-bits value. MSR is a 64 bits register for
> all platforms that have HTM enabled.
>=20
> This patch dumps the MSR value as 64-bits instead of 32 bits.

(sorry I was distracted when you asked me about this before offline...)

I think you might need to clear up in the description why you are changing
  reason -> msr.

Mikey

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 0e17dcb48720..cd561fd89532 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1402,7 +1402,7 @@ void program_check_exception(struct pt_regs *regs)
>  			goto bail;
>  		} else {
>  			printk(KERN_EMERG "Unexpected TM Bad Thing exception
> "
> -			       "at %lx (msr 0x%x)\n", regs->nip, reason);
> +			       "at %lx (msr 0x%lx)\n", regs->nip, regs->msr);
>=20
>  			die("Unrecoverable exception", regs, SIGABRT);
>  		}
>  	}
