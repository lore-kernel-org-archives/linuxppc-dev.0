Return-Path: <eparis@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 4B446B6FD3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 04:14:47 +1000 (EST)
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
From: Eric Paris <eparis@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 08 Jun 2011 14:13:36 -0400
In-Reply-To: <20110608163653.GA9592@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
	<20110607171952.GA25729@redhat.com>
	<1307472796.2052.12.camel@localhost.localdomain>
	<20110608163653.GA9592@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1307556823.2577.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, richard@nod.at, x86@kernel.org,
	mingo@redhat.com, fenghua.yu@intel.com,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	viro@zeniv.linux.org.uk, tglx@linutronix.de, monstr@monstr.eu,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org, schwidefsky@de.ibm.com,
	linux390@de.ibm.com, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-08 at 18:36 +0200, Oleg Nesterov wrote:
> On 06/07, Eric Paris wrote:
> >
> > On Tue, 2011-06-07 at 19:19 +0200, Oleg Nesterov wrote:
> > >
> > > With or without this patch, can't we call audit_syscall_exit() twice
> > > if there is something else in _TIF_WORK_SYSCALL_EXIT mask apart from
> > > SYSCALL_AUDIT ? First time it is called from asm, then from
> > > syscall_trace_leave(), no?
> > >
> > > For example. The task has TIF_SYSCALL_AUDIT and nothing else, it does
> > > system_call->auditsys->system_call_fastpath. What if it gets, say,
> > > TIF_SYSCALL_TRACE before ret_from_sys_call?
> >
> > No harm is done calling twice.  The first call will do the real work and
> > cleanup.  It will set a flag in the audit data that the work has been
> > done (in_syscall == 0) thus the second call will then not do any real
> > work and won't have anything to clean up.
> 
> Hmm... and I assume context->previous != NULL is not possible on x86_64.
> OK, thanks.
> 
> And I guess, all CONFIG_AUDITSYSCALL code in entry.S is only needed to
> microoptimize the case when TIF_SYSCALL_AUDIT is the only reason for the
> slow path. I wonder if it really makes the measureble difference...

All I know is what Roland put in the changelog:

Avoiding the iret return path when syscall audit is enabled helps
performance a lot.

I believe this was a result of Fedora starting auditd by default and
then Linus bitching about how slow a null syscall in a tight loop was.
It was an optimization for a microbenchmark.  How much it affects things
on a real syscall that does real work is probably going to be determined
by how much work is done in the syscall.  (or just disable auditd in
userspace)

-Eric
