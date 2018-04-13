Return-Path: <linus971@gmail.com>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40N7km67sYzF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Apr 2018 05:53:52 +1000 (AEST)
Received: by mail-io0-x233.google.com with SMTP id p139so11521826iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 12:53:52 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180413184522.GD16308@e103592.cambridge.arm.com>
References: <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
 <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
 <20180413184522.GD16308@e103592.cambridge.arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 12:53:49 -0700
Message-ID: <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
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

On Fri, Apr 13, 2018 at 11:45 AM, Dave Martin <Dave.Martin@arm.com> wrote:
>
> Most uses I've seen do nothing more than use the FPE_xyz value to
> format diagnostic messages while dying.  I struggled to find code that
> made a meaningful functional decision based on the value, though that's
> not proof...

Yeah. I've seen code that cares about SIGFPE deeply, but it's almost
invariably about some emulated environment (eg Java VM, or CPU
emulation).

And the siginfo data is basically never good enough for those
environments anyway on its own, so they will go and look at the actual
instruction that caused the fault and the register state instead,
because they need *all* the information.

The cases that use si_code are the ones that just trapped signals in
order to give a more helpful abort message.

So I could certainly imagine that si_code is actually used by somebody
who then decides to actuall act differently on it, but aside from
perhaps printing out a different message, it sounds far-fetched.

                Linus
