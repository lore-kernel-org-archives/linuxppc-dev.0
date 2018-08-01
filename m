Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gNry5Y5QzF18f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 16:37:22 +1000 (AEST)
Subject: Re: [PATCH v3 5/9] powerpc/traps: Print signal name for unhandled
 signals
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Joe Perches <joe@perches.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-6-muriloo@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <631e9a9b-dbbe-ede7-eb81-81520cc36ad5@c-s.fr>
Date: Wed, 1 Aug 2018 08:37:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180731145020.14009-6-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> This adds a human-readable name in the unhandled signal message.
> 
> Before this patch, a page fault looked like:
> 
>    pandafault[6303]: unhandled signal 11 at 100007d0 nip 1000061c lr 7fff93c55100 code 2 in pandafault[10000000+10000]
> 
> After this patch, a page fault looks like:
> 
>    pandafault[6352]: segfault (11) at 13a2a09f8 nip 13a2a086c lr 7fffb63e5100 code 2 in pandafault[13a2a0000+10000]
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>   arch/powerpc/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1c4f06fca370..e71f12bca146 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -96,6 +96,41 @@ EXPORT_SYMBOL(__debugger_fault_handler);
>   #define TM_DEBUG(x...) do { } while(0)
>   #endif
>   
> +static const char *signames[SIGRTMIN + 1] = {
> +	"UNKNOWN",
> +	"SIGHUP",			// 1
> +	"SIGINT",			// 2
> +	"SIGQUIT",			// 3
> +	"SIGILL",			// 4
> +	"unhandled trap",		// 5 = SIGTRAP
> +	"SIGABRT",			// 6 = SIGIOT
> +	"bus error",			// 7 = SIGBUS
> +	"floating point exception",	// 8 = SIGFPE
> +	"illegal instruction",		// 9 = SIGILL
> +	"SIGUSR1",			// 10
> +	"segfault",			// 11 = SIGSEGV
> +	"SIGUSR2",			// 12
> +	"SIGPIPE",			// 13
> +	"SIGALRM",			// 14
> +	"SIGTERM",			// 15
> +	"SIGSTKFLT",			// 16
> +	"SIGCHLD",			// 17
> +	"SIGCONT",			// 18
> +	"SIGSTOP",			// 19
> +	"SIGTSTP",			// 20
> +	"SIGTTIN",			// 21
> +	"SIGTTOU",			// 22
> +	"SIGURG",			// 23
> +	"SIGXCPU",			// 24
> +	"SIGXFSZ",			// 25
> +	"SIGVTALRM",			// 26
> +	"SIGPROF",			// 27
> +	"SIGWINCH",			// 28
> +	"SIGIO",			// 29 = SIGPOLL = SIGLOST
> +	"SIGPWR",			// 30
> +	"SIGSYS",			// 31 = SIGUNUSED
> +};

I don't think is is worth having that full table when we only use a few 
of them. (As discussed in v1 https://patchwork.ozlabs.org/patch/948802/)

I would suggest to instead use a function like this:

static const char *signame(int signr)
{
	if (signr == SIGBUS)
		return "bus error";
	if (signr == SIGFPE)
		return "floating point exception";
	if (signr == SIGILL)
		return "illegal instruction";
	if (signr == SIGILL)
		return "segfault";
	if (signr == SIGTRAP)
		return "unhandled trap";
	return "unknown signal";
}

Christophe

> +
>   /*
>    * Trap & Exception support
>    */
> @@ -314,8 +349,8 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
>   	if (!unhandled_signal(current, signr))
>   		return;
>   
> -	pr_info("%s[%d]: unhandled signal %d at %lx nip %lx lr %lx code %x",
> -		current->comm, current->pid, signr,
> +	pr_info("%s[%d]: %s (%d) at %lx nip %lx lr %lx code %x",
> +		current->comm, current->pid, signames[signr], signr,
>   		addr, regs->nip, regs->link, code);
>   
>   	print_vma_addr(KERN_CONT " in ", regs->nip);
> 
