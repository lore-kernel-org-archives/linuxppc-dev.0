Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E7357679EA
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 08:06:52 +1000 (EST)
Date: Sat, 1 Apr 2006 14:06:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: "tvec_bases too large for per-cpu data" commit broke
	early_serial_setup()
Message-Id: <20060401140610.2ec67738.akpm@osdl.org>
In-Reply-To: <20060401205336.GA5748@gate.ebshome.net>
References: <20060401205336.GA5748@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, jbeulich@novell.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eugene Surovegin <ebs@ebshome.net> wrote:
>
> Commit 
>  a4a6198b80cf82eb8160603c98da218d1bd5e104 
>  "[PATCH] tvec_bases too large for per-cpu data"
> 
>  broke early_serial_setup() and maybe other code which uses 
>  init_timer() before init_timers_cpu() is called.
> 
>  This commit introduced run-time initialization dependence which never 
>  existed before, namely, tvec_bases was always valid before this 
>  change, but now it's a pointer which should be initialized prior to 
>  use of any timer function.
> 
>  If init_timer() is called before such initialization (in my case this 
>  happens when PPC440GX board support code calls early_serial_setup to 
>  register UARTs, serial8250_isa_init_ports() calls init_timer()), 
>  "base" field in the timer_list struct is set to NULL.
> 
>  When later mod_timer() is called for such timer it hangs in 
>  lock_timer_base().
> 
>  Rolling back this commit fixes the problem, although, this is 
>  obviously not a proper fix.
> 

Thanks.   Early boot is ugly.

Does this fix it?



From: Andrew Morton <akpm@osdl.org>

We need the boot CPU's tvec_bases[] entry to be initialised super-early in
boot, for early_serial_setup().  That runs within setup_arch(), before even
per-cpu areas are initialised.

The patch changes tvec_bases to use compile-time initialisation, and adds a
separate array `tvec_base_done' to keep track of which CPU has had its
tvec_bases[] entry initialised (because we can no longer use the zeroness of
that tvec_bases[] entry to determine whether it has been initialised).

Thanks to Eugene Surovegin <ebs@ebshome.net> for diagnosing this.

Cc: Eugene Surovegin <ebs@ebshome.net>
Cc: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/timer.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff -puN kernel/timer.c~timer-initialisation-fix kernel/timer.c
--- devel/kernel/timer.c~timer-initialisation-fix	2006-04-01 14:04:00.000000000 -0800
+++ devel-akpm/kernel/timer.c	2006-04-01 14:04:00.000000000 -0800
@@ -81,9 +81,11 @@ struct tvec_t_base_s {
 } ____cacheline_aligned_in_smp;
 
 typedef struct tvec_t_base_s tvec_base_t;
-static DEFINE_PER_CPU(tvec_base_t *, tvec_bases);
+
 tvec_base_t boot_tvec_bases;
 EXPORT_SYMBOL(boot_tvec_bases);
+static DEFINE_PER_CPU(tvec_base_t *, tvec_bases) = { &boot_tvec_bases };
+static char tvec_base_done[NR_CPUS];
 
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
@@ -1225,27 +1227,34 @@ static int __devinit init_timers_cpu(int
 	int j;
 	tvec_base_t *base;
 
-	base = per_cpu(tvec_bases, cpu);
-	if (!base) {
+	if (!tvec_base_done[cpu]) {
 		static char boot_done;
 
-		/*
-		 * Cannot do allocation in init_timers as that runs before the
-		 * allocator initializes (and would waste memory if there are
-		 * more possible CPUs than will ever be installed/brought up).
-		 */
 		if (boot_done) {
+			/*
+			 * The APs use this path later in boot
+			 */
 			base = kmalloc_node(sizeof(*base), GFP_KERNEL,
 						cpu_to_node(cpu));
 			if (!base)
 				return -ENOMEM;
 			memset(base, 0, sizeof(*base));
+			per_cpu(tvec_bases, cpu) = base;
 		} else {
-			base = &boot_tvec_bases;
+			/*
+			 * This is for the boot CPU - we use compile-time
+			 * static initialisation because per-cpu memory isn't
+			 * ready yet and because the memory allocators are not
+			 * initialised either.
+			 */
 			boot_done = 1;
+			base = &boot_tvec_bases;
 		}
-		per_cpu(tvec_bases, cpu) = base;
+		tvec_base_done[cpu] = 1;
+	} else {
+		base = per_cpu(tvec_bases, cpu);
 	}
+
 	spin_lock_init(&base->lock);
 	for (j = 0; j < TVN_SIZE; j++) {
 		INIT_LIST_HEAD(base->tv5.vec + j);
_
