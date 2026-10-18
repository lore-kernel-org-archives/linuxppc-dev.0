Return-Path: <linuxppc-dev+bounces-29649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C587CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70R733Gfz2xg3;
	Mon, 19 Oct 2026 00:49:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331379;
	cv=none; b=gQWsCvYl/ecV3Hy2MjWg7KW90UEuTC948IY9GthvKjx25ayFn2YMHcePAGt3dBG1vtbXXRzAIVlaBb6ePwovd1d5NnSHlGxYSx1GOUpGY5mCEZ0cLuay4K/GZt6qDIm9afoK2wR31V5sNeDIT/8wntmm5oHgKYS5IblPS6wUDnbteZjL2+bUBr3cF/bpLul3ecJXOooyA3X/IK8BpfZUd/9IHG+LBH2F1RMxlr+BKlVzD2kdKCPeRiFpNQmrZH+1btLxGtNUC7dVpFSNs4CGSRmWRTlIYxFY2L3Neb0dxnwFFTftIG0mJo2o6hbpk7gd0TIDxoCJ0y4Dww8Cz2+ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331379; c=relaxed/relaxed;
	bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSSHh4mjNx19gF8kmZQRGAVPsPVoDfvP7qRmgQwSK5dDi0TrNxKflo+KYlMx4GFHcWtpi92JYJlMBsB5MzGsTRk0KR6AEh441T73FoOyE0b36Y3uISr/KvxeNAEIRqy9J91MDO0aTt0Iy2xhAsBwIMDo4pL1RC0XYoiMUsIynrRCKQcpcJdsl4TH/1RkkWyYCkZE3JCOPj4ctsMphdTAW3C3DdI8XOjJmOBtWpmiP1a809/wCntIom0G2HR9uPxJu42XoC6xpPyFUUzW6lMXjHaGOkTDKQDQRuZjpFRh/iJOTE5zrykAjgyCfJ/9KvXBOzJMfiibJ8X0dzRHmX70UA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=if9K3aCj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=if9K3aCj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70R56L2Mz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:37 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c37b612635bso141421766b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331374; x=1792936174; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
        b=if9K3aCjaNJ0estCVpJVhf8WQuH5wMeMXZ5EtmwAWE+d013yJcrJSLcvgCDbjwu356
         arZHSFFXXV0pDuBH6c+muBdNUMuzjVBW9lC0BPUq2b7wk/v/jtUPtxJDzD5xEZRvL547
         NmTZk+g6peXk+Sw5wWGkOo8NOIVIXfz99WAk2zjlBI/fwD81vTQn/XPCBkvGdGCLYqAS
         8sFPA+vMFmWseniWbVnRCEDBdriRF2lXWWVWm7F4lG/38tx7IQeA2h3ze1kAlNlAfqHH
         r2Rh5JhwoxB49rQkgsg3xQBUIy6KNR+tpTBqaaKL81cpwABIwlD17oKyXsWZZ8SvwwGs
         3iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331374; x=1792936174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JW5bZpm7GPoO7pVkcm3aweioHrkQpRkv3vtqxcRc/ZU=;
        b=yFWsGgW363BQ6LAnYPdUP7cO0BD9c4kKvDks4d5/Ehj/hO6dcvyhK0x0Jua1l/QUgx
         Fy6i9ZdgZXeMc5ZKZUkSnQNE6H04G/PN20eEg0S8Vmu1c2nTR74oz+JG2RCyJyvT2qy9
         VqiwrxvA235LJeJGx3Nl20ZX+2p5k9R9BFCIsgkuRXKvRmIdippK/h8KI+II+0XuYR98
         jdHNGBTGM7BUjQ5Mr2QGKTQol2TJkT1L2IIM4XlfttzG1yPYmVUphVSn4clkaDuIZPJD
         t1Fm6b6+e2r8yvq5xyQcoSJP1RPnYg0zSrT+sS8NoJGW0XT41khgRPuQPQPNPjKOyW3x
         XE3A==
X-Forwarded-Encrypted: i=1; AKwUvByyjay19g44OLK74DLpBiFGlmeQeJGRe5HvdWDQd326VFRKOkIr6YMjwEozjpSqI2gw66Le1L0b0XYIKvw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK+UtAk84UuaSYxXdaVnk5v+/6dSLvyld395uP5fB6kT8XgFh+k
	ofXqoOGiU7XIYeY48lokLNj+IZBYI1mxV+SDypvJ09epB/ozNMrRWI48
X-Gm-Gg: AYBFou0JOwNhoibHJZoU2kAWF3fYK2zF+VljlvqAbUSu5CdqddmaeuKSi9pxddKmJ6Q
	9qHWW5UykfEYsi3wkO321Q3KgfTCoxzCxgK+HT/Lrq/+JFaPiFUHnqodkQK/72VsfbMIMqtzaSl
	oQV/K/DyTG7xSMBRfI7JEHlYmhfss+uoLJQ9xlABg5y9XTlzxoOz3LSxMS/CXQZaHApQgEXPf6Z
	36yLgCFWiBaIyWLVMsn1I0qN5unZN2xf368Xnva8gUoJ/oxEZs0/hA5sQPi6k7aSki6jGPRsONj
	IJJPfr3Oi0yP+DIK3dklgTs0WKPgekqrgTeDztdeYK+8pE0B6Kx7uLKsHJGFcVlHa4Z/HqDm8y0
	qAFEqLazKR8EgIkoecNeouhn/48/YpXzZI1azuY6XzcDibotmSZe5wS40j6OyCZp84XXSJA5DuK
	GbYpUfn4DVXcPPslOJaE1ZJ6bHs6D4D4c1pTFSysPyT3DAu94dO4lTNLpzFGXHvUjFeyUPE6e5u
	g4g2Uo3Wa53uJH7M2OFKQcCFSeNbjFeo93FFqDb
X-Received: by 2002:a17:907:d2a:b0:c41:21ef:26ef with SMTP id a640c23a62f3a-c419ef2407fmr317025966b.20.1792331374388;
        Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:33 -0700 (PDT)
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
Subject: [PATCH v4 03/10] sparc64: avoid huge kernel PUD mappings with small hardware pages
Date: Sun, 18 Oct 2026 15:45:05 +0200
Message-ID: <20261018134738.1016106-4-linmag7@gmail.com>
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

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring hardware pages of at least 256MB. Sun4u instead selects
4MB pages, losing bits 27:22 when refilling a huge PUD. Sun4v also falls
back to 4MB pages when neither 256MB nor 2GB pages are selected.

Keep PMD mappings when the selected PUD encoding matches the small-page
entry. The PMD refill path preserves the bits needed by the 4MB TTE;
sun4v selections of 256MB or larger remain eligible for huge PUDs.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..f3f7eba08469 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Retain PMD mappings when the selected PUD
+	 * encoding falls back to the small-page entry.
+	 */
+	if (kern_linear_pte_xor[2] == kern_linear_pte_xor[0])
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0


