Return-Path: <SRS0=KLET=3K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D0C33CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 04:31:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94C722314
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 04:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="reEt3KIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94C722314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481wbv46lTzDqcS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 15:31:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481wYq3Lq1zDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 15:30:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=reEt3KIn; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 481wYq2nxsz9sP6; Tue, 21 Jan 2020 15:30:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 481wYq19zDz9sRf; Tue, 21 Jan 2020 15:30:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579581007;
 bh=VnXSOr/CG3F/Q+yjJXGwBci7SZLXmzCen97FGPUl4HA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=reEt3KInFz/U2iRTTS2ZAj2zbEGmb0FCe7yxOqOO3Cv4nQ32G+MTOXLlj+a4RC+ZB
 PV38l8hSMAoEHmfto2mfKSkFu07BLpSFDgCpqlUi1PCV1w8BG9m8Z5ePOtJiwrYd5Q
 SuGyWZqqjOSOkqATrZxnTVA8YeVyYXWkVlmwiJZlbIodt3YzqjLrgY7yZGow7ed5y6
 UCksbFuJpbxJOy5lqdT9eUuYAYDGPO4MrvLkJbvbq+gtz6P+EiQZuRXQ4v/f4QWwC/
 vlRvBK/NMwWd3yRbq17bBNGCLQb6i3BuWPRwNeorif7ND7C3ocenrAzMP6wlNW+LzC
 en+dsMUTSdEzQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 02/10] powerpc/configs: NET_CADENCE became
 NET_VENDOR_CADENCE
Date: Tue, 21 Jan 2020 15:29:52 +1100
Message-Id: <20200121043000.16212-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121043000.16212-1-mpe@ellerman.id.au>
References: <20200121043000.16212-1-mpe@ellerman.id.au>
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
Cc: oohall@gmail.com, joel@jms.id.au, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The NET_CADENCE symbol was renamed to NET_VENDOR_CADENCE, so we don't
need to disable the former, see commit 0df5f81c481e ("net: ethernet:
Add missing VENDOR to Cadence and Packet Engines symbols").

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 1 -
 1 file changed, 1 deletion(-)

v2: No change.

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 7ff1ff1ddc28..eaaffe9ae8b9 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -138,7 +138,6 @@ CONFIG_TIGON3=m
 CONFIG_BNX2X=m
 # CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
 CONFIG_CHELSIO_T1=m
 # CONFIG_NET_VENDOR_CISCO is not set
-- 
2.21.1

