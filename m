Return-Path: <srs0=hfyf=bl=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCNzn0VjTzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 19:19:17 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yCNzm4Zbxz8t9Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 19:19:16 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yCNzl70Mzz9t2W
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2017 19:19:15 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id h28so5075445pfh.5
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2017 01:19:15 -0700 (PDT)
Date: Thu, 12 Oct 2017 18:18:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/watchdog: Print the NIP in
 soft_nmi_interrupt()
Message-ID: <20171012181856.3d88a5d9@roar.ozlabs.ibm.com>
In-Reply-To: <1507783474-28210-3-git-send-email-mpe@ellerman.id.au>
References: <1507783474-28210-1-git-send-email-mpe@ellerman.id.au>
 <1507783474-28210-3-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 12 Oct 2017 15:44:34 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> When a CPU detects its locked up via soft_nmi_interrupt() we have
> pt_regs, so print the regs->nip, which points to where we took the
> soft-NMI.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/watchdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 2494cbe34132..4594ba0979e4 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -235,7 +235,7 @@ void soft_nmi_interrupt(struct pt_regs *regs)
>  		}
>  		set_cpu_stuck(cpu, tb);
>  
> -		pr_emerg("CPU %d self-detected hard LOCKUP\n", cpu);
> +		pr_emerg("CPU %d self-detected hard LOCKUP @ %pS\n", cpu, (void *)regs->nip);
>  		print_modules();
>  		print_irqtrace_events(current);
>  		show_regs(regs);

These patches all look fine to me, but we should be printing nip
with show_regs, so why here too?

Thanks,
Nick
