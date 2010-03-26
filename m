Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DAD40B7067
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 09:03:35 +1100 (EST)
Date: Fri, 26 Mar 2010 23:03:29 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: peterz@infradead.org, mingo@elte.hu, tglx@linutronix.de,
	oleg@redhat.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 5/7] arch/powerpc/kernel: Use set_cpus_allowed_ptr
Message-ID: <Pine.LNX.4.64.1003262303080.6480@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Use set_cpus_allowed_ptr rather than set_cpus_allowed.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression E1,E2;
@@

- set_cpus_allowed(E1, cpumask_of_cpu(E2))
+ set_cpus_allowed_ptr(E1, cpumask_of(E2))

@@
expression E;
identifier I;
@@

- set_cpus_allowed(E, I)
+ set_cpus_allowed_ptr(E, &I)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/kernel/smp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -561,12 +561,12 @@ void __init smp_cpus_done(unsigned int m
 	 * se we pin us down to CPU 0 for a short while
 	 */
 	old_mask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
+	set_cpus_allowed_ptr(current, cpumask_of(boot_cpuid));
 	
 	if (smp_ops && smp_ops->setup_cpu)
 		smp_ops->setup_cpu(boot_cpuid);
 
-	set_cpus_allowed(current, old_mask);
+	set_cpus_allowed_ptr(current, &old_mask);
 
 	snapshot_timebases();
 
