Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17773.28579.192615.227454@cargo.ozlabs.ibm.com>
Date: Wed, 29 Nov 2006 22:31:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Tell firmware we can handle POWER6 compatible mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the "logical" PVR value used by POWER6 in "compatible" mode
to the list of PVR values that the kernel tells firmware it is able to
handle.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 396109a..520ef42 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -643,6 +643,7 @@ static void __init early_cmdline_parse(v
 static unsigned char ibm_architecture_vec[] = {
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
+	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
 	5 - 1,				/* 5 option vectors */
 
