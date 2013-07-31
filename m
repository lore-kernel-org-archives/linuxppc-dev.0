Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4F032C0192
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 13:00:00 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 31 Jul 2013 08:20:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7DE43E004F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 08:30:01 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6V30wJv35782672
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 08:30:58 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6V2xn3h021891
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:59:51 GMT
Subject: [PATCH V2 2/6] cpuidle/pseries: Remove dependency of pseries.h file
To: benh@kernel.crashing.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, michael@ellerman.id.au,
 srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 31 Jul 2013 08:29:05 +0530
Message-ID: <20130731025903.19448.92271.stgit@deepthi>
In-Reply-To: <20130731025840.19448.24468.stgit@deepthi>
References: <20130731025840.19448.24468.stgit@deepthi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rjw@sisk.pl, dongsheng.wang@freescale.com, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a part of pseries_idle cleanup to make the backend driver
code common to both pseries and powernv, this patch
is essential to remove the dependency of pseries.h
header file.

Move the declaration of smt_snooze_delay from pseries.h
to processor_idle.c. smt_snooze_delay variable is
needed for both pseries and powernv.

/* Snooze Delay, pseries_idle */
DECLARE_PER_CPU(long, smt_snooze_delay);

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/processor_idle.c |    4 +++-
 arch/powerpc/platforms/pseries/pseries.h        |    3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index d6a1caa..64da5cc 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -20,7 +20,9 @@
 #include <asm/runlatch.h>
 
 #include "plpar_wrappers.h"
-#include "pseries.h"
+
+/* Snooze Delay, pseries_idle */
+DECLARE_PER_CPU(long, smt_snooze_delay);
 
 struct cpuidle_driver pseries_idle_driver = {
 	.name             = "pseries_idle",
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index c2a3a25..d1b07e6 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -60,9 +60,6 @@ extern struct device_node *dlpar_configure_connector(u32);
 extern int dlpar_attach_node(struct device_node *);
 extern int dlpar_detach_node(struct device_node *);
 
-/* Snooze Delay, pseries_idle */
-DECLARE_PER_CPU(long, smt_snooze_delay);
-
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
 int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
