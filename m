Return-Path: <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 09 Apr 2010 16:21:18 +1000
Subject: [PATCH 0/5] sched: asymmetrical packing for POWER7 SMT4
Message-Id: <1270794078.794237.347827867455.qpush@pale>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series implements asymmetric SMT packing which ensures
consistently good performance on POWER7.  

I'm no scheduler expert so these probably need some review.  It works
for my simple test case on a POWER7 with SMT4.  I can now run a number
of CPU bound processes and they are pulled down to lower threads
giving the best performance consistently. 

Suresh: some of this touches code you changed recently, so you may
want to test in your environment.

The 1st patch is a fix for SMT4 in general.
The 2nd adds actual the asymmetrical packing infrastructure.  
The 3rd adds the powerpc specific hooks for POWER7.
The 4th and 5th are fixes required for packing to work.
