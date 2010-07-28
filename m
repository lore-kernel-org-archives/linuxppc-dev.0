Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A21E8B6EF7
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 01:41:03 +1000 (EST)
Message-ID: <4C5011A3.3020501@windriver.com>
Date: Wed, 28 Jul 2010 06:16:51 -0500
From: Jason Wessel <jason.wessel@windriver.com>
MIME-Version: 1.0
To: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] powerpc: Replace hardcoded offset by BREAK_INSTR_SIZE
References: <1280308724-8402-1-git-send-email-monstr@monstr.eu>
In-Reply-To: <1280308724-8402-1-git-send-email-monstr@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: KGDB Mailing List <kgdb-bugreport@lists.sourceforge.net>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2010 04:18 AM, Michal Simek wrote:
> kgdb_handle_breakpoint checks the first arch_kgdb_breakpoint
> which is not known by gdb that's why is necessary jump over
> it. The jump lenght is equal to BREAK_INSTR_SIZE that's
> why is cleaner to use defined macro instead of hardcoded
> non-described offset.
>
>   
Seems fine to me.  I'll add this to the kgdb merge queue for 2.6.36.

Jason.

> Signed-off-by: Michal Simek <monstr@monstr.eu>
> CC: Jason Wessel <jason.wessel@windriver.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@ozlabs.org
> ---
>  arch/powerpc/kernel/kgdb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 82a7b22..7f61a3a 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -129,7 +129,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>  		return 0;
>  
>  	if (*(u32 *) (regs->nip) == *(u32 *) (&arch_kgdb_ops.gdb_bpt_instr))
> -		regs->nip += 4;
> +		regs->nip += BREAK_INSTR_SIZE;
>  
>  	return 1;
>  }
>   
