Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3623C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:11:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0DC2076C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RS7wIc6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0DC2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQvrn6vVYzDqMt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 00:11:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQvjH5sWlzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 00:04:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=RS7wIc6e; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BQvjF21WQz9sTr;
 Wed, 12 Aug 2020 00:04:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1597154689;
 bh=hhQGWNZC4SROishmbkcAwtkGkjYy/VFeAK9d6mFBlwY=;
 h=From:To:Cc:Subject:Date:From;
 b=RS7wIc6eShMc/Wmt8z+8pE6hySzPKgv7xUwK2W5yTS6Ac1LvOIJ8NV0nUYxB+Yjq9
 mSXmuEdOS5meYwt5lwV1QBF+l7GJDA3J5L+BD05bvfMT/3FuTJRtjrWh0P2wosGpJT
 mqEtQhLsNviCkUstlC7qcfOLdC9oRP4Kf+sQ8d8OY9khYeLqB/H9QOM3lGxAPkxkie
 H2l08qExHn+yyJaR5pe5nzkaa3h6urqUdqvQjBcilwMMtwKS1DTUIXf4oI5Zt6U0bS
 xP0D0ev/R5WQS1iXEAXRsnnPSm0iQ1hlBvdlF4mjxPOugX3tVhrCFvQqV/R4gV5D9J
 LPRfDUec6OgrQ==
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/7] powerpc: unrel_branch_check.sh: make it suck less
Date: Wed, 12 Aug 2020 00:04:27 +1000
Message-Id: <20200811140435.20957-1-sfr@canb.auug.org.au>
X-Mailer: git-send-email 2.28.0
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
Cc: Linux PowerPC List <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman: "who wants to make
arch/powerpc/tools/unrel_branch_check.sh suck less"

This series is based off the current powerpc/next branch and keeps the
same functionaity as the original except that it suppresses some error
messages for early failures that still cause this script to succeed
(as it always did).

I did this as a series so that people can see the (mostly obvious)
transofrmations at each step.   As a single patch, it basically replaces
the whole file.

Hopefully this fulfills your definition of "sucks less" :-)

 arch/powerpc/tools/unrel_branch_check.sh | 88 ++++++++++++++++----------------
 1 file changed, 43 insertions(+), 45 deletions(-)

Cc: Nicholas Piggin <npiggin@gmail.com>
-- 
Cheers,
Stephen Rothwell

