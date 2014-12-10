Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AAD01A0013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 10:06:30 +1100 (AEDT)
Message-ID: <1418252789.26146.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: secondary CPUs signal to master before setting
 active and online (fixes kernel BUG at kernel/smpboot.c:134!)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Dec 2014 10:06:29 +1100
In-Reply-To: <CA+55aFyR5PzNkojvEej1NXnpEFOPOYfnxCcPDAjg1rE79tQv7A@mail.gmail.com>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
 <20141208083408.GA8023@gmail.com> <20141208211859.6e81ec81@kryten>
 <20141209105819.0e847b4b@kryten>
 <CA+55aFyR5PzNkojvEej1NXnpEFOPOYfnxCcPDAjg1rE79tQv7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Yuanhan Liu <yuanhan.liu@linux.intel.com>,
 Benjamin Segall <bsegall@google.com>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
 yuyang.du@intel.com, Daniel J Blueman <daniel@numascale.com>,
 Steven Rostedt <rostedt@goodmis.org>, Anton Blanchard <anton@samba.org>,
 subbaram@codeaurora.org, Thomas Gleixner <tglx@linutronix.de>,
 Wu Fengguang <fengguang.wu@intel.com>, lkp@01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Slava Pestov <sp@datera.io>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 12:54 -0800, Linus Torvalds wrote:
> On Mon, Dec 8, 2014 at 3:58 PM, Anton Blanchard <anton@samba.org> wrote:
> > Hi Ingo,
> >
> >> At that point I thought the previous task_cpu() was somewhat ingrained
> >> in the scheduler and came up with the patch. If not, we could go on a
> >> hunt to see what else needs fixing.
> >
> > I had another look. The scheduled does indeed make assumptions about the
> > previous task_cpu, but we have a hammer to fix it up called
> > select_fallback_rq.
> >
> > I annotated select_fallback_rq, and did hit a case where the CPU was
> > not active. ppc64 patch below.
> 
> Anton, I'll assume I will get this through the usual powerpc pull requests?

Yeah I'll put it in my tree unless Anton objects.

cheers
