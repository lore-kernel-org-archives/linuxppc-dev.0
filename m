Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2C081DE0CD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 07:26:00 +1100 (EST)
Message-ID: <47852DD6.5000702@pikatech.com>
Date: Wed, 09 Jan 2008 15:25:58 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] Warp Base Platform - cputable
References: <47852C41.8000506@pikatech.com>
In-Reply-To: <47852C41.8000506@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think I sent this, but I will include it here for completeness.
It adds the 440EP Rev C to the cputable.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index f1928af..ece0c71 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1226,6 +1226,18 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc440",
 	},
+	{ /* Matches both physical and logical PVR for 440EP (logical pvr = pvr | 0x8) */
+		.pvr_mask		= 0xf0000ff7,
+		.pvr_value		= 0x400008d4,
+		.cpu_name		= "440EP Rev. C",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440ep,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc440",
+	},
 	{ /* Use logical PVR for 440EP (logical pvr = pvr | 0x8) */
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x400008db,
