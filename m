Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BA606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bh5TC13A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGGl51mkGz30Vs;
	Fri, 30 Oct 2026 20:58:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793353010;
	cv=none; b=okxHnn0ytm/vjK6E6aAUc+uAl1kDSbP4Iu9F1nWv6uVQ5dNovZ5xSVqZd2s3nB5Z9X54wGWoy1N3uivTWSpz7vZtE0sVE28pz77yGGa6BPagyKbTWm/ySItw/HwhnAeQOexVOWmxVGt5phWqX8bgbOl/L5VL0k7W4xzntVxZBjFSmMJUR6lUDkPi+QSRHS2vlRpqhvSxtSWBiO1X73e+to7ZmbIg8nbXVKkNgi4T34tyPd5dLohReR46NlTU638cFL6uXOt1Ist71ZioLbYKMkYAIuowQ08gYKUtGC4lMA+dgTiIB+7lhNuE914pV7iyGd3cQkAdLgZZjQMI/18b7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793353010; c=relaxed/relaxed;
	bh=lIUdXHqt1l6Ach/lPnny+8tyovb/w0zE0U5VmrKoitY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJr12ZWWCe39het2mGmmgkUPINKN4uh6hSVeGVEl4za1Y8ywttAtbb5QDXMzpecNteQiMvmzv3gPpzZ7Xh65oIIxdyROZiPJXXxjrl4TTOtegeLnPVCGbneNnMxRw2qb7VGil8FNwQEaGBQERzWJ773dBTYGyJXcCl+qQcbKWKN0fvUSZ7NiUiwdWpSXcNlwvcPyPhTObCAG/EYdOPupOX4pkYQnyAmSfMDuOkK+RqhuuBXg2jgu9M3Zm9UR7SKDQ09UXK/QHSLJBIXrnHqiyDOE3owgR26+cToU1lywVyerN42fklERNnZgIqbFBIo/w+PqWOeGOmctcJruA7eznQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bh5TC13A; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=thnkslprpt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bh5TC13A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=thnkslprpt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGGFs04MZz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:36:48 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso2862815e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353000; x=1793957800; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIUdXHqt1l6Ach/lPnny+8tyovb/w0zE0U5VmrKoitY=;
        b=bh5TC13Aaw1WWVdfdHZMs6e0QXDZqLd/Utu54OVrgfnPauNB4+rosZRkEGrM66vWxi
         AE87thhTrpK8f/1iHbUujYzyDyzXu/352ufwITKW4EymmjD74yZ3FzBdKtnLd/E2PgEi
         ufdNJCuyHXGZANCpMMzLadaTnLB/5KFA5xgf2vAnvmdC2wUVfIThzid+dDGWeLfLQIzv
         dIn3SAft39bdOrPk/DTEkiBgPXw3BmAkSKMTNCMA36yVwbv+zb+bkXdHZSfAUyMeAsDS
         0R68DjFAZf310uNEqxvxDelg8An6UXy01Ahd3uEgV9/gRSE6PdvK1t+j2QgRGsN1wbIT
         V7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353000; x=1793957800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIUdXHqt1l6Ach/lPnny+8tyovb/w0zE0U5VmrKoitY=;
        b=F5sBgumlithlabQXc3q8MZxOsMZENPw2qefggHo5VknPSdJH56IYVRHbnVA1CA67/C
         JnSUcilLdYTTAkSVcvsqm1a4fyMtYk6ePS7jREWpFrBP+OzsQFhWZs5HEdsiuzWh1Gl1
         g6DyPZ6c+HONk2eJ8K2ziIWqM1SpwY/K7vqgC3mTi5BamI2pXVfl7mvWB+wbJ22MLwm6
         CqEbYTTNpHdMRo2Nnk9vpM+K/YRd0MPl+v3ywP1Eg32WeGG8Nxxkosg3PTGBS02XjThN
         dd+uV3wofOH4D/97eHHufdUkemiehAv+KWf0pUffZPUMTUtlJgpUtds39Op4UCTZfZ4q
         UasQ==
X-Forwarded-Encrypted: i=1; AKwUvBzU2yLkRjubrI+ZKr9Jjufnz/qCejt/6Xt2YIpOpn2K89DBrKctosbWIqcsq6k6tHSdVS8MqpOyI9Xli8o=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJwBXQN1BFClPoMEIgp76DWHVPaZW9eVQ55Ry4dVq3LLgrWYmGD
	TDSzI2PzNKDub/sb1F7JDlIdj1YVttWEhQH6SZlel1sa6WnCmE2f+rdo
X-Gm-Gg: AYBFou0s2xwCwxgv/cT08oTqVu3mH9ujnRZ6i66ykXTRGPnOTElPEKuEvWYaEVJXDuY
	p7zVlQb3WXapilHLM95ooO1xJl2v3Hr30CGl32rhtSdG8GjMVe1Iligu1RNpzI2YoxGwm6FGrSQ
	l5BdgSqQXFq7wGrQGAnCO5kIwKhhvrBEywOoUTdy1ww7mqnyHwZSWcN10tQIGDO3rjf5TtzFPzA
	2Oup7R4rJB0NVwEkMIFYRysZbgbCAEnPVt0XN9GrUcAE0OXI0iCbIwIpx8FJmLjiZzqYfU+4fhZ
	m4sXMCOHF3P7OboXX8H1f8h5T/D4eQpcXDthSsbCplpkV5XkUrgGciwFJ6j36tE65+xt7w2U23P
	uRoXzHt0C0rJJU6e02IRIlXsrKZdMf3uAuVbO/GTJSsb/14t06SpusDLRbmQSnuqFG8qCl232tP
	GXHZWNTWeUsefzidN+6RToc1aIGFCAnW170/cGuxbp92/nExENhhluQ6nR/wXwfGT8UrDE78QW6
	c3Fo/Gu2JARGKWor/3Ba1RQyOCaPJvobYEgwq+dVGRFRzTwfiQp50t0qLpgKNYdE4/ucRfgKinl
	6NqMWNtiMYN5BlmvTNhsIyK88a86m3rrnZMMW6JGR7p6jA==
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ac187a80bfmr35290785e9.30.1793352999880;
        Fri, 30 Oct 2026 02:36:39 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:6ca3:c7d9:c03f:68c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7c5063e3sm123364125e9.0.2026.10.30.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:36:39 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] virt: fsl_hypervisor: use matching dev_id for shutdown IRQ
Date: Fri, 30 Oct 2026 11:36:36 +0200
Message-ID: <20261030093635.2194503-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fsl_hypervisor_init() registers the shutdown doorbell IRQ with a NULL
cookie, but both the unload and allocation-failure paths pass dbisr
to free_irq(). The IRQ core cannot find the registered action and
leaves the handler installed.

Pass dbisr to request_irq() so both cleanup paths remove the action.

Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor management driver")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/virt/fsl_hypervisor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index f472c94806da7..de52d47a705e3 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -855,7 +855,7 @@ static int __init fsl_hypervisor_init(void)
 		if (of_device_is_compatible(np, "fsl,hv-shutdown-doorbell")) {
 			/* The shutdown doorbell gets its own ISR */
 			ret = request_irq(irq, fsl_hv_shutdown_isr, 0,
-					  np->name, NULL);
+					  np->name, dbisr);
 		} else if (of_device_is_compatible(np,
 			"fsl,hv-state-change-doorbell")) {
 			/*

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.43.0


