Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DFC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:33:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29624600D4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29624600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gr02Q3rTvz3d8v
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 19:33:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=tFZEIbDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32c;
 helo=mail-wm1-x32c.google.com; envelope-from=lukas.bulwahn@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tFZEIbDl; dkim-atps=neutral
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gr01C6wHYz3bYt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2021 19:32:47 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 q11-20020a7bce8b0000b02902e6880d0accso6378984wmj.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2021 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9E+b7yEFyl2AwVZRyoTJe5CWMWvjWa59eGiPsrwe3Mo=;
 b=tFZEIbDlHNE+xia5g8/hRiyMaPYwdmhyoL9uigWW2I+3GMS/h/BxVaRI9BRlTGzgaM
 3zq8mZmaYkg06Bzc3/TM511P0YOg3YD1FH3toNrTY6xq9402Ndrn1a94K+2KS97AXIWE
 mGWS0oqr6BMMhPZYeBiCgjJXEhU0ZmyxrFbs43wvT9T85E51DqlAAqlwLK2nmNOO3OlR
 nSj2sPa1theke08K4vpuohL7HrOo9KM4O8YPLajfW5v1bKri3BvP3P3c/8Fnv1hcv8qp
 wAGePiin/nEJY8Q0Gvz9YdAF4Jd+JJKnLjHU4QIsFLLXrBz2sdnxW2h2H1l4NS5Ny6qd
 Gq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9E+b7yEFyl2AwVZRyoTJe5CWMWvjWa59eGiPsrwe3Mo=;
 b=Uimszh974J+/p7e0n+EkePlr1+98lrcZZLCUHy5XRehigXEpc0rBtBkKNaKWLrIN16
 yz+VKOSHefabGt4O/1GmI8X+58xlH9Ofg6qkIC7PCMUoS1vXRPfKoXEoRh8lPCIMKYO9
 2wYaeGs5nJBCdndOwK9AYl/XUPli3WTESANxEkrSyD9XFjQ3TFhy5M9lP9kYGU67y9Dt
 Me3Q6TySmtZgg2sfcyRyYjaqlFD/eekTTzUCHtWw0No7qbdBMJGdobmpJ0qDz/nUfwxC
 jljGYHxnDbKREgN3H8CqK8Zt3P/TXldO0tLE5iJpNm4YB05VizfKkGMH3MwGmM1AWECk
 3Mwg==
X-Gm-Message-State: AOAM532unMnCB+yW5sSHCBLZN/bPKk+PHqvuKSldDW2vkkPrS8KICIri
 18HeyYnvJca/GCnr1WfTpwI=
X-Google-Smtp-Source: ABdhPJwIwVlI9d/xhjmdxG9trJ2BKi+LKFHcS50VjOHOgZfRQ86q4w2s4Ld6XT/GuXYT9nWNu28yFQ==
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr894890wmg.147.1629365564031; 
 Thu, 19 Aug 2021 02:32:44 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt.
 [84.90.178.246])
 by smtp.gmail.com with ESMTPSA id h11sm8485061wmc.23.2021.08.19.02.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Aug 2021 02:32:43 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: kvm: rectify selection to PPC_DAWR
Date: Thu, 19 Aug 2021 11:32:25 +0200
Message-Id: <20210819093226.13955-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819093226.13955-1-lukas.bulwahn@gmail.com>
References: <20210819093226.13955-1-lukas.bulwahn@gmail.com>
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
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit a278e7ea608b ("powerpc: Fix compile issue with force DAWR")
selects the non-existing config PPC_DAWR_FORCE_ENABLE for config
KVM_BOOK3S_64_HANDLER. As this commit also introduces a config PPC_DAWR,
it probably intends to select PPC_DAWR instead.

Rectify the selection in config KVM_BOOK3S_64_HANDLER to PPC_DAWR.

The issue was identified with ./scripts/checkkconfigsymbols.py.

Fixes: a278e7ea608b ("powerpc: Fix compile issue with force DAWR")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/powerpc/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index e45644657d49..aa29ea56c80a 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -38,7 +38,7 @@ config KVM_BOOK3S_32_HANDLER
 config KVM_BOOK3S_64_HANDLER
 	bool
 	select KVM_BOOK3S_HANDLER
-	select PPC_DAWR_FORCE_ENABLE
+	select PPC_DAWR
 
 config KVM_BOOK3S_PR_POSSIBLE
 	bool
-- 
2.26.2

