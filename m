Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PBl26hS4zF1pD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 23:12:43 +1000 (AEST)
Date: Sun, 15 Apr 2018 14:12:06 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Dmitry V. Levin" <ldv@altlinux.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
Message-ID: <20180415131206.GR16141@n2100.armlinux.org.uk>
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
 <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
 <20180413170827.GB16308@e103592.cambridge.arm.com>
 <20180413175407.GO16141@n2100.armlinux.org.uk>
 <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
 <20180413184522.GD16308@e103592.cambridge.arm.com>
 <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2018 at 12:53:49PM -0700, Linus Torvalds wrote:
> On Fri, Apr 13, 2018 at 11:45 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > Most uses I've seen do nothing more than use the FPE_xyz value to
> > format diagnostic messages while dying.  I struggled to find code that
> > made a meaningful functional decision based on the value, though that's
> > not proof...
> 
> Yeah. I've seen code that cares about SIGFPE deeply, but it's almost
> invariably about some emulated environment (eg Java VM, or CPU
> emulation).
> 
> And the siginfo data is basically never good enough for those
> environments anyway on its own, so they will go and look at the actual
> instruction that caused the fault and the register state instead,
> because they need *all* the information.
> 
> The cases that use si_code are the ones that just trapped signals in
> order to give a more helpful abort message.
> 
> So I could certainly imagine that si_code is actually used by somebody
> who then decides to actuall act differently on it, but aside from
> perhaps printing out a different message, it sounds far-fetched.

Okay, in that case let's just use FPE_FLTINV.  That makes the patch
easily back-portable for stable kernels.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
