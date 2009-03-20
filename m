Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AC0CDDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 16:43:06 +1100 (EST)
Subject: Re: [RFC][PATCH -tip 4/9] power: add kernel_trap_sp()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Masami Hiramatsu <mhiramat@redhat.com>
In-Reply-To: <49C2B4BF.4080904@redhat.com>
References: <49C2B4BF.4080904@redhat.com>
Content-Type: text/plain
Date: Fri, 20 Mar 2009 16:42:40 +1100
Message-Id: <1237527760.25062.567.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	systemtap-ml <systemtap@sources.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-19 at 17:10 -0400, Masami Hiramatsu wrote:
> Add kernel_trap_sp() on powerpc, based on systemtap's runtime/regs.h.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>

I haven't looked at the usage of it, but it's weird to have something
call "kernel_trap_sp" that returns the -user- stack pointer... is
this really what's expected here ?

> ---
>  arch/powerpc/include/asm/ptrace.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index c9c678f..0ac366c 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -83,6 +83,7 @@ struct pt_regs {
> 
>  #define instruction_pointer(regs) ((regs)->nip)
>  #define user_stack_pointer(regs) ((regs)->gpr[1])
> +#define kernel_trap_sp(regs) (user_stack_pointer(regs))
>  #define regs_return_value(regs) ((regs)->gpr[3])
> 
>  #ifdef CONFIG_SMP
