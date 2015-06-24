Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84DEA1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 15:00:19 +1000 (AEST)
Message-ID: <1435122019.3620.6.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Set the correct kernel taint on machine check
 errors.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Date: Wed, 24 Jun 2015 15:00:19 +1000
In-Reply-To: <1434338719-8416-1-git-send-email-dja@axtens.net>
References: <1434338719-8416-1-git-send-email-dja@axtens.net>
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

On Mon, 2015-06-15 at 13:25 +1000, Daniel Axtens wrote:
> This means the 'M' flag will work properly when the kernel prints a backtrace.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/kernel/traps.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 6530f1b..37de90f 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -297,6 +297,8 @@ long machine_check_early(struct pt_regs *regs)
>  
>  	__this_cpu_inc(irq_stat.mce_exceptions);
>  
> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);

I'm not sure about the lockdep bit.

I guess it's safer to just declare it fubar.

Does this fix a bug, or just nice to have?

cheers
