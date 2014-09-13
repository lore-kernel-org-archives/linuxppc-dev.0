Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D4FA1A0418
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 18:28:06 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: av1474@comtv.ru
Subject: [PATCH] Simplify symbol check in prom_init_check.sh
References: <87zjfkvyha.fsf@comtv.ru> <1410510342.17540.10.camel@concordia>
 <87r3zgd5xx.fsf_-___23348.7322264866$1410551821$gmane$org@comtv.ru>
Date: Sat, 13 Sep 2014 10:20:17 +0200
In-Reply-To: <87r3zgd5xx.fsf_-___23348.7322264866$1410551821$gmane$org@comtv.ru>
 (av's message of "Fri, 12 Sep 2014 22:55:38 +0400")
Message-ID: <87oauk6if2.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/prom_init_check.sh | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index fe8e54b..12640f7 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -50,24 +50,14 @@ do
 	done
 
 	# ignore register save/restore funcitons
-	if [ "${UNDEF:0:9}" = "_restgpr_" ]; then
+	case $UNDEF in
+	_restgpr_*|_restgpr0_*|_rest32gpr_*)
 		OK=1
-	fi
-	if [ "${UNDEF:0:10}" = "_restgpr0_" ]; then
-		OK=1
-	fi
-	if [ "${UNDEF:0:11}" = "_rest32gpr_" ]; then
-		OK=1
-	fi
-	if [ "${UNDEF:0:9}" = "_savegpr_" ]; then
+		;;
+	_savegpr_*|_savegpr0_*|_save32gpr_*)
 		OK=1
-	fi
-	if [ "${UNDEF:0:10}" = "_savegpr0_" ]; then
-		OK=1
-	fi
-	if [ "${UNDEF:0:11}" = "_save32gpr_" ]; then
-		OK=1
-	fi
+		;;
+	esac
 
 	if [ $OK -eq 0 ]; then
 		ERROR=1
-- 
2.1.0

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
