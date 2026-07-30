Return-Path: <linuxppc-dev+bounces-25140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2033C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 22:31:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB3pb5ZSsz2xnp;
	Fri, 31 Jul 2026 08:31:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785450711;
	cv=none; b=CypT2fZz31O7i4OWedYiQdofCclVWWSYm8bcjjeTGanMksGgzO9aPLk8Pecdlxy4BYCxeKvvPrPPNw3QZsteFid3R0qKPu3MSlzfdbmpqC+Qi2K/WOtQXuStRUUyNCFk57WaIGjkX2Rgtpxt0N+Ejc3NbdLpbTgpiWI5XIMnpYZgYCiEGMOipZ6Lu3r8+8bzwbborPsYoBcpYFVDiei5w3az4ZCX2gsYTgwK8JHGjxH9K8eslP14NwyhFSpqFea5qpyC2K+atFpFoV5R+zYze47rEcR9eL0HkGK6PEpHfZtfg/YDExo0SuPZgqMv0fAkLT6JSmM3O1qbTeahvm8i/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785450711; c=relaxed/relaxed;
	bh=PlKOnAY10vVaTbHY589tMDEBcYBV0lZutRarK9tzuxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jS5cai9zMHohcXecuAWD5MkDd2DylrTb1R/KaXHmc3ROlia8ZGrojQATrwX92JAU5+oJg/W6gMnmLtpNqqva8OfeWq22Se8ADc1Zt7kTV4V47QVsoLtVztT1OB0fdomQvCIABi83SBnuMz6t7ae9UNLv5wzOeJDNdEjyXNgaLmRzvi5lBRPq6+gQXUxtRyeT+SCj8g354ajLykrRyMbSE8W5GAqcupScyZZb9OizXNlcHiepH2QZlPrfGvs50sUhoWB91nRFbIUppElTVbkzVdhLtFA4L5NyAC1M9z4W3BdxwbPvvGjEASI/x6/yt2v/gKdP4+TUQp3NNG1X5MbPLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5jusWwC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=colin.i.king@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5jusWwC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=colin.i.king@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB3pZ15BKz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 08:31:48 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so1882175e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785450703; x=1786055503; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlKOnAY10vVaTbHY589tMDEBcYBV0lZutRarK9tzuxA=;
        b=c5jusWwCaKs2PNajMwmkp47r/SK5OXVxANXR++AHYPApP0DB4INhpMwH0d7xOXFwln
         47a4FrNxEshyC8twDv+ThHOnDYysbLj5Jlkxou76iHvL7wbkyDwHXvi984h/ujjqoKhA
         xmCNt5YuuClNYqtLSDcrqkcqMVpn4TQYoMcxDBiZdNDhWhlbiMqhb1qhAJzaojwOh0nE
         gTPjRWvlDcgNNqssPYnM2KWN5dHDAx+Wpsd26RX4tegOK9om1P1wMmwjveC4l/WqqVp+
         ZQBlZLr6Xrnrdpx1tnN6PwrYfxgSAETsQFnm2qAmJ1178yGnG5QG+tKdvgbuyiTKYnWR
         W+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450703; x=1786055503;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlKOnAY10vVaTbHY589tMDEBcYBV0lZutRarK9tzuxA=;
        b=oIfeLBjzrs/qrp4gJchr8q5lnHCnD+gEYqPVCFjYQA1l4zbHQNaxKZVkmDSrhX+r21
         Ez91+vXoQ+PYpf3Ba9VqOVCTVsBopzxYgSmNRn6UO2GDcV5erTBiQcGPaOiIHuDXQDLz
         Mo7F71sNVbggwdDYiyirvVyC+GLmERy0kmBDfBq+KKu3c2yx+L5//RXlVkuZ8Ts0cUAb
         kPPfof/FlJf55uCypv6UGxcCXVRKrm48YSbAp086oPprxietzCRIlO0FGNBJFpWYnUIg
         0zkMYbxckE5eYGFQ0d/4OAR/g2iWJmNaenlKEjuqVnY0BORQfLcIHyQEBRPrGww0EFia
         FxLQ==
X-Forwarded-Encrypted: i=1; AHgh+RowRdmf02JerW8S92d3HCDcqQKhb7dLwgBzOCLdoKgQJykoYnSbo9L70+LT5wndcG9+CAzuKAgvCU+WiZI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy9rCEwxedB0lWVKl5DuV/u5fOewBltInfJO+MDHDecvL5SbQpP
	ojCvuz9aFDlzphNMtp3ldHSLjWPSKqA+VYzRkAAEPRbZOwRAnmDG84v/
X-Gm-Gg: AR+sD12JnX1M2dmYW84svhrxbLKG4d9KGjjSeQQujrqBMvhRJJQ3Pnrw3cQvglMln5U
	ReSnecHCzFgo+FSJPD57lsBAVMy55+3USDrqeygjxgXY2v26C9Fbws0fhdoMcfbVc0UPoVnfFvJ
	ghtDus3cfdWx/b8J1PDRazBWqpOEME/Q604PDw648NBgXSHyuRmfw4AUr0QkIHcQvc3bizF04tX
	Sa+4xwCi3XOMXBPBkYDiG99IOt5Nq83twNon7HWTqOFgC6nx8JaH/Wl6nnsnTnQ4yuLKecmElEY
	hDi7Hz7l8c1D3fS+v15vVTQDKVZWaAa0CA1FhF6BNynbRGOF1pY9N7w9025OXMUd6xkTLsW90UE
	LJbX8gZTUcWyN4M73P1246keho32DCZOcHFettpNsOclx1fxAva47pXgYZHq2Iox8wjAJ89Ch1s
	5h6FOcVV6w6mAVWz4DekW5fuxxu+vAo7+QIgjWgUm7mX81XBBITgCj322ObIo=
X-Received: by 2002:a05:600c:1f90:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-49800e74e48mr58540825e9.9.1785450703407;
        Thu, 30 Jul 2026 15:31:43 -0700 (PDT)
Received: from localhost ([5.83.201.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f1a7f7sm110882175e9.5.2026.07.30.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:31:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: ibmvfc: Fix spelling mistake "Deleteing" -> "Deleting"
Date: Thu, 30 Jul 2026 23:29:51 +0100
Message-ID: <20260730222951.352872-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a tgt_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index dfa231b6cc47..93b9f699c2e5 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6141,7 +6141,7 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
 
 		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
 			if (tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
-				tgt_dbg(tgt, "Deleteing NVMe rport\n");
+				tgt_dbg(tgt, "Deleting NVMe rport\n");
 				nvme_rport = tgt->nvme_remote_port;
 				list_del(&tgt->queue);
 				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DELETED_RPORT);
-- 
2.53.0


