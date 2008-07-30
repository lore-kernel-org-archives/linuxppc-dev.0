Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DF09DE129
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 02:23:48 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6UGQ4Qo004481
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 12:26:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6UGNRV1227406
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 12:23:27 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6UGNRQU008654
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 12:23:27 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m6UGNQJT008629
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 12:23:27 -0400
Received: from [9.53.40.161] ([9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m6UGNQQF042866
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 11:23:26 -0500
Message-ID: <4890957F.5080203@austin.ibm.com>
Date: Wed, 30 Jul 2008 11:23:27 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Zero fill the return values of rtas arg buffer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The kernel copy of the rtas args struct contains the return
value(s) for the specified rtas call.  These are copied back
to user space with the assumption that every value is properly
updated prior.  This patch zero's out the return value fields
of the rtas args struct before processing the rtas call.

I am seeing an issue in testing partition mobility, where the
return value fields of the rtas args struct contain stale data.
This causes it to appear as thought the rtas call fails, when
it actually succeeds.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---

Index: linux-2.6.git/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.git.orig/arch/powerpc/kernel/rtas.c	2008-07-22 09:34:03.000000000 -0500
+++ linux-2.6.git/arch/powerpc/kernel/rtas.c	2008-07-28 11:25:18.000000000 -0500
@@ -792,6 +792,9 @@
 	if (args.token == RTAS_UNKNOWN_SERVICE)
 		return -EINVAL;
 
+	args.rets = &args.args[nargs];
+	memset(args.rets, 0, args.nret * sizeof(rtas_arg_t));
+
 	/* Need to handle ibm,suspend_me call specially */
 	if (args.token == ibm_suspend_me_token) {
 		rc = rtas_ibm_suspend_me(&args);
@@ -808,8 +811,6 @@
 	enter_rtas(__pa(&rtas.args));
 	args = rtas.args;
 
-	args.rets = &args.args[nargs];
-
 	/* A -1 return code indicates that the last command couldn't
 	   be completed due to a hardware error. */
 	if (args.rets[0] == -1)
 
