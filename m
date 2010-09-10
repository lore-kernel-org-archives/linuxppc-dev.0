Return-Path: <nfont@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6ED62B70A8
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Sep 2010 05:41:39 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8AJVGOv027618
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:31:16 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8AJfaPl145980
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:41:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8AJfaMt005310
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:41:36 -0600
Received: from [9.53.40.150] (dyn95340150.austin.ibm.com [9.53.40.150])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8AJfZva005299
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:41:35 -0600
Message-ID: <4C8A89EF.8020805@austin.ibm.com>
Date: Fri, 10 Sep 2010 14:41:35 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] Export rtas_ibm_suspend_me()
References: <4C8A8937.9000005@austin.ibm.com>
In-Reply-To: <4C8A8937.9000005@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the rtas_ibm_suspend_me() routine.  This is needed to perform
partition migration in the kernel.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/include/asm/rtas.h |    1 +
 arch/powerpc/kernel/rtas.c      |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-next/arch/powerpc/include/asm/rtas.h
===================================================================
--- linux-next.orig/arch/powerpc/include/asm/rtas.h	2010-09-10 12:38:28.000000000 -0500
+++ linux-next/arch/powerpc/include/asm/rtas.h	2010-09-10 12:40:14.000000000 -0500
@@ -187,6 +187,7 @@ extern void rtas_progress(char *s, unsig
 extern void rtas_initialize(void);
 extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
 extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
+extern int rtas_ibm_suspend_me(struct rtas_args *);
 
 struct rtc_time;
 extern unsigned long rtas_get_boot_time(void);
Index: linux-next/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-next.orig/arch/powerpc/kernel/rtas.c	2010-09-10 12:38:28.000000000 -0500
+++ linux-next/arch/powerpc/kernel/rtas.c	2010-09-10 12:41:01.000000000 -0500
@@ -805,7 +805,7 @@ static void rtas_percpu_suspend_me(void
 	__rtas_suspend_cpu((struct rtas_suspend_me_data *)info, 1);
 }
 
-static int rtas_ibm_suspend_me(struct rtas_args *args)
+int rtas_ibm_suspend_me(struct rtas_args *args)
 {
 	long state;
 	long rc;
@@ -855,7 +855,7 @@ static int rtas_ibm_suspend_me(struct rt
 	return atomic_read(&data.error);
 }
 #else /* CONFIG_PPC_PSERIES */
-static int rtas_ibm_suspend_me(struct rtas_args *args)
+int rtas_ibm_suspend_me(struct rtas_args *args)
 {
 	return -ENOSYS;
 }
