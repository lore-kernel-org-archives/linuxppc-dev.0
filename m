Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B6606A332
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfoOHzrq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGLYd1WYhz30Vm;
	Fri, 30 Oct 2026 23:50:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793364645;
	cv=none; b=E7TACwXgAD3RfhQG/tW+AcHn7iMJTFkMmqgCE72Ngba8NBnFBWTHHcWSzz8uR2pKWYzCT0PIc314GRo5c4WTEeEsOTM6RHZm7bjBKQfPU2+fQ7eKNvLjTGmfzzxxLnfZFraKepL9kTwyPZgoI04Sol0JReoEGyVn7DNEFEhkdz38SU1Q9SMaJMlL2aVeF55/RJJKxoqR+fR3tYCdBeS3hFta+4pGmvjneGYQBYsxW2IcLAYE/bH93N3K6HWZVnWz8UGXZn1Pm/STDs3+AXS8MEyFROUl32MQ0n23uMrVOQ+7bCgN9ctbnGlRFjTwLFYZnY0SZ27GUEbfcRyJdLeCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793364645; c=relaxed/relaxed;
	bh=mQqyYE4c1qwaf/1U8bOHUwTa3uH7ZLUdP/AlkoHge5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oM4S+3eW9W/PxSVpERk28jwy/7tT3//uYG5jjyA1LULcPxfsjZrQLDDPe1LwKl504qz2OlRfg767VMv+yMoaetkkiE9nLWwnMNKsNz0pWI3qGlPn3PEBEUwFLUkqW8DRMZHwDpZtrJGhoc2dxr+UqgU5paWVsft5f9WdY+Kotk0NQd3bWUeLCArjYQwi8E+HXA6u0GxYFzp5m5Hd2HFTlza4HqXpfAk42PapxKMss5zNNztdx0PUlLwPgd2VNbJzpqM+9GQYQqjdMA7gnTQLG0WNrApcXuJTo2ZydWFWjh+f7vYT9g7JAIsm9FUTPLJgiS7p8Z8V3VFf7yXGVfow6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfoOHzrq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mfoOHzrq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGLYb2Xdcz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 23:50:42 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so6850335e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364640; x=1793969440; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQqyYE4c1qwaf/1U8bOHUwTa3uH7ZLUdP/AlkoHge5g=;
        b=mfoOHzrqeX1kI+eMO2gWCQMyBN9r3C9q//CW8HZUMjFf31/PT5ujNgaqK8sf5tK8T5
         claCWQTG+e8Nz98Rn0S1SY5rm6iAVFMksDAXbmQgOpJhWdiymvQCxQeZGv1S+mhN4kVb
         d8KkdEEOgrNb33uZWXE/0LTxchAv522UVr5ZJhmtkxQBC3LYuKr9jDBI3paqlt7ELA6P
         t7JiuLKouJurRxNbdzI6ikuMGqagWXaF8hNzOZuGWQEUY0L3gvM2+kj3xi8RJVIwYoqW
         3TREVntaegig4Pd54vP+IBkQvFMw5/a7NQH4jKv1aabSW3mHwSHaKy7xTd2FSx3aOF+X
         pLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364640; x=1793969440;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mQqyYE4c1qwaf/1U8bOHUwTa3uH7ZLUdP/AlkoHge5g=;
        b=raARgidt8xWoxVzX2twZH6GKBcw1/1Xucd31lpaQXrRb3MnM5UNrgUb0xJ8Q6vTIP2
         jkkXjW/icLvxwECNJNYZDS69JsCyGAVlkerO9F15fJM2yVVK0HQEY1z3g0d7kLLqbTJm
         KymqnRYnHxqDReg4AUt+0Z7cXtgQy01j4V3+To6HQr2Bwp4L8BJqv3o01Vppo24g036r
         x1ANVst1DWZo0ozGKmtajWX8eleTm4njv8CGQBNy0pFr23v6lKXaqLFfsmunC6S03Zon
         KzRzV72TvSPpfN1swQzHr1S2CFVW5OVHSrbEhwitptpnKc6KgHS1pcHhYslyHU2jtkWr
         eWVQ==
X-Gm-Message-State: AFq9FYLHhcx1YU/VpYQymu+8QOss5OgdfVf98D4b0urh++WFY7Emlmum
	iGXiPv35KzPomRN6POHE1fP43wmr0dJe1BGJUJMnCaBHhwIHcLF2KW6vBAYfS+XQ3IE=
X-Gm-Gg: AYBFou2JGyeAS5JXySsXbowe7FnhKVdf+ZLy7hhnHW42p9/v5MUwE0i7UuBOJ4/n0GR
	albNtGMrzmY1mZdNWassC84RBpiBmBb/JtS7ZyTIk+bfYlSAfLa36oDAfJh/NTuMkcpC8XpL4zf
	wehG5FxP7FEnKFWkM9c5hkWfh5KmczgreK26VPJCiMr3pw3A6N1P7+aNx44aoG0hW+2DG5unDDl
	S//wzz0DyYsoLWAA3LQ9UTFuuPK/iHP19AHmHsYgOop9wqgVosco6OHiqAX+a+/52LZeYl3lkZB
	OIRn4YXT4rrlkRaEcfVE2GkVvyzXEGRKor/NRcdbt4VaYy96jXWgX7bzcZu75QXFigB36LniAWD
	uI6F0e8TEE8L+dCCSYZGhsHLGM1PtiIPiEmH2Q1eKo9lLVjHORSKHQttaR3L8RVLdYlbv4oDXh+
	WHGjMuMdUs1ChEmtWKR1zTC065ksU2ASRZu9DKXUxgRjJbeHLf7zYAAg8g3FiEZ2g6KG+emTULz
	zG3nmQi6WbSN/fq6oSRoS3hTBKccLNQni66n/dJOx7aRdP8OHF4HrXK3NJMhYo/9fntOx/xWFAh
	4cblkf7MmcmazXL5FTmsvIH/t/EFIJmeBxiusl9Vpi4aMN1Zst9qfD4AXUl18C0y8V/DyO3nhQ7
	mJegYpjTXM7lGKfIFd6Qj2TEW3lqHyEt0dpA94ho2nxdjs4/ztrUInJ/rLef2xgp1HXxyLJw3I+
	fQdZYvaKtIDhy2mkM=
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id 5b1f17b1804b1-4ac150b28bamr49842075e9.4.1793364639460;
        Fri, 30 Oct 2026 05:50:39 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm93079855e9.3.2026.10.30.05.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:50:38 -0700 (PDT)
From: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	maddy@linux.ibm.com,
	sashiko-bot@kernel.org,
	Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Subject: [PATCH v9 1/2] dt-bindings: vendor-prefixes: Add WatchGuard Technologies, Inc.
Date: Fri, 30 Oct 2026 08:50:20 -0400
Message-ID: <20261030125024.612396-1-lefteris.koutrakis@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the vendor prefix for WatchGuard Technologies, Inc.

Signed-off-by: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..898bb9396454 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1891,6 +1891,8 @@ patternProperties:
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":
     description: Wandbord (Technexion)
+  "^watchguard,.*":
+    description: WatchGuard Technologies, Inc.
   "^waveshare,.*":
     description: Waveshare Electronics
   "^wd,.*":
-- 
2.53.0


