Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A1C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:00:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3232086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3232086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YNTf3QZwzF37q
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 14:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YNJ853RczF0yj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:51:52 +1100 (AEDT)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9F2o7jO008210;
 Sun, 14 Oct 2018 21:50:20 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/12] powerpc/prom_init: Move ibm_arch_vec to __prombss
Date: Mon, 15 Oct 2018 13:49:55 +1100
Message-Id: <20181015025000.4522-7-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181015025000.4522-1-benh@kernel.crashing.org>
References: <20181015025000.4522-1-benh@kernel.crashing.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Make the existing initialized definition constant and copy
it to a __prombss copy

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 70f2bde06ab3..03b171bb1c29 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -788,7 +788,7 @@ struct ibm_arch_vec {
 	struct option_vector6 vec6;
 } __packed;
 
-struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
+static const struct ibm_arch_vec ibm_architecture_vec_template = {
 	.pvrs = {
 		{
 			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
@@ -926,6 +926,8 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 	},
 };
 
+static struct ibm_arch_vec __prombss ibm_architecture_vec  ____cacheline_aligned;
+
 /* Old method - ELF header with PT_NOTE sections only works on BE */
 #ifdef __BIG_ENDIAN__
 static const struct fake_elf {
@@ -1135,6 +1137,10 @@ static void __init prom_check_platform_support(void)
 	};
 	int prop_len = prom_getproplen(prom.chosen,
 				       "ibm,arch-vec-5-platform-support");
+
+	/* First copy the architecture vec template */
+	ibm_architecture_vec = ibm_architecture_vec_template;
+
 	if (prop_len > 1) {
 		int i;
 		u8 vec[prop_len];
-- 
2.17.1

