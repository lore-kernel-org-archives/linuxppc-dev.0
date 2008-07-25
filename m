Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED91DDE09B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 07:25:47 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6PLPhMF002523
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 17:25:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6PLPhAl172744
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 15:25:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6PLPhYf020616
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 15:25:43 -0600
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6PLPhMq020604
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 15:25:43 -0600
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m6PLPga2054238
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 16:25:42 -0500
Message-ID: <488A44DB.7090400@austin.ibm.com>
Date: Fri, 25 Jul 2008 16:25:47 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Memset the kernel copy of rtas args before using
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The kernel copy of the rtas args struct that is read in from
user space is a stack variable.  This structure should be
zero'ed out before we do any reads/writes to/from the user
when handling a rtas call request.  This patch adds a memset
to do this.

I am seeing an issue in testing partition mobility, where the
parts of the rtas args struct that return status top the user
contain stale data.

Signed-off-by: Nathan Fontenot <nfont@ausitn,ibm.com>
---

Index: linux-2.6.git/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/rtas.c	2008-07-22 09:34:03.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/rtas.c	2008-07-25 16:06:00.000000000 -0500
@@ -775,6 +775,8 @@
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	memset(&args, 0, sizeof(args));
+
 	if (copy_from_user(&args, uargs, 3 * sizeof(u32)) != 0)
 		return -EFAULT;
 
