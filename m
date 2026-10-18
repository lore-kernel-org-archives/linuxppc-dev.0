Return-Path: <linuxppc-dev+bounces-29653-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002DCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70RH22JKz30B0;
	Mon, 19 Oct 2026 00:49:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331387;
	cv=none; b=AU4eHkdEFMTTEnWdGQ0GEeMvKG8/YZMGb1sHOZiadbUuwLK5Tyqyy+iJ4RhTsClcA5vsSw/mc3Q2ox7X25LOtu4P7RwMR4xvHnHtStyBA3Eex2A1aVbcEhzj1h2OtD7t98VHrLCDrXGQ7WGE1MUnaerfA1U1jalceheybYzcXhPjgdlvxtFAprVNKqOJA7a5sSA5dA8THD4csSZMQ60k0A+R25Ba/3rQX7Iv0FeRLPAis0+h7wL6l9OFTMWMbLCCp9ycj+Fp5ULuthZnPP+OfD5JL5up0HjEoAjEbgLvPziYpnu0g+Hky10UHX1s5Wms4qFPVelbDjW2fxDGkXvkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331387; c=relaxed/relaxed;
	bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8On2UfZ4WXelK1IHQN5pI3MPLz0o1ZhcjWzm+BMMfJyACGh+NxvBzpdeTxGXUHSoP5NZ3qCSr8hqx5FMz+ICl3lh/1Pdqq7KgiWyDRSv32wJx5AMvKZDN82J2FM9NuIza1VM93RurYz25VTQMXZCxTnUzRTiSVYJOtrkyzB+8AtyJ5ti3ARXLAa86E6zNjt85q/GrQTFakoi7qWwwFs6ltTppdhaW0uJ38sixHjSCwl0O5PFCyILGmj60QU98jTCSxUKb1UUIESywQC7DOQWmw2TF9nmXAfnb0rx+YFk6DFUgpKcNfL40No2fSyoEP/iuzdyEh3xc+97K3ZHZB2Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMKUrZCk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OMKUrZCk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70RG2zKwz30Wh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:46 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c4086e892a4so151695366b.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331383; x=1792936183; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
        b=OMKUrZCkCTpFY/2etPpVnd33ZBYOoD104cq/KCuOHzebzAymd9jslmo8vor4/ZAizQ
         QGBUQ4uHlu09K+pL9cGD7HNYV0Gv7ibax3ZWVNdOKUeqqbHKR38FNg35tr8v+Jzh9abT
         9W0EYQUl1yg5KjpujUAGWO6iF2qudTsEYvR/DP+lIiGeaqY4NLQi2J3kso3tZxslwz+j
         X+g9DzXZTcaHWZVshAb7j7QzXVI0dQeBTljBzRGFSITH/bKMfad7m9JNL6sJxI3StUQy
         JloMtsqeefR/RyuHfFOBaituX+qVoLpirQn2H7vJuXgb3DOBXUho6vibeS/0BVgFiwsT
         vGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331383; x=1792936183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0iP+m3EX5ucikvDp402dsq76Smx73BsFN2IxwK6/bU=;
        b=kX35R/znObJLqiuwXVxdv7dxxNM43IIITCUnrmXl2vdUTQr4wjmgSER89qmIdYtipE
         aFxWKX2+xjph1aqlPZYzjjvTuLV40C3zph4bJV/md3WHyrhDmdO+OBb/CXxX5wWICGZa
         kjQnQaYA8zmhrrcg25k/z3DS9gPTh8ZIQJ7X7RqFstR8fRRFtTSCHdGD1hGDTRE/7D64
         ZI+RqUYineXouQ6D2wKGqb6EKdfpQJc+yn63NDLnpl8MKlbhtNcI85OCdWopioGZomGL
         aliMAtNGO1z1rmv3VL08lhzseCKI4ucKVBQWeG4R7tCsXbgwnvKnl8Ejkv5b8/bZ6ofP
         kRtg==
X-Forwarded-Encrypted: i=1; AKwUvBzcE97nK/P5HDzjNwvnpx2aXC18RqVTcO2I5mJHb67MpRIUrnrzY/mZtVnmD4sxsVAC680ZhaL8hJrBFlA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLghDAhpD+medp35+n+y1jRocgv4Qbj5XvZa5j9760t7ZE0Sqdi
	weBZIgFJ1iiS9oVucfIzJazmQ4oVS8k6x93Y9k3WKcjyZNAYt6eWZYCH
X-Gm-Gg: AYBFou000tJwuI8W1IMJfmAlY5EMlxl7ADFxqFSCE/yW1AJqTsPnJrBWETXrmXFIDCo
	vUTVdzDrxDWyCYJ9rBN1tU28pRObGmBNycfXWXonPeVa4MAnhBx8pqJtvlKmUQe0XyA7TzYQXUy
	6g6e0B/PkvQWo99sdEiRj7kV2GN3eGfxxj6Hl72/d5b4U+GYrhYiUlrF1vtt0E+fof0IjyWhCxn
	EL8DA3hQckbQo7KZSjHxWi78VVe8pSuo47jWPrxnfjOz28lgXCtRUGcw5KfN5yzyxZy6/AQ98yu
	im8MonG/oCAqfOUZU6uo9bF3gApAz70yNZQBF3UcCLyft1rPVPJMDZYOE6oVCcN9mHqGWPfbOUW
	NdinnTfMcHk/9cw8bb9RA2sdL2ZTDeQILgyfq56oTA8DTA9j4dx79moQIwnLSJM07zDvFbGcTng
	6sDzPn8GxpiwUVoEuv65plzq8PjcHGUkvurTxjG+W9N2g1QTUBQRTsw/Zgd6DjXh+USI6ILncE8
	RPa8RcDYlpO6HUK9F5yrgeizqVkcpB+izmjloqp
X-Received: by 2002:a17:907:c22:b0:c41:1e13:8891 with SMTP id a640c23a62f3a-c419df3e64emr310042766b.9.1792331382777;
        Sun, 18 Oct 2026 06:49:42 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:41 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 07/10] sparc64: zero newly allocated IOMMU page tables
Date: Sun, 18 Oct 2026 15:45:09 +0200
Message-ID: <20261018134738.1016106-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
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
Content-Transfer-Encoding: 8bit

iopte_make_dummy() replaces only the physical page field, preserving
all attributes. Applying it to an uninitialized table leaves validity,
permissions, context and reserved bits dependent on prior page contents.

Zero the table allocation before installing dummy page addresses. Keep
iopte_make_dummy() unchanged for unmap callers that preserve attributes.

This initialization pattern is already present in the initial Git
import; the Fixes tag identifies its earliest recorded version.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index a23105b64fb9..66aaafbf1621 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -130,7 +130,7 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 
 	/* Now allocate and setup the IOMMU page table itself.  */
 	order = get_order(tsbsize);
-	page = alloc_pages_node(numa_node, GFP_KERNEL, order);
+	page = alloc_pages_node(numa_node, GFP_KERNEL | __GFP_ZERO, order);
 	if (!page) {
 		printk(KERN_ERR "IOMMU: Error, gfp(tsb) failed.\n");
 		goto out_free_dummy_page;
-- 
2.43.0


