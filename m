Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4187BDDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:20:47 +1000 (EST)
Date: Wed, 26 Sep 2007 13:20:34 +0900 (JST)
Message-Id: <20070926.132034.-1300539325.kouish@swc.toshiba.co.jp>
Subject: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at initializing SLB
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a workaround NOT to insert EA=0 entry at initializing SLB.
Without this patch, you can see /sbin/init hanging at a machine
which has less or equal than 256MB memory.

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/kernel/setup_64.c
+++ linux-powerpc-git/arch/powerpc/kernel/setup_64.c
@@ -195,6 +195,12 @@ void __init early_setup(unsigned long dt
 	get_paca()->stab_real = __pa((u64)&initial_stab);
 	get_paca()->stab_addr = (u64)&initial_stab;
 
+	/* XXX: It's a hack!
+	 * kstack must be set properly or slb_initialize() go mad to set
+	 * ESID=0 entry in bolted area of SLB.
+	 * TODO: Set correct value */
+	get_paca()->kstack = (u64)__builtin_frame_address(0);
+
 	/* Probe the machine type */
 	probe_machine();
 
