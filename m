Return-Path: <linuxppc-dev+bounces-25265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FB9C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 13:06:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDH4D4cmyz30NF;
	Mon, 03 Aug 2026 23:06:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:ee2:a80:100::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785762380;
	cv=none; b=hc08rShgES/YWJk1JlXVrDdjBR0+mU55ZbQKwiKGweicgD86ZfbSuhTPc7qcuyJkIMsiDwYsN+awP8seHIjPJRA3tPqDBY4Rj3aVgLD7xINJAoDfnCdDc6s4cZdl0KQ99mkMJwvV7jwolNSDtHuvrcQ2CgdEkoPFUEiY8DrGxTMMWgwcJ6YM+G7rJFmNvbUjwxH/YTa3X/ThyOlD6vMVsbpu8oopt+fy1q5jYIEsyiTQCTJn/R3S5GTSjnBTGSZW7RZeWqZZyMN197WbEwX0TwyaTsJk9VBhTpDk3Ws0PyOTVOj4gGIF42v3K/YxmnVn7AOtM0GbQK3/DN6fZlLqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785762380; c=relaxed/relaxed;
	bh=XbIwinSBPQ6jV79oyF4QUyL/zUZBXLXiBQ7h6a9Yn1E=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=BI0cbZ/977ZQ8HTneYHOSBXOSbSVYXSOCQ/PaklEkW/6117ZsuQaPwS1SxL735v8gXZhJsgWm+QCsCtcv1Zr1fnZ8GkRZ+5lcdG8oBDKHi/bWIfn1pC6/rHtWn9Ji6NwWuMVJ3grXaHwbVtpD6AcX7uUZbj62daUVBHK84sC/rXUaxOdOK1jD4O+lYZD5RaWemj+MBIToMFP80CZGtKqb4bHxLrY9PnTL6ZKELZATqnB0lqPOrq5Fwz5Hw1PRfwNgYv0LIiJCJoOcSKRzUqfYiR48CjYZ+ytiW3eUqw76uwoHattOZzlVvanlgFwj+Q2HVpwCFAWW2ATra5IYRgfvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=borea.si; dkim=pass (1024-bit key; unprotected) header.d=borea.si header.i=@borea.si header.a=rsa-sha256 header.s=dkim header.b=BK2KYh/q; dkim-atps=neutral; spf=pass (client-ip=2a00:ee2:a80:100::2; helo=ris.borea.si; envelope-from=matevz.langus@borea.si; receiver=lists.ozlabs.org) smtp.mailfrom=borea.si
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=borea.si
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=borea.si header.i=@borea.si header.a=rsa-sha256 header.s=dkim header.b=BK2KYh/q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=borea.si (client-ip=2a00:ee2:a80:100::2; helo=ris.borea.si; envelope-from=matevz.langus@borea.si; receiver=lists.ozlabs.org)
X-Greylist: delayed 463 seconds by postgrey-1.37 at boromir; Mon, 03 Aug 2026 23:06:14 AEST
Received: from ris.borea.si (ris.borea.si [IPv6:2a00:ee2:a80:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDH466kvtz30HB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 23:06:14 +1000 (AEST)
Received: from ris.borea.si (ris.borea.si [127.0.0.1])
	by ris.borea.si (Postfix) with ESMTP id 4hDGtz6rGCz1nY
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 14:58:19 +0200 (CEST)
Authentication-Results: ris.borea.si (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=borea.si
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=borea.si; h=
	x-mailer:to:date:date:message-id:subject:subject:mime-version
	:content-transfer-encoding:content-type:content-type:from:from;
	 s=dkim; t=1785761898; x=1788353899; bh=XbIwinSBPQ6jV79oyF4QUyL/
	zUZBXLXiBQ7h6a9Yn1E=; b=BK2KYh/qtvPMsdgp52p2xb7fuaRcnYAI2WZPu2hU
	2o/kyepIL35RgFAE1HOAQOofyQnUErSbt+Bfd+Mk0Onv8p0sNGjQA19HN17EvbBI
	dbTQ6X8QnxO0qtjXSJt2u6KuNkY79p3tVTxD9gotn9kN4lh4I8tUlYp5AbvXJHu8
	3pE=
X-Virus-Scanned: Debian amavisd-new at ris.borea.si
Received: from ris.borea.si ([127.0.0.1])
	by ris.borea.si (ris.borea.si [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jy2jpooRDETK for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2026 14:58:18 +0200 (CEST)
Received: from smtpclient.apple (unknown [IPv6:2a00:ee2:a80:0:880f:f393:d837:b93f])
	by ris.borea.si (Postfix) with ESMTPSA id 4hDGtx2LdczDq;
	Mon,  3 Aug 2026 14:58:17 +0200 (CEST)
From: Matevz Langus <matevz.langus@borea.si>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC PRAM
Message-Id: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
Date: Mon, 3 Aug 2026 14:58:06 +0200
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
To: Zhao Qiang <qiang.zhao@nxp.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

More MURAM needs to be allocated than just sizeof(struct =
ucc_hdlc_param).
We have noticed MURAM corruption outside of struct ucc_hdlc_param. It =
was
caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
Even looking into QE UCC HDLC microcode source code reveals it actually
stores data beyond 0x6c.

Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode on =
kernel 6.12.

Signed-off-by: Matevz Langus <matevz.langus@borea.si>
---
 drivers/net/wan/fsl_ucc_hdlc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.h =
b/drivers/net/wan/fsl_ucc_hdlc.h
index 71d5ad0a7b98..e170d3ac9116 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.h
+++ b/drivers/net/wan/fsl_ucc_hdlc.h
@@ -60,6 +60,7 @@ struct ucc_hdlc_param {
  __be16 haddr4;
  __be16 ts_tmp;
  __be16 tmp_mb;
+ __u8 reserved[148];
 };
   struct ucc_hdlc_private {
--  2.34.1


