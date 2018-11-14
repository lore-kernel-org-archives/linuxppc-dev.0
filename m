Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C3DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 08:39:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4318D21582
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LrzAFjMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4318D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vybl2NhVzF3F8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 19:39:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="LrzAFjMR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=198.137.202.133;
 helo=bombadil.infradead.org;
 envelope-from=batv+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="LrzAFjMR"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vyFN4xj0zF3KK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 19:23:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nw/+1np6RLBwFolHupU7NVMEa64709yGsbbCr2kO4Uw=; b=LrzAFjMRbZGmBAjMO9HHRyGIWC
 KYe9i1KM+gnkk3XB+hU1HE3XRagWqWFKHt6MdzJdoGVLcyMmMqxTVIEeF3VUFYASMizmt4HbRECGo
 ciCcZVdXE5icpvoJY1T0JkuWcHf0j2dni5LK9I3JVVEXFxQ+U96/6KgzUn5DlwsdivzcxXGdEkpcL
 T/Xk0HDV2YvozBu+aBb+EBz0paVrdtN9qHlt4PaHq8ZDkwfJ0Og5BD1yPANn3mX5CL4puLZl+sphQ
 JkkOFVvCBTJJIHA7eVIhp4hGKm5d0vAB2dRFFWVPPRYGcQxrkKPOaBMF/WfGiiHqUJ1zDyQ2snIVB
 akQJq2zg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMqSH-0004e1-Qq; Wed, 14 Nov 2018 08:23:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 02/34] powerpc: allow NOT_COHERENT_CACHE for amigaone
Date: Wed, 14 Nov 2018 09:22:42 +0100
Message-Id: <20181114082314.8965-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

AMIGAONE select NOT_COHERENT_CACHE, so we better allow it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/Kconfig.cputype | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f4e2c5729374..6fedbf349fce 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -412,7 +412,8 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
+	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
+		GAMECUBE_COMMON || AMIGAONE
 	default n if PPC_47x
 	default y
 
-- 
2.19.1

