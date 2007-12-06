Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 3FCD6DDFB2
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 06:18:11 +1100 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JSN0031K6W3JV90@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 06 Dec 2007 12:16:51 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JSN004006VW3Z20@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 06 Dec 2007 12:16:51 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JSN00KR26VU6420@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 06 Dec 2007 12:16:44 -0700 (MST)
Date: Thu, 06 Dec 2007 12:16:44 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [PPC] virtex bug fix: Use canonical value for AC97 interrupt
	xparams
To: jwboyer@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Message-id: <20071206191602.29192.42800.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The ml300 and ml403 xparameters.h files use different macros for the AC97
interrupt pin assignments.  This patch normalizes them to a canonical
value similar to what EDK generates for most other devices

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Josh, Paulus; this is a bug fix needed to get ml300 support to compile
in arch/ppc.  Please merge for 2.6.24

Thanks,
g.

 arch/ppc/platforms/4xx/xparameters/xparameters.h |    8 ++++++++
 arch/ppc/syslib/virtex_devices.c                 |    8 ++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
index 01aa043..8ef0887 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -15,8 +15,16 @@
 
 #if defined(CONFIG_XILINX_ML300)
   #include "xparameters_ml300.h"
+  #define XPAR_INTC_0_AC97_CONTROLLER_REF_0_PLAYBACK_VEC_ID \
+  	XPAR_DCR_INTC_0_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_INTR
+  #define XPAR_INTC_0_AC97_CONTROLLER_REF_0_RECORD_VEC_ID \
+	XPAR_DCR_INTC_0_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_INTR
 #elif defined(CONFIG_XILINX_ML403)
   #include "xparameters_ml403.h"
+  #define XPAR_INTC_0_AC97_CONTROLLER_REF_0_PLAYBACK_VEC_ID \
+  	XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_INTR
+  #define XPAR_INTC_0_AC97_CONTROLLER_REF_0_RECORD_VEC_ID \
+	XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_INTR
 #else
   /* Add other board xparameter includes here before the #else */
   #error No xparameters_*.h file included
diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index f658ff3..7322781 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -98,13 +98,13 @@
 			.flags = IORESOURCE_MEM, \
 		}, \
 		{ \
-			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_PLAYBACK_INTERRUPT_INTR, \
-			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_PLAYBACK_INTERRUPT_INTR, \
+			.start = XPAR_INTC_0_AC97_CONTROLLER_REF_##num##_PLAYBACK_VEC_ID, \
+			.end = XPAR_INTC_0_AC97_CONTROLLER_REF_##num##_PLAYBACK_VEC_ID, \
 			.flags = IORESOURCE_IRQ, \
 		}, \
 		{ \
-			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_RECORD_INTERRUPT_INTR, \
-			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_RECORD_INTERRUPT_INTR, \
+			.start = XPAR_INTC_0_AC97_CONTROLLER_REF_##num##_RECORD_VEC_ID, \
+			.end = XPAR_INTC_0_AC97_CONTROLLER_REF_##num##_RECORD_VEC_ID, \
 			.flags = IORESOURCE_IRQ, \
 		}, \
 	}, \
