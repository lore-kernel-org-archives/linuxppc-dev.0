Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E93BADE27F
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 00:54:29 +1000 (EST)
Date: Mon, 22 Sep 2008 16:54:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal
Message-ID: <20080922145404.GC27956@elte.hu>
References: <200809221602.32616.srinivasa@in.ibm.com>
	<20080922104202.GE30137@elte.hu>
	<200809221841.27993.srinivasa@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809221841.27993.srinivasa@in.ibm.com>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	"H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Srinivasa Ds <srinivasa@in.ibm.com> wrote:

> --- linux-2.6.27-rc7.orig/arch/ia64/include/asm/siginfo.h
> +++ linux-2.6.27-rc7/arch/ia64/include/asm/siginfo.h

please do not send patches that modify include/asm/ files, the 
include/asm-x86/ file should be modified instead.

(this problem will go away in v2.6.28 when we'll move include/asm-x86/ 
to arch/x86/include/)

> +	si_code = get_si_code((unsigned long*)&condition);

coding style problem: please run checkpatch.

>  	/* Ok, finally something we can handle */
> -	send_sigtrap(tsk, regs, error_code);
> +	send_sigtrap(tsk, regs, error_code, si_code);

ok, that looks much nicer.

> -	info.si_code = TRAP_BRKPT;
> +	info.si_code = get_si_code(&condition);

no need to pass in the condition by reference.

> +#define TRAP_BRANCH     (__SI_FAULT|3)  /* process taken branch trap */
> +#define TRAP_HWBKPT     (__SI_FAULT|4)  /* hardware breakpoint or watchpoint 
> */

stray linewrapped patch line - see Documentation/email-clients.txt.

> -void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int 
> error_code)
> +void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int 
> error_code,

linewrap.

> +++ linux-2.6.27-rc7/include/asm-x86/traps.h
> @@ -36,6 +36,16 @@ void do_invalid_op(struct pt_regs *, lon
>  void do_general_protection(struct pt_regs *, long);
>  void do_nmi(struct pt_regs *, long);
>  
> +int get_si_code(unsigned long *condition)
> +{
> +	if (*condition & DR_STEP)
> +		return TRAP_TRACE;

please declare inline functions explicitly as 'static inline'.

	Ingo
