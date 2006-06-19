Return-Path: <arnd@arndb.de>
Message-Id: <20060619183405.408643000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:25 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 10/20] spufs: fix initial state of wbox file
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The wbox channel count of an spu is now initialized
to four for the saved context. This makes it possible
to write to the mailbox right away without waiting
for the SPE to become scheduled first.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2129,6 +2129,7 @@ static void init_prob(struct spu_state *
 	csa->spu_chnlcnt_RW[28] = 1;
 	csa->spu_chnlcnt_RW[30] = 1;
 	csa->prob.spu_runcntl_RW = SPU_RUNCNTL_STOP;
+	csa->prob.mb_stat_R = 0x000400;
 }
 
 static void init_priv1(struct spu_state *csa)

--
