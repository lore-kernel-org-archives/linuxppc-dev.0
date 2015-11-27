Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CE491A0464
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 15:45:59 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 21:45:57 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C15F919D8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:33:47 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR4jf2i19988516
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:41 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR4jes8016749
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:40 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Remove OPAL pre-v3 support
Date: Fri, 27 Nov 2015 15:45:22 +1100
Message-Id: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Everything that ever made it out of the lab is OPALv3.

The number of machines in the lab even that are OPAL pre v3 is so
likely to be zero it's not funny, and the number of people expecting
to run mainline kernels on OPAL pre v3 is even lower than that.

So, this patch series removes things referencing OPAL that isn't
OPALv3 and leaves us with a simple FW_FEATURE_OPALv3 define at the
end that we can check against.

Anyone mad enough to do an OPALv4 gets to go look at all the things
themselves.

Stewart Smith (4):
  powerpc/powernv: panic() on OPAL < V3
  powerpc/powernv: Remove OPALv2 firmware define and references
  powerpc/powernv: remove FW_FEATURE_OPAL and just use FW_FEATURE_OPALv3
  powerpc/powernv: remove logic for pre-OPALv3 firmware

 arch/powerpc/include/asm/firmware.h    |  5 +--
 arch/powerpc/mm/numa.c                 |  4 +-
 arch/powerpc/platforms/powernv/opal.c  | 16 ++------
 arch/powerpc/platforms/powernv/pci.c   |  2 +-
 arch/powerpc/platforms/powernv/setup.c | 10 ++---
 arch/powerpc/platforms/powernv/smp.c   | 72 +++++++++++++++-------------------
 arch/powerpc/sysdev/xics/ics-opal.c    |  2 +-
 drivers/i2c/busses/i2c-opal.c          |  2 +-
 drivers/rtc/rtc-opal.c                 |  2 +-
 drivers/tty/hvc/hvc_opal.c             |  2 +-
 10 files changed, 46 insertions(+), 71 deletions(-)

-- 
2.1.4
