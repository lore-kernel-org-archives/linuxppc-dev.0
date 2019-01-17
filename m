Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B4C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:46:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AB420851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AB420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gQMd2BGDzDqgj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 00:46:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gQ2G44fDzDqpd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 00:31:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gQ2F5hpJz9sBn; Fri, 18 Jan 2019 00:31:01 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43gQ2F3Fkzz9sDP; Fri, 18 Jan 2019 00:31:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 7/7] powerpc/pseries: Add firmware details to dump stack
 arch description
Date: Fri, 18 Jan 2019 00:30:42 +1100
Message-Id: <20190117133042.793-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117133042.793-1-mpe@ellerman.id.au>
References: <20190117133042.793-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: tj@kernel.org, akpm@linux-foundation.org, mikey@neuling.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Once we have unflattened the device tree we can easily grab these
firmware version details and add them to dump stack arch description,
which is printed in case of an oops.

Currently /hypervisor only exists on KVM, so if we don't find that look
for something that suggests we're on phyp and if so that's probably a
good guess. The actual content of the ibm,fw-net-version seems to be
a full path so is too long to add to the description.

Hardware name: ... of:'IBM,FW860.42 (SV860_138)' hv:phyp

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

v2: Use 'of' rather than 'prom' for the open firmware value.

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 41f62ca27c63..dfb084f5a573 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -923,6 +923,39 @@ static void pSeries_cmo_feature_init(void)
 	pr_debug(" <- fw_cmo_feature_init()\n");
 }
 
+static void __init pseries_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *prop;
+
+	dn = of_find_node_by_path("/openprom");
+	if (dn) {
+		prop = of_get_property(dn, "model", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("of:'%s'", prop);
+
+		of_node_put(dn);
+	}
+
+	dn = of_find_node_by_path("/hypervisor");
+	if (dn) {
+		prop = of_get_property(dn, "compatible", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("hv:%s", prop);
+
+		of_node_put(dn);
+	} else {
+		dn = of_find_node_by_path("/");
+		if (dn) {
+			prop = of_get_property(dn, "ibm,fw-net-version", NULL);
+			if (prop)
+				dump_stack_add_arch_desc("hv:phyp");
+
+			of_node_put(dn);
+		}
+	}
+}
+
 /*
  * Early initialization.  Relocation is on but do not reference unbolted pages
  */
@@ -930,6 +963,8 @@ static void __init pseries_init(void)
 {
 	pr_debug(" -> pseries_init()\n");
 
+	pseries_add_dump_stack_arch_desc();
+
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hvc_vio_init_early();
-- 
2.20.1

