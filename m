Return-Path: <jschopp@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FAF8DE07E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 06:19:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5IKJGdv023968
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 16:19:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5IKJF2n176482
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 14:19:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5IKJFXS014997
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 14:19:15 -0600
Date: Wed, 18 Jun 2008 15:18:21 -0500
From: jschopp@austin.ibm.com
To: paulus@samba.org
Subject: [PATCH 1/2] Power7 architected entry
Message-ID: <20080618201821.GA23865@gamma>
References: <20080618201124.GA23828@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080618201124.GA23828@gamma>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add an entry for Power7 architected mode and add "(raw)" to Power7 raw mode to
distinguish it more clearly.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com> 
---
 arch/powerpc/kernel/cputable.c             |   48 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/cpu_setup.S |    6 +++
 include/asm-powerpc/cputable.h             |    9 +++++
 3 files changed, 63 insertions(+)

Index: 2.6.26-rc6/arch/powerpc/kernel/cputable.c
===================================================================
--- 2.6.26-rc6.orig/arch/powerpc/kernel/cputable.c
+++ 2.6.26-rc6/arch/powerpc/kernel/cputable.c
@@ -385,10 +385,21 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_generic,
 		.platform		= "power6",
 	},
+	{	/* 2.06-compliant processor, i.e. Power7 "architected" mode */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x0f000003,
+		.cpu_name		= "POWER7 (architected)",
+		.cpu_features		= CPU_FTRS_POWER7,
+		.cpu_user_features	= COMMON_USER_POWER7,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_generic,
+		.platform		= "power7",
+	},
 	{	/* Power7 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003f0000,
-		.cpu_name		= "POWER7",
+		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
 		.icache_bsize		= 128,
