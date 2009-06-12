Return-Path: <jaswinder@kernel.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5868FB719F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 16:12:51 +1000 (EST)
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D86C7DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 16:12:50 +1000 (EST)
Subject: Re: [PowerPC] 2.6.30-git3 build break : perf counters
From: Jaswinder Singh Rajput <jaswinder@kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A31ECCD.7030805@in.ibm.com>
References: <4A31ECCD.7030805@in.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 11:43:18 +0530
Message-Id: <1244787198.5554.0.camel@ht.satnam>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Sachin,

On Fri, 2009-06-12 at 11:21 +0530, Sachin Sant wrote:
> 2.6.30-git3 build with CONFIG_PERF_COUNTERS=y failed on a powerpc box.
> 
>  CC      arch/powerpc/kernel/power7-pmu.o
> arch/powerpc/kernel/power7-pmu.c:297: error: PERF_COUNT_CPU_CYCLES undeclared here (not in a function)
> arch/powerpc/kernel/power7-pmu.c:297: error: array index in initializer not of integer type
> arch/powerpc/kernel/power7-pmu.c:297: error: (near initialization for power7_generic_events)
> arch/powerpc/kernel/power7-pmu.c:298: error: PERF_COUNT_INSTRUCTIONS undeclared here (not in a function)
> arch/powerpc/kernel/power7-pmu.c:298: error: array index in initializer not of integer type
> ......<SNIP>......
> 

Is this fix your problem :

diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
index b3f7d12..fb72404 100644
--- a/arch/powerpc/kernel/power7-pmu.c
+++ b/arch/powerpc/kernel/power7-pmu.c
@@ -294,12 +294,12 @@ static void power7_disable_pmc(unsigned int pmc, u64 mmcr[])
 }
 
 static int power7_generic_events[] = {
-       [PERF_COUNT_CPU_CYCLES] = 0x1e,
-       [PERF_COUNT_INSTRUCTIONS] = 2,
-       [PERF_COUNT_CACHE_REFERENCES] = 0xc880,         /* LD_REF_L1_LSU */
-       [PERF_COUNT_CACHE_MISSES] = 0x400f0,            /* LD_MISS_L1 */
-       [PERF_COUNT_BRANCH_INSTRUCTIONS] = 0x10068,     /* BRU_FIN */
-       [PERF_COUNT_BRANCH_MISSES] = 0x400f6,           /* BR_MPRED */
+       [PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
+       [PERF_COUNT_HW_INSTRUCTIONS] = 2,
+       [PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,              /* LD_REF_L1_LSU */
+       [PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,         /* LD_MISS_L1 */
+       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x10068,  /* BRU_FIN */
+       [PERF_COUNT_HW_BRANCH_MISSES] = 0x400f6,                /* BR_MPRED */
 };
 
 #define C(x)   PERF_COUNT_HW_CACHE_##x
