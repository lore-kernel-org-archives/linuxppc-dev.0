Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "radon.swed.at", Issuer "neon.swed.at" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9DCB6B6FA7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 08:41:34 +1000 (EST)
From: Richard Weinberger <richard@nod.at>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
Date: Fri, 3 Jun 2011 00:32:16 +0200
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>
In-Reply-To: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201106030032.17398.richard@nod.at>
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

Am Donnerstag 02 Juni 2011, 23:04:58 schrieb Eric Paris:
> b/arch/um/sys-i386/shared/sysdep/ptrace.h index d50e62e..ef5c310 100644
> --- a/arch/um/sys-i386/shared/sysdep/ptrace.h
> +++ b/arch/um/sys-i386/shared/sysdep/ptrace.h
> @@ -162,6 +162,7 @@ struct syscall_args {
>  #define UPT_ORIG_SYSCALL(r) UPT_EAX(r)
>  #define UPT_SYSCALL_NR(r) UPT_ORIG_EAX(r)
>  #define UPT_SYSCALL_RET(r) UPT_EAX(r)
> +#define regs_return_value UPT_SYSCALL_RET

This does not work at all.
UPT_SYSCALL_RET expects something of type struct uml_pt_regs.

#define regs_return_value REGS_EAX
Would be correct. (For x86_64 it needs to be REGS_RAX)

But there seems to be another problem.
Why is pt_regs of type void *?

gcc complains:
In file included from include/linux/fsnotify.h:15:0,
                 from include/linux/security.h:26,
                 from init/main.c:32:
include/linux/audit.h: In function =E2=80=98audit_syscall_exit=E2=80=99:
include/linux/audit.h:440:17: warning: dereferencing =E2=80=98void *=E2=80=
=99 pointer
include/linux/audit.h:440:3: error: invalid use of void expression
include/linux/audit.h:441:21: warning: dereferencing =E2=80=98void *=E2=80=
=99 pointer
include/linux/audit.h:441:21: error: void value not ignored as it ought to =
be

Thanks,
//richard
