Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2031BB6FC4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  5 Jun 2011 08:39:33 +1000 (EST)
From: Richard Weinberger <richard@nod.at>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH -v2] Audit: push audit success and retcode into arch
	ptrace.h
Date: Sun, 5 Jun 2011 00:36:44 +0200
References: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110603220451.23134.47368.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201106050036.44852.richard@nod.at>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	oleg@redhat.com, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, mingo@redhat.com, fenghua.yu@intel.com,
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

Am Samstag 04 Juni 2011, 00:04:51 schrieb Eric Paris:
> The audit system previously expected arches calling to audit_syscall_exit
> to supply as arguments if the syscall was a success and what the return
> code was. Audit also provides a helper AUDITSC_RESULT which was supposed
> to simplify things by converting from negative retcodes to an audit
> internal magic value stating success or failure.  This helper was wrong
> and could indicate that a valid pointer returned to userspace was a failed
> syscall.  The fix is to fix the layering foolishness.  We now pass
> audit_syscall_exit a struct pt_reg and it in turns calls back into arch
> code to collect the return value and to determine if the syscall was a
> success or failure.  We also define a generic is_syscall_success() macro
> which determines success/failure based on if the value is < -MAX_ERRNO. 
> This works for arches like x86 which do not use a separate mechanism to
> indicate syscall failure.
> 
> In arch/sh/kernel/ptrace_64.c I see that we were using regs[9] in the old
> audit code as the return value.  But the ptrace_64.h code defined the macro
> regs_return_value() as regs[3].  I have no idea which one is correct, but
> this patch now uses the regs_return_value() function, so it now uses
> regs[3].
> 
> We make both the is_syscall_success() and regs_return_value() static
> inlines instead of macros.  The reason is because the audit function must
> take a void* for the regs.  (uml calls theirs struct uml_pt_regs instead
> of just struct pt_regs so audit_syscall_exit can't take a struct pt_regs).
>  Since the audit function takes a void* we need to use static inlines to
> cast it back to the arch correct structure to dereference it.
> 
> The other major change is that on some arches, like ia64, we change
> regs_return_value() to give us the negative value on syscall failure.  The
> only other user of this macro, kretprobe_example.c, won't notice and it
> makes the value signed consistently for the audit functions across all
> archs.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Acked-by: H. Peter Anvin <hpa@zytor.com> [for x86 portion]

The UML part is now fine for me. :-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
