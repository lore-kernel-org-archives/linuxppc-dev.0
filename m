Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9FFC04AB5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 17:47:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C05420868
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 17:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C05420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KY5m4xY5zDqyY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 03:47:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KXs72JVxzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 03:36:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45KXs61FJWz8wGk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 03:36:42 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45KXs55ZHLz9sQn; Fri,  7 Jun 2019 03:36:41 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=cclaudio@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45KXs42bY5z9sPg
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Jun 2019 03:36:40 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x56HTOnH138824
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Jun 2019 13:36:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sy76ngk3p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Jun 2019 13:36:37 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cclaudio@linux.ibm.com>;
 Thu, 6 Jun 2019 18:36:36 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Jun 2019 18:36:33 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x56HaVUW36831510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2019 17:36:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88AE8AC05B;
 Thu,  6 Jun 2019 17:36:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB5FDAC059;
 Thu,  6 Jun 2019 17:36:29 +0000 (GMT)
Received: from rino.br.ibm.com (unknown [9.18.235.79])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2019 17:36:29 +0000 (GMT)
From: Claudio Carvalho <cclaudio@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 7/9] KVM: PPC: Ultravisor: Restrict LDBAR access
Date: Thu,  6 Jun 2019 14:36:12 -0300
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606173614.32090-1-cclaudio@linux.ibm.com>
References: <20190606173614.32090-1-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060617-2213-0000-0000-0000039B189B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011224; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214150; UDB=6.00638204; IPR=6.00995229; 
 MB=3.00027209; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-06 17:36:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060617-2214-0000-0000-00005EBEA890
Message-Id: <20190606173614.32090-8-cclaudio@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-06_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060117
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauermann@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the ultravisor firmware is available, it takes control over the
LDBAR register. In this case, thread-imc updates and save/restore
operations on the LDBAR register are handled by ultravisor.

Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 2 ++
 arch/powerpc/platforms/powernv/idle.c     | 6 ++++--
 arch/powerpc/platforms/powernv/opal-imc.c | 7 +++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f9b2620fbecd..cffb365d9d02 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -375,8 +375,10 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_RPR, r0
 	ld	r0, KVM_SPLIT_PMMAR(r6)
 	mtspr	SPRN_PMMAR, r0
+BEGIN_FW_FTR_SECTION_NESTED(70)
 	ld	r0, KVM_SPLIT_LDBAR(r6)
 	mtspr	SPRN_LDBAR, r0
+END_FW_FTR_SECTION_NESTED(FW_FEATURE_ULTRAVISOR, 0, 70)
 	isync
 FTR_SECTION_ELSE
 	/* On P9 we use the split_info for coordinating LPCR changes */
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index c9133f7908ca..fd62435e3267 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -679,7 +679,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 		sprs.ptcr	= mfspr(SPRN_PTCR);
 		sprs.rpr	= mfspr(SPRN_RPR);
 		sprs.tscr	= mfspr(SPRN_TSCR);
-		sprs.ldbar	= mfspr(SPRN_LDBAR);
+		if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
+			sprs.ldbar	= mfspr(SPRN_LDBAR);
 
 		sprs_saved = true;
 
@@ -762,7 +763,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 	mtspr(SPRN_PTCR,	sprs.ptcr);
 	mtspr(SPRN_RPR,		sprs.rpr);
 	mtspr(SPRN_TSCR,	sprs.tscr);
-	mtspr(SPRN_LDBAR,	sprs.ldbar);
+	if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
+		mtspr(SPRN_LDBAR,	sprs.ldbar);
 
 	if (pls >= pnv_first_tb_loss_level) {
 		/* TB loss */
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 1b6932890a73..e9b641d313fb 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -254,6 +254,13 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	bool core_imc_reg = false, thread_imc_reg = false;
 	u32 type;
 
+	/*
+	 * When the Ultravisor is enabled, it is responsible for thread-imc
+	 * updates
+	 */
+	if (firmware_has_feature(FW_FEATURE_ULTRAVISOR))
+		return -EACCES;
+
 	/*
 	 * Check whether this is kdump kernel. If yes, force the engines to
 	 * stop and return.
-- 
2.20.1

