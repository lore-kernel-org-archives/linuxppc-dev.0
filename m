Return-Path: <brking@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B7E2B71F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Sep 2011 07:22:49 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8DL8Kw6013591
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2011 17:08:20 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8DLMjY9272410
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2011 17:22:46 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p8DLMKmg001260
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2011 15:22:20 -0600
Message-Id: <201109132122.p8DLMJho001157@d03av02.boulder.ibm.com>
Subject: [PATCH 1/1] hvcs: Ensure page aligned partner info buffer 
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Tue, 13 Sep 2011 16:22:51 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The Power platform requires the partner info buffer to be page aligned
otherwise it will fail the partner info hcall with H_PARAMETER. Switch
from using kmalloc to allocate this buffer to __get_free_page to ensure
page alignment.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/tty/hvc/hvcs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/tty/hvc/hvcs.c~hvcs_pi_buf_alloc drivers/tty/hvc/hvcs.c
--- linux-2.6/drivers/tty/hvc/hvcs.c~hvcs_pi_buf_alloc	2011-09-09 16:00:25.000000000 -0500
+++ linux-2.6-bjking1/drivers/tty/hvc/hvcs.c	2011-09-09 16:07:08.000000000 -0500
@@ -1532,7 +1532,7 @@ static int __devinit hvcs_initialize(voi
 		goto register_fail;
 	}
 
-	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	hvcs_pi_buff = (unsigned long *) __get_free_page(GFP_KERNEL);
 	if (!hvcs_pi_buff) {
 		rc = -ENOMEM;
 		goto buff_alloc_fail;
@@ -1548,7 +1548,7 @@ static int __devinit hvcs_initialize(voi
 	return 0;
 
 kthread_fail:
-	kfree(hvcs_pi_buff);
+	free_page((unsigned long)hvcs_pi_buff);
 buff_alloc_fail:
 	tty_unregister_driver(hvcs_tty_driver);
 register_fail:
@@ -1597,7 +1597,7 @@ static void __exit hvcs_module_exit(void
 	kthread_stop(hvcs_task);
 
 	spin_lock(&hvcs_pi_lock);
-	kfree(hvcs_pi_buff);
+	free_page((unsigned long)hvcs_pi_buff);
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 
_
