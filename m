Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [194.196.100.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90A6ADDF43
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:14:24 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id m9E9EIIa015424
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:14:19 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9E9EEXx3014666
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:14:14 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9E9EDb7025000
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:14:14 +0100
Message-Id: <20081014091413.437197300@linux.vnet.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
Date: Tue, 14 Oct 2008 11:12:52 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [RFC PATCH 5/5] hvc_console: Remove __devexit annotation of
	hvc_remove()
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

Removed __devexit annotation of hvc_remove() to avoid a section mismatch
if the backend initialization fails and hvc_remove() must be used to
clean up allocated hvc structs (called in section __init or __devinit).

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/hvc_console.c |    2 +-
 drivers/char/hvc_console.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -806,7 +806,7 @@ struct hvc_struct __devinit *hvc_alloc(u
 }
 EXPORT_SYMBOL_GPL(hvc_alloc);
 
-int __devexit hvc_remove(struct hvc_struct *hp)
+int hvc_remove(struct hvc_struct *hp)
 {
 	unsigned long flags;
 	struct tty_struct *tty;
--- a/drivers/char/hvc_console.h
+++ b/drivers/char/hvc_console.h
@@ -81,7 +81,7 @@ extern int hvc_instantiate(uint32_t vter
 extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int data,
 				struct hv_ops *ops, int outbuf_size);
 /* remove a vterm from hvc tty operation (module_exit or hotplug remove) */
-extern int __devexit hvc_remove(struct hvc_struct *hp);
+extern int hvc_remove(struct hvc_struct *hp);
 
 /* data available */
 int hvc_poll(struct hvc_struct *hp);

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
