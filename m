Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD857B7E4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 10:00:12 +1000 (EST)
Subject: Re: [PATCH 3/4] ftrace syscalls: Allow arch specific syscall
	symbol matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1273736594-19320-4-git-send-email-imunsie@au1.ibm.com>
References: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
	<1273736594-19320-4-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 May 2010 09:54:56 +1000
Message-ID: <1273794896.21352.203.camel@pasglop>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-05-13 at 17:43 +1000, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> Some architectures have unusual symbol names and the generic code to
> match the symbol name with the function name for the syscall metadata
> will fail. For example, symbols on PPC64 start with a period and the
> generic code will fail to match them.
> 
> This patch splits out the match logic into a standalone weak function
> that can be overridden on archs with unusual symbol names.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Ian, I assume you will implement the support for the "special" ppc_*
syscalls via a subsequent patch and not a respin of this one right ?

Cheers,
Ben.

>  Documentation/trace/ftrace-design.txt |    3 +++
>  include/linux/ftrace.h                |    1 +
>  kernel/trace/trace_syscalls.c         |   19 ++++++++++++-------
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.txt
> index 8369a1c..3936d5f 100644
> --- a/Documentation/trace/ftrace-design.txt
> +++ b/Documentation/trace/ftrace-design.txt
> @@ -247,6 +247,9 @@ You need very few things to get the syscalls tracing in an arch.
>  - If the system call table on this arch is more complicated than a simple array
>    of addresses of the system calls, implement an arch_syscall_addr to return
>    the address of a given system call.
> +- If the symbol names of the system calls do not match the function names on
> +  this arch, implement an arch_syscall_match_sym_name with the appropriate
> +  logic to return true if the function name corresponds with the symbol name.
>  - Tag this arch as HAVE_SYSCALL_TRACEPOINTS.
>  
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e0ae83b..26ad1f5 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -534,6 +534,7 @@ static inline void trace_hw_branch_oops(void) {}
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  
>  unsigned long arch_syscall_addr(int nr);
> +bool arch_syscall_match_sym_name(const char *sym, const char *name);
>  
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 1c231d0..ebbc74d 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -32,13 +32,7 @@ static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
>  	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
>  
>  	for ( ; start < stop; start++) {
> -		/*
> -		 * Only compare after the "sys" prefix. Archs that use
> -		 * syscall wrappers may have syscalls symbols aliases prefixed
> -		 * with "SyS" instead of "sys", leading to an unwanted
> -		 * mismatch.
> -		 */
> -		if (start->name && !strcmp(start->name + 3, str + 3))
> +		if (start->name && arch_syscall_match_sym_name(str, start->name))
>  			return start;
>  	}
>  	return NULL;
> @@ -408,6 +402,17 @@ unsigned long __init __weak arch_syscall_addr(int nr)
>  	return (unsigned long)sys_call_table[nr];
>  }
>  
> +bool __weak arch_syscall_match_sym_name(const char *sym, const char *name)
> +{
> +	/*
> +	 * Only compare after the "sys" prefix. Archs that use
> +	 * syscall wrappers may have syscalls symbols aliases prefixed
> +	 * with "SyS" instead of "sys", leading to an unwanted
> +	 * mismatch.
> +	 */
> +	return (!strcmp(sym + 3, name + 3));
> +}
> +
>  int __init init_ftrace_syscalls(void)
>  {
>  	struct syscall_metadata *meta;
