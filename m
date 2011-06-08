Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A870DB6FBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 02:39:42 +1000 (EST)
Date: Wed, 8 Jun 2011 18:36:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
Message-ID: <20110608163653.GA9592@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
	<20110607171952.GA25729@redhat.com>
	<1307472796.2052.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307472796.2052.12.camel@localhost.localdomain>
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

On 06/07, Eric Paris wrote:
>
> On Tue, 2011-06-07 at 19:19 +0200, Oleg Nesterov wrote:
> >
> > With or without this patch, can't we call audit_syscall_exit() twice
> > if there is something else in _TIF_WORK_SYSCALL_EXIT mask apart from
> > SYSCALL_AUDIT ? First time it is called from asm, then from
> > syscall_trace_leave(), no?
> >
> > For example. The task has TIF_SYSCALL_AUDIT and nothing else, it does
> > system_call->auditsys->system_call_fastpath. What if it gets, say,
> > TIF_SYSCALL_TRACE before ret_from_sys_call?
>
> No harm is done calling twice.  The first call will do the real work and
> cleanup.  It will set a flag in the audit data that the work has been
> done (in_syscall == 0) thus the second call will then not do any real
> work and won't have anything to clean up.

Hmm... and I assume context->previous != NULL is not possible on x86_64.
OK, thanks.

And I guess, all CONFIG_AUDITSYSCALL code in entry.S is only needed to
microoptimize the case when TIF_SYSCALL_AUDIT is the only reason for the
slow path. I wonder if it really makes the measureble difference...

Oleg.
