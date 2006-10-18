Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FA4E67BED
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 01:47:48 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9IFlj2Z011307
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 11:47:45 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9IFljTR511032
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 09:47:45 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9IFljQB012358
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 09:47:45 -0600
Subject: [PATCH] 970GX cputable entry
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 10:47:22 -0500
Message-Id: <1161186443.28147.46.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

970GX cputable entry from Steve Winiecki.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

 arch/powerpc/kernel/cputable.c          |   15 +++++++++++++++
 arch/powerpc/oprofile/op_model_power4.c |    2 +-
 include/asm-powerpc/reg.h               |    1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

Index: merge/arch/powerpc/kernel/cputable.c
===================================================================
--- merge.orig/arch/powerpc/kernel/cputable.c
+++ merge/arch/powerpc/kernel/cputable.c
@@ -227,6 +227,21 @@ struct cpu_spec	cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
 	},
+	{	/* PPC970GX */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00450000,
+		.cpu_name		= "PPC970GX",
+		.cpu_features		= CPU_FTRS_PPC970,
+		.cpu_user_features	= COMMON_USER_POWER4 |
+			PPC_FEATURE_HAS_ALTIVEC_COMP,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 8,
+		.cpu_setup		= __setup_cpu_ppc970,
+		.oprofile_cpu_type	= "ppc64/970",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.platform		= "ppc970",
+	},
 	{	/* Power5 GR */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003a0000,
Index: merge/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- merge.orig/arch/powerpc/oprofile/op_model_power4.c
+++ merge/arch/powerpc/oprofile/op_model_power4.c
@@ -76,7 +76,7 @@ static inline int mmcra_must_set_sample(
 {
 	if (__is_processor(PV_POWER4) || __is_processor(PV_POWER4p) ||
 	    __is_processor(PV_970) || __is_processor(PV_970FX) ||
-	    __is_processor(PV_970MP))
+	    __is_processor(PV_970MP) || __is_processor(PV_970GX))
 		return 1;
 
 	return 0;
Index: merge/include/asm-powerpc/reg.h
===================================================================
--- merge.orig/include/asm-powerpc/reg.h
+++ merge/include/asm-powerpc/reg.h
@@ -591,6 +591,7 @@
 #define PV_630		0x0040
 #define PV_630p	0x0041
 #define PV_970MP	0x0044
+#define PV_970GX	0x0045
 #define PV_BE		0x0070
 #define PV_PA6T		0x0090
 
