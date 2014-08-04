Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe01x03-cgp.akado.ru [77.232.31.164])
 by lists.ozlabs.org (Postfix) with ESMTP id 9DF721A0189
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 06:36:27 +1000 (EST)
Received: from [10.0.66.9] (HELO linmac)
 by fe01-cgp.akado.ru (CommuniGate Pro SMTP 5.2.13)
 with ESMTP id 15318058 for linuxppc-dev@lists.ozlabs.org;
 Mon, 04 Aug 2014 23:36:17 +0400
Date: Mon, 04 Aug 2014 23:36:17 +0400
Message-Id: <87zjfkvyha.fsf@comtv.ru>
From: <av1474@comtv.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Avoid bashisms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From 300a98f895dc7e2167cf379408322a9607907761 Mon Sep 17 00:00:00 2001
From: malc <av1474@comtv.ru>
Date: Mon, 4 Aug 2014 23:28:05 +0400
Subject: [PATCH] Avoid bashisms

---
 arch/powerpc/kernel/prom_init_check.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index fe8e54b..413f792 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -50,22 +50,22 @@ do
 	done
 
 	# ignore register save/restore funcitons
-	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
+	if [ "$(printf %.9s $UNDEF)" = "_restgpr_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:10}" = "_restgpr0_" ]; then
+	if [ "$(printf %.10s $UNDEF)" = "_restgpr0_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
+	if [ "$(printf %.11s $UNDEF)" = "_rest32gpr_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
+	if [ "$(printf %.9s $UNDEF)" = "_savegpr_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:10}" = "_savegpr0_" ]; then
+	if [ "$(printf %.10s $UNDEF)" = "_savegpr0_" ]; then
 		OK=1
 	fi
-	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
+	if [ "$(printf %.11s $UNDEF)" = "_save32gpr_" ]; then
 		OK=1
 	fi
 
-- 
2.0.0.GIT


-- 
mailto:av1474@comtv.ru
