Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1182F1A008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 07:19:46 +1000 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3hRsKY3bNBz3hhp6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 23:14:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 3hRsKX47sgz7S6Rt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 23:14:08 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.8.180])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
 port 10024)
 with ESMTP id UJxb1vCyevLd for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  4 Aug 2014 23:14:07 +0200 (CEST)
Received: from igel.home (ppp-188-174-156-107.dynamic.mnet-online.de
 [188.174.156.107]) by mail.mnet-online.de (Postfix) with ESMTPA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Aug 2014 23:14:07 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Simplify symbol check in prom_init_check.sh
References: <87zjfkvyha.fsf__21215.9315743067$1407184642$gmane$org@comtv.ru>
Date: Mon, 04 Aug 2014 23:14:07 +0200
In-Reply-To: <87zjfkvyha.fsf__21215.9315743067$1407184642$gmane$org@comtv.ru>
 (av's message of "Mon, 04 Aug 2014 23:36:17 +0400")
Message-ID: <87mwbkez4w.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
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
2.0.4


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
