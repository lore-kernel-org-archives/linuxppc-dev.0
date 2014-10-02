Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C55831A0A9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 07:34:54 +1000 (EST)
Message-ID: <1412285674.28143.35.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix sys_call_table declaration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romeo Cane <romeo.cane.ext@coriant.com>
Date: Fri, 03 Oct 2014 07:34:34 +1000
In-Reply-To: <20141002144131.GA3855@rcane-VirtualBox>
References: <20141002144131.GA3855@rcane-VirtualBox>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 15:41 +0100, Romeo Cane wrote:
> Declaring sys_call_table as a pointer causes the compiler to generate the wrong lookup code in arch_syscall_addr

Care to elaborate ?

Ben.

> Signed-off-by: Romeo Cane <romeo.cane.ext@coriant.com>
> ---
>  arch/powerpc/include/asm/syscall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index b54b2ad..528ba9d 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -17,7 +17,7 @@
>  
>  /* ftrace syscalls requires exporting the sys_call_table */
>  #ifdef CONFIG_FTRACE_SYSCALLS
> -extern const unsigned long *sys_call_table;
> +extern const unsigned long sys_call_table[];
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
>  static inline long syscall_get_nr(struct task_struct *task,
