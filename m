Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D57C679E8
	for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2005 02:54:07 +1000 (EST)
Message-ID: <42926A07.20706@am.sony.com>
Date: Mon, 23 May 2005 16:40:55 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] add machine state register support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds routines to get and set the machine state register.  These 
are needed by power management code on some platforms.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--

Index:linux-2.6.11/arch/ppc/kernel/misc.S
===================================================================
--- linux-2.6.11.orig/arch/ppc/kernel/misc.S	2005-04-15 14:59:12.408518820 -0700
+++ linux-2.6.11/arch/ppc/kernel/misc.S	2005-04-15 14:59:34.005586781 -0700

@@ -1160,6 +1159,14 @@
 	addi	r1,r1,16
 	blr
 
+_GLOBAL(_get_msr)
+	mfmsr   r3
+	blr
+
+_GLOBAL(_set_msr)
+	mtmsr   r3
+	blr
+
 /*
  * This routine is just here to keep GCC happy - sigh...
  */
