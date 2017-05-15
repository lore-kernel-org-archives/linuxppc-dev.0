Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRLVF4vhnzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 23:08:05 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FD46vT187421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:03 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afbmxv87v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:01 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Mon, 15 May 2017 14:08:00 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/4] Support for the FSP2 476fpe board in arch/powerpc
Date: Mon, 15 May 2017 16:07:50 +0300
Message-Id: <20170515130754.59363-1-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for the FSP2 (476fpe) board. This includes code in
arch/powerpc/platforms/44x for board initialization. Only uImage is
supported by now. Also there was some problem with whole watchdog TCR
rewrite which causing unexpected very early panic and fixed by 4 patch.
dts and defconfig for common usage included as well. Tested on FSP2 board
with uboot and initramfs image.

Ivan Mikhaylov (4):
  arch/powerpc/44x/fsp2: platform support for fsp2(476fpe) board
  arch/powerpc/44x/fsp2: add device tree for fsp2 board
  arch/powerpc/44x/fsp2: add defconfig for fsp2 board
  arch/powerpc/44x/fsp2: wdt tcr update instead of whole rewrite

 arch/powerpc/boot/dts/fsp2.dts          |  608 +++++++++++++++++++++++++++++++
 arch/powerpc/configs/44x/fsp2_defconfig |  126 +++++++
 arch/powerpc/kernel/time.c              |   16 +
 arch/powerpc/platforms/44x/Kconfig      |   12 +
 arch/powerpc/platforms/44x/Makefile     |    1 +
 arch/powerpc/platforms/44x/fsp2.c       |   62 ++++
 6 files changed, 825 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsp2.dts
 create mode 100644 arch/powerpc/configs/44x/fsp2_defconfig
 create mode 100644 arch/powerpc/platforms/44x/fsp2.c
