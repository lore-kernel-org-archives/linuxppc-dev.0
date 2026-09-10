Return-Path: <linuxppc-dev+bounces-27027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297EFC79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:19:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgdZ81PFcz2xjM;
	Thu, 10 Sep 2026 23:19:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789042428;
	cv=none; b=OIfH7WfAmXWXTQEpffAMbl7a42xWdhE8VkrWaBlwBrKPVeLOlaI50vWwYLR+YqN3GAwcP7Dkfs+BDciSFLur1BB68ZlR/AnbA6HAxipQX8XFdv3U4mqVt9izER9/o3JI7Bodeavg30KsSOc2zCym1pLjNhKlEIc719Hrz8DoQE+fOQ9rchv6EpqxFd09IASdaRjkFaVOeluqgCOknIC2jTzs3e/wuk4caotbwetIOE5Z4u+WQaUQSX3ah1PdN22vK7oBbaHoa+hVTzQTLQ+Y/LrS0phWg0Ps326j9dUGPSyjgLTiw+8aIncaCFNaZiM8x/6jYhpLniLecXXfl7ou2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789042428; c=relaxed/relaxed;
	bh=4hqhe5nL5m8h0oyKqgGFnsjXQH8e2lSBQ7XG7ZTQ+wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpnG4wLKZZZdrFv3S+qpCMK+OltlQcqaSe2DUva2p/xn8bb2PaUnO3ZeLkNJ3QYz5lfBkCpbXB9kB6Mdt2yGtfdBCGAsOXN1LLteSghbKuwB4/zSX+zbFtLCRXObXnZf7cHdfRkK3vMjdrkn4ofK/H17fxQhqeKJSQO+zf6uWpDLmRDaRxU6x0x+jCA+yiFPoEWQX6u5ig/kV8BAobLEfdJ6KDadfC0LkNYrmhi5gRbDw16N5RE0k8s4Pv/gwsLlRFF2BHrnvH+meMq27oqfAsd6tIAJwv7oJZKCJANwLndI/MFVqPPcdyIuZBz8+LYNksQ6q+RaYH5MkmNN1fdUEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NdQvJCBR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=adrianox@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NdQvJCBR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=adrianox@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgc636b1Gz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:13:47 +1000 (AEST)
Received: by mail-qk2-x10.google.com with SMTP id af79cd13be357-93910c3e6b1so123294485a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789042425; x=1789647225; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4hqhe5nL5m8h0oyKqgGFnsjXQH8e2lSBQ7XG7ZTQ+wA=;
        b=NdQvJCBRt2wVZEnZXVQamMu/9RkL/Ibyxfk0lQAnb07NcTCQFnv4NUvR2jsbB32xz+
         lM/hz1VnMbzyRB9V691HqJdnXuv58m41nkqHz+ZaKjPt+LtRpua0UVxHxLLRzUpcoOmh
         +z+InBkn1ijqCRIZbHzbyhvjeL5WUlmTlx1jKYUVS657ZcC4hf0dV6f1WvzjEdtJfT9U
         55VLy5ylyjnlM/+KixjdaAmIEzrhTmzhkD8CEh2glIW3DIStF/4syEaMmi9Ct9jtcgX/
         b1+/hatrGeyAHycCzxDguULIJI2hk0aV8G4gkRMSCfJWYS41sCjYK+m7MwQSRO+IQ6J7
         4JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789042425; x=1789647225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hqhe5nL5m8h0oyKqgGFnsjXQH8e2lSBQ7XG7ZTQ+wA=;
        b=rD5CJNW4iW0x0XEe5J5C0grSiO703BIvifayWjoD8ZWcxwR695+GhSLAC1MpglSymT
         Fb1LzjUr0b9Yn6v5mVSdastThaOtl/GYd6SX0C54CsPE9svKpZuAhdV8lPjZk9h5cTC/
         eP9DNRSmg6s3qhu9QG3tDUq3FV945v/+J4Jxbi4Q7caUZJgZiQbPhIVkT+NLdlUUs1uu
         6MeRXWx/LxwWXVvGLCuouwDm+5TD3+hpeq18wCcZj/9ftwYwZ/9oLblIQcFkzRz6kbXV
         K0dSMMtyA3S2se+Lx3N0PviWwhQRx14rtjrmZ53oLn9OumSfAp3/fDvfHGXksp+H2hMr
         2O0A==
