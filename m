Return-Path: <hugh@veritas.com>
Date: Fri, 25 Jul 2008 19:45:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: CONFIG_FRAME_POINTER [was [PATCH] x86: BUILD_IRQ say .text]
In-Reply-To: <20080724104459.GI28817@elte.hu>
Message-ID: <Pine.LNX.4.64.0807251839190.20617@blonde.site>
References: <Pine.LNX.4.64.0807211828470.26173@blonde.site>
	<20080724104459.GI28817@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: the arch/x86 maintainers <x86@kernel.org>, Linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jul 2008, Ingo Molnar wrote:
> * Hugh Dickins <hugh@veritas.com> wrote:
> 
> > I've been using -fno-unit-at-a-time (to lessen inlining, for easier 
> > debugging) for a long time
> 
> Should we perhaps enable this automatically on CONFIG_FRAME_POINTER=y 
> builds? Although a separate, default-off config option might be better, 

I'm content to go on patching the Makefile to suit my own private debug
proclivities, somewhat reluctant to foist them upon others.  But I must
have found no-unit-at-a-time made things clearer at some point,
and assume it is still being useful.

Whether it deserves its own config option, hmm, not sure of that.
But agree it shouldn't really go into CONFIG_FRAME_POINTER=y
(though notice that already bundles no-optimize-sibling-calls).

I rather think CONFIG_FRAME_POINTER shouldn't exist at all (or be
a private, config-user-invisible, specific-to-a-few-arches thing):
what one wants to configure is how far to sacrifice cpu performance
and kernel smallness to getting a good stacktrace.  Frame pointer
is just an implementation detail on that, appropriate to some arches.
Perhaps three settings: no stacktrace, fair stacktrace, best stacktrace.

I've Cc'ed Ben and linuxppc-dev because I wonder if they're aware
that several options (I got it from LATENCYTOP, but I think LOCKDEP
and FTRACE and some others) are doing a "select FRAME_POINTER",
which forces CONFIG_FRAME_POINTER=y on PowerPC, even though
FRAME_POINTER is not an option offered on PowerPC.  The
resulting kernels appear to run okay, but I was surprised.

> i'd not be surprised if there were more regressions in this area, it's a 
> seldom used build vector.

There'd probably be a lot more if we weren't (recently?) supporting
compilers which only manage no-unit-at-a-time.  The only issue I get
in my kernel builds is with sched_clock() - but I've not been trying
allyesconfig or randconfig.  Here's a patch: but whereas the BUILD_IRQ
one seemed worth sending because the problem might crop up in other
ways and waste someone's time, this one just depends on your taste.


[PATCH] sched: move sched_clock before first use

Move sched_clock() up to stop warning: weak declaration of `sched_clock'
after first use results in unspecified behavior (if -fno-unit-at-a-time).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 kernel/sched_clock.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- 2.6.26-git/kernel/sched_clock.c	2008-07-18 11:33:34.000000000 +0100
+++ linux/kernel/sched_clock.c	2008-07-18 11:57:46.000000000 +0100
@@ -32,6 +32,15 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ * This is default implementation.
+ * Architectures and sub-architectures can override this.
+ */
+unsigned long long __attribute__((weak)) sched_clock(void)
+{
+	return (unsigned long long)jiffies * (NSEC_PER_SEC / HZ);
+}
 
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 
@@ -321,16 +330,6 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeu
 
 #endif
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- * This is default implementation.
- * Architectures and sub-architectures can override this.
- */
-unsigned long long __attribute__((weak)) sched_clock(void)
-{
-	return (unsigned long long)jiffies * (NSEC_PER_SEC / HZ);
-}
-
 unsigned long long cpu_clock(int cpu)
 {
 	unsigned long long clock;
