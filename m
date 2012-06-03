Return-Path: <B16395@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35ACDB7010
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 17:41:04 +1000 (EST)
Received: from mail84-va3 (localhost [127.0.0.1])	by mail84-va3-R.bigfish.com
 (Postfix) with ESMTP id 4EB99C02EA	for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2012 07:40:24 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.243])	by
 mail84-va3.bigfish.com (Postfix) with ESMTP id E153F2E0051	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 07:40:21 +0000 (UTC)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/3] powerpc/mpic: Enhancements for FSL MPIC. 
Date: Sun, 3 Jun 2012 13:10:51 +0530
Message-ID: <1338709251-31075-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
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
