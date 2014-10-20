Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12DBB1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:06:59 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 s9K96vog017320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 09:06:58 GMT
Date: Mon, 20 Oct 2014 12:06:27 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: benh@kernel.crashing.org
Subject: re: [POWERPC] 4xx: EP405 boards support for arch/powerpc
Message-ID: <20141020090627.GA24768@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Benjamin Herrenschmidt,

The patch 619740384ceb: "[POWERPC] 4xx: EP405 boards support for
arch/powerpc" from Dec 21, 2007, leads to the following static
checker warning:

	arch/powerpc/boot/4xx.c:567 ibm405gp_fixup_clocks()
	warn: shifting and masking to zero

arch/powerpc/boot/4xx.c
   562          fbdv = (pllmr & 0x1e000000) >> 25;
   563          if (fbdv == 0)
   564                  fbdv = 16;
   565          cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
   566          opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
   567          ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
                         ^^^^^^^^^^^^^^^^^^^^^^^^^
This mask and shift means that ppdv is always 1.

   568          epdv = ((pllmr & 0x00001800) >> 11) + 2; /* PLB:EBC */
   569          udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
   570  
   571          /* check for 405GPr */
   572          if ((mfpvr() & 0xfffffff0) == (0x50910951 & 0xfffffff0)) {
   573                  fwdvb = 8 - (pllmr & 0x00000007);
   574                  if (!(psr & 0x00001000)) /* PCI async mode enable == 0 */
   575                          if (psr & 0x00000020) /* New mode enable */
   576                                  m = fwdvb * 2 * ppdv;
   577                          else
   578                                  m = fwdvb * cbdv * ppdv;

regards,
dan carpenter
