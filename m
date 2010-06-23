Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 60008B6F14
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 01:16:21 +1000 (EST)
Subject: Re: [PATCH 01/40] ftrace syscalls: don't add events for unmapped
	syscalls
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-2-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-2-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 23 Jun 2010 11:02:19 -0400
Message-ID: <1277305339.9181.33.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Masami Hiramatsu <mhiramat@redhat.com>
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-06-23 at 20:02 +1000, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> FTRACE_SYSCALLS would create events for each and every system call, even
> if it had failed to map the system call's name with it's number. This
> resulted in a number of events being created that would not behave as
> expected.
> 
> This could happen, for example, on architectures who's symbol names are
> unusual and will not match the system call name. It could also happen
> with system calls which were mapped to sys_ni_syscall.
> 
> This patch changes the default system call number in the metadata to -1.
> If the system call name from the metadata is not successfully mapped to
> a system call number during boot, than the event initialisation routine
> will now return an error, preventing the event from being created.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  include/linux/syscalls.h      |    2 ++
>  kernel/trace/trace_syscalls.c |    8 ++++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 7f614ce..86f082b 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -159,6 +159,7 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>  	  __attribute__((section("__syscalls_metadata")))	\
>  	  __syscall_meta_##sname = {				\
>  		.name 		= "sys"#sname,			\
> +		.syscall_nr	= -1,	/* Filled in at boot */	\
>  		.nb_args 	= nb,				\
>  		.types		= types_##sname,		\
>  		.args		= args_##sname,			\
> @@ -176,6 +177,7 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>  	  __attribute__((section("__syscalls_metadata")))	\
>  	  __syscall_meta__##sname = {				\
>  		.name 		= "sys_"#sname,			\
> +		.syscall_nr	= -1,	/* Filled in at boot */	\
>  		.nb_args 	= 0,				\
>  		.enter_event	= &event_enter__##sname,	\
>  		.exit_event	= &event_exit__##sname,		\
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 34e3580..82246ce 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -431,6 +431,14 @@ void unreg_event_syscall_exit(struct ftrace_event_call *call)
>  int init_syscall_trace(struct ftrace_event_call *call)
>  {
>  	int id;
> +	int num;
> +
> +	num = ((struct syscall_metadata *)call->data)->syscall_nr;
> +	if (num < 0 || num >= NR_syscalls) {
> +		pr_debug("syscall %s metadata not mapped, disabling ftrace event\n",
> +				((struct syscall_metadata *)call->data)->name);
> +		return -ENOSYS;
> +	}

Perhaps this should be:

	if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls)
		return -ENOSYS;

-- Steve

>  
>  	if (set_syscall_print_fmt(call) < 0)
>  		return -ENOMEM;
