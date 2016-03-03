Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0475E1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 20:23:45 +1100 (AEDT)
Message-ID: <1456997018.335.7.camel@ellerman.id.au>
Subject: Re: hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org,  mingo@redhat.com, paulus@samba.org
Date: Thu, 03 Mar 2016 20:23:38 +1100
In-Reply-To: <20160302115942.GC6356@twins.programming.kicks-ass.net>
References: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160302115324.63B35140BF5@ozlabs.org>
 <20160302115942.GC6356@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-02 at 12:59 +0100, Peter Zijlstra wrote:

> On Wed, Mar 02, 2016 at 10:53:24PM +1100, Michael Ellerman wrote:

> > Peterz, acme, do you guys want to take this? Or should I?
>
> I'm not too happy its touching event->ctx at all. It really should not
> be doing that.

Hmm OK.

It's been using ctx->task since it was merged in 2010. In fact that commit also
added arch_unregister_hw_breakpoint(), and we're still the only user of that.

The prima facie reason it's using ctx is to get at task->thread to clear
last_hit_ubp.

It looks like other arches avoid needing to do something similar by storing the
break point in a per-cpu array. Which I guess is what you meant in your other
mail ("Why do you keep per task state anyway?").

I can't think of a reason why we can't also store it per-cpu, but I could be
wrong, I don't know the code well and I haven't thought about it for very long.

Do you mind if I merge the following fix for now as a band-aid, and we'll try
and fix it up properly in the next few weeks (but maybe not in time for 4.5
final).

cheers


diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 05e804cdecaa..aec9a1b1d25b 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -109,8 +109,9 @@ void arch_unregister_hw_breakpoint(struct perf_event *bp)
 	 * If the breakpoint is unregistered between a hw_breakpoint_handler()
 	 * and the single_step_dabr_instruction(), then cleanup the breakpoint
 	 * restoration variables to prevent dangling pointers.
+	 * FIXME, this should not be using bp->ctx at all! Sayeth peterz.
 	 */
-	if (bp->ctx && bp->ctx->task)
+	if (bp->ctx && bp->ctx->task && bp->ctx->task != ((void *)-1L))
 		bp->ctx->task->thread.last_hit_ubp = NULL;
 }
 
