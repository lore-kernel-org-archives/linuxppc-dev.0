Return-Path: <roland@redhat.com>
Received: from QMTA08.emeryville.ca.mail.comcast.net
	(qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
	by ozlabs.org (Postfix) with ESMTP id 6D5DDDDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 11:24:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: unprivileged use of MSR_SE
Message-Id: <20080320002407.D911C26F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 17:24:07 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Are there any powerpc instructions that can read or change the MSR
explicitly from user mode?  Any that can see or affect the MSR_SE bit?

e.g. x86 has pushf/popf unprivileged instructions, with which a user
program can both see the single-step flag set, and enable single-step for
its own next instruction (presumably when it has a handler for SIGTRAP).
This actually gets used in arcane places.

I recall being told before there's no unprivileged way to see or touch
MSR_SE.  But it looks to me like a user program can set the bit in a
sigcontext and sigreturn to set it.  Is that intentionally supported?
Or could sigreturn ignore the MSR_SE bit without breaking any strange user?

On x86 do we some machinations so that PTRACE_GETREGS et al show the
single-step bit set if user-mode itself had set it, but not if
PTRACE_SINGLESTEP set it.  If you use PTRACE_SETREGS et al to set the
single-step bit, then it stays set even if you use PTRACE_CONT.

I'd like to clean this up for powerpc too.  If there is no way at all for
user-mode to set MSR_SE, then it doesn't much matter whether it shows up
when ptrace reads it--ptrace just needs to ignore attempts to set it.  So
if there's no reason not to, what I would do is remove MSR_SE from the
MSR_DEBUGCHANGE mask and make sigreturn always clear MSR_SE.

Does that make sense?


Thanks,
Roland
