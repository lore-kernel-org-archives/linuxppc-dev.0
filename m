Return-Path: <keescook@google.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT4gX0RlKzDqcl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 06:51:03 +1000 (AEST)
Received: by mail-wm0-x231.google.com with SMTP id n184so94718627wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 13:51:03 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 13 Jun 2016 13:50:57 -0700
Message-ID: <CAGXu5jJsWOdhRBauQ-_S-4ODd4m+xUbdjk1_zPXQqY7Qp-Dgdw@mail.gmail.com>
Subject: Re: [PATCH 00/14] run seccomp after ptrace
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 James Hogan <james.hogan@imgtec.com>,
 Jeff Dike <jdike@addtoit.com>, linux-arch <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "Maciej W. Rozycki" <macro@imgtec.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>,
 user-mode-linux-devel@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Oops, forgot to send this series through the lsm list...)

On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
> There has been a long-standing (and documented) issue with seccomp
> where ptrace can be used to change a syscall out from under seccomp.
> This is a problem for containers and other wider seccomp filtered
> environments where ptrace needs to remain available, as it allows
> for an escape of the seccomp filter.
>
> Since the ptrace attack surface is available for any allowed syscall,
> moving seccomp after ptrace doesn't increase the actually available
> attack surface. And this actually improves tracing since, for
> example, tracers will be notified of syscall entry before seccomp
> sends a SIGSYS, which makes debugging filters much easier.
>
> The per-architecture changes do make one (hopefully small)
> semantic change, which is that since ptrace comes first, it may
> request a syscall be skipped. Running seccomp after this doesn't
> make sense, so if ptrace wants to skip a syscall, it will bail
> out early similarly to how seccomp was. This means that skipped
> syscalls will not be fed through audit, though that likely means
> we're actually avoiding noise this way.
>
> This series first cleans up seccomp to remove the now unneeded
> two-phase entry, fixes the SECCOMP_RET_TRACE hole (same as the
> ptrace hole above), and then reorders seccomp after ptrace on
> each architecture.

Has anyone else had a chance to review this series? I'd like to get it
landed in -next as early as possible in case there are unexpected
problems...

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
