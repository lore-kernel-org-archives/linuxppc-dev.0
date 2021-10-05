Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F46C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Oct 2021 17:22:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CA8611CC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Oct 2021 17:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1CA8611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HP4C31gjWz3cN7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 04:22:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=P+WtH3IM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=naveennaidu479@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=P+WtH3IM; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HP4915DBYz3c6R
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Oct 2021 04:20:21 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id
 oa12-20020a17090b1bcc00b0019f715462a8so128755pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Oct 2021 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
 b=P+WtH3IMZqtUvBm5H9fMw9DkmxTpj9xDSJjyGL7A64Uyef7vOxtT1+71U5DwpJz9BF
 tFNkTjq14XrRxR35pQ2LG8xelzcnyqJOZeCllFYuLfBuYSQrS2XM5vb+amlwWQYvXML+
 bMoFMOoM+fQocWCzlMqISl30VSZGX7i4dvK2GZRUEVWmdwsjVZz9QkBz1ndtcGtG0QVm
 YqclJ9Y4OH1rQdMR2h4DfHgPPebH6E5VXsAg7UtWi17GKtsxNGIN3pu3NWgtOXbyMl8d
 Nqf8reqqrkiaDwGYfIyNTSfJ8gZcGkMYY6WUcBdrDnt62jpRuPfzrn7MrifNHc4tfwtx
 8O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WgoZ9+KpQrZR7tDkQXfhNUVljLBFuOfZzG3U49+7PlA=;
 b=fTlxi1qIGtpXeadxQOd3WZXUJ2N2aNOUmy/I+SRCthT4jRipcHaJpwoER+optlItYK
 JRqVnaozjlH3Z393KKumx0SH8soMBPkgELoEfRgwFe7IsKluKPTpqo1a6JN+Z7heHz4p
 Jvj9KqYtpgOUHmg8NNYRaeLWdc4h9es4u7x1f9XzK0+Xp9qDLgiZ00+Pcfbz1DSmmMf9
 a8Uv9OehUBNCxGsAOtjZR/JU9mlxYWDt0t8DH7DFd50W7fzuqx/VLglVkS1UhfNeVvBh
 LPdKhUAV7un4RNtHZ0x6hIP7VCUJNeUIPnHYsPL43WRk7XJgCwUQk5mCpx0npc4VRsrz
 CJ+w==
X-Gm-Message-State: AOAM533xsxV/XOWDfsImm1i88Jr90PzwHaOS5JoD35QBjtogphDqxdzj
 Fk9s5/tXicHP1xYVIKPHpSc=
X-Google-Smtp-Source: ABdhPJzxqc2t34kz5KgXjU7wEFsOAyUW6poe2t4eqVtMHyzkzQNDJDQfNcauVu19XLiaFPM/+9zQJw==
X-Received: by 2002:a17:902:b7c9:b0:13e:e094:e24c with SMTP id
 v9-20020a170902b7c900b0013ee094e24cmr5196351plz.3.1633454419116; 
 Tue, 05 Oct 2021 10:20:19 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
 by smtp.gmail.com with ESMTPSA id
 f25sm18476722pge.7.2021.10.05.10.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 10:20:18 -0700 (PDT)
From: Naveen Naidu <naveennaidu479@gmail.com>
To: bhelgaas@google.com,
	ruscur@russell.cc,
	oohall@gmail.com
Subject: [PATCH v4 4/8] PCI/DPC: Use pci_aer_clear_status() in
 dpc_process_error()
Date: Tue,  5 Oct 2021 22:48:11 +0530
Message-Id: <f0d301cb1245a8e2fd9565426b87c22a97aa6de7.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Naveen Naidu <naveennaidu479@gmail.com>, skhan@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel-mentees@lists.linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

dpc_process_error() clears both AER fatal and non fatal status
registers. Instead of clearing each status registers via a different
function call use pci_aer_clear_status().

This helps clean up the code a bit.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index df3f3a10f8bc..faf4a1e77fab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_status(pdev);
 	}
 }
 
-- 
2.25.1

