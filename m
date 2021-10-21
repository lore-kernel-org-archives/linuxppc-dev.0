Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A013C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 04:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E642760F6E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 04:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E642760F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZYhS4bYTz3dwl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 15:02:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IJWcy4+q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=IJWcy4+q; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZYX91fY2z3bhh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Oct 2021 14:54:49 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id
 s61-20020a17090a69c300b0019f663cfcd1so2136781pjj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Oct 2021 20:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HSNM9Um8dCUyHDcxBJjDI1OfjPG7rCZCjauktoe39AQ=;
 b=IJWcy4+qorzqrgAMiOcjPmtcvf3vcDpZ/puTgzXncXK74DTunFOIO0q8eXmRKAXoqF
 JWKnhNjEUt8uea/yvttxS8/wJoaNQoBZtLEmFLx7QE0JR5fVGOiwU+BbbtDFciZSdd3/
 SR7JNHq7T/GGK8BPAmlYgwpnApvGYi13TOIqqvPzV88f0GybB7zre/PQa6kqRx4Inuqx
 fOFjNXGrOu/atdXmouj7x+hs1mfuzc04Uq/pU76+3hC/PDmbFEEV9RbJ9XdB98tXf1aq
 6mrgpoteezftoGc7lXEvGU85eMdl+emKaqPqRpKlo/ViG4zvleFQumLxC8wffky8cKmh
 2lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HSNM9Um8dCUyHDcxBJjDI1OfjPG7rCZCjauktoe39AQ=;
 b=E/TsnXRu5gr+B3g7SEgaANmlyLNROfpldrKpMP55Ti3CWZNfUbCrG0pRCgpFIu+KVg
 G32L1E+ix6vn8BvScQMWrHj4HSInOnIhVOaLFcnMeCdaGkoaeThn0qW4YWoap0SYVZrI
 BRxhBvhsopG8zyV/oceAmrVlQy0BYm/9gG64WhfDbzlfEx7t6my991HM3+92eDjV3zTa
 sH5oq/9tcvDzot9nQrzVFQeSgad/1Raq93gG+ubsonogbTmNFOTFX1PFOCJGXCMtaK1o
 htgpl0y85BMOEdLnyLROFcGk6YYg+cF/TUdJqVnOHmE4wp4H1Vmg7MZAShVP5gPJ/ebj
 zIVw==
X-Gm-Message-State: AOAM531CpbiaV/lqio4svBEA4QlQPWeiEUvn/qhOImGp/q3OZmDDONP8
 aLm1iq1iG9Fqff3e/70qOGaOS4fr59E=
X-Google-Smtp-Source: ABdhPJyk2/j0zMZ8nG6k+4Ow/0FKY6dmUlK756a1hQ7PjjYnvq0pWNJfbzxS69E/6LfFn36pEB4vpA==
X-Received: by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id
 s9-20020a170902ea0900b0013f0ac2c5aemr2917779plg.3.1634788486822; 
 Wed, 20 Oct 2021 20:54:46 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-203-144-177.static.tpgi.com.au.
 [14.203.144.177])
 by smtp.gmail.com with ESMTPSA id t9sm7369249pjm.36.2021.10.20.20.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 20:54:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/16] powerpc/64: pcpu setup avoid reading
 mmu_linear_psize on 64e or radix
Date: Thu, 21 Oct 2021 13:54:12 +1000
Message-Id: <20211021035417.2157804-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211021035417.2157804-1-npiggin@gmail.com>
References: <20211021035417.2157804-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Radix never sets mmu_linear_psize so it's always 4K, which causes pcpu
atom_size to always be PAGE_SIZE. 64e sets it to 1GB always.

Make paths for these platforms to be explicit about what value they set
atom_size to.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index eaa79a0996d1..7d4bcbc3124e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -880,14 +880,23 @@ void __init setup_per_cpu_areas(void)
 	int rc = -EINVAL;
 
 	/*
-	 * Linear mapping is one of 4K, 1M and 16M.  For 4K, no need
-	 * to group units.  For larger mappings, use 1M atom which
-	 * should be large enough to contain a number of units.
+	 * BookE and BookS radix are historical values and should be revisited.
 	 */
-	if (mmu_linear_psize == MMU_PAGE_4K)
-		atom_size = PAGE_SIZE;
-	else
+	if (IS_ENABLED(CONFIG_PPC_BOOK3E)) {
 		atom_size = 1 << 20;
+	} else if (radix_enabled()) {
+		atom_size = PAGE_SIZE;
+	} else {
+		/*
+		 * Linear mapping is one of 4K, 1M and 16M.  For 4K, no need
+		 * to group units.  For larger mappings, use 1M atom which
+		 * should be large enough to contain a number of units.
+		 */
+		if (mmu_linear_psize == MMU_PAGE_4K)
+			atom_size = PAGE_SIZE;
+		else
+			atom_size = 1 << 20;
+	}
 
 	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
 		rc = pcpu_embed_first_chunk(0, dyn_size, atom_size, pcpu_cpu_distance,
-- 
2.23.0

