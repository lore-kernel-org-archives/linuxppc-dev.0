Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id 26CEEDDF86
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 01:48:32 +1100 (EST)
Message-ID: <460292FA.8050206@mindspring.com>
Date: Thu, 22 Mar 2007 10:30:18 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: MPC83xx SDMR setup error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There appears to be an error in the MPC83xx SDMR setup in
arch/powerpc/sysdev/qe_lib/qe.c line 259.  Since 0x1 shifted right 13 bits
(QE_SDMR_CEN_SHIFT) will always be zero, the CEN field will be set to
zero.  This means the SDMR buffer size will always be 512, rather than
the intended (and allocated) 1024 bytes.

In addition, and not shown in the patch below, there is a conflict in the
alignment requirement for the value to be written to the SDEBCR register.
The SDEBCR holds the address in MURAM of the buffer to be used by the SDMA
controller.  In the MPC8323ERM.pdf section 18.1.7 titled "SDMA Internal
Resource", it states that "the base address must be aligned to a 4KByte
boundary."  However, later in the description of the SDEBCR in section
18.1.8.9, it states that the address must be "64 bytes aligned".  The code
in arch/powerpc/sysdev/qe_lib/qe.c (line 254) that allocates this buffer
aligns it to a 64-byte boundary.  This is only correct if the manual section
18.1.7, which requires a 4KByte alignment, is wrong.  Which manual section
is correct?

Chuck

--- a/linux-2.6/arch/powerpc/sysdev/qe_lib/qe.c	2007-01-13 09:37:03.000000000 -0500
+++ b/linux-2.6/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-22 09:48:46.000000000 -0400
@@ -256,7 +256,7 @@ static int qe_sdma_init(void)
  		return -ENOMEM;

  	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
-	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 <<
  					QE_SDMR_CEN_SHIFT)));

  	return 0;
