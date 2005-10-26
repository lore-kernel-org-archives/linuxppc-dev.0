Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFEAA685F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Oct 2005 06:01:07 +1000 (EST)
Date: Wed, 26 Oct 2005 12:57:10 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20051026145710.GA10496@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] ppc_sys: do not BUG if system ID is unknown
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly,

Subject and diff says it all: currently ppc_sys BUGs on unknown system
ID, which is quite unfriendly.

The following is applied to the 8xx-fixes tree.

diff-tree a807b39b11a2fc311d3bbeff2b6f17c31636bb58 (from 94c84a4faa99c5f1ca93f0b9c5ad3df9d57409f8)
Author: Marcelo Tosatti <marcelo@pegasos.cnet>
Date:   Wed Oct 26 14:43:30 2005 -0500

    ppc32: Make ppc_sys friendly to unknown system ID's

diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index 52ba0c6..26d7605 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -85,8 +85,11 @@ static int __init find_chip_by_name_and_
 void __init identify_ppc_sys_by_name_and_id(char *name, u32 id)
 {
 	int i = find_chip_by_name_and_id(name, id);
-	BUG_ON(i < 0);
-	cur_ppc_sys_spec = &ppc_sys_specs[i];
+	if (i < 0) {
+		printk(KERN_ERR "ppc_sys: Unable to identify PPC system!\n");
+		cur_ppc_sys_spec = NULL;
+	} else
+		cur_ppc_sys_spec = &ppc_sys_specs[i];
 }
 
 /* Update all memory resources by paddr, call before platform_device_register */
@@ -128,7 +131,8 @@ static int __init ppc_sys_init(void)
 {
 	unsigned int i, dev_id, ret = 0;
 
-	BUG_ON(cur_ppc_sys_spec == NULL);
+	if(cur_ppc_sys_spec == NULL)
+		return 1;
 
 	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
 		dev_id = cur_ppc_sys_spec->device_list[i];
