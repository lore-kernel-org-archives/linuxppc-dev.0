Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 14510B707F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 01:26:29 +1000 (EST)
Subject: Re: [PATCH 10/40] tracing: add tracing support for compat syscalls
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-11-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-11-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 23 Jun 2010 11:26:26 -0400
Message-ID: <1277306786.9181.51.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@redhat.com>, Li Zefan <lizf@cn.fujitsu.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
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
> Add core support to event tracing for compat syscalls. The basic idea is that we
> check if we have a compat task via 'is_compat_task()'. If so, we lookup in the
> new compat_syscalls_metadata table, the corresponding struct syscall_metadata, to
> check syscall arguments and whether or not we are enabled.
> 
> Signed-off-by: Jason Baron <jbaron@redhat.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  include/linux/compat.h        |    2 +
>  include/trace/syscall.h       |    4 ++
>  kernel/trace/trace.h          |    2 +
>  kernel/trace/trace_syscalls.c |   86 +++++++++++++++++++++++++++++++++++++----
>  4 files changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index ab638e9..a94f13d 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -363,6 +363,8 @@ extern ssize_t compat_rw_copy_check_uvector(int type,
>  
>  #else /* CONFIG_COMPAT */
>  
> +#define NR_syscalls_compat 0
> +
>  static inline int is_compat_task(void)
>  {
>  	return 0;
> diff --git a/include/trace/syscall.h b/include/trace/syscall.h
> index 75f3dce..67d4e64 100644
> --- a/include/trace/syscall.h
> +++ b/include/trace/syscall.h
> @@ -22,6 +22,7 @@
>  struct syscall_metadata {
>  	const char	*name;
>  	int		syscall_nr;
> +	int		compat_syscall_nr;

This is also bloating the kernel. I don't like to add fields to the
syscall_metadata lightly.

You're adding 4 more bytes to this structure to handle a few items. Find
a better way to do this.

>  	int		nb_args;
>  	const char	**types;
>  	const char	**args;
> @@ -38,6 +39,9 @@ struct syscall_metadata {
>  
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  extern unsigned long arch_syscall_addr(int nr);
> +#ifdef CONFIG_COMPAT
> +extern unsigned long arch_compat_syscall_addr(int nr);
> +#endif
>  extern int init_syscall_trace(struct ftrace_event_call *call);
>  
>  extern int reg_event_syscall_enter(struct ftrace_event_call *call);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 01ce088..53ace4b 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -79,12 +79,14 @@ enum trace_type {
>  struct syscall_trace_enter {
>  	struct trace_entry	ent;
>  	int			nr;
> +	int			compat;

You're adding 4 bytes to a trace (taking up precious buffer space) for a
single flag. If anything, set the 31st bit of nr if it is compat.

-- Steve

>  	unsigned long		args[];
>  };
>  
>  struct syscall_trace_exit {
>  	struct trace_entry	ent;
>  	int			nr;
> +	int			compat;
>  	long			ret;
>  };
>  
