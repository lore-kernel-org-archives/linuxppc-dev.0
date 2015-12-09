Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18F0A1A1048
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 17:18:49 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 8 Dec 2015 23:18:48 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6906BC9003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 01:06:55 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB96Ikai22872240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 06:18:46 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB96Ijqt026016
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 01:18:45 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] Remove OPAL pre-v3 support
Date: Wed,  9 Dec 2015 17:18:17 +1100
Message-Id: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
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

Changes since V1:
- Fix missing ; in patch 1
- remove cpuinfo OPAL v1 line in patch 2 rather than 3
- keep FW_FEATURE_OPAL rather than FW_FEATURE_OPALv3

Stewart Smith (3):
  powerpc/powernv: panic() on OPAL < V3
  powerpc/powernv: Remove OPALv2 firmware define and references
  powerpc/powernv: remove FW_FEATURE_OPALv3 and just use FW_FEATURE_OPAL

 arch/powerpc/include/asm/firmware.h          |  5 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  4 +-
 arch/powerpc/platforms/powernv/idle.c        |  2 +-
 arch/powerpc/platforms/powernv/opal-xscom.c  |  2 +-
 arch/powerpc/platforms/powernv/opal.c        | 36 +++++---------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  2 +-
 arch/powerpc/platforms/powernv/setup.c       | 12 ++---
 arch/powerpc/platforms/powernv/smp.c         | 74 ++++++++++++----------------
 drivers/cpufreq/powernv-cpufreq.c            |  2 +-
 drivers/cpuidle/cpuidle-powernv.c            |  2 +-
 10 files changed, 56 insertions(+), 85 deletions(-)

-- 
2.1.4
