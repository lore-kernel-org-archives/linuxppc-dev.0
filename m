Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17EACDDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 04:30:10 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAGHU4R0022583
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 12:30:04 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAGHTwNx083764
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 10:30:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAGHTwSZ031523
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 10:29:58 -0700
Received: from weaponx (weaponx.rchland.ibm.com [9.10.86.205])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lAGHTvM1031487
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 10:29:57 -0700
Date: Fri, 16 Nov 2007 11:29:56 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Use virtual PVR value to init FPU on
	arch/ppc 440EP
Message-ID: <20071116112956.0f1ca5b1@weaponx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes arch/ppc 440EP platforms to setup the FPU correctly.  A virtual
PVR is used, as 440GR platforms share an identical hardware PVR value and do
not have an FPU.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Index: linux-2.6/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/setup.c
+++ linux-2.6/arch/ppc/kernel/setup.c
@@ -312,7 +312,14 @@ early_init(int r3, int r4, int r5)
 	 * Identify the CPU type and fix up code sections
 	 * that depend on which cpu we have.
 	 */
+#if defined(CONFIG_440EP) && defined(CONFIG_PPC_FPU)
+	/* We pass the virtual PVR here for 440EP as 440EP and 440GR have
+	 * identical PVRs and there is no reliable way to check for the FPU
+	 */
+	spec = identify_cpu(offset, (mfspr(SPRN_PVR) | 0x8));
+#else
 	spec = identify_cpu(offset, mfspr(SPRN_PVR));
+#endif
 	do_feature_fixups(spec->cpu_features,
 			  PTRRELOC(&__start___ftr_fixup),
 			  PTRRELOC(&__stop___ftr_fixup));
