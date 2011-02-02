Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 0558AB7102
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 01:04:49 +1100 (EST)
Subject: Re: [PATCH 4/6] ftrace syscalls: Allow arch specific syscall
	symbol matching
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1296630718-17537-5-git-send-email-imunsie@au1.ibm.com>
References: <1296630718-17537-1-git-send-email-imunsie@au1.ibm.com>
	<1296630718-17537-5-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 02 Feb 2011 09:04:44 -0500
Message-ID: <1296655484.10797.47.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Andreas Dilger <adilger@dilger.ca>, Andreas Schwab <schwab@linux-m68k.org>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Namhyung Kim <namhyung@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Nathan Lynch <ntl@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 18:11 +1100, Ian Munsie wrote:

I'll answer your question here.

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index dcd6a7c..0d0e109 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -527,6 +527,15 @@ extern enum ftrace_dump_mode ftrace_dump_on_oops;
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  
>  unsigned long arch_syscall_addr(int nr);
> +#ifndef arch_syscall_match_sym_name
> +/*
> + * Only compare after the "sys" prefix. Archs that use
> + * syscall wrappers may have syscalls symbols aliases prefixed
> + * with "SyS" instead of "sys", leading to an unwanted
> + * mismatch.
> + */
> +#define arch_syscall_match_sym_name(sym, name) !strcmp(sym + 3, name + 3)

Instead, you could have:

#ifndef ARCH_HAS_SYSCALL_MATCH_SYM_NAME

static inline arch_syscall_match_sym_name(const char *sym, const char *name)
{
	return strcmp(sym + 3, name + 3) != 0;
}


If an arch needs to make its own, then it can simply override it by
creating its own version and defining:

#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME

Just like they do when an arch has its own strcmp.

This just keeps things cleaner. I like to avoid macros as they can have
nasty side effects (never would have guess that if you look at what I've
done in trace/ftrace.h ;-)

For example, if we use your call as:

arch_syscall_match_sym_name(str = sym[5], name);

That str would end up being something unexpected. I'm not condoning such
side-effect code, but it is something to think about when using macros.

-- Steve


> +#endif
>  
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 33360b9..76bffba 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -72,13 +72,7 @@ static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
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
