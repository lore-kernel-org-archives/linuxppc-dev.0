Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] cpumask: avoid cast-away-const for deprecated cpu_*_map.
Date: Wed, 18 Feb 2009 17:45:20 +1030
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902181745.21595.rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linuxppc-dev@ozlabs.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: fix potential (non-x86) SMP boot failure with some gcc versions

The deprecated cpu_*_map are currently #defined to the new cpu_*_mask,
except without the const.  Some versions of gcc seem to dislike this,
and I suspect this will break boot for some archs with the "wrong" gcc
version.

So play it safe and use real vars until we kill them all (replacements
are init_*_map(), set_cpu_*() and cpu_*_mask).

PowerPC and Alpha have reported warnings, and James Bottomley
encountered worse: gcc was simply not changing cpu_possible_map,
causing boot failure (fixed by using init_cpu_possible()).

See also:
Alpha gcc 4.2 warning fix:
	ee0c468bb151aad23281660152d2894f1e214238
Voyager bug report:
	lkml: [PATCH] voyager: fix cpu bootmaps
	Message-Id: <1233340317.3248.39.camel@localhost.localdomain>
	(Merged without comments in 92ab78315c638515d0e81b0c70b2082f713582d9)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: linuxppc-dev@ozlabs.org
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James.Bottomley@HansenPartnership.com
Cc: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |   14 +++++++++-----
 kernel/cpu.c            |   10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -487,11 +487,15 @@ extern const struct cpumask *const cpu_p
 extern const struct cpumask *const cpu_present_mask;
 extern const struct cpumask *const cpu_active_mask;
 
-/* These strip const, as traditionally they weren't const. */
-#define cpu_possible_map	(*(cpumask_t *)cpu_possible_mask)
-#define cpu_online_map		(*(cpumask_t *)cpu_online_mask)
-#define cpu_present_map		(*(cpumask_t *)cpu_present_mask)
-#define cpu_active_map		(*(cpumask_t *)cpu_active_mask)
+/* Deprecated: use cpu_*_mask and set_cpu_*(). */
+#define cpu_possible_map	(*_cpu_possible_mask_nonconst)
+#define cpu_online_map		(*_cpu_online_mask_nonconst)
+#define cpu_present_map		(*_cpu_present_mask_nonconst)
+#define cpu_active_map		(*_cpu_active_mask_nonconst)
+extern struct cpumask *_cpu_possible_mask_nonconst;
+extern struct cpumask *_cpu_online_mask_nonconst;
+extern struct cpumask *_cpu_present_mask_nonconst;
+extern struct cpumask *_cpu_active_mask_nonconst;
 
 #if NR_CPUS > 1
 #define num_online_cpus()	cpumask_weight(cpu_online_mask)
diff --git a/kernel/cpu.c b/kernel/cpu.c
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -565,3 +565,13 @@ void init_cpu_online(const struct cpumas
 {
 	cpumask_copy(to_cpumask(cpu_online_bits), src);
 }
+
+/* Deprecated accessors. */
+struct cpumask *_cpu_possible_mask_nonconst = to_cpumask(cpu_possible_bits);
+EXPORT_SYMBOL(_cpu_possible_mask_nonconst);
+struct cpumask *_cpu_online_mask_nonconst = to_cpumask(cpu_online_bits);
+EXPORT_SYMBOL(_cpu_online_mask_nonconst);
+struct cpumask *_cpu_present_mask_nonconst = to_cpumask(cpu_present_bits);
+EXPORT_SYMBOL(_cpu_present_mask_nonconst);
+struct cpumask *_cpu_active_mask_nonconst = to_cpumask(cpu_active_bits);
+EXPORT_SYMBOL(_cpu_active_mask_nonconst);
