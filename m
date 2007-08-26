Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9B8AEDDE04
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 19:10:59 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id F1A69221409
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 11:10:56 +0200 (CEST)
Received: from ibook.aepfle.de (DSL01.83.171.160.67.ip-pool.NEFkom.net
	[83.171.160.67])
	by mail.mnet-online.de (Postfix) with ESMTP id E8A9C903C6
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 11:10:56 +0200 (CEST)
Date: Sun, 26 Aug 2007 11:10:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix pmac_zilog debug arg
Message-ID: <20070826091059.GA17651@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


drivers/serial/pmac_zilog.c:1590: warning: format '%d' expects type 'int', but argument 3 has type 'pm_message_t'

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/serial/pmac_zilog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -1587,7 +1587,7 @@ static int pmz_suspend(struct macio_dev 
 	if (pm_state.event == mdev->ofdev.dev.power.power_state.event)
 		return 0;
 
-	pmz_debug("suspend, switching to state %d\n", pm_state);
+	pmz_debug("suspend, switching to state %d\n", pm_state.event);
 
 	state = pmz_uart_reg.state + uap->port.line;
 
