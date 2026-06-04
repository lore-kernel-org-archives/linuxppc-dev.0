Return-Path: <linuxppc-dev+bounces-22036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75379CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:20:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCn3mwwz2yb9;
	Thu, 04 Jun 2026 23:20:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579205;
	cv=none; b=WuOZaxk28trqWzz3lN+hdGCVZ2H4rSnIqwvkUr3339p/0pHihwzul4q/UEW7x/0YxXL4n9sq8h4KpTdriRevUViXoh5LmwaZIc9ZapxfuDRx2FP4AEv1lnbjZoqNGLZgFwKKxwoOthajCyxKSJPr7bNeW+TI4gxKewW0BTYw4Sw1w/iPJKjQ2xQztSIIQQsyITUHWdF0jsgrXaXB+0ADmxw4AxtTbLZStCmvvFINBtoKJ0pI0lsIAOt3HPri5LwZ0zgH8ScIyZ3Rtq7yaTUQlE0fwnoM9EBlChxKj8Pq51yOk6viyYSbzEMCnBxaFWYs4irxC+FzyYN4xDTGuhmjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579205; c=relaxed/relaxed;
	bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyZMy4/+K3LFoSMWLx7rE/2hwy4ZC3CBdPxsfgD/BwO5ATWfu20Hv2/hMMyn0PA5f/gpycK0GrpNbsiXJHgKx7iXbaao1bTIWiY2sf4zByiqh4npW4P2+GHwgPybjQX7NsJXm2wWKj7H8Fp1zNNErBluL+77dDrNM248WXBTS0D2n95aL3h1t4YMhI2KzGfye3g+P97xwrG8Koe4uCKH237WeRxzmNW694cbAsJSsEiusNJYBX9DnsmqRzECE0SAX+VJC29MLl8C44FOnTwZVPlVkgHZdxRkdt3NizR7uhx3w0vNwyFRGfMY9mHl1ZXqLFmfzZll3TOFCuA3yPiEsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJJttr1S; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJJttr1S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCm4J5pz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:20:04 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-45ef1198766so415587f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579202; x=1781184002; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
        b=JJJttr1SF4MDRmJ1QPt9aAUWCZLxR1lQelxW9efew2veIVFhrHvgnsB1Gy27e5HR5f
         wYVDE7fCyOvNU25AtDiAEs84z8rVLBhlKE/jXw84sS3j8qAsU9TMWPlBVPB/pQUyxfX+
         ey9L5Ovm34TlHiLlmeC2oNQXRUBw+UcIjcY8NtOVNTLlmk3faRQW4ESHMtV6DWHeQnSK
         6Rz/ufiG6VhFTY/pDaqkBf2wyoYV0XTUeEBo/7Psxy1qNmXcHGnHNctWRzo91MqgtKcY
         nZ/GLiG2cQXxbzPiuSahXLfOnbuXQ+pPA0WVty1BojGheMHSZutU0JA5263r1QMaijwP
         viwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579202; x=1781184002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
        b=l+GnZj2kQTYUalbKjvZMTDLn16gDt76xWxOfQhiUYebh/BQUifbi20ekbuKS02noJr
         ORRfJmwEcewp+0ioT9h9hzdZWPiDUyeDe6zmhoiYbzEqIZgqIJfw/3cN61n9uPugQJMA
         M7iFG8IHmFZYhb6FH7273YnOZ4FVWzAvRT+ZKWzqiugOV6rB2fjRtS25oIeRAFYPnKaV
         5CL4X/+nRTp/FTJ1sPV8xei1nbJuQZqHQcrMeaiKNTxOaB88CF3iyBosDJKugUor7kUx
         jQUI16cWxUuVlgJPFAk3jas8yS7RzfMPEP0TilSIcuYMLy8tTreEZQ6SpQkkWabVjq4G
         5tnA==
X-Forwarded-Encrypted: i=1; AFNElJ+B2AbDBQcCzRZE+XotQY2b8OwUxo8+QFjulS9UKD6n9kjmtxSDsVyX0hqe5shczNXo1yd9znl343X1/XI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylJBfy4JHh7dmznIvYGl1wn1evK+O9qJaoeBEY9+KAvpq7ZFtZ
	XCGnxa49cT62eP3jKX5/a/EZX1AEZmuF4/ap+jedL5Bh+ojiSPrBSUr9
X-Gm-Gg: Acq92OGMMVodsXeceNd3CJa7QNzNdbPYBX12XEa3Q2n8X0A9cSdHzhMVwFs0q82Cvgd
	Zv7vp/feBBP4Pzyebp7U9akQyKMs6+VCD5pi1xnhQ9OyWroFeVbqpx+DdEU/XOYi68G9dsQ624z
	l2wbV6Qv4TaOxWhYZW7amwIoOreiY6OXkYKe59rdKp5xTPu7CxFtxmc3esfMG9Q+jkrSyWyiySd
	Ayrr3XDAnBDi5CHgO3XPAmqZs95v141RY82AI8un2WUs+WPI9FiQoJQ9LykAr0pBkf6q450eWp1
	SZ/TMiHQiQT5zoeZV4uz93j4clyuOGuFj0xLiVfmwrLG72hy2KntMkF45c5kYXW1CPJdf4ajAvz
	i7/G5D0hpT31HBgjA+9vjsl8rCw3MCAiVx/xgbSFXXHlvflb9v75IxXVDzNzuJPt/VVU7+21O45
	X221Q7ueczehqi1+v72aHjhv8ar9QaegJP
X-Received: by 2002:adf:f9cb:0:b0:450:ad00:86aa with SMTP id ffacd0b85a97d-46027334f00mr4350905f8f.15.1780579201550;
        Thu, 04 Jun 2026 06:20:01 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm16699144f8f.16.2026.06.04.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:20:01 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:28 +0300
Subject: [PATCH v3 5/6] sh: Remove remaining defconfig reference to the
 pktcdvd driver
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-5-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=qLq31BYjVwoita8p3VYbMVHsnGBFQquUbQzcOZAQW8k=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vUbg4sCfwjVxDoesvyfcbp2wXwO5d1rzS5+q5cTn
 pozz+ZGRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZiIMRcjw4LzeSe7T+xV9p50
 z5Yh/ZzHFna1hwXT1+ZHTSp83fXl60FGhj0iy0Jk/1atj4qxP3tw4bVFNxnFYrn//RW9kh8fLuX
 ymhMA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind a
CONFIG_CONFIG_CDROM_PKTCDVD reference in defconfigs. Remove it.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/sh/configs/sh2007_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 5d9080499485..f287a41cd38c 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -45,7 +45,6 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NET_PKTGEN=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=y
 CONFIG_RAID_ATTRS=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y

-- 
2.54.0


