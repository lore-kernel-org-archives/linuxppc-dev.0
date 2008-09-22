Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2265DDEF1
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 20:42:36 +1000 (EST)
Date: Mon, 22 Sep 2008 12:42:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srinivasa Ds <srinivasa@in.ibm.com>, Roland McGrath <roland@redhat.com>
Subject: Re: [RFC][PATCH] Demultiplexing SIGTRAP signal
Message-ID: <20080922104202.GE30137@elte.hu>
References: <200809221602.32616.srinivasa@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809221602.32616.srinivasa@in.ibm.com>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	"H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org,
	Thomas Gleixner <tglx@linutronix.de>, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Srinivasa Ds <srinivasa@in.ibm.com> wrote:

> Currently a SIGTRAP signal can denote any one of below reasons.
> 	- Breakpoint hit
> 	- H/W debug register hit
> 	- Single step
> 	- SIGTRAP signal sent through kill() or rasie()
> 
> Architectures like powerpc/parisc provides infrastructure to 
> demultiplex SIGTRAP signal by passing down the information for 
> receiving SIGTRAP through si_code of siginfot_t structure. Here is an 
> attempt is generalise this infrastructure by extending it to x86 and 
> x86_64 archs.

no fundamental objections - assuming existing x86 apps have not grown an 
ABI dependency on the existing send_sigtrap() semantics. (Debuggers and 
JITs would be a candidate for such dependencies.)

a small implementational detail, this bit:

> @@ -935,8 +936,22 @@ void __kprobes do_debug(struct pt_regs *
>  			goto clear_TF_reenable;
>  	}
>  
> -	/* Ok, finally something we can handle */
> -	send_sigtrap(tsk, regs, error_code);
> +	tsk->thread.trap_no = 1;
> +	tsk->thread.error_code = error_code;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.si_signo = SIGTRAP;
> +	if (condition & DR_STEP)
> +		info.si_code = TRAP_TRACE;
> +	else if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))
> +		info.si_code = TRAP_HWBKPT;
> +	else
> +		info.si_code = TRAP_BRKPT;
> +	/* User-mode ip? */
> +	info.si_addr = user_mode_vm(regs) ? (void __user *) regs->ip : NULL;
> +
> +	/* Send us the fake SIGTRAP */
> +	force_sig_info(SIGTRAP, &info, tsk);

should be pushed into [a sufficiently extended] send_sigtrap() instead.

and this bit:

> -	info.si_code = TRAP_BRKPT;
> +	if (condition & DR_STEP)
> +		info.si_code = TRAP_TRACE;
> +	else if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3))
> +		info.si_code = TRAP_HWBKPT;
> +	else
> +		info.si_code = TRAP_BRKPT;

should be separated into a helper function as well i guess.

Roland, any objections to the core idea (or to the implementation)?

	Ingo
