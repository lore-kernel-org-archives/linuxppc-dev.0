Return-Path: <linuxppc-dev+bounces-25107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4358C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:40:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9phB4RB7z2yjR;
	Thu, 30 Jul 2026 22:40:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785391583;
	cv=none; b=XV+GXUzz3t8IXTdy6VGWFME/Xbyz9Npjtp799PQhJVzh3L67GwutZCYXO5tvL47L+z88dITc/ROyjRg2I5TbGeLq8TlNTE7QcyzPgoVwLQUO3UgM9FaLHIKP4MWO/bcqcA6FA1D4E0bIs3UB4ltWPH03uw4yOwypTeuIey5kenvO6wgMAXyCGSc1WV24/JwgcNdH4Edrc9XU+Nj8xUOZYyvuH16BudfurBaImyvm22gGgYaWCYcDqCh+tFVkfXkHGvslrlKAWwP9/Ziz9qDsSofppOUFr955y7LMGkGBZpb9YTDuFeC+YwpxA6KpCqBqPsTdF6i0x5K7lM4nljrM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785391583; c=relaxed/relaxed;
	bh=oc22gTId6HvmzrfanPJzdlwN1Vujg0CkMxmiMkWQDoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av1t829aHoSUxuyb7L84OW1yxlWHQjOrYDlrU7zSm7mDxiVSdx0vLG1YeSZktX9jcWB4wvDLOZDq7lsyIpIxWw4aEV2P9gvEpK9+9KzctNIaf8jXK48MTNM5p6/PwCIni/y0Vd0eef62IDxkwMbe1JzmwMKgh1vdl1SbawQPykRxyoXDZ2f1zi3PtfdznnMfhrL3Ri/UMdVaNK96yKvD2TuJz9da3Xf0e+pjZaYts0qi0hA2Wbp8/GthKK2C0S5eZT4TD8FGMe8KG/rFivQwyL7ycERDVy7LyCIz1Q5qX/sDqWejuTs64FI2tlK2Aw0Guqhz9TCrleMClJBIuHRNVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E0cLE44k; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=bbnpreetsingh@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E0cLE44k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=bbnpreetsingh@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dxV2xKQz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:06:22 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so23003355ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391580; x=1785996380; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oc22gTId6HvmzrfanPJzdlwN1Vujg0CkMxmiMkWQDoI=;
        b=E0cLE44ki8AEhoJ9ouwM9RN5n0RSASbXwNwqD+le0pyFJHySVWeKKWd1EUfyW+O/aF
         qrdfOyk5uJHXDP6Mbgxj3Ze3KlRtBaljGg/Z6NRtCx6q/k3zGqkXAsu7fOztDCk/EcPp
         jmtr4Vp8qlzz1RoxzGxv88lNa6UBVGUnOpQMQpZtaOXqJZSgn+IpwXQ3t2shZ0FF8Ron
         wjFAFW0EwRqVuQXUYSLYLkknkLBi0e7paON5Hk8YsDE7JlkQ7BJx7jrTw9p1Oxdg0XAo
         GHdpDomrhXVFaNRIl240o1VQgDE+jiJyaA+Kqd+YG6aKxz+2k3aCQ7UvJctRjMSe+MdK
         /bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391580; x=1785996380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oc22gTId6HvmzrfanPJzdlwN1Vujg0CkMxmiMkWQDoI=;
        b=hrWqJL3cdSU/CFtJQOWcVXI2B8Tb/Kc3KadPYkA+ZvUEHtGYn5O3kTeJv1Ys5FSpoU
         cILV5WU1w1sCxmHpz5J+R3WGzaag7cLAwoKZ2GwdWamNJTOgJ4Qr7o+7MsmxutIBuS0V
         0WBOZnS6O1ntdc3V9wLS4fzlDklFUqRKW/hZUmXdh9vej0pVf3cfA47xvhUdjY+nWGDD
         8moXFN+ChjpPl9/9cXvZcw26RMMC3HXn8yrU+X0eXnsC+uPvgKnN902fZPehRvr9bP9g
         Tg32H3BToAv64ad2nQVlryAef+atsMKrtq0+zJe9PJsCu2HhInFNhZIAKeyT7deP5z/h
         +Hog==
X-Forwarded-Encrypted: i=1; AHgh+RorQpvc4eYxFBBwGVc5gEATIe+gUO+l54p4UyV6BYKxNkz2tfawZNi2c49ywzBYu/jhUQ9cHcIZincUd9s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydADXF4swu4ZO62OB8lKCZJHJlHo0zS3+dvSYF1nAbTFhQIIWK
	9pkm2uhhzQwUvPDaQ+1v6Z5yob3mRFbUCruSWdasvLIGANgKqNe2ngFR
X-Gm-Gg: AR+sD12EiBq2BlbUt7mG2oM18b2zdkz7YW4itoQgKav7FIzq9QZnqKYY58fmUgf/6aB
	tKwpxMd38Fr8rEmBLIsBNcrnH7T8ux7nViRUmNtbXY1qx2jISB1qPqVTierglxhldLQyV2Fq7IA
	c2P/fvDJz63nWsVwF6NkLRPa/d96z2hLbRZ+inCkF+y4dX3Uow+u7qz5pnj+Bl3xns2lxA5224g
	CsXfHtxSqHiWyqjXPT/4GoedYgoZTcABq5HHhpjSS6Q+0PJAi5FCoPWpLZ4sQmvwgHhE9zrsRKZ
	5cqeaGrcOYDyoXQLyB22tPEMRfrXE6/wWygTK6YSgEYh7toCy118NeYcCDjT86hxjsA6r0tEIKg
	qirSvMtJ+biNVvrmefKPcRSsQkrApALDS6+Ax51Ze27wg1SjkNnF5prm6CyvgbE0cymeC0cRuhh
	2/JKYdloVzo+vbXU2DnjzkHKC0q9JZPQvlonMQXJ3W2Bu7vGXvvCAepbiRIl1kfBylv44zmaQ=
X-Received: by 2002:a17:902:c40d:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2d035c864a4mr16689545ad.25.1785391580093;
        Wed, 29 Jul 2026 23:06:20 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a46774sm20780785ad.27.2026.07.29.23.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:06:19 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 2/2] watchdog: booke_wdt: Document unused parameter of __booke_wdt_disable()
Date: Thu, 30 Jul 2026 06:06:17 +0000
Message-ID: <20260730060617.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730060617.7-1-bbnpreetsingh@gmail.com>
References: <20260730060617.7-1-bbnpreetsingh@gmail.com>
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

scripts/kernel-doc -none reports:

  Warning: drivers/watchdog/booke_wdt.c:158 function parameter 'data'
  not described in '__booke_wdt_disable'

__booke_wdt_disable() is invoked through on_each_cpu(), so it takes a
void * argument that it does not use. Its kernel-doc comment does not
describe the parameter at all.

Document it as unused.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/watchdog/booke_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 932a03f4436a3..1b1fb389b89ba 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -149,6 +149,7 @@ static void __booke_wdt_enable(void *data)
 
 /**
  * __booke_wdt_disable - disable the watchdog on the given CPU
+ * @data: unused
  *
  * This function is called on each CPU.  It disables the watchdog on that CPU.
  *
-- 
2.43.0


