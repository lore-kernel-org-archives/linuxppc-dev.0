Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 966B767B2F
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:04:35 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwi1-0007Sd-5F@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:41 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc sparse annotations: emulate_string_inst()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	replaced declaration of EA from u32 to unsigned long - this beast
is used only to cast it to (userland) pointer and proper integer type for
that is unsigned long.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-mveth/arch/ppc/kernel/traps.c RC12-rc3-ppc-traps/arch/ppc/kernel/traps.c
--- RC12-rc3-mveth/arch/ppc/kernel/traps.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-ppc-traps/arch/ppc/kernel/traps.c	Mon Apr 25 01:36:38 2005
@@ -403,7 +403,7 @@
 	u8 rA = (instword >> 16) & 0x1f;
 	u8 NB_RB = (instword >> 11) & 0x1f;
 	u32 num_bytes;
-	u32 EA;
+	unsigned long EA;
 	int pos = 0;
 
 	/* Early out if we are an invalid form of lswx */
