Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B7606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfIXmQWc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQldY63wqz2yqs;
	Fri, 13 Nov 2026 16:08:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794546497;
	cv=none; b=fKxviUq8xd8TOJnR1n56KAjVtzSgIonTzqO5saQfjvdemS9j9S+B3pfGxJt3txTp8ddE4yvXAXlWWzrGwI/mYLpJMKzEIBuS4FNAscVRrY49RtYdIQTLmlIEhC0UQ4vj/YoBdQ/mR3BDtDdzvkuJreF7cvR6cT2dge0ssF+wJZO2rmctiy3va7l+f4WhXe8z6a3V1sKbEnAEV/PYReq51ra6Em7eUQ5/y4a61LzsFmrykik2dkfVeM3CX/N4qb02ShLO1fry05CeGzHJiVI06SMZum1pY4h5BufSif1cjxmv3k40myZtC2dEYlFM5qeonzwjemySXt+bo68FZBM1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794546497; c=relaxed/relaxed;
	bh=y2Z4k53MZ5CuMtRn2UaTr841R9J/LmSKA80BVWLhtkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLL/hEx2VIyC47+iDJM0TZNMg0I1QPr6Wb2zxruGT9tYiJ6wrqXIT/Z4AZtQtwQojVVk5yCT7OhU8P2EURrREQK5za9TsXXRNB6oXZVvQRbp3tPg/XlvfeWDWWzQnpPEFYJGBQhhUw5eUze+lgn170/Tk7RzCd8nGHLUeW+X+YyM0yy+CYPf2tfPX/IyUzyNiUYv1x8t8Ju/LmA+HeLOXoniGSbmymKzjPWp5jKdUG63ybkGN7MA6pGwhP1XAYBP23LBZGk9k/Vxj1Sf1+8TFYJrp7KwR8mqeDvkrHLyFaLS4KkNAOc3smWopQMstlaRmXH9XWXR97yC6RDHlf8J8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfIXmQWc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfIXmQWc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQldY1RdKz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 16:08:17 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso242018a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546495; x=1795151295; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2Z4k53MZ5CuMtRn2UaTr841R9J/LmSKA80BVWLhtkM=;
        b=tfIXmQWcQatQdl962IQwusbM6kTqXkg4jlDv7ktgVOh7jCXNYoBq+s/CuKEbx2UC29
         v6nm9OvnDt3tWInc50UEpI3DJ0/4wn+k2tFYpkRK4cgk0IvBv0wnBDleXNpBcnC80BAq
         7QIrQipVWYPfQ8R5bnDBa22n4fBxVR/Vm2yoUERekbLJfv+uY+iEkFIYhzGa8tL1LgHg
         pGR1u2qQC8r8D0H8zWS3QBdauj3WYCwVNmdn5c+3VGzzH/fbz1fslh40yK3hMIXzyOik
         IQKgQsCjvNeajriUp7vVZfdOD95Q5dH4dxZWFYK9sTpY/jWLzC9qgHlSgww8PupXVZ1D
         6nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546495; x=1795151295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2Z4k53MZ5CuMtRn2UaTr841R9J/LmSKA80BVWLhtkM=;
        b=qDrG5mX4Ir/Nf6moL/nPIDPBREPTO+Fo4WRCteIQ+vYlPtuMPp+Vr9lFEL7YqqaG6g
         +OKqjeZurTYkmjpP3IQ7WHqLXRxz7rDZDOYuZfipk1ehX1/IMo/Q7oKZ8zztbJyktjug
         VeJpNh6M6G1dO7J1iYuIHgSeUFKUXZ5MbVegOnYAuQXBhpafJNR/3v9fM/5L9nvi8tYC
         6R/Ow2NRfxCjmzUJEaPg+qe/udIItw2MTh1S7O6vuH3GibamTHtwO5rbmi6bQwWPjKtW
         enuA9QCbdXAM2GsJruOKIj6WUnP465OQPdxKc2Hq/n1XYFLcHx8TRiZ6CEmyaX8xdLRy
         9y4g==
