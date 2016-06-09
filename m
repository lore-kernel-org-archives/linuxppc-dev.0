Return-Path: <luto@amacapital.net>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com
 [IPv6:2607:f8b0:4003:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQgQc2q20zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 08:46:32 +1000 (AEST)
Received: by mail-oi0-x22e.google.com with SMTP id w5so7731648oib.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 15:46:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465506124-21866-6-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
 <1465506124-21866-6-git-send-email-keescook@chromium.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 9 Jun 2016 15:46:10 -0700
Message-ID: <CALCETrUsqr3YbD=5mA9mRmgYqiHeEoLpWi-teyexUo_jR1BaFA@mail.gmail.com>
Subject: Re: [PATCH 05/14] seccomp: recheck the syscall after RET_TRACE
To: Kees Cook <keescook@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>,
 linux-arch <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "Maciej W. Rozycki" <macro@imgtec.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>,
 Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
> When RET_TRACE triggers, a tracer may change a syscall into something that
> should be filtered by seccomp. This re-runs seccomp after a trace event
> to make sure things continue to pass.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>  kernel/seccomp.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 14a37d71b612..54d15eb2b701 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -556,7 +556,8 @@ void secure_computing_strict(int this_syscall)
>  #else
>
>  #ifdef CONFIG_SECCOMP_FILTER
> -static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
> +static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
> +                           const bool recheck_after_trace)

This patch looks good with one minor nit: I read this as "pass true if
you want to recheck after trace", which is exactly the opposite of how
it works.

--Andy
