Return-Path: <bergner@vnet.ibm.com>
Received: from mxsf32.cluster1.charter.net (mxsf32.cluster1.charter.net
	[209.225.28.156]) by ozlabs.org (Postfix) with ESMTP id 1BC0F67B5B
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 06:21:22 +1000 (EST)
Received: from mxip18a.cluster1.charter.net (mxip18a.cluster1.charter.net
	[209.225.28.148])
	by mxsf32.cluster1.charter.net (8.12.11.20060308/8.12.11) with ESMTP id
	k8EJId7L020188
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 15:18:39 -0400
Date: Thu, 14 Sep 2006 14:18:38 -0500
From: Peter Bergner <bergner@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add AT_PLATFORM value for Xilinx Virtex-4 FX
Message-ID: <20060914191838.GB17750@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Jelinek <jakub@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jakub noticed the cputable.c entry for Xilinx Virtex-4 FX was missing
a .platform value, so the AT_PLATFORM value wouldn't be set correctly.
This patch adds it.

Peter


Signed-off-by: Peter Bergner <bergner@vnet.ibm.com>

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 272e436..518b808 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -929,6 +929,7 @@ struct cpu_spec	cpu_specs[] = {
 			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.platform		= "ppc405",
 	},
 	{	/* 405EP */
 		.pvr_mask		= 0xffff0000,
