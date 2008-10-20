Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id DA8D0DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 04:03:23 +1100 (EST)
Message-Id: <20081020170320.713010000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:27 -0700
From: Mike Travis <travis@sgi.com>
To: Ingo Molnar <mingo@elte.hu>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 08/35] cpumask: cpumask_size()
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

Dynamic allocation of cpumasks requires the size.

Signed-off-by: Mike Travis <travis@sgi.com>
---
 include/linux/cpumask.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- test-compile.orig/include/linux/cpumask.h
+++ test-compile/include/linux/cpumask.h
@@ -64,6 +64,7 @@
  * int next_cpu(cpu, mask)		Next cpu past 'cpu', or NR_CPUS
  * int next_cpu_nr(cpu, mask)		Next cpu past 'cpu', or nr_cpu_ids
  *
+ * size_t cpumask_size()		Length of cpumask in bytes.
  * cpumask_t cpumask_of_cpu(cpu)	Return cpumask with bit 'cpu' set
  *					(can be used as an lvalue)
  * CPU_MASK_ALL				Initializer - all bits set
@@ -148,6 +149,11 @@ struct cpumask
 };
 #define cpumask_bits(maskp) ((maskp)->bits)
 
+static inline ssize_t cpumask_size(void)
+{
+	return BITS_TO_LONGS(NR_CPUS) * sizeof(long);
+}
+
 /* Deprecated. */
 typedef struct cpumask cpumask_t;
 extern cpumask_t _unused_cpumask_arg_;

-- 