X-Forwarded-Encrypted: i=1; AKwUvBx+Rgz1AQsDY1OUs8cqh+I7WdtUpMBxJyNiYlFiXK5gD8KLXu5e1Y0urDSuLd+L8wLWpWhzX5vBIj+fWlE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m7PUU973/kiwo1W6HRVSuyr4N9SFiwNFfyWLgC6h/GM2ytUeXM
	8m0XjKNKg+OjGq6Y/681FyMZabaVswem07d9uEWWaph+UT8N0aj990q0
X-Gm-Gg: AYBFou0SLeIQGem5btys9CmVzbmyGXSyvbHTLNXX7fhu0qDJfqF6rTF7RLd/gyltoa1
	WEdwEsCGGcgUvqNsX1lWNOPE9IOxie0Kgfb4LICUT6laI08aPoyBG6jDKA/1LnCKFX/hUWTpGS+
	UK7SnFwZgXMp16DZMZ7RJzKQ1HH+xU6GJfBKI2yOjA5slSPsE6DnEeGx+0WPZdKAl692PCf49iR
	G0SoW/8lxfBrEwZ1obPDd3YVeeR10/yP6stRjXeXf3O3y1ReZbPJuk2rp1sNQrZlDDKNGXClp7J
	A1azVbVIXIe3ZaLSCqG22E2M7GrR+cpSeWfd2ALlbMu8oziIYvkStUVnIjWeQl0JovLCkh0l5Mh
	meZ7yu0MDtVLKyhlhmzy+msCG8JPNsBQxCH9RBPKl7hEWPUQQBUS5oJ3xPfRlMnrD+cQ3T0OaDF
	UX/3TIzfb4GpYIHF9NEXPcf5aIlr/5k7XVgA4rMqhm09kXtS6KDLJU7uehb05mILGH9OnYtvoG
X-Received: by 2002:a05:620a:608b:b0:939:934b:dd61 with SMTP id af79cd13be357-939d7fa9584mr459351885a.22.1789042424724;
        Thu, 10 Sep 2026 05:13:44 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:a801:3f8c:3321:84a0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1691021085a.46.2026.09.10.05.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 05:13:43 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linas Vepstas <linas@austin.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] PCI: rpaphp: report first slot registration error
Date: Thu, 10 Sep 2026 09:13:30 -0300
Message-ID: <20260910121330.339150-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
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

rpaphp_drc_add_slot() overwrites retval on every loop iteration, so a
failure to register a slot is lost if a later slot registers
successfully and the function returns success.

Track the first error and return it, while still attempting to register
the remaining slots.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 2316de0fd198..af7241d526cf 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -376,6 +376,7 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
 {
 	struct slot *slot;
 	int retval = 0;
+	int first_error = 0;
 	int i;
 	const __be32 *indexes, *names, *types, *power_domains;
 	char *name, *type;
@@ -407,16 +408,18 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
 		if (!retval)
 			retval = rpaphp_register_slot(slot);
 
-		if (retval)
+		if (retval) {
+			if (!first_error)
+				first_error = retval;
 			dealloc_slot_struct(slot);
+		}
 
 		name += strlen(name) + 1;
 		type += strlen(type) + 1;
 	}
-	dbg("%s - Exit: rc[%d]\n", __func__, retval);
+	dbg("%s - Exit: rc[%d]\n", __func__, first_error);
 
-	/* XXX FIXME: reports a failure only if last entry in loop failed */
-	return retval;
+	return first_error;
 }
 
 /**
-- 
2.51.0


