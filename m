Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D69606A331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9HfHq2r
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tF0k6qz2yr7;
	Fri, 20 Nov 2026 15:04:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147445;
	cv=none; b=ZZ//BrCTwwwQtpvPuCsWQ31Tu6Isj9Muc4f/pg3uSSCpyQRElNwAtB0P88v24c3UB97f7mRDguGQjFZLxQedK/BnkSAWd2Hw/30myHaTaxwk+LtQMwnEJAVrRygDp+w8H6k1kDnMNgJEnKXK2UjDgNazF6Nd8L6g9ioPD7uBO6yLdCoHHzq5ow5PwGMJJoPvXS1TevgBkTYsZaGFI494jCp+rh4SXIMobA84SA9UPh9LVX9+7bTzXeK0EcNip+IU1KGXpBGbWs3baG3LL5RyuKH1hJLi1nzn0lcUAeOwV5FlGTQdKiKFPx/mCloe3VlitKcfetVBvpWsyOEkRTuF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147445; c=relaxed/relaxed;
	bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLmvzXSlHGSLliDPNky39pvYUdsXiuIN2qc0yRoGS7amokUp1fqz3PcpMBEPAcKIBeByLYhASxXgkKdHnsLJsnqIQUyZqPBmX2VQjKuO2hHTrjfMTKwSQQE4shIH+dTaoMJPCmgFc+0sEs+mDtwJSSAvwT8aUhzCDsEnwgv4zCIPFzkZZSnyPxy5rIFq6jPeRtfehFdlLhIwdwvApecbpCI5cT5i98skDx+TeshYuS+P2NxJYUG8cLMv7r2eTsWyaomYWtpPcUwS9t/R+8P/RqINQlQmklTpje/jrplZed0cY0/Fi0YHovFzDVKumiCW68LsHS5+ROz5Qr8ABgMocA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9HfHq2r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9HfHq2r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tD3PBfz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:04 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-38564b4b017so486548eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147443; x=1795752243; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
        b=o9HfHq2ro5DJgTQ/F1lM+HqSheM/vIFMbnTkvRKdTAUttwjzxG+m3ovSsNYJ616Fe+
         RjObNkI19Ucp4cg6e93GJWnSZ2qJMslb+dCaAFArS+qv+EexklTEJovXUcs1AWTBwtUO
         Dwfh1Jt45oaHDCaqx6DL8P5jnCtI1uuYRvcjnRBKnMPxZyvz0kdC5/Xa7/5O65HWUlBY
         50fAtXuP/dXM5RiPLMlR6ypXmBuVWayFovbqwSkmpRMS7aRU6TCLVObLRULeut8yGdBw
         MeTPNXG4NznKtxjZRF2TxPOj0oXgQBgp3agBEWBmTlrUYj0gOYCWyF+aQkNCP8WL/Hy7
         bm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147443; x=1795752243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewTGQvK3tt2260QtNRrZ7p3X1lbZ3jh2OEzTu9yhDdE=;
        b=HjHSikRAkl6fa2G97yaCRH2+6s8yqN7I7mIRci9x+YY/knTpU9rd9oqCQHM7MIY9De
         559ZpBxSDkOLOS/bEX0qoLsYsnzqygQet9es55NfoOCXuoX/VngncW549h3udN07Y0b/
         72MYdmfJYrWcB/L9xbyj7zE06U1f65A6U4im0kdO4xgp+ueYEF4hkNYAwXb6QhKFfT9r
         YSfRZ8Z/4rea08PKmnXKH9tRLNGrvxxpGGmjKxO5GLLPOWcVhnzzqdf4fzekCJmYlRlf
         tws8YCf9H66MTFxlbZwENB0EhTVDbcjNDK9qqF6G3BfwX4I6Bh5AsSd/86cu4RPmmBUS
         YuYQ==
X-Gm-Message-State: APuU4Z8giY4ZjRQEEPW+YHq3QoCsF+n3j6IGbH3uGC3m9iohIOt0G1Ve
	CHgh6ggd5ZX/JYb6AGaEZh3z9YjkNOWsZKf6wDdr7PxeVUbVsZb+QgXry0kr4A==
X-Gm-Gg: AZFdTZd3x4vbrUgFe/8fT2+Kx9vUExz3O8/UcEKAKhwx8ZUNwKI+dyJb95nRAbMEMMl
	N0CLQfyJHCR/F+UGpiN3oPbmevb/aXzF9QOUdz0mOeOql/Y/kP1/tLMxwAtSdoXWMQZHDOfueiR
	gY4ZiqR86kppwrKrGC4/0Bmqa0vcz1iIRen9Cp8f8YCtWFMrrudAi3dCTYEA47oDS64W5DLVU9Q
	dmDGmUxlPMUUkRjCGKgOm81ZL4yD7XcjUjhBEFIoJnFojGPr8SCxi6PTq4IW9VXAgkMJCV6lFpz
	1Rk8uj2SX5S5NTDIwb1qcFnd9igm0ZNFwwhpl4mBkD4tRjNdBxrghwpy9WFkqUIa8abBtVcdxDC
	E8zmiiENd6QWZO9xfN6uvNJiDQZe3MTd1oKX0fI/c53g0sN7TOM6V5F4eCl0dbAREINcYl2c397
	ryMKPN8wVH7eU5X5+QlKdZzo6AmBv8+6VigrFklicQ0eQxDWdEbiom6sHm/PdaW2hAHAhgRs51G
	rGoo4Z9zdde3q9c1hNaVELiq6T23Cm7tujqvZzHPlEurU+BKvcen9/CHhKAGa4hEnYQbh5/YJQf
	ls1W1Ro1bqnN3HAe+tG9NXHITJSUBy2PHx4y7T+O9OrlvTM75rs8tCM=
X-Received: by 2002:a05:7300:f794:b0:381:c31c:bfbf with SMTP id 5a478bee46e88-384b496a36amr3121021eec.21.1795147442650;
        Thu, 19 Nov 2026 20:04:02 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:01 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 08/19] powerpc/pseries: Drop inline from hugepage invalidate
Date: Fri, 20 Nov 2026 09:33:07 +0530
Message-Id: <835cff52eb035d0fca6656209233790a3ad09dbd.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Leave __pSeries_lpar_hugepage_invalidate() static and let the
compiler decide whether to inline it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6a415febc53b..94cd30e9f6e1 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1225,7 +1225,7 @@ static void hugepage_bulk_invalidate(unsigned long *slot, unsigned long *vpn,
 	}
 }
 
-static inline void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 						      unsigned long *vpn,
 						      int count, int psize,
 						      int ssize)
-- 
2.39.5