X-Forwarded-Encrypted: i=1; AL+hErHW1sPAb/pWx4cTWQ8tGO/Lkn9uUsFMZpTC8ByPviZu6gVY4Qy6gx9He28e//ydw3iuJFP3IZLMi6InS3A=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9lXeBsx+UAdFcG5IVVziEJz2RGm1EBfb7fnvzm7TRasDdPTtGM
	GHgRCZr68BxncHBFhM7hql0lYRYxMdf9jA3OcnrP51uXXr6u66Bc8ZTm
X-Gm-Gg: AYBFou1qW6EGRYlQICIbT8ff/hKj+1pCwHSdwdL141TwcATTHfjEJiaIpbxFA//Vr/A
	B2Ps4NhDBW4YYcPnoTIfwt0ngrBPPBdqRn+7vzb5q7WkIKucutE5yLPwoaWm5zYDWIdzR1fvP6x
	5VPeWTyyw8w/NqVXlzC61QvQuIKx9obo8uUXSYRCGlPm5KDztc9EIN3NzFFavAvBo6ghrngmcKC
	acytZDLoH5lxLwC06pysnXtbaJCshD/JPmaiA6H/f/nxRk9iKniPLC1F0fHpP+GwGBjNww7AKWo
	St9CKyZG51y/GnQ/a7pGUTmN0bmqN2I/uAb+wrdvHI2X00yWBFQTbFOniWYvGwNzUVjMNgiZxE0
	hzcyax+NlevDgcala+7/3jJ+O8RL1PT3qoczkvAHhrV8WVtXKjBSj2IvOvKPoML2ENyfjdxc2jl
	t4w/Au8+7FFqcHgCNLibfX0Dc/Li5nL/f9KGQ+P5+wziuYQNKTDayE2RNXr1O5I0Bt0OdZWuIHH
	7u1lg4k4xK/SKXg312oD7j0TPpMcyHdLVf0jSf55wgsAlMdy7GHHrPojOUh9kyKkvpGLoSJea/h
	f+kCpn5hrjqji0Wx4GZ1ChUIyMpq5LxH2TbE7h2ruuiCLREKMsfN8w4KNsOeQDPjDi7SmBK2ltE
	DgQBbi0wtc3b7suGOLar5ztmGWXDzeiuSKlCCW5LcaPkU
X-Received: by 2002:a17:90b:3f8c:b0:39e:59a0:46b5 with SMTP id 98e67ed59e1d1-3b1b0b48069mr1373982a91.24.1794546494954;
        Thu, 12 Nov 2026 21:08:14 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm7643420a91.16.2026.11.12.21.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:08:14 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 4/6] ASoC: fsl_asrc: Request the IRQ after the device is initialized
Date: Fri, 13 Nov 2026 12:07:25 +0700
Message-ID: <20261113050727.14053-5-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113050727.14053-1-phucduc.bui@gmail.com>
References: <20261113050727.14053-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Request the IRQ after fsl_asrc_init(), while the device is still
runtime active, so that the interrupt handler cannot run before
the device is initialized.

If requesting the IRQ fails, balance the runtime PM usage count
before proceeding with cleanup.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index f7ac60724c6c..c97f814d7358 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1299,11 +1299,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
-			       dev_name(&pdev->dev), asrc);
-	if (ret)
-		return ret;
-
 	asrc->mem_clk = devm_clk_get(&pdev->dev, "mem");
 	if (IS_ERR(asrc->mem_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(asrc->mem_clk),
@@ -1436,6 +1431,14 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	/* Request the IRQ only once the device is initialized */
+	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
+			       dev_name(&pdev->dev), asrc);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		goto err_pm_get_sync;
+	}
+
 	ret = pm_runtime_put_sync(&pdev->dev);
 	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
-- 
2.43.0


