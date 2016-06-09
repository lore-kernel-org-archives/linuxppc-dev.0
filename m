Return-Path: <keescook@chromium.org>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQd6M6zV8zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 07:02:19 +1000 (AEST)
Received: by mail-pa0-x229.google.com with SMTP id b5so16517222pas.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 14:02:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 "Maciej W. Rozycki" <macro@imgtec.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>,
 user-mode-linux-devel@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 00/14] run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:01:50 -0700
Message-Id: <1465506124-21866-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There has been a long-standing (and documented) issue with seccomp
where ptrace can be used to change a syscall out from under seccomp.
This is a problem for containers and other wider seccomp filtered
environments where ptrace needs to remain available, as it allows
for an escape of the seccomp filter.

Since the ptrace attack surface is available for any allowed syscall,
moving seccomp after ptrace doesn't increase the actually available
attack surface. And this actually improves tracing since, for
example, tracers will be notified of syscall entry before seccomp
sends a SIGSYS, which makes debugging filters much easier.

The per-architecture changes do make one (hopefully small)
semantic change, which is that since ptrace comes first, it may
request a syscall be skipped. Running seccomp after this doesn't
make sense, so if ptrace wants to skip a syscall, it will bail
out early similarly to how seccomp was. This means that skipped
syscalls will not be fed through audit, though that likely means
we're actually avoiding noise this way.

This series first cleans up seccomp to remove the now unneeded
two-phase entry, fixes the SECCOMP_RET_TRACE hole (same as the
ptrace hole above), and then reorders seccomp after ptrace on
each architecture.

Thanks,

-Kees
