Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB879DDF06
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 05:46:56 +1000 (EST)
Date: Thu, 29 Mar 2007 14:43:14 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Please pull from 'for_linus' branch
Message-ID: <Pine.LNX.4.64.0703291434500.23408@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from 'for_linus' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

These are a few fixes for 2.6.21 related to the quicc engine support.

to receive the following updates:

 arch/powerpc/sysdev/qe_lib/qe.c |    6 +++---
 include/asm-powerpc/immap_qe.h  |    3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

Chuck Meade (1):
      [POWERPC] qe: Fix QUICC Engine SDMA setup errors

Timur Tabi (1):
      [POWERPC] qe: ucc_slow.guemr is in the wrong place

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index e3d71e0..43f6cc9 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -251,13 +251,13 @@ static int qe_sdma_init(void)

 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
-	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
+ 	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
 	if (IS_MURAM_ERR(sdma_buf_offset))
 		return -ENOMEM;

 	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
-	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
-					QE_SDMR_CEN_SHIFT)));
+ 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
+ 					(0x1 << QE_SDMR_CEN_SHIFT)));

 	return 0;
 }
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
index 9fdd049..1020b7f 100644
--- a/include/asm-powerpc/immap_qe.h
+++ b/include/asm-powerpc/immap_qe.h
@@ -258,8 +258,9 @@ struct ucc_slow {
 	u8	uccs;		/* UCCx status register */
 	u8	res3[0x24];
 	__be16	utpt;
+	u8	res4[0x52];
 	u8	guemr;		/* UCC general extended mode register */
-	u8	res4[0x200 - 0x091];
+	u8	res5[0x200 - 0x091];
 } __attribute__ ((packed));

 /* QE UCC Fast */
