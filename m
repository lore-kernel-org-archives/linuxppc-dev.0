Return-Path: <moilanen@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5BD8B67B6E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jul 2006 06:15:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6PKFETb025626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 16:15:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6PKFDvX178684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 14:15:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6PKFDLv032061
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Jul 2006 14:15:13 -0600
Subject: [PATCH] CEDE on non-SMT
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 15:11:47 -0500
Message-Id: <1153858308.29826.148.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the JS21 systems, they have the SPLPAR hypertas set, but are not SMT
capable.  So, they are not making the h_cede call.  This is causing the
hypervisor to have to queue up work for the hdecr, taking an excessive
amount of time in maintenance code, and causing jitter on the box.

Making the h_cede call helps alleviate that problem.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com> 

Index: 2.6-msi/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- 2.6-msi.orig/arch/powerpc/platforms/pseries/setup.c	2006-07-25
14:49:26.000000000 -0500
+++ 2.6-msi/arch/powerpc/platforms/pseries/setup.c	2006-07-25
14:52:49.000000000 -0500
@@ -501,7 +501,8 @@
 	}
 
 	/*
-	 * Cede if the other thread is not idle, so that it can
+	 * If not SMT, cede processor.  If CPU is running SMT
+	 * cede if the other thread is not idle, so that it can
 	 * go single-threaded.  If the other thread is idle,
 	 * we ask the hypervisor if it has pending work it
 	 * wants to do and cede if it does.  Otherwise we keep
@@ -514,7 +515,8 @@
 	 * very low priority.  The cede enables interrupts, which
 	 * doesn't matter here.
 	 */
-	if (!lppaca[cpu ^ 1].idle || poll_pending() == H_PENDING)
+	if (!cpu_has_feature(CPU_FTR_SMT) || !lppaca[cpu ^ 1].idle
+	    || poll_pending() == H_PENDING)
 		cede_processor();
 
 out:
