Return-Path: <lig.fnst@cn.fujitsu.com>
From: liguang <lig.fnst@cn.fujitsu.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc/smp: use '==' instead of '<' for  system_state
Date: Thu, 30 May 2013 14:47:53 +0800
Message-Id: <1369896473-23588-1-git-send-email-lig.fnst@cn.fujitsu.com>
Cc: cbe-oss-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 liguang <lig.fnst@cn.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'system_state < SYSTEM_RUNNING' will have same effect
with 'system_state == SYSTEM_BOOTING', but the later
one is more clearer.

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 arch/powerpc/platforms/cell/smp.c    |    2 +-
 arch/powerpc/platforms/powernv/smp.c |    2 +-
 arch/powerpc/platforms/pseries/smp.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index d35dbbc..f75f6fc 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -142,7 +142,7 @@ static int smp_cell_cpu_bootable(unsigned int nr)
 	 * during boot if the user requests it.  Odd-numbered
 	 * cpus are assumed to be secondary threads.
 	 */
-	if (system_state < SYSTEM_RUNNING &&
+	if (system_state == SYSTEM_BOOTING &&
 	    cpu_has_feature(CPU_FTR_SMT) &&
 	    !smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 		return 0;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 88c9459..77784ae 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -51,7 +51,7 @@ static int pnv_smp_cpu_bootable(unsigned int nr)
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
+	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
 		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 			return 0;
 		if (smt_enabled_at_boot
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 12bc8c3..306643c 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -192,7 +192,7 @@ static int smp_pSeries_cpu_bootable(unsigned int nr)
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
+	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
 		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 			return 0;
 		if (smt_enabled_at_boot
-- 
1.7.2.5
