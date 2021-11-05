Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1101C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 15:50:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13B560ED5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 15:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F13B560ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hm4hz4jWPz3cZg
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Nov 2021 02:50:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=r0S0hC2Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=alexandre.ghiti@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=r0S0hC2Z; 
 dkim-atps=neutral
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hm4hH10Byz2xXW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Nov 2021 02:49:51 +1100 (AEDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C71AC4002C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Nov 2021 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1636127388;
 bh=O16OdHn+GTs4ijs6PH3u89m4wmvvKfK54fa2lozmRZs=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=r0S0hC2Zdk6ru6tVnHqGcTCQi7SyiqqVbaxA6dPaSmnq7hoRbJcMR67I0/jYyjZFI
 zHYFmUggBccXzEp7vt6bVrH3n2GruBDxcBiAECvfpAjD4yvO6vZjwRMYjdDggz9uy6
 42FcfzyE1c06aGcd34GO9Ads4f/Th++H5DXuoneZFOpFoG1aBPAMwWackJWsjiYapp
 R+UVy3NcsKPa04yec7OPXeqmFYYjKs7zIYguLHEJOiPd4nhIzZURxa8KvftMfKvSCL
 dJjrzaYtqVFWkU0P2+2o5E4Co6BRJKZGE9d/xAj0HPieSX0NU8p+Zcsnv2NibzM5xj
 xxyIN9oY7Xcsg==
Received: by mail-wm1-f72.google.com with SMTP id
 m1-20020a1ca301000000b003231d5b3c4cso5860950wme.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Nov 2021 08:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O16OdHn+GTs4ijs6PH3u89m4wmvvKfK54fa2lozmRZs=;
 b=hzdaq3z1lh6e8kEkUQf68sCn4DueLYuHfxcH9h8FsBvYirOtXREHhDEZHskrorKZzY
 yzr2wzXjqIBrORhv1Rc0BMVbHM+4TllYmh+ga4ZVgidUS21fmO/6ipxis2n2lSwK294W
 Gn+pReqk7oDruuE1VO6sosepMA6rtlfKvHHyj3qSI3Q/kt0m6AHRjUcxgDMDirey4WsK
 9w0Y/DFdvlKuxm5gGEQQYJOp8K2Qalk8JXQfvtO+p3QFvSM09tNsabY3sydcXLfcrC1m
 iNqEcMi+wl6SJiiiTKQRQmC1M+mz3KiBj53QeeApimeWckVaMxiO851osV1leYMez4mT
 lXlQ==
X-Gm-Message-State: AOAM53248NzfVffSkeuEBX3TLwzI/yS8ToF6OghR4/OfJGxTibzs0ddS
 mhmYpsyl1RrCbejTcbFAxuLU65lpZ/GIUubq50V7Qiiuo21gCzX8sVVGOAz5uSaKgevYiC+R/qV
 7sVETufHXZzJMnybJVRmo66nVRr2KZKoozzW/2njIBzc=
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr51023046wrq.221.1636127388423; 
 Fri, 05 Nov 2021 08:49:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY603x0zr+Chuyb1t2ADL8WGsBiGEq/MpdSLq2l9mjdNq6e20HunukFRMlsP5KMMQo9T/EOQ==
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr51023001wrq.221.1636127388217; 
 Fri, 05 Nov 2021 08:49:48 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr.
 [2.7.60.249])
 by smtp.gmail.com with ESMTPSA id o25sm8150426wms.17.2021.11.05.08.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 08:49:47 -0700 (PDT)
From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
To: Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
 David Howells <dhowells@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee.jones@linaro.org>, Jeff Layton <jlayton@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Ronnie Sahlberg <lsahlber@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cachefs@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH 6/7] include: mfd: Remove leftovers from bd70528 watchdog
Date: Fri,  5 Nov 2021 16:43:33 +0100
Message-Id: <20211105154334.1841927-7-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
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
Cc: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This driver was removed so remove all references to it.

Fixes: 52a5502507bc ("watchdog: bd70528 drop bd70528 support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 include/linux/mfd/rohm-bd70528.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/linux/mfd/rohm-bd70528.h b/include/linux/mfd/rohm-bd70528.h
index 4a5966475a35..297a4a84fff5 100644
--- a/include/linux/mfd/rohm-bd70528.h
+++ b/include/linux/mfd/rohm-bd70528.h
@@ -362,28 +362,4 @@ enum {
 #define BD70528_MASK_BUCK_RAMP 0x10
 #define BD70528_SIFT_BUCK_RAMP 4
 
-#if IS_ENABLED(CONFIG_BD70528_WATCHDOG)
-
-int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_state);
-void bd70528_wdt_lock(struct rohm_regmap_dev *data);
-void bd70528_wdt_unlock(struct rohm_regmap_dev *data);
-
-#else /* CONFIG_BD70528_WATCHDOG */
-
-static inline int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable,
-				  int *old_state)
-{
-	return 0;
-}
-
-static inline void bd70528_wdt_lock(struct rohm_regmap_dev *data)
-{
-}
-
-static inline void bd70528_wdt_unlock(struct rohm_regmap_dev *data)
-{
-}
-
-#endif /* CONFIG_BD70528_WATCHDOG */
-
 #endif /* __LINUX_MFD_BD70528_H__ */
-- 
2.32.0

