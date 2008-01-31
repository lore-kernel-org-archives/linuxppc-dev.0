Return-Path: <tony.luck@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by ozlabs.org (Postfix) with ESMTP id 43871DDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 10:28:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Date: Thu, 31 Jan 2008 15:28:13 -0800
Message-ID: <1FE6DD409037234FAB833C420AA843EC78CC73@orsmsx424.amr.corp.intel.com>
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC78C75A@orsmsx424.amr.corp.intel.com>
References: <20080130180623.GA24881@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757DEA@orsmsx424.amr.corp.intel.com>
	<47A0CD4B.5040706@sgi.com>
	<1FE6DD409037234FAB833C420AA843EC757F12@orsmsx424.amr.corp.intel.com>
	<20080130194616.GA19426@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757F7C@orsmsx424.amr.corp.intel.com>
	<20080130200221.GA28073@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC757FC2@orsmsx424.amr.corp.intel.com>
	<20080130205915.GA4562@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC78C219@orsmsx424.amr.corp.intel.com>
	<20080131090642.GA5688@elte.hu>
	<1FE6DD409037234FAB833C420AA843EC78C75A@orsmsx424.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>,
	"Ingo Molnar" <mingo@elte.hu>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> So the percpu changes are innocent ... something else since 2.6.24 is
> to blame.  Only 5749 commits :-)  I'll start bisecting.

12 bisections later ... nothing!  I think I got lost in the
maze.  Bisection #5 had a crash, but it looked to be a very
differnt crash (and looked to happen later than the bug I was
hunting).  So I marked that as "good" on the theory that it
looked like this bug wasn't in the kernel. Same thing happened
at bisection #9.  But I ended up with:

commit bfada697bd534d2c16fd07fbef3a4924c4d4e014
Author: Pavel Emelyanov <xemul@openvz.org>
Date:   Sun Dec 2 00:57:08 2007 +1100

    [IPV4]: Use ctl paths to register devinet sysctls


Which just looks too improbable to be the cause of the UP
crash.  Git won't revert it out from top of tree automatically
so I can't easily test whether some weird magic means that
this is the buggy commit.

Perhaps the issue is another offset of object X in kernel w.r.t.
object Y ... and so the good/bad choices in the bisection are
actually pretty random depending on how much code is stuffed
between X & Y at each bisection point.

-Tony
