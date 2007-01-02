Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id D6E7ADDEA2
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 06:18:42 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH] ppc: pic pmacpic_find_viaint cleanup
Date: Tue, 2 Jan 2007 20:20:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701022020.04174.m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	Litte rework to supress this warning:

arch/powerpc/platforms/powermac/pic.c: In function 'pmacpic_find_viaint':
arch/powerpc/platforms/powermac/pic.c:625: warning: label 'not_found' defined but not used

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/platforms/powermac/pic.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- linux-2.6.20-rc2-mm1-a/arch/powerpc/platforms/powermac/pic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/platforms/powermac/pic.c	2007-01-02 16:49:05.000000000 +0100
@@ -609,21 +609,18 @@ unsigned long sleep_save_mask[2];
  */
 static int pmacpic_find_viaint(void)
 {
-	int viaint = -1;
-
 #ifdef CONFIG_ADB_PMU
 	struct device_node *np;
 
 	if (pmu_get_model() != PMU_OHARE_BASED)
-		goto not_found;
+		return -1;
 	np = of_find_node_by_name(NULL, "via-pmu");
 	if (np == NULL)
-		goto not_found;
-	viaint = irq_of_parse_and_map(np, 0);;
+		return -1;
+	return irq_of_parse_and_map(np, 0);
+#else
+	return -1;
 #endif /* CONFIG_ADB_PMU */
-
-not_found:
-	return viaint;
 }
 
 static int pmacpic_suspend(struct sys_device *sysdev, pm_message_t state)


-- 
Regards,

	Mariusz Kozlowski
