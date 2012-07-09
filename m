Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 695342C02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 18:44:29 +1000 (EST)
Received: from mail1-db3 (localhost [127.0.0.1])	by mail1-db3-R.bigfish.com
 (Postfix) with ESMTP id 63CE84002C3	for <linuxppc-dev@lists.ozlabs.org>; Mon,
 9 Jul 2012 08:42:07 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.227])	by
 mail1-db3.bigfish.com (Postfix) with ESMTP id 5A1B42A0104	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 08:42:05 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q698iHGw030993	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 01:44:18 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] powerpc/mpic: Enhancements for FSL MPIC. 
Date: Mon, 9 Jul 2012 14:13:03 +0530
Message-ID: <1341823383-15510-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds/fixes the following functionality specific to the
FSL MPIC:
1. Fix support for timer group B interrupts. Previously these were
not getting initialized.

2. Use the MPIC_LARGE_VECTORS flag while intializing FSL MPIC.
This prevents us from eating in to hardware vector number
space (MSIs) while setting up internal sources.

3.Cascaded handling for the MPIC error interrupt. This is possible
with FSL MPIC version >= 4.1.

The patches are based on "next" branch of Benjamin Herrenschmidt's powerpc
linux tree.

Varun Sethi (3):
  Support time group b on freescale chips.
  Use MPIC_LARGE_VECTORS flag for Freescale MPIC.
  Add support for cascaded error interrupt handling.

 arch/powerpc/include/asm/mpic.h          |   22 ++++
 arch/powerpc/sysdev/Makefile             |    2 +-
 arch/powerpc/sysdev/fsl_mpic_err.c       |  157 ++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/mpic.c               |   95 +++++++++++++++----
 arch/powerpc/sysdev/mpic.h               |   22 ++++
 6 files changed, 338 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_mpic_err.c

-- 
1.7.2.2
