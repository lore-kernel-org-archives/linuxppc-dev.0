Return-Path: <linus971@gmail.com>
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40N5kj2jWdzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Apr 2018 04:23:40 +1000 (AEST)
Received: by mail-io0-x22f.google.com with SMTP id t13so3721321ioc.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 11:23:40 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180413175407.GO16141@n2100.armlinux.org.uk>
References: <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 11:23:36 -0700
Message-ID: <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Dave Martin <Dave.Martin@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Dmitry V. Levin" <ldv@altlinux.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2018 at 10:54 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> FPE_FLTINV means "floating point invalid operation".  Does it really
> cover the case where hardware has failed, or is it intended to cover
> the case where userspace did something wrong and asked for an invalid
> operation from the FP hardware?

Note that the number of people who actually look at the si_code is
approximately zero.

But the ones that _do_ check the si_code are certainly not going to
check it against a new code that they don't know about.

I suspect that if you start searching for FLT_xyz occurrences in code,
approximately 100% of them are from the kernel code that generates
them, not from any actual users.

So I'd be very surprised if you can find *anybody* who cares about
that exact value (with the possible exceptions of test-suites).

Sadly, google code-search is no more. It was useful for things like that.

                Linus
