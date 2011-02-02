Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 4507CB7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 01:28:19 +1100 (EST)
Subject: RE: [PATCH 4/6] ftrace syscalls: Allow arch specific syscallsymbol
	matching
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC3A@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AC3A@saturn3.aculab.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 02 Feb 2011 09:28:13 -0500
Message-ID: <1296656893.10797.53.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Andreas Dilger <adilger@dilger.ca>, David Gibson <dwg@au1.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.cz>, Namhyung Kim <namhyung@gmail.com>,
	linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
	Avantika Mathur <mathur@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Ian Munsie <imunsie@au1.ibm.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, Nathan Lynch <ntl@pobox.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Jason Baron <jbaron@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 14:15 +0000, David Laight wrote:
> > +#define arch_syscall_match_sym_name(sym, name) !strcmp(sym + 3, name
> + 3)
> 
> Whenever you use a #define macro arg, you should enclose it in ().
> About the only time you don't need to is when it is being
> passed as an argument to another function
> (ie when it's use is also ',' separated).
> 
> So the above ought to be:
> #define arch_syscall_match_sym_name(sym, name) (!strcmp((sym) + 3,
> (name) + 3))

I would have mentioned this if I wanted it to stay a macro ;)

> 
> Whether an inline function is better or worse is much more subtle!
> For instance I've used:
>    asm volatile ( "# line " STR(__LINE__) :: )
> to stop gcc merging the tails of conditionals.
> Useful when the conditional is at the end of a loop (etc),
> it might increase code size slightly, but removes a branch.
> 
> If I put one of those in an 'inline' function separate copies
> of the function end up sharing code.
> With a #define __LINE__ differs so they don't.
> 
> (I had some code to get below 190 clocks, these changes
> were significant!)

For what you were doing, this may have helped. But the code in question
is the "default" version of the function. I much more prefer it to be a
static inline. The issues you experience could change from gcc to gcc.
But static inlined functions are much cleaner and easier to read than
macros.

Using a macro for this purpose is just too messy.

Again, look at include/trace/ftrace.h. If I'm saying using a macro is
ugly, then don't use it! Listen to me, because I'm Mr. Ugly Macro Man.

-- Steve
