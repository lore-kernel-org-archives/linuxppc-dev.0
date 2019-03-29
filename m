Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5668C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:40:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745C22070B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745C22070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W0CS3xJ9zDqX2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 22:40:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vzvt27v0zDqSH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 22:26:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Vzvt0t2Xz9sPB; Fri, 29 Mar 2019 22:26:34 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44Vzvs6nn0z9sRj; Fri, 29 Mar 2019 22:26:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.14 06/32] powerpc/64s: Enhance the information in
 cpu_show_spectre_v1()
Date: Fri, 29 Mar 2019 22:25:54 +1100
Message-Id: <20190329112620.14489-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329112620.14489-1-mpe@ellerman.id.au>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michal Suchanek <msuchanek@suse.de>

commit a377514519b9a20fa1ea9adddbb4129573129cef upstream.

We now have barrier_nospec as mitigation so print it in
cpu_show_spectre_v1() when enabled.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 7553951b500a..a8b277362931 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -120,6 +120,9 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, c
 	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
 		return sprintf(buf, "Not affected\n");
 
+	if (barrier_nospec_enabled)
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+
 	return sprintf(buf, "Vulnerable\n");
 }
 
-- 
2.20.1

