Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D07C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jan 2022 08:38:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JY3x43dh7z3cZq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jan 2022 19:38:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k+z4UCTm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9f316ba3532366066ccc+6715+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=k+z4UCTm; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JY3tC2Qvpz2yP9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jan 2022 19:35:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=+0c6MseXPX7zRtfUKiUXoXASKsSqROUYFWkyRGrgS/E=; b=k+z4UCTmXBgFK382dQDwr3z2t6
 kVefYkgvQp9eCA/CLiLCIrHBfw+PwMZAKdwFhPwN9ah2qsJAWtBmHuCNulfrdPe4aiBAie9ToSvlo
 FlGdVO8ZBi+zFHSXuB3RSv1ZZQ0KbrHdGGonk7JWce5iq3TV5OpysFc2rOf+YpceQZP9S0+QJyD3x
 +O/wDVGaV3SIiYOCFXy0HSr2UD9eB2djs4YBV2YFQUddvn/tzeRATyuMcX28UoYSh6y98mf1Jsmpp
 K35fG3pM90lgaTLPjRQlgA+riGmgHbQy5JRMDoAT+XDSvuyYccO1nbJfd64HZ73mQHmRPvIgvPRMc
 Qdgwt52A==;
Received: from [2001:4bb8:18c:6af6:82da:93cd:da5b:aa3a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7Cci-00FKq3-QZ; Tue, 11 Jan 2022 08:35:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64 define
Date: Tue, 11 Jan 2022 09:35:11 +0100
Message-Id: <20220111083515.502308-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
References: <20220111083515.502308-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-parisc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/asm-generic/fcntl.h       | 2 --
 tools/include/uapi/asm-generic/fcntl.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index ecd0f5bdfc1d6..caa482e3b01af 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -207,7 +207,6 @@ struct flock {
 };
 #endif
 
-#ifndef HAVE_ARCH_STRUCT_FLOCK64
 #ifndef __ARCH_FLOCK64_PAD
 #define __ARCH_FLOCK64_PAD
 #endif
@@ -220,6 +219,5 @@ struct flock64 {
 	__kernel_pid_t  l_pid;
 	__ARCH_FLOCK64_PAD
 };
-#endif
 
 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index ac190958c9814..4a49d33ca4d55 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -202,7 +202,6 @@ struct flock {
 };
 #endif
 
-#ifndef HAVE_ARCH_STRUCT_FLOCK64
 #ifndef __ARCH_FLOCK64_PAD
 #define __ARCH_FLOCK64_PAD
 #endif
@@ -215,6 +214,5 @@ struct flock64 {
 	__kernel_pid_t  l_pid;
 	__ARCH_FLOCK64_PAD
 };
-#endif
 
 #endif /* _ASM_GENERIC_FCNTL_H */
-- 
2.30.2

