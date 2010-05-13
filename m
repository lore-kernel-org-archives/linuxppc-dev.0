Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 4307CB7E26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 May 2010 02:12:33 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.52])
	by hrndva-qmta01.mail.rr.com with ESMTP
	id <20100513160731481.IVFN29767@hrndva-qmta01.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2010 16:07:31 +0000
Subject: Re: ftrace syscalls, PowerPC: Fixes and PowerPC raw syscall
	tracepoint implementation
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Munsie <imunsie@au1.ibm.com>
In-Reply-To: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
References: <1273736594-19320-1-git-send-email-imunsie@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 13 May 2010 12:06:11 -0400
Message-ID: <1273766771.27703.1069.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic,

I'm fine with these patches, but since you mainly did the syscall work,
I'll let you take them.

The patches that touch the PowerPC code needs an acked-by from Ben or
Paul.

-- Steve


On Thu, 2010-05-13 at 17:43 +1000, Ian Munsie wrote:
> This patch series implements raw system call tracepoints on PowerPC that can be
> used with ftrace and perf. Some problems with the generic ftrace syscall
> tracepoint code have also been addressed.
> 
> The patches are based upon Ben's powerpc/next tree merged with tip/tracing/core
> 
> Patch #1 removes all ftrace syscall events that fail to map the system call
> name from the system call metadata with the system call's number, preventing
> the events which will not work from showing up in perf list and removing them
> from /sys/kernel/debug/tracing/events/syscalls.
> 
> Patches #2 and #3 allow for archs with unusual system call tables (#2) or
> unusual symbol names (#3) to override the appropriate functions so that they
> can still work with ftrace syscalls.
> 
> Patch #4 implements the actual raw system call tracepoints that ftrace syscalls
> builds upon, allowing all of the system calls to be used with the raw_syscalls
> events category and most to be used with the syscalls category.
> 
> 
> Not all the raw_syscalls are currently mapped to ftrace syscalls - the syscalls
> defined in /arch/powerpc/include/asm/syscalls.h do not use the SYSCALL_DEFINE
> class of macros and as such have no meta data, likewise some of the ppc_*
> syscalls have assembly wrappers. These are on their way, but I wanted to put
> the work I have done so far out first.
> 
> Some of those syscalls have different return types than the __SYSCALL_DEFINE
> macro uses (unsigned long, int, time_t) and some have different prefixes (ppc,
> ppc64) - I didn't particularly want to change them straight over without asking
> the list first, and I certainly don't want to change the return types. I see
> that Jason Baron ran into similar issues, but his "add compat syscall support"
> patches have yet to be merged, and do not tackle the differing return types.
> 
