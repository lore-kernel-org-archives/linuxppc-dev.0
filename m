Return-Path: <tony.luck@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 60C2DDDE3A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 06:07:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Date: Tue, 5 Feb 2008 11:05:03 -0800
Message-ID: <1FE6DD409037234FAB833C420AA843EC8130DD@orsmsx424.amr.corp.intel.com>
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
To: "Ingo Molnar" <mingo@elte.hu>
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

> Applied that patch and UP kernel built ok, and then crashed in the
> same place with the memset() to a user-looking address from =
kmem_cache_alloc()
>
> So the percpu changes are innocent ... something else since 2.6.24 is
> to blame.  Only 5749 commits :-)  I'll start bisecting.

The bisection narrowed in on an innocent patch in ipv4 space.  Meanwhile
the rush of patches continues.  When I retested yesterday when Linus
HEAD was 8af03e782... the CONFIG_SMP=3Dn kernel worked perfectly.  So
maybe it was fixed?  Or maybe the bug depends on the relative
location of various bits of code/data and as the kernel grows and
shrinks with incoming changes the problem comes and goes :-(

-Tony
