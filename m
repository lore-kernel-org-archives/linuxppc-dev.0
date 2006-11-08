Return-Path: <moilanen@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D14B267CD0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 07:12:49 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA8KCiQq024231
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 15:12:44 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA8KChvZ206334
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 15:12:44 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA8KChww031041
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Nov 2006 15:12:43 -0500
Subject: [PATCH] client-architecture termination
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 14:12:28 -0600
Message-Id: <1163016748.9913.273.camel@goblue>
Mime-Version: 1.0
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Firmware is crashing during CAS parsing.  It appears that a portion of
Will's patch got dropped.

	http://patchwork.ozlabs.org/linuxppc/patch?id=6768

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

 arch/powerpc/kernel/prom_init.c |    1 +
 1 files changed, 1 insertion(+)

Index: 2.6/arch/powerpc/kernel/prom_init.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/prom_init.c
+++ 2.6/arch/powerpc/kernel/prom_init.c
@@ -649,6 +649,7 @@ static unsigned char ibm_architecture_ve
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
+	W(0x00000000), W(0xffffffff),	/* Terminator-list-entry */
 	5 - 1,				/* 5 option vectors */
 
 	/* option vector 1: processor architectures supported */
