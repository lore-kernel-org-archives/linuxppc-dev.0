Return-Path: <linuxppc-dev+bounces-14582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9F1D1BDE0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Dec 2025 21:00:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dM94z4thmz2ynH;
	Thu, 04 Dec 2025 08:00:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764789483;
	cv=none; b=RELSb9oK3ZytRR3V92K2ywEknw7cj2vuhZdtsv/P92a6sLjLvb9BabY03ssSQ31uZqk3t1JTf6DrBuZZOZTmWRy8WxwOcOn74rVpUmQ3ZTsvvj6NUSdn5l8KsgxphpiPEzh52r5oeKuYLau9LRIYh51vVeXUclz9ZsaRJ0z8+HkjbM7T/+hhyK6G6c1aSAe8hUGZh3TzsK8FwwGTkXLwLIwt6iDMxA46KphdmH9jjx9yfy0sBLr3xXaj0rdtIoqTvidvcYoMOd045GfNslkcj8dL8T4Hg2sR8Vms4pLvlyxFwL25frJhsfmzGCr6BoLk2B+U8XIwdXiACS2krC3PFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764789483; c=relaxed/relaxed;
	bh=6iTv+jxCLMgJTqv4zJ35P8h4uCjs9494yiCOJzGvP0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TBjRcw2xDRApZG2ldrdZ0NSpRy2aaq3HxPpxPjK9acUhmTymuL6oI5w6/3wO0AUNK71NzW0dRfL0LWYRLZGj3V3+HT+BXN7rVS6XuGLlzSmypDAOxZbhxstrEG06vBecdg4CsPTDO8+PrTLnCo+NWEC/GG7guoX9tG1uUqOKBIMFsb0f1n3hMkG8vReFzW57NDpd4YG/oOI11F5qtBTFmfN8TpQxWUbhTB4ekikFGb1L4nVE0Bu4x06bwIBr7uGnbR1MCgmkZ8jN0zC5D4TwwiaCGMvGSw1ezu6oRZWvfJvKPWjifP8NsQYd9zgGe6mJ4gIsKCw1ayIilptu1nev4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WwXuARqx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=sohammetha01@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WwXuARqx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=sohammetha01@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dM6qG0VRcz2yvB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Dec 2025 06:18:00 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-343ea89896eso28124a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2025 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789478; x=1765394278; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6iTv+jxCLMgJTqv4zJ35P8h4uCjs9494yiCOJzGvP0U=;
        b=WwXuARqxAqfAFEd172eqLFEEoCF8SUPOrLAQOi/wHYPEhSYhhMFwHGqmGkCzl6e/92
         nC1o+hpcXy2RTnHol1StQk1LmQdtjkLIuUq6Dpe5ctaILZsBYIVRo1LLEF0cLXPNaNqG
         xZwLtb3Jht9dUoRvzPrKLTZKcdJA5TWAKL0axGkvW5P22/V1KG+lwhz79cWRDnG5BPKT
         34WY+6lQp7/mwvbPYdqxoQ01OmgfRn83qVN9xLfxEYpA+4HrdfE5ZuzorMiMf6lGNmPw
         VSMUZ7aT+Nw4JIkchITf2iueUr9uhqvgwHIJLPATnFWXOd2UrwJJK1hj9R0saFNAtzQd
         twWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789478; x=1765394278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iTv+jxCLMgJTqv4zJ35P8h4uCjs9494yiCOJzGvP0U=;
        b=Ugf4wQm/6WN+CxMP3KvnkmUbKmLwt6UEKknz9fXVJu4qNAGmmOVM43d0xbLFLUnFmz
         OCYZpCUSie0kefZlCuvDe2hE3r8R7x2TXBCVvjLIQX1oYzEetU9z3WKC531oKcOnnyvE
         YgN1dZOFb4mosZsNAHfPGebhe+a/iQsu8WUWjnvcbvm3HFVEK78G0q17FJ+OjDoOrcL+
         ulxCSzeLcaYgB3rBI+pvKAjIs+bWcN7PCeVmOozVUdAtPZWSQPu8vpt+iFcpzgNoUdya
         1CHcJ3xAxJNpkkcDIX/Ra5N7Ze8kd5AdoI/2Wp2rT6mStOuO/Sus2wf3cNo8vN4zL+p+
         sjwg==
X-Forwarded-Encrypted: i=1; AJvYcCUOj2hfxW1IPGJ5BjGgcJjZmU0XUDDnj7o8vk6AFDq3aWUfDUqGwZNHy1sGoifg5ReaYDaStXxbKSxDYHw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6G67bueVco8dSLBDaem+Gj5kfYhjWQPXQfIP6bTqVUkWkiiLo
	9K3kLQboq1XnIawWJwVJVng8j6q7zYe3ib8ZqmPdqvWoZxUpULZSmdgh
X-Gm-Gg: ASbGnctL0ZvxkhgIcBDOVOyq4CmSOSfK/+08BAaZQgienshlCkhHb7SP4bep0tud6/X
	5h9Z2Lp2Y/n7V1UFvPt6/VopC7GRyzsHZB+3KwJEQyRTlHmQZ2RAzzFnKFWiTpGi+m9vPuUVvAA
	5g9o5uQdlsIAd0r4fdjixyi4uH0EuhyPWVHLeNC9rMGsFPWcDos3ux1fHfF6BdGXG0jo4agf3p8
	Nh/xPJ3ViBvjH5HZgVXwpA9jVF8x/+nsnN3zlDRkwEn1k+Oy6g1DOBL15la1CiW/IVEhAkog4ug
	sSFKo8t9cSUEVxhVk5LNX+XREeFYatV5QCsWVb/+S2HzH6ke4ITHwHoEGRlnWbpjMyTCvKswF/J
	yVX+COz5ZEtX/EF1RRqGxzNDUt2J+9roeNXs6hNpS3Zn32Lld541/3YjczGE2xWxwjqkyoUQtG/
	mtdp2OtpnfRKwv/KYrTTw=
X-Google-Smtp-Source: AGHT+IFMir/v4p5eC22DpnDZcblBNCoUo8QfniyVutGYcK+UKapVvVN5phw0cR7NylgNr5IFljGhog==
X-Received: by 2002:a17:90b:2f03:b0:343:6108:1706 with SMTP id 98e67ed59e1d1-349126895a7mr4245812a91.17.1764789477875;
        Wed, 03 Dec 2025 11:17:57 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34930b5a195sm601293a91.3.2025.12.03.11.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:17:57 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <ricardo@marliere.net>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpic: Fix dead link to fsl/mpic.txt
Date: Thu,  4 Dec 2025 00:47:05 +0530
Message-Id: <20251203191706.58901-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Update the reference to the old 'fsl/mpic.txt' binding, which was removed in
commit 326d25198112 ("dt-bindings: powerpc: Drop duplicate fsl/mpic.txt").

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
No functional changes.

 arch/powerpc/sysdev/mpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index ad7310bba00b..b6c7b7dc1622 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1105,7 +1105,7 @@ static int mpic_host_xlate(struct irq_domain *h, struct device_node *ct,
 		 * First two cells are as usual.  Third specifies
 		 * an "interrupt type".  Fourth is type-specific data.
 		 *
-		 * See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+		 * See Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml
 		 */
 		switch (intspec[2]) {
 		case 0:
-- 
2.34.1


