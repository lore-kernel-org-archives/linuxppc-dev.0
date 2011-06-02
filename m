Return-Path: <tony.luck@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E172B6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 09:00:54 +1000 (EST)
Received: by iym7 with SMTP id 7so1401902iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Jun 2011 16:00:51 -0700 (PDT)
MIME-Version: 1.0
Sender: tony.luck@gmail.com
In-Reply-To: <201106030032.17398.richard@nod.at>
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>
	<201106030032.17398.richard@nod.at>
Date: Thu, 2 Jun 2011 16:00:51 -0700
Message-ID: <BANLkTik9kCs_06=7HKo44cWqpS0zB9fr+A@mail.gmail.com>
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
From: Tony Luck <tony.luck@intel.com>
To: Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset=windows-1252
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	oleg@redhat.com, paulus@samba.org, ralf@linux-mips.org,
	hpa@zytor.com, sparclinux@vger.kernel.org,
	linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
	fenghua.yu@intel.com, user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	viro@zeniv.linux.org.uk, tglx@linutronix.de, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
	lethal@linux-sh.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> But there seems to be another problem.
> Why is pt_regs of type void *?
>
> gcc complains:
> In file included from include/linux/fsnotify.h:15:0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from include/linux/security.h:26,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from init/main.c:32:
> include/linux/audit.h: In function =91audit_syscall_exit=92:
> include/linux/audit.h:440:17: warning: dereferencing =91void *=92 pointer
> include/linux/audit.h:440:3: error: invalid use of void expression
> include/linux/audit.h:441:21: warning: dereferencing =91void *=92 pointer
> include/linux/audit.h:441:21: error: void value not ignored as it ought t=
o be

Perhaps same issue on ia64 - but symptoms are different:

  CC      crypto/cipher.o
In file included from include/linux/fsnotify.h:15,
                 from include/linux/security.h:26,
                 from init/do_mounts.c:8:
include/linux/audit.h: In function =91audit_syscall_exit=92:
include/linux/audit.h:440: warning: dereferencing =91void *=92 pointer
include/linux/audit.h:440: error: request for member =91r10=92 in
something not a structure or union
include/linux/audit.h:441: error: request for member =91r10=92 in
something not a structure or union
include/linux/audit.h:441: error: request for member =91r8=92 in something
not a structure or union
include/linux/audit.h:441: error: request for member =91r8=92 in something
not a structure or union
include/linux/audit.h:441: error: expected =91;=92 before =91}=92 token
include/linux/audit.h:441: error: void value not ignored as it ought to be

-Tony
