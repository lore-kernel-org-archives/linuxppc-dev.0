Return-Path: <anton@samba.org>
Date: Tue, 18 Jan 2011 21:44:04 +1100
From: Anton Blanchard <anton@samba.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] powerpc: perf: Fix frequency calculation for overflowing
	counters (FSL version)
Message-ID: <20110118214404.2f42e634@kryten>
In-Reply-To: <1295285881.30950.218.camel@laptop>
References: <20110117161742.5feb3761@kryten>
	<20110117113250.48098aaa@udp111988uds.am.freescale.net>
	<1295285881.30950.218.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Scott Wood <scottwood@freescale.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > Does perf_event_fsl_emb.c need this as well (it has almost the same
> > record_and_restart code)? 
> 
> I would think so.

Good point:


When fixing the frequency calculations for perf on powerpc I forgot
to fix the FSL version.

If we dont set event->hw.last_period the frequency to period calculations
in perf go haywire and we continually throttle/unthrottle the PMU.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

This is only compile tested.

Index: powerpc.git/arch/powerpc/kernel/perf_event_fsl_emb.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/perf_event_fsl_emb.c	2011-01-18 21:23:57.761644115 +1100
+++ powerpc.git/arch/powerpc/kernel/perf_event_fsl_emb.c	2011-01-18 21:25:28.994477247 +1100
@@ -596,6 +596,7 @@ static void record_and_restart(struct pe
 			if (left <= 0)
 				left = period;
 			record = 1;
+			event->hw.last_period = event->hw.sample_period;
 		}
 		if (left < 0x80000000LL)
 			val = 0x80000000LL - left;
