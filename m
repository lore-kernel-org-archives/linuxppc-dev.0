Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/7] powerpc: Add helper functions set the DAWR and CIABR
 using set_mode
Date: Fri, 21 Dec 2012 11:06:41 +1100
Message-Id: <1356048405-20560-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1356048405-20560-1-git-send-email-mikey@neuling.org>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

These are just wrappers around the new set_mode HCALL.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index e6cc34a..fd09183 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -304,4 +304,14 @@ static inline long disable_reloc_on_exceptions(void) {
 	return plpar_set_mode(0, 3, 0, 0);
 }
 
+static inline long plapr_set_ciabr(unsigned long ciabr)
+{
+	return plpar_set_mode(0, 1, ciabr, 0);
+}
+
+static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
+{
+	return plpar_set_mode(0, 2, dawr0, dawrx0);
+}
+
 #endif /* _PSERIES_PLPAR_WRAPPERS_H */
-- 
1.7.10.4
