Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3r551xSVzDt8v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 00:11:36 +1100 (AEDT)
Date: Wed, 26 Oct 2016 16:03:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: matthias.fuchs@esd-electronics.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] [POWERPC] 4xx: Add 405GPr and 405EP support in boot
 wrapper
Message-ID: <20161026130311.GA3080@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Matthias Fuchs,

The patch 2af59f7d5c3e: "[POWERPC] 4xx: Add 405GPr and 405EP support
in boot wrapper" from Dec 7, 2007, leads to the following static
checker warning:

	arch/powerpc/boot/4xx.c:567 ibm405gp_fixup_clocks()
	warn: mask and shift to zero

arch/powerpc/boot/4xx.c
   552  void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
   553  {
   554          u32 pllmr = mfdcr(DCRN_CPC0_PLLMR);
   555          u32 cpc0_cr0 = mfdcr(DCRN_405_CPC0_CR0);
   556          u32 cpc0_cr1 = mfdcr(DCRN_405_CPC0_CR1);
   557          u32 psr = mfdcr(DCRN_405_CPC0_PSR);
   558          u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
   559          u32 fwdv, fwdvb, fbdv, cbdv, opdv, epdv, ppdv, udiv;
   560  
   561          fwdv = (8 - ((pllmr & 0xe0000000) >> 29));
   562          fbdv = (pllmr & 0x1e000000) >> 25;
   563          if (fbdv == 0)
   564                  fbdv = 16;
   565          cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
   566          opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
   567          ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
                                 ^^^^^^^^^^^^^^^^^
This is zero.  It looks like 0x00000600 was probably intended?

   568          epdv = ((pllmr & 0x00001800) >> 11) + 2; /* PLB:EBC */
   569          udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
   570  
   571          /* check for 405GPr */

regards,
dan carpenter
