Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83CA52C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:30:43 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 15:19:39 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2B6DE2CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:30:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M5Ef9955247078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:14:41 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7M5UcQD013250
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:30:39 +1000
Subject: [PATCH V4 1/5] pseries/cpuidle: Remove dependency of pseries.h file
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 11:00:01 +0530
Message-ID: <20130822052958.23277.32656.stgit@deepthi.in.ibm.com>
In-Reply-To: <20130822052938.23277.67621.stgit@deepthi.in.ibm.com>
References: <20130822052938.23277.67621.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rjw@sisk.pl, daniel.lezcano@linaro.org, dongsheng.wang@freescale.com,
 preeti@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a part of pseries_idle cleanup to make the backend driver
code common to both pseries and powernv.
Remove non-essential smt_snooze_delay declaration in pseries.h
header file and pseries.h file inclusion in
pseries/processor_idle.c

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/processor_idle.c |    1 -
 arch/powerpc/platforms/pseries/pseries.h        |    3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 4644efa0..ca70279 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -20,7 +20,6 @@
 #include <asm/runlatch.h>
 
 #include "plpar_wrappers.h"
-#include "pseries.h"
 
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
