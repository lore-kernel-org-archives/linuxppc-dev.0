Return-Path: <sonny@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4256FDDF71
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 09:00:41 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6BN0Zun010516
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 19:00:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6BN0Zgs163304
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:00:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6BN0Ywa028574
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 17:00:35 -0600
Date: Fri, 11 Jul 2008 18:00:26 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: don't spin on sync
Message-ID: <20080711230026.GB17878@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sonnyrao@us.ibm.com, paulus@samba.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Push the sync below the secondary smp init hold loop and comment its purpose.
This should speed up boot by reducing global traffic during the single-threaded
portion of boot.

Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>
Signed-off-by: Milton Miller <miltonm@bga.com>

--- next.git/arch/powerpc/kernel/head_64.S~orig	2008-07-11 17:28:47.000000000 -0500
+++ next.git/arch/powerpc/kernel/head_64.S	2008-07-11 17:31:50.000000000 -0500
@@ -1198,7 +1198,6 @@ _GLOBAL(generic_secondary_smp_init)
 3:	HMT_LOW
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
 					/* start.			 */
-	sync
 
 #ifndef CONFIG_SMP
 	b	3b			/* Never go on non-SMP		 */
@@ -1206,6 +1205,8 @@ _GLOBAL(generic_secondary_smp_init)
 	cmpwi	0,r23,0
 	beq	3b			/* Loop until told to go	 */
 
+	sync				/* order paca.run and cur_cpu_spec */
+
 	/* See if we need to call a cpu state restore handler */
 	LOAD_REG_IMMEDIATE(r23, cur_cpu_spec)
 	ld	r23,0(r23)
