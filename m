Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37DB9DDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 06:06:32 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBJJ6SCB024787
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 14:06:28 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBJJ6O0p276930
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 14:06:24 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBJJ6OJ9024061
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 14:06:24 -0500
Date: Tue, 19 Dec 2006 13:06:17 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc fixup error message
Message-ID: <20061219190617.GF5506@austin.ibm.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,
Please apply this somewhat trite patch; it did come up in conversations.

Heads up:
I'm debugging a more serious problem for power4, concerning
multi-function adapters & eeh recovery, and would like to get that 
patch in if/when I get it figured out and fixed.

--linas


Clarify error message re EEH permanent failure.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-12-15 17:29:10.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/platforms/pseries/eeh_driver.c	2006-12-15 17:35:27.000000000 -0600
@@ -446,7 +446,8 @@ excess_failures:
 	 */
 	printk(KERN_ERR
 	   "EEH: PCI device at location=%s driver=%s pci addr=%s \n"
-		"has failed %d times and has been permanently disabled. \n"
+		"has failed %d times in the last hour "
+		"and has been permanently disabled. \n"
 		"Please try reseating this device or replacing it.\n",
 		location, drv_str, pci_str, frozen_pdn->eeh_freeze_count);
 	goto perm_error;
