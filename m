Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/9] powerpc/perf: Use existing out label in power_pmu_enable()
Date: Fri, 28 Jun 2013 18:15:13 +1000
Message-Id: <1372407319-718-4-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
References: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In power_pmu_enable() we can use the existing out label to reduce the
number of return paths.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3d566ee..af4b4b1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -919,12 +919,13 @@ static void power_pmu_enable(struct pmu *pmu)
 
 	if (!ppmu)
 		return;
+
 	local_irq_save(flags);
+
 	cpuhw = &__get_cpu_var(cpu_hw_events);
-	if (!cpuhw->disabled) {
-		local_irq_restore(flags);
-		return;
-	}
+	if (!cpuhw->disabled)
+		goto out;
+
 	cpuhw->disabled = 0;
 
 	/*
-- 
1.7.10.4
