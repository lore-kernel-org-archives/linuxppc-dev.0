Date: Mon, 10 Sep 2001 19:47:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: Another fix for xmon on non-standard MMU machines
Message-ID: <20010910194730.J4823@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This patch stops xmon from attempting to print the segment registers
on machines where CONFIG_PPC_STD_MMU is not set.  This prevents xmon
from causing an exception when the 'S' command is used on the 4xx (and
others).

diff -urN ../linuxppc_2_4_devel/arch/ppc/xmon/xmon.c linux-bungo/arch/ppc/xmon/xmon.c
--- ../linuxppc_2_4_devel/arch/ppc/xmon/xmon.c	Mon Sep 10 11:11:43 2001
+++ linux-bungo/arch/ppc/xmon/xmon.c	Mon Sep 10 19:14:40 2001
@@ -847,10 +847,12 @@
 		printf("sprg0-3 = %x %x %x %x\n", get_sprg0(), get_sprg1(),
 		       get_sprg2(), get_sprg3());
 		printf("srr0 = %x, srr1 = %x\n", get_srr0(), get_srr1());
+#ifdef CONFIG_PPC_STD_MMU
 		printf("sr0-15 =");
 		for (i = 0; i < 16; ++i)
 			printf(" %x", get_sr(i));
 		printf("\n");
+#endif
 		asm("mr %0,1" : "=r" (i) :);
 		printf("sp = %x ", i);
 		asm("mr %0,2" : "=r" (i) :);


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
