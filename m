Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C7172C0079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 15:52:19 +1000 (EST)
Received: by wibhq4 with SMTP id hq4so3525282wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 22:52:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 14 Sep 2012 07:52:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 0/8] Avoid cache trashing on clearing huge/gigantic page
Message-ID: <20120914055210.GC9043@gmail.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120913160506.d394392a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120913160506.d394392a.akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 Jan Beulich <jbeulich@novell.com>, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Robert Richter <robert.richter@amd.com>, x86@kernel.org,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Alex Shi <alex.shu@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 20 Aug 2012 16:52:29 +0300
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > Clearing a 2MB huge page will typically blow away several levels of CPU
> > caches.  To avoid this only cache clear the 4K area around the fault
> > address and use a cache avoiding clears for the rest of the 2MB area.
> > 
> > This patchset implements cache avoiding version of clear_page only for
> > x86. If an architecture wants to provide cache avoiding version of
> > clear_page it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> > clear_page_nocache() and clear_user_highpage_nocache().
> 
> Patchset looks nice to me, but the changelogs are terribly 
> short of performance measurements.  For this sort of change I 
> do think it is important that pretty exhaustive testing be 
> performed, and that the results (or a readable summary of 
> them) be shown.  And that testing should be designed to probe 
> for slowdowns, not just the speedups!

That is my general impression as well.

Firstly, doing before/after "perf stat --repeat 3 ..." runs 
showing a statistically significant effect on a workload that is 
expected to win from this, and on a workload expected to be 
hurting from this would go a long way towards convincing me.

Secondly, if you can find some user-space simulation of the 
intended positive (and negative) effects then a 'perf bench' 
testcase designed to show weakness of any such approach, running 
the very kernel assembly code in user-space would also be rather 
useful.

See:

comet:~/tip> git grep x86 tools/perf/bench/ | grep inclu
tools/perf/bench/mem-memcpy-arch.h:#include "mem-memcpy-x86-64-asm-def.h"
tools/perf/bench/mem-memcpy-x86-64-asm.S:#include "../../../arch/x86/lib/memcpy_64.S"
tools/perf/bench/mem-memcpy.c:#include "mem-memcpy-x86-64-asm-def.h"
tools/perf/bench/mem-memset-arch.h:#include "mem-memset-x86-64-asm-def.h"
tools/perf/bench/mem-memset-x86-64-asm.S:#include "../../../arch/x86/lib/memset_64.S"
tools/perf/bench/mem-memset.c:#include "mem-memset-x86-64-asm-def.h"

that code uses the kernel-side assembly code and runs it in 
user-space.

Although obviously clearing pages on page faults needs some care 
to properly simulate in user-space.

Without repeatable hard numbers such code just gets into the 
kernel and bitrots there as new CPU generations come in - a few 
years down the line the original decisions often degrade to pure 
noise. We've been there, we've done that, we don't want to 
repeat it.

Thanks,

	Ingo
