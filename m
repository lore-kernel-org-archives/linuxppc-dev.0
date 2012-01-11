Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9F9E6B6EF1
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2012 12:05:48 +1100 (EST)
Message-ID: <1326243935.23910.85.camel@pasglop>
Subject: [PATCH] cpuidle: Default y for pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Jan 2012 12:05:35 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Shaohua Li <shaohua.li@intel.com>,
 linux-pm@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We just replaced the pseries platform idle loops with a cpuidle backend,
however that means that you won't get any power saving and won't return
any unused idle time to the hypervisor unless cpuidle is enabled.

Thus is should default to y when pseries is enabled. I prefer that to
a select so we can still make it modular if we want to.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Linus, do you want to just pick that up or should I put it into powerpc.git
and ask you to pull ? I will have 2 or 3 other fixes there later today,
but I wanted to make sure you were ok with the approach with this
specific one.

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 7dbc4a8..62ca70d 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -1,7 +1,8 @@
 
 config CPU_IDLE
 	bool "CPU idle PM support"
-	default ACPI
+	default y if ACPI
+	default y if PPC_PSERIES
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
