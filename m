Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C96D6DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 15:01:56 +1000 (EST)
Date: Sat, 28 Jun 2008 13:59:08 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 28/60] microblaze_v4: ptrace support
Message-ID: <20080628045908.GG25492@linux-sh.org>
References: <1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214483429-32360-29-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 02:29:57PM +0200, monstr@seznam.cz wrote:
> +long arch_ptrace(struct task_struct *child, long request, long addr, long data)
> +{
> +	int rval;
> +
> +	switch (request) {
> +		unsigned long val, copied;
> +
> +	case PTRACE_PEEKTEXT: /* read word at location addr. */
> +	case PTRACE_PEEKDATA:
> +		pr_debug("PEEKTEXT/PEEKDATA at %08lX\n", addr);
> +		copied = access_process_vm(child, addr, &val, sizeof(val), 0);
> +		rval = -EIO;
> +		if (copied != sizeof(val))
> +			break;
> +		rval = put_user(val, (unsigned long *)data);
> +		goto out;
> +
> +	case PTRACE_POKETEXT: /* write the word at location addr. */
> +	case PTRACE_POKEDATA:
> +		pr_debug("POKETEXT/POKEDATA to %08lX\n", addr);
> +		rval = 0;
> +		if (access_process_vm(child, addr, &data, sizeof(data), 1)
> +			== sizeof(data))
> +			break;
> +		rval = -EIO;
> +		goto out;
> +
You can use generic_ptrace_peekdata()/generic_ptrace_pokedata() for
these. Or kill them off and let ptrace_request() handle it.

> +	/* Continue and stop at next (return from) syscall */
> +	case PTRACE_SYSCALL:
> +		pr_debug("PTRACE_SYSCALL\n");
> +	case PTRACE_SINGLESTEP:
> +		pr_debug("PTRACE_SINGLESTEP\n");
> +	/* Restart after a signal. */
> +	case PTRACE_CONT:
> +		pr_debug("PTRACE_CONT\n");
> +		rval = -EIO;
> +		if (!valid_signal(data))
> +			break;
> +
> +		if (request == PTRACE_SYSCALL)
> +			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> +		else
> +			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> +
> +		child->exit_code = data;
> +		pr_debug("wakeup_process\n");
> +		wake_up_process(child);
> +		rval = 0;
> +		break;
> +
This is a reimplementation of ptrace_resume(), you can kill all of these
off as well, as they are also handled generically these days.

> +	/*
> +	 * make the child exit. Best I can do is send it a sigkill.
> +	 * perhaps it should be put in the status that it wants to
> +	 * exit.
> +	 */
> +	case PTRACE_KILL:
> +		pr_debug("PTRACE_KILL\n");
> +		rval = 0;
> +		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
> +			break;
> +		child->exit_code = SIGKILL;
> +		wake_up_process(child);
> +		break;
> +
> +	case PTRACE_DETACH: /* detach a process that was attached. */
> +		pr_debug("PTRACE_DETACH\n");
> +		rval = ptrace_detach(child, data);
> +		break;
> +
> +	default:
> +		rval = -EIO;
> +		goto out;
> +	}
> + out:
> +	return rval;
> +}
> +
Or rather, they would be, if you defaulted to ptrace_request() for the
unhandled cases.
