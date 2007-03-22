Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-masked.atl.sa.earthlink.net
	(elasmtp-masked.atl.sa.earthlink.net [209.86.89.68])
	by ozlabs.org (Postfix) with ESMTP id E8F31DDFC1
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 05:13:47 +1100 (EST)
Message-ID: <4602C74F.6040402@mindspring.com>
Date: Thu, 22 Mar 2007 14:13:35 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: MPC83xx SDMR setup error
References: <460292FA.8050206@mindspring.com>	<E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>	<4602BD39.9020102@mindspring.com>
	<20070322125712.2229ff99.kim.phillips@freescale.com>
In-Reply-To: <20070322125712.2229ff99.kim.phillips@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> However, as I mention below, it is unclear whether the buffer alignment
>> requirement is 64 bytes or 4Kbytes.  The code aligns the buffer to 64 bytes.
> 
> The rev.1 8360 manual changes the rev.0 manual's 64 bytes to a 4Kbytes alignment requirement, so it's probably best to go with 4KiB.

Thanks for the information Kim.

In light of this alignment requirement, I have updated the patch and included
it below.  The new part of the patch (the alignment change) could prevent
potentially serious problems of the SDMA using MURAM that is owned by other
units.

Chuck

diff -uprN a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
--- a/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-22 14:00:02.000000000 -0400
+++ b/arch/powerpc/sysdev/qe_lib/qe.c	2007-03-22 14:01:30.000000000 -0400
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
