Return-Path: <matt@ozlabs.org>
Message-ID: <4C0DF36A.3080401@ozlabs.org>
Date: Tue, 08 Jun 2010 17:38:18 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
Subject: [PATCH] kexec, ppc64:  Wait for online/possible CPUs only.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec_perpare_cpus_wait() iterates i through NR_CPUS to check
paca[i].kexec_state of each to make sure they have quiesced.
However now we have dynamic PACA allocation, paca[NR_CPUS] is not necessarily
valid and we overrun the array;  spurious "cpu is not possible, ignoring"
errors result.  This patch iterates for_each_online_cpu so stays
within the bounds of paca[] -- and every CPU is now 'possible'.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/machine_kexec_64.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 26f9900..ed31a29 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -182,28 +182,12 @@ static void kexec_prepare_cpus_wait(int wait_state)
 
 	my_cpu = get_cpu();
 	/* Make sure each CPU has atleast made it to the state we need */
-	for (i=0; i < NR_CPUS; i++) {
+	for_each_online_cpu(i) {
 		if (i == my_cpu)
 			continue;
 
 		while (paca[i].kexec_state < wait_state) {
 			barrier();
-			if (!cpu_possible(i)) {
-				printk("kexec: cpu %d hw_cpu_id %d is not"
-						" possible, ignoring\n",
-						i, paca[i].hw_cpu_id);
-				break;
-			}
-			if (!cpu_online(i)) {
-				/* Fixme: this can be spinning in
-				 * pSeries_secondary_wait with a paca
-				 * waiting for it to go online.
-				 */
-				printk("kexec: cpu %d hw_cpu_id %d is not"
-						" online, ignoring\n",
-						i, paca[i].hw_cpu_id);
-				break;
-			}
 			if (i != notified) {
 				printk( "kexec: waiting for cpu %d (physical"
 						" %d) to enter %i state\n",
-- 
1.6.3.3
