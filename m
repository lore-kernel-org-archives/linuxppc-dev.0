Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7DCE6DE03B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:42 +1000 (EST)
Date: Tue, 3 Apr 2007 22:50:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 16/17] [POWERPC] Rename get_property to of_get_property: the
	last one
Message-Id: <20070403225059.e735b5e4.sfr@canb.auug.org.au>
In-Reply-To: <20070403224937.f6a07e56.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This also fixes a bug where a property value was being modified
in place.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/cbe_cpufreq.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/cell/cbe_cpufreq.c b/arch/powerpc/platforms/cell/cbe_cpufreq.c
index a3850fd..9c5d63b 100644
--- a/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -126,7 +126,8 @@ static int set_pmode(int cpu, unsigned int pmode)
 
 static int cbe_cpufreq_cpu_init (struct cpufreq_policy *policy)
 {
-	u32 *max_freq;
+	const u32 *max_freqp;
+	u32 max_freq;
 	int i, cur_pmode;
 	struct device_node *cpu;
 
@@ -137,20 +138,20 @@ static int cbe_cpufreq_cpu_init (struct cpufreq_policy *policy)
 
 	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
 
-	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
+	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
 
-	if(!max_freq)
+	if (!max_freqp)
 		return -EINVAL;
 
 	// we need the freq in kHz
-	*max_freq /= 1000;
+	max_freq = *max_freqp / 1000;
 
-	pr_debug("max clock-frequency is at %u kHz\n", *max_freq);
+	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
 	pr_debug("initializing frequency table\n");
 
 	// initialize frequency table
 	for (i=0; cbe_freqs[i].frequency!=CPUFREQ_TABLE_END; i++) {
-		cbe_freqs[i].frequency = *max_freq / cbe_freqs[i].index;
+		cbe_freqs[i].frequency = max_freq / cbe_freqs[i].index;
 		pr_debug("%d: %d\n", i, cbe_freqs[i].frequency);
 	}
 
-- 
1.5.0.3
