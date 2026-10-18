Return-Path: <linuxppc-dev+bounces-29646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE1BCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:49:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70R30T20z2xjP;
	Mon, 19 Oct 2026 00:49:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331374;
	cv=none; b=N9AC+GX/5LsmINySU4kBhktjReDPfvNlao1Ulp+Yw6inbwbC1yOB/kU4g7buvVzHLdswQb/AkDItxt7BCbcr9HSeCbz7JZ0ksxO8f5AsrwHXl+tbUKkxBdHszklSd7H6FTH5rTMtLbhlufj20y7AJcpCe2xonCY4fsNhMRqyLhsjZ6k2Ro2sEJAvnZzLPru4SqNMMCxzv+38jxC9iCQIYIJAzIlu1XKagZrMNbuSw83GRTJsUlp97/dTmAAqD544SSC+j/49pEuyeYLpWgvQTAYfLefS91mxaY8n1/UPllneNsIrrPl9v5dqh+Zyhjm3jVgYN6PcBdRWCJE+5NgyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331374; c=relaxed/relaxed;
	bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPW/ZNB1F4SWdmwlLw5dJL0algP3QaLyqlGjjxN9QkBM1WqbAnb13cCI1tcnORjAXuJqIW4o+3mudOPBbxA8c0xK2y7jPkY1ebkRt18vRUG8nm9WgTS9wLG8r+vkQKhi4MdgpSoyOA1TI145N+QSEOM0Ee8OrgrjLf4HxPJFcU//7pQ6hFupLXooZv8976rPs/LWngabxqm2B0qHHfttnZHAoMvaKdZOdZ33j26Xf6Qh2Wdm8gzy4n6DwNB9L+MpQpyMbUCgbd1lMwn7Bo0lTdMIHjwdT9mAyCC6Ug6TCCwP3sa/YvNbNYhirPzhqgoKOeNASG8QdqbJWbXh3+QMDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hN3MZmmk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hN3MZmmk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70R12SRmz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:32 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso204982666b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331369; x=1792936169; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
        b=hN3MZmmkCHZ6UrdX/4x6/DLhL3lHnc6pQwiw9Th9TZ+RlIfJhMfWCqEDwCFkrxHoEi
         DTqBk46TnAkiWevjzdDTUV7OdT0sqK+8mIkx6sjeXf6v18SmV97vWatniz0G8EpD1ThW
         Y8MKFsWvjkG5PvhLIODbVs9BQV62f3RfATLcufz7shKh38/t2K7zY5RP8TZ2YDnoaiV1
         kD3QA/gzzxhwZqsSHRiHSBNkYSfoUBkhN3Lk3jreZigdrnBH+0f9pzK3eAHAzaQtMEno
         p0L1UU5cHzNfx+CuBP/YiWuDoAy0ekbZKCucUdSsM0XsGO1+6fQMNnccwjIOiCsGc+VD
         C7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331369; x=1792936169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
        b=S/e2FrL2pKBncANnrlPiloloqsniv+81cqVdIr5xVaMcQ/ewJ9vnRgkIt8MPwFkGts
         ab7upyVtt1uOGBCt95bT8Obfhezy16XEjkwlLvxsp0lDTw27KBcHCp6uEl72HZuHX82b
         7LSVIOORiRfiyHfOWW1gZogFIDRGxRX1kSjI84na5DnjgZaz+ejHgcadw6w2JM4Y2Zuo
         P9vPIAbWSmS51WkXPxyg3IHICO1v+lPj+lUfoQ4ZFlro2oVrwXbqFK08UveBGA3bOmbb
         KtVDSKB95TaUWgR9jqOSY8q8JRqQUpcgSedT7zXYfn9dmz5nKCgRyw1LqRCLMZhaCB1V
         h8xQ==
X-Forwarded-Encrypted: i=1; AKwUvByKoi4ABqMS3RfdguQrb9T019U2EF8Qm4kNuT4ONSM/z9hSfrcH/CVxmC//FQhc3OlG5IxbfKwgW3c7Q6I=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJiYXXjKMT/f05xwBcDH+SuUED7QmHjDYDp3jpNQ8Vlj/vKD7OD
	TiG8VMEJsHzrp61eNjEojkXEXuUc3TQytGq6E/FoBlF+ddxcF8Y4iyuw
X-Gm-Gg: AYBFou2WmF8AWxjUOZPAdOW0wBd5uPGLfdvHxj++vOquvzlkIrNB8B2CXI41y6egLwr
	zeibFJmLDkhpQZb4rF8xvHS982WKw17k8tEYQQGFKaBZWw7u0g9NTaSIkXOfsAqg7H2pV2hBckw
	J/t+oi0edV/BSWClx2xS9YcoDl2ONckw1ydTyPgcfF9NX1J/0hHB4IcGiYMqxGlpAGb5RtwBk5q
	oOyM/ESk5uneSNHZJBJmE1NH56aMDZdHts8zWshehjjMFVGEFW7QhxuN1uDYVbaLIgW0ZG8UnAH
	maBH5S7B7pKuhCOiTfJv9vo6k738S5mW+EM+5usj+sP4uf6MbA/KFMBwkD2tMtTXh8ww+37epCU
	GbZzG6xPBgSBtqHMAOhuyH13wq57x4DnweEzA8CupBlhV5SpJVScgmojGgOZxsZhgLY2bci8yP9
	j2ZsPMy2a3G61iiIQxyUaBk2xKNJxteLCiTMP854+kvBO9AhnnkTE7nOHOLHqQdHwtOn0o52M9/
	m1VgbRrpAvyW8j+CPU5qC0Uei7YOMpyL6VDQB2t
X-Received: by 2002:a17:907:c80e:b0:c44:16ad:c31d with SMTP id a640c23a62f3a-c4416adc6afmr28611766b.4.1792331369203;
        Sun, 18 Oct 2026 06:49:29 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:27 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 01/10] sparc64: return from the generic clear_page implementation
Date: Sun, 18 Oct 2026 15:45:03 +0200
Message-ID: <20261018134738.1016106-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
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

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
This executes 45 extra instructions, including six stores and three
FLUSH instructions, before returning.

Return once the clear loop completes, as GENcopy_page does. This affects
processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0


