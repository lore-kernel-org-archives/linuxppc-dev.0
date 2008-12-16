Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3023F474C4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 20:25:55 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id mBG9Pj1F445092
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 09:25:45 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mBG9O9ob2072804
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:24:15 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mBG9O8IO008493
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:24:09 +0100
Message-Id: <20081216092408.362722962@linux.vnet.ibm.com>
References: <20081216091544.061115344@linux.vnet.ibm.com>
Date: Tue, 16 Dec 2008 10:15:45 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [patch 1/1] hvc_console: escape magic sysrq key
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

The ctrl-o (^O) is a common control key used by several applications like vim.

To allow users to send ^O to the terminal, this patch introduces a check
if ^O is pressed again if the sysrq_pressed variable is already set.
In this case, clear sysrq_pressed state and flip the ^O character to the tty.
(The old behavior has always set "sysrq_pressed" if ^0 has been entered, and it
has not flipped the ^O character to the tty.)

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -642,8 +642,11 @@ int hvc_poll(struct hvc_struct *hp)
 				/* Handle the SysRq Hack */
 				/* XXX should support a sequence */
 				if (buf[i] == '\x0f') {	/* ^O */
-					sysrq_pressed = 1;
-					continue;
+					/* if ^0 is pressed again, reset
+					 * sysrq_pressed and flip ^0 char */
+					sysrq_pressed = (sysrq_pressed) ? 0 : 1;
+					if (sysrq_pressed)
+						continue;
 				} else if (sysrq_pressed) {
 					handle_sysrq(buf[i], tty);
 					sysrq_pressed = 0;

-- 
Hendrik Brueckner
D/3303 Linux on System z Development
eMail: brueckner@linux.vnet.ibm.com
IBM Deutschland Research & Development GmbH, Schoenaicher Str. 220, 71032 Boeblingen

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
