Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSGXC11GwzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 11:12:59 +1000 (AEST)
Date: Wed, 17 May 2017 10:12:48 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/jprobes: Save and restore the parameter
 save area
Message-Id: <20170517101248.7b3d2a5f38fff1a765df9687@kernel.org>
In-Reply-To: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 15 May 2017 23:35:03 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index a83821f33ea3..b6960ef213ac 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -61,6 +61,15 @@ extern kprobe_opcode_t optprobe_template_end[];
>  #define MAX_OPTINSN_SIZE	(optprobe_template_end - optprobe_template_entry)
>  #define RELATIVEJUMP_SIZE	sizeof(kprobe_opcode_t)	/* 4 bytes */
>  
> +/* Save upto 16 parameters along with the stack frame header */
> +#define MAX_STACK_SIZE		(STACK_FRAME_PARM_SAVE + (16 * sizeof(unsigned long)))
> +#define MIN_STACK_SIZE(ADDR)					       \
> +	(((MAX_STACK_SIZE) < (((unsigned long)current_thread_info()) + \
> +			      THREAD_SIZE - (unsigned long)(ADDR)))    \
> +	 ? (MAX_STACK_SIZE)					       \
> +	 : (((unsigned long)current_thread_info()) +		       \
> +	    THREAD_SIZE - (unsigned long)(ADDR)))

Could you add CUR_STACK_SIZE(addr) as x86 does instead of repeating similar code?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
