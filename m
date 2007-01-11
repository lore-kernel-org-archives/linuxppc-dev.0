Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EF50DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:40:42 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id l0B5rmOa165294
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:53:50 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0B5fqYE156834
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:42:04 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0B5cN8g017226
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:38:23 +1100
Subject: [PATCH] powerpc: Remove bogus sanity check in pci -> OF node code
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 16:38:22 +1100
Message-Id: <1168493902.22458.399.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new implementation of pci_device_to_OF_node() on ppc32 has a bogus
sanity check in it that can cause oopses at boot when no device node is
present, and might hit correct cases with older/weird apple device-trees
where they have the type "vci" for the chaos bridge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Zang, please confirm that this fixes your problem. If it does, paulus,
this should go in 2.6.20


Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-01-11 16:30:09.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-01-11 16:30:31.000000000 +1100
@@ -775,11 +775,6 @@ static struct device_node *scan_OF_for_p
 	np = scan_OF_for_pci_dev(parent, bus->self->devfn);
 	of_node_put(parent);
 
-	/* sanity check */
-	if (strcmp(np->type, "pci") != 0)
-		printk(KERN_WARNING "pci: wrong type \"%s\" for bridge %s\n",
-		       np->type, np->full_name);
-
 	return np;
 }
 
