Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89B08DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 08:30:30 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6QMURBQ012041
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:30:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6QMURqo531282
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:30:27 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6QMURQb021703
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:30:27 -0400
Date: Thu, 26 Jul 2007 17:30:26 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc/eeh: tweak printk message.
Message-ID: <20070726223026.GA21552@austin.ibm.com>
References: <20070726222935.GJ9876@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726222935.GJ9876@austin.ibm.com>
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



Print return code to print message. Also fix whitespace.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-07-24 16:14:22.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/platforms/pseries/eeh.c	2007-07-25 13:11:09.000000000 -0500
@@ -750,12 +750,12 @@ int rtas_set_slot_reset(struct pci_dn *p
 			return 0;
 
 		if (rc < 0) {
-			printk (KERN_ERR "EEH: unrecoverable slot failure %s\n",
-			        pdn->node->full_name);
+			printk(KERN_ERR "EEH: unrecoverable slot failure %s\n",
+			       pdn->node->full_name);
 			return -1;
 		}
-		printk (KERN_ERR "EEH: bus reset %d failed on slot %s\n",
-		        i+1, pdn->node->full_name);
+		printk(KERN_ERR "EEH: bus reset %d failed on slot %s, rc=%d\n",
+		       i+1, pdn->node->full_name, rc);
 	}
 
 	return -1;
