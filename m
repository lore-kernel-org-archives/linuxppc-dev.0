Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2072E1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 17:50:18 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1QKQex-0004ni-Rj
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2011 09:50:11 +0200
Date: Thu, 12 May 2011 09:48:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
Message-ID: <20110512074850.GA9937@elte.hu>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, David Howells <dhowells@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Eric Paris <eparis@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org, jmorris@namei.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kees.cook@canonical.com,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, microblaze-uclinux@itee.uq.edu.au,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Roland McGrath <roland@redhat.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>,
	linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
	agl@chromium.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ok, i like the direction here, but i think the ABI should be done differently.

In this patch the ftrace event filter mechanism is used:

* Will Drewry <wad@chromium.org> wrote:

> +static struct seccomp_filter *alloc_seccomp_filter(int syscall_nr,
> +						   const char *filter_string)
> +{
> +	int err = -ENOMEM;
> +	struct seccomp_filter *filter = kzalloc(sizeof(struct seccomp_filter),
> +						GFP_KERNEL);
> +	if (!filter)
> +		goto fail;
> +
> +	INIT_HLIST_NODE(&filter->node);
> +	filter->syscall_nr = syscall_nr;
> +	filter->data = syscall_nr_to_meta(syscall_nr);
> +
> +	/* Treat a filter of SECCOMP_WILDCARD_FILTER as a wildcard and skip
> +	 * using a predicate at all.
> +	 */
> +	if (!strcmp(SECCOMP_WILDCARD_FILTER, filter_string))
> +		goto out;
> +
> +	/* Argument-based filtering only works on ftrace-hooked syscalls. */
> +	if (!filter->data) {
> +		err = -ENOSYS;
> +		goto fail;
> +	}
> +
> +#ifdef CONFIG_FTRACE_SYSCALLS
> +	err = ftrace_parse_filter(&filter->event_filter,
> +				  filter->data->enter_event->event.type,
> +				  filter_string);
> +	if (err)
> +		goto fail;
> +#endif
> +
> +out:
> +	return filter;
> +
> +fail:
> +	kfree(filter);
> +	return ERR_PTR(err);
> +}

Via a prctl() ABI:

> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1698,12 +1698,23 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		case PR_SET_ENDIAN:
>  			error = SET_ENDIAN(me, arg2);
>  			break;
> -
>  		case PR_GET_SECCOMP:
>  			error = prctl_get_seccomp();
>  			break;
>  		case PR_SET_SECCOMP:
> -			error = prctl_set_seccomp(arg2);
> +			error = prctl_set_seccomp(arg2, arg3);
> +			break;
> +		case PR_SET_SECCOMP_FILTER:
> +			error = prctl_set_seccomp_filter(arg2,
> +							 (char __user *) arg3);
> +			break;
> +		case PR_CLEAR_SECCOMP_FILTER:
> +			error = prctl_clear_seccomp_filter(arg2);
> +			break;
> +		case PR_GET_SECCOMP_FILTER:
> +			error = prctl_get_seccomp_filter(arg2,
> +							 (char __user *) arg3,
> +							 arg4);

To restrict execution to system calls.

Two observations:

1) We already have a specific ABI for this: you can set filters for events via 
   an event fd.

   Why not extend that mechanism instead and improve *both* your sandboxing
   bits and the events code? This new seccomp code has a lot more
   to do with trace event filters than the minimal old seccomp code ...

   kernel/trace/trace_event_filter.c is 2000 lines of tricky code that
   interprets the ASCII filter expressions. kernel/seccomp.c is 86 lines of
   mostly trivial code.

2) Why should this concept not be made available wider, to allow the 
   restriction of not just system calls but other security relevant components 
   of the kernel as well?

   This too, if you approach the problem via the events code, will be a natural 
   end result, while if you approach it from the seccomp prctl angle it will be
   a limited hack only.

Note, the end result will be the same - just using a different ABI.

So i really think the ABI itself should be closer related to the event code. 
What this "seccomp" code does is that it uses specific syscall events to 
restrict execution of certain event generating codepaths, such as system calls.

Thanks,

	Ingo
