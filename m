Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A2EEFB6FD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 04:39:36 +1000 (EST)
Date: Wed, 8 Jun 2011 20:37:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
Message-ID: <20110608183720.GA16883@redhat.com>
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
	<20110607171952.GA25729@redhat.com>
	<1307472796.2052.12.camel@localhost.localdomain>
	<20110608163653.GA9592@redhat.com>
	<1307556823.2577.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307556823.2577.5.camel@localhost.localdomain>
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

On 06/08, Eric Paris wrote:
>
> On Wed, 2011-06-08 at 18:36 +0200, Oleg Nesterov wrote:
> > And I guess, all CONFIG_AUDITSYSCALL code in entry.S is only needed to
> > microoptimize the case when TIF_SYSCALL_AUDIT is the only reason for the
> > slow path. I wonder if it really makes the measureble difference...
>
> All I know is what Roland put in the changelog:
>
> Avoiding the iret return path when syscall audit is enabled helps
> performance a lot.
>
> I believe this was a result of Fedora starting auditd by default and
> then Linus bitching about how slow a null syscall in a tight loop was.
> It was an optimization for a microbenchmark.  How much it affects things
> on a real syscall that does real work is probably going to be determined
> by how much work is done in the syscall.

and probably by how much work is done in audit_syscall_entry/exit.

OK. Thanks a lot Eric for your explanations.

Oleg.
