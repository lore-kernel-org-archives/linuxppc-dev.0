Return-Path: <linuxppc-dev+bounces-22465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE85CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 05:25:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbWLw0TbSz2yv2;
	Thu, 11 Jun 2026 15:25:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1242"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781140164;
	cv=none; b=l8R7OMDSJrgU+qiPt929Gg8fIIF2M8uS/k3aNep1GQpOPZ7mYPxoL86Z7dQMWzAzpDgZLX4v+RmrmoAo7CrHrupXwVxmvCsLUOtmLAzTpG/ZyeScf3UnmIJLLLag3qlTnt+RmPOSC2Yl3dFU4CnkW3uA9xdUz+EBJW7oCcPchSg4REpAodXXuitLzmUdRdOQuvrqvdqOKHrJNoEDTG+eDlqqGxbmXvUr3ChVSovCDR4MViRFQptxIPtR7kPA7jOH1YWgGLKKjzoXb+LAXU1LvVA4zKyu8SBBeDbuCLNDy94yBkUelxIg5R5Kzwtsav8VR1jomqVO/3fhVEWL2a7Pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781140164; c=relaxed/relaxed;
	bh=wVFUmgfZWQUg8yb+neHfsaKcJQcz+e1b1jXoBTh5r50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grVkAO5Z5LrXTSPT+DZZ08hJiW34fpPlQflQEzDitx1p7J9ZyxDBv7gqu/3l+HfT+g97kMlL2ihsKICQ2fskFBVdimD6H3JC1WWbdf+WlQUxOxwNJOE/1Dp8xCV2LEW3G62/F+GUOmEBLSuhCpdlHUI1Mj7awE/PrkI5EowKLMnZw0pb5x0g/KkXtIgn3bHcsgfeiKOeUofC6yRXl8ejIPLqGJAKpbmkjJtDq9U/F88G8DzgccdWreJ+V/jHVEuuhwRgssdYLkkkc31EZNDizZLH4U75JQEHHu+A5SvB/8oPaXhzSWbC7dSIZkYpy88AAbrYfCNrjCKvcgG+Lz56pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZB/jSi/2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1242; helo=mail-dl1-x1242.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZB/jSi/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1242; helo=mail-dl1-x1242.google.com; envelope-from=enelsonmoore@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com [IPv6:2607:f8b0:4864:20::1242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbPgQ5jM4z2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 11:09:22 +1000 (AEST)
Received: by mail-dl1-x1242.google.com with SMTP id a92af1059eb24-138405b7bc5so1234252c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 18:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781140160; x=1781744960; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wVFUmgfZWQUg8yb+neHfsaKcJQcz+e1b1jXoBTh5r50=;
        b=ZB/jSi/2uIx1CwD39TMjj+4NShWNitc+D2h1H0bEPkPG1S1UOmJXNitCmT6Bg2A6q3
         RngrNEg6ztKuHb4VWR5BZa3LF4m9H6znSIXue09vtEOwFNXh1xpO9cb2qN3aNRHUaeub
         8dcfnrh/qsVvIa2+ytpcydkQ7uSllWdz7BVRAwJAJJzDpMPN/JonPMKIKZrUGF6i9OP4
         G6zV4/PqLRr3toH/SSuqPY23zWmrSUL35GVL80m5c82oB4QdRNady4rgbL4rdb/UU4Oe
         XH3zCLQQtpCSd9yVl6DTXewECm41VzPYcMue3gyCRomW/MvvTki3t8eYeh9AYvvorc90
         hvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781140160; x=1781744960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVFUmgfZWQUg8yb+neHfsaKcJQcz+e1b1jXoBTh5r50=;
        b=SpJBZQ/jcZUJFMAHDTTgpjhjjBGWsqHB2pMtdnE6yeZu2wc8SFraoydfE8nSrv3fXA
         E7Kj6bk6g3AUl77C7NBPAEHgNg2dfrIpP0LLnk5tq8DxY8mTQ4US5zy/viPcfJmSX3Vg
         uTaI9tpgAasAlhqMysPCuYz7DtD6HdRxFMVuBUmPxpr7n0cPZJX2sFpD0tnq9mZl4gOJ
         tfPGOpnkfblfWpwV2y66x9pzMAbjwVDOGYd1gkb8jx/0/vDXsOhDETYDpQ2HvrTHwZwS
         fhvTXgxoXEpdTf6LqhFExOvS3h4cbCKo4Np2UtGJCojMK3Xx2SNp9dKq1eihHCfPsIwX
         OCuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hu2vNRC7HIDEn6GYPmUxba/jhEL1IWLJKSnS+6dkutXEzShbCZvEIUhm9g3J4Gsq3mBnaovbg8yLnOvw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwV9lg6SWz9HORJa081yziOo/1rKKfGswVtVTgzmQ35nZCf/fte
	qJeGoXkjmDx7Y2ELEjYNB4twdgi7X0tWb7ph9DgTNiboRfhp6QFEuF4kFiBK3SUW
X-Gm-Gg: Acq92OFeUTabzN23qV4caIpcFbVEE8wnoaBDe/z4W5/OmS46wrdzhjVXwZ8s4lPqbAC
	Q6uS/g1m6aCtuxP2WLcN28HLnWkqv6ywTFjtdDhAnD7SXezuERitftwlofR6mi4m5nxlfhkEsnu
	kPwNnWH1egOSUB8MsVj2bGuffDU4O/Fs3dZof+7HXbezO+vc6hj6AL+Y/3EnKyol9wSFBb9wufw
	vvVKprsf4r1PvyB9O0t+lDC0DsKxdi+lqFlczINDbhGNpRhtStxmN8jImp0uDxeys+dJoRAruVa
	xX7DTIvzh0eW6Y2QlJ4fGZcGFyhOuFWB18pmOUYv/IaNFRrVTPWZGDdSvPzzvAA+9ow2KTfcQt/
	IwM5s0nkW1KXH+IVnrWv1O4YMPxJYELYPOhul/TIiAB+nra5kvC9PvauZThQ9CeAnk5au2NkBxb
	+lGuimaSlPAI0w5oro273TFKPHgLut+SU6uji/DhV97387EMFdBBtLlCbrQV7eObtdFduelvjgA
	5t3UcqPylfdbsxXZebmfi5KeCMJPz/yhaw78Cs91e70Rt4C1w5MpbR1OZvl6WGcOZ+5blRNkGbB
	SJFtxCkqTVOSNm5SK5lXbdV6mabl
X-Received: by 2002:a05:701b:2914:b0:136:e42d:2c2b with SMTP id a92af1059eb24-138421be22fmr248006c88.17.1781140159987;
        Wed, 10 Jun 2026 18:09:19 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13843790552sm117029c88.13.2026.06.10.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:09:19 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/uaccess: correct check for CONFIG_PPC_E500 in mask_user_address()
Date: Wed, 10 Jun 2026 18:09:12 -0700
Message-ID: <20260611010914.429574-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
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

CONFIG_E500 was renamed to CONFIG_PPC_E500 in commit 688de017efaa
("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500"), but the check for
it in mask_user_address() was not updated, causing
mask_user_address_isel() to no longer be used on E500 hardware. Fix the
check to use the correct name.

Fixes: 688de017efaa ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index e98c628e3899..619270bb7380 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 
 	if (IS_ENABLED(CONFIG_PPC64))
 		return mask_user_address_simple(ptr);
-	if (IS_ENABLED(CONFIG_E500))
+	if (IS_ENABLED(CONFIG_PPC_E500))
 		return mask_user_address_isel(ptr);
 	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
 		return mask_user_address_simple(ptr);
-- 
2.43.0


