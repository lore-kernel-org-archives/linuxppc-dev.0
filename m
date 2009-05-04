Return-Path: <stenzel@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D574DDDA9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 05:32:11 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id n44JW6Bt013939
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 19:32:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n44JW6793580154
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 21:32:06 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n44JW69x022448
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 21:32:06 +0200
Received: from stenzel-desktop (sig-9-145-69-38.uk.ibm.com [9.145.69.38])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id n44JW40q022436
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 21:32:05 +0200
From: stenzel@de.ibm.com
Date: Mon, 04 May 2009 21:32:01 +0200
Message-Id: <87iqkgd5qm.fsf@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [Patch] powerpc/cell: make ptcal more reliable
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is for QS21. The following patch allocates pages only from 
the specified node, moves the ptcal area into the middle of the 
allocated page to avoid potential prefetch problems and prints 
the address of the ptcal area to facilitate diagnostics. 
    
Signed-off-by: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/ras.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/ras.c
+++ linux-2.6/arch/powerpc/platforms/cell/ras.c
@@ -122,12 +122,22 @@ static int __init cbe_ptcal_enable_on_no
 
 	area->nid = nid;
 	area->order = order;
-	area->pages = alloc_pages_node(area->nid, GFP_KERNEL, area->order);
+	area->pages = alloc_pages_node(area->nid, GFP_KERNEL | GFP_THISNODE, area->order);
 
-	if (!area->pages)
+	if (!area->pages) {
+		printk(KERN_INFO "%s: no page on node %d\n",
+			__FUNCTION__, area->nid);
 		goto out_free_area;
+	}
 
-	addr = __pa(page_address(area->pages));
+	/*
+	 * We move the ptcal area to the middle of the allocated
+	 * page, in order to avoid prefetches in memcpy and similar
+	 * functions stepping on it.
+	 */
+	addr = __pa(page_address(area->pages)) + (PAGE_SIZE >> 1);
+	printk(KERN_INFO "%s: enabling PTCAL on node %d address=0x%016lx PAGE_SIZE>>1=0x%016lx \n",
+			__FUNCTION__, area->nid, addr, PAGE_SIZE>>1);
 
 	ret = -EIO;
 	if (rtas_call(ptcal_start_tok, 3, 1, NULL, area->nid,
===================================================================

Best regards, 

Gerhard Stenzel, Linux on Cell Development, LTC
-------------------------------------------------------------------------------------
IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter | Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen | Registergericht: Amtsgericht Stuttgart, HRB 243294
