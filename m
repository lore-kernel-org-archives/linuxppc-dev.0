Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/tm: Fix null pointer deference in flush_hash_page
Date: Fri, 03 May 2013 11:36:14 +1000
Message-ID: <22932.1367544974@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 John J Miller <millerjo@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure that current->thread.reg exists before we deference it in
flush_hash_page.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: John J Miller <millerjo@us.ibm.com>
Cc: <stable@vger.kernel.org>

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 3e4c4ed..88ac0ee 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1230,6 +1230,7 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 	 * unmapping it first, it may see the speculated version.
 	 */
 	if (local && cpu_has_feature(CPU_FTR_TM) &&
+	    current->thread.regs &&
 	    MSR_TM_ACTIVE(current->thread.regs->msr)) {
 		tm_enable();
 		tm_abort(TM_CAUSE_TLBI);
