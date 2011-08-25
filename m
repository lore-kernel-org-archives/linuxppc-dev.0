Return-Path: <MAILER-DAEMON>
Received: from WA2EHSNDR006.bigfish.com (smtp-cpk.frontbridge.com
	[204.231.192.41]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A899B6F7C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 22:21:53 +1000 (EST)
Received: from mail84-ch1 (localhost.localdomain [127.0.0.1])	by
	mail84-ch1-R.bigfish.com (Postfix) with ESMTP id DAA5B155051A	for
	<linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 12:21:47 +0000 (UTC)
Received: from CH1EHSMHS013.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.241])	by mail84-ch1.bigfish.com (Postfix) with ESMTP id
	9C072166004C	for <linuxppc-dev@ozlabs.org>;
	Thu, 25 Aug 2011 12:21:47 +0000 (UTC)
Received: from localhost.localdomain ([10.171.71.184])	by
	az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	p7PCLWUb006339	for
	<linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 07:21:34 -0500 (CDT)
From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/time: When starting the decrementer don't zero the
	other bits in TCR
Date: Thu, 25 Aug 2011 15:19:55 +0300
Message-ID: <1314274795-4966-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Reply-To: testfarm@localhost.localdomain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clearing the other TCR bits might break code that sets them (e.g. to setup
the watchdog or fixed interval timer) before start_cpu_decrementer() gets
called.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
 arch/powerpc/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 03b29a6..e8b5cdc 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -721,7 +721,7 @@ void start_cpu_decrementer(void)
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
 
 	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_DIE);
 #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
 }
 
-- 
1.7.1
