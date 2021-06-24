Return-Path: <SRS0=UTIz=LS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF69C49EA5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 06:58:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E234613E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 06:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E234613E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G9WDk0ZYWz3btr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 16:58:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cdjrlc.com (client-ip=59.36.132.50; helo=qq.com;
 envelope-from=wangborong@cdjrlc.com; receiver=<UNKNOWN>)
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir;
 Thu, 24 Jun 2021 16:38:17 AEST
Received: from qq.com (smtpbg467.qq.com [59.36.132.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G9Vnj4mWsz2yWG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 16:38:17 +1000 (AEST)
X-QQ-mid: bizesmtp37t1624516600tqz6f830
Received: from localhost.localdomain (unknown [182.148.13.245])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 24 Jun 2021 14:36:38 +0800 (CST)
X-QQ-SSF: 01000000004000208000B00A0000000
X-QQ-FEAT: b/ahUAh0Vpxk5eOVWi7G1S7hXdII6Xjak228SqLppcx6xR828AtN7zPfeLEax
 1KLc1R+tMbQB85tRIRu2jNGu9mn6Vt88dsGu+Ma3Mwp7T0FIpC3oJaziCRETz4r8++oxwfL
 Yz6uxdIqkEpv/mfBrFsnH5GF8aYXUuRQsOJPxOhqJ7tdNlyc7Mm5e63r+GY53hsWNHC86M3
 afN8a2lnRQV09Zv4gZTaHZ6XpFoRTL1jnkEdx9i5R5n7NeluvaB4NgDh73EfSSdVruawJAU
 8NBYoHGbI/IJja030DPA/L/V7zamPqIVjnLdrNyjZV5dJraOTDnOchHeZFL9L4YWbsEcQQH
 7FDalMB/zuTRmudDXvRwZMtXliWtQ==
X-QQ-GoodBg: 0
From: Jason Wang <wangborong@cdjrlc.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/sysfs: Replace sizeof(arr)/sizeof(arr[0]) with
 ARRAY_SIZE
Date: Thu, 24 Jun 2021 14:36:32 +0800
Message-Id: <20210624063632.25632-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Thu, 24 Jun 2021 16:57:30 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: christophe.leroy@c-s.fr, maddy@linux.ibm.com, wangborong@cdjrlc.com,
 paulus@samba.org, clg@kaod.org, linuxppc-dev@lists.ozlabs.org, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ARRAY_SIZE macro is more compact and more formal in linux source.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/kernel/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 2e08640bb3b4..5ff0e55d0db1 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -843,14 +843,14 @@ static int register_cpu_online(unsigned int cpu)
 #ifdef HAS_PPC_PMC_IBM
 	case PPC_PMC_IBM:
 		attrs = ibm_common_attrs;
-		nattrs = sizeof(ibm_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(ibm_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_IBM */
 #ifdef HAS_PPC_PMC_G4
 	case PPC_PMC_G4:
 		attrs = g4_common_attrs;
-		nattrs = sizeof(g4_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(g4_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_G4 */
@@ -858,7 +858,7 @@ static int register_cpu_online(unsigned int cpu)
 	case PPC_PMC_PA6T:
 		/* PA Semi starts counting at PMC0 */
 		attrs = pa6t_attrs;
-		nattrs = sizeof(pa6t_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(pa6t_attrs);
 		pmc_attrs = NULL;
 		break;
 #endif
@@ -940,14 +940,14 @@ static int unregister_cpu_online(unsigned int cpu)
 #ifdef HAS_PPC_PMC_IBM
 	case PPC_PMC_IBM:
 		attrs = ibm_common_attrs;
-		nattrs = sizeof(ibm_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(ibm_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_IBM */
 #ifdef HAS_PPC_PMC_G4
 	case PPC_PMC_G4:
 		attrs = g4_common_attrs;
-		nattrs = sizeof(g4_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(g4_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_G4 */
@@ -955,7 +955,7 @@ static int unregister_cpu_online(unsigned int cpu)
 	case PPC_PMC_PA6T:
 		/* PA Semi starts counting at PMC0 */
 		attrs = pa6t_attrs;
-		nattrs = sizeof(pa6t_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(pa6t_attrs);
 		pmc_attrs = NULL;
 		break;
 #endif
-- 
2.31.1



