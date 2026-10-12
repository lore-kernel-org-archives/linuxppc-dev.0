Return-Path: <linuxppc-dev+bounces-29306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56740CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:49:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RM95YW5z3c0n;
	Tue, 13 Oct 2026 05:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830933;
	cv=none; b=BKszCKKIU5kxjwJ6JSGTFR1ts/jaALVteFj21f1+o5O9DUdgrZXGQcQ4INitodRwUp6hmWCaZVSdwrl9jJgdyXMHsAc3sYcUs2+gsRh7goZgH13j+kmpWCDs3FUBmdBGhdlD8XlbrkWCpzU/hDNzPhL1xUYMhsAhiSDSTJl0Ep3EIvV/Tgl/BVKGYPKCkwBK/QTh+/FyPmtloVEuOVDlj3X5iFJYdoEp8sDD+PXbx6RDzRh0DXvdRmaz1Wvacw/kd2noga9OcPbyGKGrtlQ3QBAuJNx8IZuWlpuZMhApYRzaPmyIAbIlOZf+Q6Tux8EJay/s/JA5xIyO3O+xmU5siQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830933; c=relaxed/relaxed;
	bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjeWx8UxlEQF6X+JLtgErnbrEVp/Ej1JlEgDRpatf557SMGgxfHI0e2Z8UVcRDwIPMtienrZk7d27aigLL7+qhbihi3t/P69n/CwOZgFZ+FjVbdV06H+G65FW7Wj/lKa8TG8ZXh5M/c8Z4Dt2/eSGszzoG6i2dsp6770T3Br1zPw0LtneT+J+G6drrBarh+LdEbmKGtDyo+DxwCQpUnMha2uowBh93Z/AxLFaDZ5CeQrs1eP3SJ7smpdOLBbGVjsBKts65RcQalLMjyIGPTzWsqN1Evj6nAEyJI+yuBYVVCsv5AFbMPjs0v5YKKP7lRRiDM7N19KSp5G2x5ap6iJfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rLxKn/wl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rLxKn/wl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RM85Tdvz3byZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:52 +1100 (AEDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso369814366b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830929; x=1792435729; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=rLxKn/wlMTbh+EmSViJNBNC6/GvYCRvB3cM6Es5sPx/iUTQTM20PmZD6fPZbirCaRl
         c2bUAuHLzAZqIaVZefsohapTSD9nfcvIaX/awNLt29scpCR298Oxp1OY+TS2tXcpt2Ac
         W2pmMONqjFoFLKoz/5TRuUzyTgLq9UybsUR9Bx2x2WKZ2TXu3PyjQmYIkusJ5gAFPWpB
         KL9TikMn8egboj/EewPg47Lh4YF9I6NbHn1kiKsWaAophyO/TNXgu8O3b3Pl5QImNsHK
         cAhSE6PYooq9C5Qs2oxnLiTEPsLFI/FuyvGHYAY3GHgv+zBUsJffOHNnD1MxzG17zTl3
         ic2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830929; x=1792435729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gLypezyadrnh0M08opMU0Y8wfZpigwqaTEA/o05oR4=;
        b=aKoJtVwhaqOLQa0EtQ3AGmMlenKeYV56l96GgiFgaXegCOTPbLdy6rQYrh4lA7284G
         9DtLocNX5J7+I9Gth1OqT3V592d4aUFiOTkKrPN1WTbBk8B7e0YCaf5S5mdQQrFYfZiX
         KKX/HABz5s4htzY/Gsc7ihZxmFCevcy3D0NKShHbpOAC/HLSca+jUa9H2w1YmE9lZc09
         0N+7WEV/Uo7WBMbfAwPh0grPq13Xb/4CN1BxUu00+uKgJMPP+98bmNraBNkEKHbouybI
         8rRZ5tUAGt/X5ThXynDLhVJUh9HU1yBD3SqSJd5JfNOE2GqyuQ1qgSnJpa+K6d8UCDc9
         aJLQ==
X-Forwarded-Encrypted: i=1; AKwUvByyTJqSZzps22QjtPCD7XU9AmugvrJSbwoGQwQj8dFMVMOHQ9kLqRHIQKtKLxGFUUZawpS7z87Bbnhajb4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLJc/IGcxux6WE+X5A4pPagxmkkkYQM/wyhUiABJDEM8zNsUnNl
	W4pwTUtrP7MtICofb7CG1cNzKlxXbQEp8IMamw4PxBBOtWbUQexUu3c0
X-Gm-Gg: AYBFou3PKo5pRegHMrsHRQ/3PjMGKMYP3A5zZDQnyKxUuwpK0NgznIdxaQ3B5fyWK1V
	tR7BJdQ/dKchEp57dxKnxjdPUB11smKNl9J+YneqNtv6odJVQZqgb5dsLM2nAVMYClh0M6l+m6x
	0CHW2DD2Xjs2+UQPxVKbZlKN7Z73t/+T0J8iUsThTSpOtY3E2YN6zNk39batB/bDYFITwWJW9ma
	D3rWLmdyEUDfqzTqW3fdmnPgvfkCIdEua9yGJSStKkLQ1HWPJuSkthaHWIU8iwH0QG6TlMYYVp7
	IC/JI90uiARBf7Vq6u9BdzzKN4ey+c/yo4Xj8reNfuow1xV8QA7JzdxqlYj6qNTprAqrjS2T6ww
	8jLUEiQLwvnLbOEYszl+Ccfcy+Zi5zhlT32Ah3+n0mFbomOa7BzBEpiuHaIOZMMnBPr4IpK6+IZ
	kr+aEj5yh1IYHqZ78I4oO6e+TNy9spwOHbGe7ndrLgiiCQUDhw7OqXlxP/aH8Cp7oN4oa8MCWwq
	TXiOWBo1cE84CrgURdvA+lzrV1P+jUoZJQB9lWgUi0+HS0ei03Z
X-Received: by 2002:a17:907:3e0d:b0:c2e:80b0:deb3 with SMTP id a640c23a62f3a-c31a9a10e74mr1102093566b.7.1791830928881;
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
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
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 3/8] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Mon, 12 Oct 2026 20:48:04 +0200
Message-ID: <20261012184826.986050-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 

