Return-Path: <tony.luck@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by ozlabs.org (Postfix) with ESMTP id D1341DE128
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 05:34:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Date: Thu, 31 Jan 2008 10:34:23 -0800
Message-ID: <1FE6DD409037234FAB833C420AA843EC78C75A@orsmsx424.amr.corp.intel.com>
In-Reply-To: <20080131090642.GA5688@elte.hu>
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

> hm, as far as i could check, on ia64 UP the .percpu section link=20
> difference was the only ia64 difference i could find out of those=20
> changes. Could you try to copy a 2.6.24 include/asm-generic/percpu.h,=20
> include/asm-ia64.h and include/linux/percpu.h into your current tree,=20
> and see whether that boots? If yes, then it's the percpu changes. The=20
> patch below does this ontop of very latest -git - and it builds fine=20
> with your UP config with a crosscompiler.

Applied that patch and UP kernel built ok, and then crashed in the
same place with the memset() to a user-looking address from =
kmem_cache_alloc()

So the percpu changes are innocent ... something else since 2.6.24 is
to blame.  Only 5749 commits :-)  I'll start bisecting.

-Tony
