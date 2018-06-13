Return-Path: <ricardo.neri-calderon@linux.intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4157kD3GR3zDr1d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 11:01:40 +1000 (AEST)
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, Clemens Ladisch <clemens@ladisch.de>,
 Arnd Bergmann <arnd@arndb.de>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 iommu@lists.linux-foundation.org
Subject: [RFC PATCH 10/23] x86/hpet: Relocate flag definitions to a header file
Date: Tue, 12 Jun 2018 17:57:30 -0700
Message-Id: <1528851463-21140-11-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Users of HPET timers (such as the hardlockup detector) need the definitions
of these flags to interpret the configuration of a timer as passed by
platform code.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h | 6 ++++++
 arch/x86/kernel/hpet.c      | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 3266796..9fd112a 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -64,6 +64,12 @@
 /* Timer used for the hardlockup detector */
 #define HPET_WD_TIMER_NR 2
 
+#define HPET_DEV_USED_BIT		2
+#define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
+#define HPET_DEV_VALID			0x8
+#define HPET_DEV_FSB_CAP		0x1000
+#define HPET_DEV_PERI_CAP		0x2000
+
 /* hpet memory map physical address */
 extern unsigned long hpet_address;
 extern unsigned long force_hpet_address;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index b03faee..99d4972 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -24,12 +24,6 @@
    NSEC = 10^-9 */
 #define FSEC_PER_NSEC			1000000L
 
-#define HPET_DEV_USED_BIT		2
-#define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
-#define HPET_DEV_VALID			0x8
-#define HPET_DEV_FSB_CAP		0x1000
-#define HPET_DEV_PERI_CAP		0x2000
-
 #define HPET_MIN_CYCLES			128
 #define HPET_MIN_PROG_DELTA		(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
 
-- 
2.7.4
