Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-banded.atl.sa.earthlink.net
	(elasmtp-banded.atl.sa.earthlink.net [209.86.89.70])
	by ozlabs.org (Postfix) with ESMTP id 4AC7FDDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 08:24:38 +1000 (EST)
Message-ID: <4608481E.8020204@mindspring.com>
Date: Mon, 26 Mar 2007 18:24:30 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: [PATCH] Fix MPC83xx SDMA setup errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Correct the alignment of the internal buffer used by the MPC83xx SDMA
controller to 4Kbytes.  Correct the shift direction in the logic that
sets up the SDMR register for the MPC83xx SDMA controller.

Signed-off-by: Chuck Meade <chuckmeade@mindspring.com>
---
  arch/powerpc/sysdev/qe_lib/qe.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff -uprN a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
--- a/arch/powerpc/sysdev/qe_lib/qe.c	2007-01-13 09:37:03.000000000 -0500
+++ b/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-26 17:48:08.000000000 -0400
@@ -251,12 +251,12 @@ static int qe_sdma_init(void)

  	/* allocate 2 internal temporary buffers (512 bytes size each) for
  	 * the SDMA */
-	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
+	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
  	if (IS_MURAM_ERR(sdma_buf_offset))
  		return -ENOMEM;

  	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
-	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 <<
  					QE_SDMR_CEN_SHIFT)));

  	return 0;
