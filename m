Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.171.30])
	by ozlabs.org (Postfix) with ESMTP id 48A7DDDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 04:03:24 +1100 (EST)
Message-Id: <20081020170319.867619000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:21 -0700
From: Mike Travis <travis@sgi.com>
To: Ingo Molnar <mingo@elte.hu>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 02/35] cpumask: remove min from first_cpu/next_cpu
Cc: davej@codemonkey.org.uk, Jeremy Fitzhardinge <jeremy@goop.org>,
	Jes Sorensen <jes@sgi.com>, IA64 <linux-ia64@vger.kernel.org>,
	S390 <linux-s390@vger.kernel.org>, peterz@infradead.org,
	Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
	Eric Dumazet <dada1@cosmosbay.com>, PowerPC <linuxppc-dev@ozlabs.org>,
	Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yhlu.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	SPARC <sparclinux@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Seems like this has been here forever, but I can't see why:
find_first_bit and find_next_bit both return >= NR_CPUS on failure.

From: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
---
 lib/cpumask.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.28.orig/lib/cpumask.c
+++ linux-2.6.28/lib/cpumask.c
@@ -5,21 +5,20 @@
 
 int __first_cpu(const cpumask_t *srcp)
 {
-	return min_t(int, NR_CPUS, find_first_bit(srcp->bits, NR_CPUS));
+	return find_first_bit(srcp->bits, NR_CPUS);
 }
 EXPORT_SYMBOL(__first_cpu);
 
 int __next_cpu(int n, const cpumask_t *srcp)
 {
-	return min_t(int, NR_CPUS, find_next_bit(srcp->bits, NR_CPUS, n+1));
+	return find_next_bit(srcp->bits, NR_CPUS, n+1);
 }
 EXPORT_SYMBOL(__next_cpu);
 
 #if NR_CPUS > 64
 int __next_cpu_nr(int n, const cpumask_t *srcp)
 {
-	return min_t(int, nr_cpu_ids,
-				find_next_bit(srcp->bits, nr_cpu_ids, n+1));
+	return find_next_bit(srcp->bits, nr_cpu_ids, n+1);
 }
 EXPORT_SYMBOL(__next_cpu_nr);
 #endif

-- 
