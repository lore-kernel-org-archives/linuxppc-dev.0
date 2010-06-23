Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id AEFE7B6F05
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 01:16:48 +1000 (EST)
Subject: Re: [PATCH 08/40] tracing: remove syscall bitmaps in preparation
	for compat support
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-9-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-9-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 23 Jun 2010 11:16:44 -0400
Message-ID: <1277306204.9181.43.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
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
> From: Jason Baron <jbaron@redhat.com>
> 
> In preparation for compat syscall tracing support, let's store the enabled
> syscalls, with the struct syscall_metadata itself. That way we don't duplicate
> enabled information when the compat table points to an entry in the regular
> syscall table. Also, allows us to remove the bitmap data structures completely.
> 
> Signed-off-by: Jason Baron <jbaron@redhat.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  include/linux/syscalls.h      |    8 +++++++
>  include/trace/syscall.h       |    4 +++
>  kernel/trace/trace_syscalls.c |   42 +++++++++++++++++++---------------------
>  3 files changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 86f082b..755d05b 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -163,6 +163,10 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>  		.nb_args 	= nb,				\
>  		.types		= types_##sname,		\
>  		.args		= args_##sname,			\
> +		.ftrace_enter	= 0,				\
> +		.ftrace_exit	= 0,				\
> +		.perf_enter	= 0,				\
> +		.perf_exit	= 0,				\

I really hate this change!

You just removed a nice compressed bitmap (1 bit per syscall) to add 4
bytes per syscall. On my box I have 308 syscalls being traced. That was
308 bits per bitmask = 39 bytes * 2 = 78 * 2 (perf and ftrace) = 156.

Now we have 8 bytes per syscall (enter and exit), which is 1232 bytes.

Thus this change added 1076 bytes.

This may not seem as much, but the change is not worth 1K. Can't we just
add another bitmask or something for the compat case?

I also hate the moving of ftrace and perf internal data to an external
interface.

-- Steve

>  		.enter_event	= &event_enter_##sname,		\
>  		.exit_event	= &event_exit_##sname,		\
>  		.enter_fields	= LIST_HEAD_INIT(__syscall_meta_##sname.enter_fields), \
> @@ -179,6 +183,10 @@ extern struct trace_event_functions exit_syscall_print_funcs;
>  		.name 		= "sys_"#sname,			\
>  		.syscall_nr	= -1,	/* Filled in at boot */	\
>  		.nb_args 	= 0,				\
> +		.ftrace_enter	= 0,				\
> +		.ftrace_exit	= 0,				\
> +		.perf_enter	= 0,				\
> +		.perf_exit	= 0,				\
>  		.enter_event	= &event_enter__##sname,	\
>  		.exit_event	= &event_exit__##sname,		\
>  		.enter_fields	= LIST_HEAD_INIT(__syscall_meta__##sname.enter_fields), \
