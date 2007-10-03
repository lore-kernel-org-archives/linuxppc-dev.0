Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18179.7531.403853.920730@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 14:41:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Use cache-inhibited large page bit from firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Discussions with firmware architects have confirmed that the bit in
the ibm,pa-features property that indicates support for
cache-inhibited large (>= 64kB) page mappings does in fact mean that
the hypervisor allows 64kB mappings to I/O devices.

Thus we can now enable the code that tests that bit and sets our
CPU_FTR_CI_LARGE_PAGE feature bit.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 172dcc3..9f329a8 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -531,10 +531,7 @@ static struct ibm_pa_feature {
 	{CPU_FTR_CTRL, 0,		0, 3, 0},
 	{CPU_FTR_NOEXECUTE, 0,		0, 6, 0},
 	{CPU_FTR_NODSISRALIGN, 0,	1, 1, 1},
-#if 0
-	/* put this back once we know how to test if firmware does 64k IO */
 	{CPU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
-#endif
 	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
 };
 
