Return-Path: <B08248@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C2D912C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 03:05:53 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: "galak@kernel.crashing.org" <galak@kernel.crashing.org>
Subject: pci overmapping
Date: Thu, 2 May 2013 17:05:42 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15035C8E18@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar,

In fsl_pci.c there is a change you made a while back:
  "powerpc/fsl: Setup PCI inbound window based on actual amount of memory"

...and there is this comment in the code:

    /* PCIe can overmap inbound & outbound since RX & TX are separated */
    if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {

You are implying that PCIe can overmap and PCI can't.  Why is
that?   (I'm assuming that 'overmap' means that inbound window
can extend beyond the end of ram.)

We are facing an issue for a non-PCI express controller (i.e. without
PCI_CAP_ID_EXP) emulated by QEMU.  In our case we need the ATMU
window to extend beyond the end of ram, since the window size has
to be a power of 2.

Thanks,
Stuart
