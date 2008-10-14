Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14A4BDDF17
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:15:20 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9E9EECh465158
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:14:14 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E9EDGM3121348
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:14 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E9EDkt003449
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 11:14:13 +0200
Message-Id: <20081014091413.003841094@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
Date: Tue, 14 Oct 2008 11:12:49 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [RFC PATCH 2/5] hvc_console: Add tty driver flag
	TTY_DRIVER_RESET_TERMIOS
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

After a tty hangup() or close() operation, processes might not reset the
termio settings to a sane state. In order to reset the termios to its
default settings the tty driver flag TTY_DRIVER_RESET_TERMIOS has been added.

TTY driver flag description from include/linux/tty_driver.h:
	TTY_DRIVER_RESET_TERMIOS --- requests the tty layer to reset the
	  termios setting when the last process has closed the device.
	  Used for PTY's, in particular.


Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -796,7 +796,7 @@ static int hvc_init(void)
 	drv->minor_start = HVC_MINOR;
 	drv->type = TTY_DRIVER_TYPE_SYSTEM;
 	drv->init_termios = tty_std_termios;
-	drv->flags = TTY_DRIVER_REAL_RAW;
+	drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS;
 	tty_set_operations(drv, &hvc_ops);
 
 	/* Always start the kthread because there can be hotplug vty adapters

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
