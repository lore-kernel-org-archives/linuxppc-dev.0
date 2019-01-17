Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D75C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:41:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD21320851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD21320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gQGF4wynzDqtv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 00:41:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gQ2F1vNPzDqpd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 00:31:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gQ2D6Nn2z9sDB; Fri, 18 Jan 2019 00:31:00 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43gQ2D3hMGz9sD9; Fri, 18 Jan 2019 00:30:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 6/7] powerpc/powernv: Add opal details to dump stack arch
 description
Date: Fri, 18 Jan 2019 00:30:41 +1100
Message-Id: <20190117133042.793-6-mpe@ellerman.id.au>
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

Once we have unflattened the device tree we can easily grab these opal
version details and add them to dump stack arch description, which is
printed in case of an oops.

eg: Hardware name: ... opal:v6.2

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

v2: Qualify the string with 'opal' and 'mi'. Only use git-id if version
is missing.

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 14befee4b3f1..1bfb422436fb 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -156,8 +156,33 @@ static void __init pnv_setup_arch(void)
 	/* XXX PMCS */
 }
 
+static void __init pnv_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *version;
+
+	dn = of_find_node_by_path("/ibm,opal/firmware");
+	if (!dn)
+		return;
+
+	version = of_get_property(dn, "version", NULL);
+	if (!version)
+		version = of_get_property(dn, "git-id", NULL);
+
+	if (version)
+		dump_stack_add_arch_desc("opal:%s", version);
+
+	version = of_get_property(dn, "mi-version", NULL);
+	if (version)
+		dump_stack_add_arch_desc("mi:%s", version);
+
+	of_node_put(dn);
+}
+
 static void __init pnv_init(void)
 {
+	pnv_add_dump_stack_arch_desc();
+
 	/*
 	 * Initialize the LPC bus now so that legacy serial
 	 * ports can be found on it
-- 
2.20.1

