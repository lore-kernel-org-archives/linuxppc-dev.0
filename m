Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57ADDB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 15:56:46 +1100 (EST)
Date: Tue, 19 Oct 2010 15:56:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: manual merge of the tip tree with the powerpc tree
Message-Id: <20101019155644.ebd2d802.sfr@canb.auug.org.au>
In-Reply-To: <20101019154849.126a736a.sfr@canb.auug.org.au>
References: <20101019154849.126a736a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi again,

On Tue, 19 Oct 2010 15:48:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the tip tree got a conflict in
> arch/powerpc/kernel/time.c between commit
> cf9efce0ce3136fa076f53e53154e98455229514 ("powerpc: Account time using
> timebase rather than PURR") from the powerpc tree and commit
> e360adbe29241a0194e10e20595360dd7b98a2b3 ("irq_work: Add generic hardirq
> context callbacks") from the tip tree.
> 
> Just context changes.  I fixed it up and can carry the fix as necessary.

I forgot the merge diff, sorry:

diff --cc arch/powerpc/kernel/time.c
index 644f918,54888eb..0000000
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@@ -578,9 -585,11 +578,9 @@@ void timer_interrupt(struct pt_regs * r
  	old_regs = set_irq_regs(regs);
  	irq_enter();
  
- 	if (test_perf_event_pending()) {
- 		clear_perf_event_pending();
- 		perf_event_do_pending();
 -	calculate_steal_time();
 -
+ 	if (test_irq_work_pending()) {
+ 		clear_irq_work_pending();
+ 		irq_work_run();
  	}
  
  #ifdef CONFIG_PPC_ISERIES

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
