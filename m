Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:38:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CDA2077C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CDA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDPZ1X3MzDqTv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:38:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBjM66MJzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBjM0Q9Vz9sMQ; Mon, 22 Apr 2019 00:21:43 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBjK3n4qz9sLt; Mon, 22 Apr 2019 00:21:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 19/52] powerpc/64s: Wire up cpu_show_spectre_v2()
Date: Mon, 22 Apr 2019 00:20:04 +1000
Message-Id: <20190421142037.21881-20-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit d6fbe1c55c55c6937cbea3531af7da84ab7473c3 upstream.

Add a definition for cpu_show_spectre_v2() to override the generic
version. This has several permuations, though in practice some may not
occur we cater for any combination.

The most verbose is:

  Mitigation: Indirect branch serialisation (kernel only), Indirect
  branch cache disabled, ori31 speculation barrier enabled

We don't treat the ori31 speculation barrier as a mitigation on its
own, because it has to be *used* by code in order to be a mitigation
and we don't know if userspace is doing that. So if that's all we see
we say:

  Vulnerable, ori31 speculation barrier enabled

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 0eace3cac818..2cee3dcd231b 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -58,3 +58,36 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, c
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	bool bcs, ccd, ori;
+	struct seq_buf s;
+
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
+	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
+	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
+
+	if (bcs || ccd) {
+		seq_buf_printf(&s, "Mitigation: ");
+
+		if (bcs)
+			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+
+		if (bcs && ccd)
+			seq_buf_printf(&s, ", ");
+
+		if (ccd)
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+	} else
+		seq_buf_printf(&s, "Vulnerable");
+
+	if (ori)
+		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+
+	seq_buf_printf(&s, "\n");
+
+	return s.len;
+}
-- 
2.20.1

