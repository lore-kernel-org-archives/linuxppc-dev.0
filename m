Return-Path: <SRS0=XY74=AY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79010C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 17:04:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02C420738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QThq7T/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02C420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B594M0B8KzDqX8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2020 03:04:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::543;
 helo=mail-ed1-x543.google.com; envelope-from=refactormyself@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QThq7T/N; dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B58sN3Cj9zDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2020 02:55:19 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id bm28so12302820edb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2020 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vg5seoeyahxUOJ1a2of2OSXbNHc8+N6IhRiLy4XR8Ps=;
 b=QThq7T/NhE4spupA48w9flKBPIUZMsJ+uy1wChEjqmd9cLUhJNeozt9BNv1EslTKul
 9FzUYVh1psv92TVnmY05kmXxx7YOjo4zsDzZUATn9e4zIhaa/IU/l64wBzjWvrwDbAdT
 yMVtRLi35HfG89vS3VWmX51PcL78Kumuk1a4Y+mb2X5zojZOcrMRGnHmOxMBpNMDphyn
 WM6skKGt7eauq9PMF4fMY/WlqUw991iJ1Ytz1rk4085GlJxA7KXFCo39uIxgjXQ9fuJN
 3z5H1aRueRaa67gizAbiKT/8yQ6CvE9P5qTMm1ibl2NWyp9eZcuTPcv+4+0VHPs7z+dy
 9v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Vg5seoeyahxUOJ1a2of2OSXbNHc8+N6IhRiLy4XR8Ps=;
 b=iV5vqHkh+3JZsw+t0YCjdKBHSLbBCPJffK03A7mk6MwNGSXqBLx9vtbTct9icjq6ff
 OdKTEc3HOW944YqPkx5cPYsvAh/p1sqjoC7gh+K0T/j+KuFHZfzSDNnM4kBmNS8XDL7C
 zoMwJiilhspYNlMPlZAkSPCJCTiIAwV5zOK52oOZS8wESfq/cbyWuKovZ0Qi9E7clCet
 HILgz5w/8H5koqIZlif3xDuMGqAyPtqSkbH+D7qKiU4zFj0dNHCHNI0fUKJLa1U5T1/y
 ZuPkHQ6u+vNEnTJMZhYRtFFhoLT9LWuxiJSFg6hitRXIrdmNAgjV8pWGRRfhCUtoMbWN
 tcvA==
X-Gm-Message-State: AOAM532GQb+y0Pqhc2qcvr1MIHrQCe8bWOyeThYncKdm10hLpOVKJZbk
 bYlUEYfeJkfQ/L5ZsrC2C7Y=
X-Google-Smtp-Source: ABdhPJwiuJGYBhFGQzVTlihXWfzHv/j6TtpsUC2ukWbQvIDZs82x6qtdrhI4g0KTxQkpdk5UBwbo4Q==
X-Received: by 2002:aa7:d58c:: with SMTP id r12mr365600edq.160.1594659316271; 
 Mon, 13 Jul 2020 09:55:16 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
 by smtp.gmail.com with ESMTPSA id w3sm11838938edq.65.2020.07.13.09.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 09:55:15 -0700 (PDT)
From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To: skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 12/14 v3] PCI/AER: Check the return value of
 pcie_capability_read_*()
Date: Mon, 13 Jul 2020 19:55:29 +0200
Message-Id: <20200713175529.29715-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713175529.29715-1-refactormyself@gmail.com>
References: <20200713175529.29715-1-refactormyself@gmail.com>
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
Cc: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter,
val to 0.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided if the return value of pcie_capability_read_word
is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/pci/pcie/aer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..f4beb47c622c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -800,6 +800,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	int aer = dev->aer_cap;
 	u32 status, mask;
 	u16 reg16;
+	int ret;
 
 	/*
 	 * When bus id is equal to 0, it might be a bad id
@@ -828,8 +829,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 		return false;
 
 	/* Check if AER is enabled */
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
-	if (!(reg16 & PCI_EXP_AER_FLAGS))
+	ret = pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
+	if (ret || !(reg16 & PCI_EXP_AER_FLAGS))
 		return false;
 
 	if (!aer)
-- 
2.18.2

