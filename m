Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id BFE84B6FDA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 05:22:01 +1000 (EST)
Date: Wed, 8 Jun 2011 21:19:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
Message-ID: <20110608191910.GA18698@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
	<20110607171952.GA25729@redhat.com>
	<1307472796.2052.12.camel@localhost.localdomain>
	<20110608163653.GA9592@redhat.com>
	<1307556823.2577.5.camel@localhost.localdomain>
	<20110608183720.GA16883@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110608183720.GA16883@redhat.com>
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

On 06/08, Oleg Nesterov wrote:
>
> OK. Thanks a lot Eric for your explanations.

Yes. but may I ask another one?

Shouldn't copy_process()->audit_alloc(tsk) path do
clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT) if it doesn't
set tsk->audit_context?

I can be easily wrong, but afaics otherwise the child can run
with TIF_SYSCALL_AUDIT bit copied from parent's thread_info by
dup_task_struct()->setup_thread_stack() and without ->audit_context,
right? For what?

Any other reason why audit_syscall_entry() checks context != NULL?

IOW. Any reason the patch below is wrong?

I am just curious, thanks.

Oleg.

--- x/kernel/auditsc.c
+++ x/kernel/auditsc.c
@@ -885,6 +885,8 @@ int audit_alloc(struct task_struct *tsk)
 	if (likely(!audit_ever_enabled))
 		return 0; /* Return if not auditing. */
 
+	clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+
 	state = audit_filter_task(tsk, &key);
 	if (likely(state == AUDIT_DISABLED))
 		return 0;
@@ -1591,9 +1593,7 @@ void audit_syscall_entry(int arch, int m
 	struct audit_context *context = tsk->audit_context;
 	enum audit_state     state;
 
-	if (unlikely(!context))
-		return;
-
+	BUG_ON(!context);
 	/*
 	 * This happens only on certain architectures that make system
 	 * calls in kernel_thread via the entry.S interface, instead of
