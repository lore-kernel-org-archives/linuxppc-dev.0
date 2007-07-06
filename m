Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6ACEDDF84
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 08:00:00 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l66LxvT5012863
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2007 17:59:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l66Lxux9532440
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2007 17:59:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l66LxuVH017015
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2007 17:59:56 -0400
Message-ID: <468EBB5B.2070309@austin.ibm.com>
Date: Fri, 06 Jul 2007 16:59:55 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Minor: Removed double return. 
Content-Type: multipart/mixed; boundary="------------070302000702000505020305"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070302000702000505020305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Found 2 instances of return one right after each other in 
arch_add_memory(). This minor patch fixes it.
Signed-off-by:Manish Ahuja <mahuja@us.ibm.com>



--------------070302000702000505020305
Content-Type: text/plain;
 name="double-return"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="double-return"

Index: 2.6.22-rc4/arch/powerpc/mm/mem.c
===================================================================
--- 2.6.22-rc4.orig/arch/powerpc/mm/mem.c	2007-06-11 21:10:46.000000000 -0500
+++ 2.6.22-rc4/arch/powerpc/mm/mem.c	2007-06-29 22:52:42.000000000 -0500
@@ -129,8 +129,6 @@
 	zone = pgdata->node_zones;
 
 	return __add_pages(zone, start_pfn, nr_pages);
-
-	return 0;
 }
 
 /*

--------------070302000702000505020305--
