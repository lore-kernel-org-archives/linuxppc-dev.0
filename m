Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 051D11A013D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 15:59:34 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/2] powerpc/powernv: Enable POWER8 doorbells
Date: Wed, 11 Jun 2014 15:59:26 +1000
Message-Id: <1402466368-22583-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1402466368-22583-1-git-send-email-mikey@neuling.org>
References: <1402466368-22583-1-git-send-email-mikey@neuling.org>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables POWER8 doorbells on powernv.

v2 changes:
  Only clear LPCR_PECE1 in fastsleep_loop() leave all other bits untouched.
  Add "select PPC_DOORBELL" for CONFIG PPC_POWERNV/PSERIES

Michael Neuling (2):
  powerpc/cpuidle: Only clear LPCR decrementer wakeup bit on fast sleep entry
  powerpc/powernv: Enable POWER8 doorbell IPIs

 arch/powerpc/kernel/cpu_setup_power.S  | 2 ++
 arch/powerpc/platforms/powernv/Kconfig | 1 +
 arch/powerpc/platforms/powernv/smp.c   | 6 ++++++
 arch/powerpc/platforms/pseries/Kconfig | 1 +
 arch/powerpc/sysdev/xics/icp-native.c  | 9 ++++++++-
 drivers/cpuidle/cpuidle-powernv.c      | 8 +++-----
 6 files changed, 21 insertions(+), 6 deletions(-)

-- 
1.9.1
