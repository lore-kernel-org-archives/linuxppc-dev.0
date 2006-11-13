Return-Path: <brking@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9EAD767E1A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 09:33:00 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kADMWcWs027248
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:32:38 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kADMWcIg128912
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:32:38 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kADMWbDT004490
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:32:38 -0500
Message-Id: <200611132232.kADMWbFx004476@d01av04.pok.ibm.com>
Subject: [PATCH 1/1] libata: Convert from module_init to subsys_initcall
	(resend)
To: jgarzik@pobox.com
From: Brian King <brking@us.ibm.com>
Date: Mon, 13 Nov 2006 16:32:36 -0600
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	torvalds@osdl.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When building a monolithic kernel, the load order of drivers
does not work for SAS libata users, resulting in a kernel
oops. Convert libata to use subsys_initcall instead of
module_init, which ensures that libata gets loaded before
any LLDD. This is the same thing that scsi core does
to solve the problem. The load order problem was observed on
ipr SAS adapters and should exist for other SAS users as well.

Signed-off-by: Brian King <brking@us.ibm.com>
---

Jeff,

This is needed for 2.6.19 since without it monolithic kernels
on lots of PPC64 machines oops at boot time.
Please ack/nack as appropriate.

Thanks,

Brian
---

 linux-2.6-bjking1/drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/libata-core.c~libata_subsys_init drivers/ata/libata-core.c
--- linux-2.6/drivers/ata/libata-core.c~libata_subsys_init	2006-11-13 15:39:35.000000000 -0600
+++ linux-2.6-bjking1/drivers/ata/libata-core.c	2006-11-13 15:39:35.000000000 -0600
@@ -5957,7 +5957,7 @@ static void __exit ata_exit(void)
 	destroy_workqueue(ata_aux_wq);
 }
 
-module_init(ata_init);
+subsys_initcall(ata_init);
 module_exit(ata_exit);
 
 static unsigned long ratelimit_time;
_
