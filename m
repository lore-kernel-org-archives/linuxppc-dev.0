Date: Mon, 17 Sep 2001 15:23:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Erratum 51 bugfix?
Message-ID: <20010917152316.O3851@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


According to the ppc405gp errata, the workaround for erratum 51 is
incorrect.  The errata suggest that vector 0x1700 should branch to the
data tlb miss exception, whereas the current code branches to the
instruction tlb miss exception.  The patch below corrects this.

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-bungo/arch/ppc/kernel/head_4xx.S
--- ../linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Mon Sep 17 10:32:05 2001
+++ linux-bungo/arch/ppc/kernel/head_4xx.S	Mon Sep 17 15:19:57 2001
@@ -591,7 +594,7 @@
 #ifdef CONFIG_IBM405_ERR51
 	/* 405GP errata 51 */
 	START_EXCEPTION(0x1700, Trap_17)
-	b ITLBMiss
+	b	DTLBMiss
 #else
 	STND_EXCEPTION(0x1700,	Trap_17,		UnknownException)
 #endif

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
