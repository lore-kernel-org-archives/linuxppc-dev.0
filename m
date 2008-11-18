Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3ABC6DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 22:38:56 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id mAIBcoua070152
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 11:38:50 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mAIBcoTs4305112
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 12:38:50 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mAIBcndl021379
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 12:38:50 +0100
Message-Id: <20081118113848.945650506@linux.vnet.ibm.com>
References: <20081118112827.927627788@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2008 12:28:28 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [patch 1/1] hvc_console: fix: hp->ws winsize check runs out-of-sync
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

The test to check for a new winsize runs out-of-sync with the underlying
tty. After a tty has been released and initialized again, the winsize might
differ between the tty and the hp struct. 
The solution is to simply remove the check and always schedule the resize work.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/char/hvc_console.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -689,10 +689,8 @@ EXPORT_SYMBOL_GPL(hvc_poll);
  */
 void hvc_resize(struct hvc_struct *hp, struct winsize ws)
 {
-	if ((hp->ws.ws_row != ws.ws_row) || (hp->ws.ws_col != ws.ws_col)) {
-		hp->ws = ws;
-		schedule_work(&hp->tty_resize);
-	}
+	hp->ws = ws;
+	schedule_work(&hp->tty_resize);
 }
 
 /*

-- 
Hendrik Brueckner
D/3303 Linux on System z Development
Tel: +49 7031 16-1073
Fax: +49 7031 16-3456
eMail: brueckner@linux.vnet.ibm.com
IBM Deutschland Research & Development GmbH, Schoenaicher Str. 220, 71032 Boeblingen

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
