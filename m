Return-Path: <linuxppc-dev+bounces-22208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E6ECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvXl4kSXz3bsS;
	Tue, 09 Jun 2026 00:28:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928903;
	cv=none; b=bQZmpcwg6FTSJ7M61A414veCOZa6jsraY5XwGi+DtRGhv9nmeEOE9c+yo/Btj7W0BQde0yPxbSAnAYnESeQuUuadaXyVH7CbqlUQim6hjDi+RcfJd4dzKd6V4RxtD/sIU/nPe1KYOplz61NkdEcDSrVTz0ksjtkXTfXe/RHeCHcrSexPcup+2i6ZtPJZkKqeNZ2jWmIoRvmCOYWkn4JxfaK/8XSVzBmmohRYchQzBc0PU7Sc3Hi3vK1QnndoMldxLBKrya63kMc0wW0LMQCZIB+mZ3wou0iNJ1MM1ni/LqCIKnytPM6Q+Nx/xpXK83XKPb4WZtaVIjnp1IIdstcCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928903; c=relaxed/relaxed;
	bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mg/RXN6d3rwWiQ4XsFjEeNTdMbo2w6S+LcYgDokAN8LLKi7PnBV3SlkeHuDyQ6+1wtQzNCl5thwlUmvL7XTRKG0lhMVSJ32O/rBinmlB7Ed/2G2eLUSkqxCMBngJhPjgsrgJHENASbIu498gVLG6OvwV+HiGdCOHdcsxAa+IhJKEai9dGgwNzjWsu2kIdy9WlxIBm8Z+bf4b1xx+wxp++zKKuK/zWMHOaxfex7S3jLx7/F+g+BGU9+2uEQRsioo6KM2KCjNyb1HvG1+XPniJLGvjKCH+bkBrML7sAKboRo7uv0x96Gz0eCe/WX9uEuD4w/ciFpA6IZ+oEL9AUFBAow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xy7PSRrz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xy7PSRrz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvXk5hxjz3btk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:28:22 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-490b9318997so32538835e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928900; x=1781533700; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=Xy7PSRrzj6NiNwAHO1NGlV44+jJVFq9m4PEeLyF6+Oamu9VYzDhatiOdovjxLEU04c
         3SNMLHC+kDmnV/B3vcUIM5KgjH6Qo8HD9AxCD7Xeyftam3kv3WdB2TYaYvpZ3u05LZ0S
         u/qiYSTuofosyRNFSxYImn217aSdFjFcv7O64JHAhC5yo7GZAjY07fsQ8lfWfpkyaUGn
         I29QSDHcCPZvxrdLFFvCKSpW8Wem5SMb3KBX26dw5C26VU+Sd+Icls3GN03Y3g4hO80p
         q58lxfBsUKjTHHilO86yLicBk8v+vXygsIZ5KSO2mDkSOaVAaw+NrweToB5kxVgedzSs
         IDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928900; x=1781533700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=DrU5Qh1bD6zC3eqUMdeubv/Il2W8ZZfrfq0xS5UYs7U1UopvDCutsRD2JeWyliGqfc
         otHBcj4S6u1mgsizPeVtUl6GZyxR9vFQdAyH+uqwBFPNGY0BPBeB4qVL9piCwBX9d+Ms
         EhANFQiGwx7djO2JwYYApz2QH5xN2pIgTWlUApZ0NpLuSkU+aE66Sm+GvpMX3/oQeUQ6
         0zTpDmzm9OkmabOTPUP/RL8yi9sxzZSCBCzf4+yDV2vrzRPpKNBPCjPa3seV7Nfy/QgE
         iig4yoj365h5rhkQj8IHQdc1GKoAq2n3dHmcTo8TDpnGnUOAOXeoohFkpY8MksI6ls3C
         5FuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QKeFE1KY+twG67/5dI2Yj/jUVrYUKANjbzGUJHuEOJcYeB1Rstrt05SZNcMIxayKtZt24abzFJQR9IyQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylRiehK8RyHW0sWNDiz07UVIpqfgWgjRr6EgDOUfRM7orANFkG
	x3iLRYe644oqf9eaQaVCQAe2W7IEU9D/ryT4VV/qwptat1+W17jq+OOc
X-Gm-Gg: Acq92OHhs1JvaAXMI0CwTEphi+jjQ57ji1IraQlNYVDG54GC+PUAb/hdfJXABVVW7eX
	5qvs7GyOhYKuOxt5GFRge5Pke17QwIB9OweLdmiUHaofhYcVUrpT/DUebela0+crxHWU1SDMlj0
	mi7O0/mHmru+Hxp05Bs5wvIJ9QnXJlU0CXO35Kl/FafgDAQnb82NoODs3NXojtBlZWgNCv+2HSs
	A4Fb9PbNdJYQR+ilyJal/8qxJXpjtTQsSUKxGV72z5UjlcS4i+8J1bX6BEJb/lXCHGvJ/49ELS5
	2KAVTmLi+gF2o3eraiN9gZLr2Hxksl2nRygz6koey2+xf9A/J3bWp1uK0hG64teWCyd3oFPT4Hz
	86t6GPp5IzXawQUsSUutV9divrh06su1yY4VXYOMT7cua9GF5z8rKvuMWM6ODbJoXuWO45MJyjL
	EYKUBLKHs08FU7F0wkNXa/hLsIvCK10rO/
X-Received: by 2002:a05:600c:1c13:b0:490:a646:9d75 with SMTP id 5b1f17b1804b1-490c25acd23mr285116345e9.9.1780928899673;
        Mon, 08 Jun 2026 07:28:19 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm41300869f8f.32.2026.06.08.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:19 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:20 +0300
Subject: [PATCH v4 5/5] sparc: Remove remaining defconfig references to the
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
Message-Id: <20260608-remove-pktcdvd-references-v4-5-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=T2wQkK65vboZ4IeGnr4NbeD+9D8laMYxlcwY9lW95Qo=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwe+fN176W16YWiVeI9314lb07p6Lzj+3W/788muq
 H+7k59N6ShlYRDjYpAVU2R5ce5624Y9ZwLuJdm1wMxhZQIZwsDFKQAT2fWHkWHapXnibIku550W
 mbk6q0jxNRhGT0j+lmLZuitp3hHHL9sYGWbP0NXee8F19p7y7cxsz/zmV57RcN3f5PimMlXv5Um
 OFi4A
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD* references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/sparc/configs/sparc64_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 632081a262ba..4abea39281cd 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -60,8 +60,6 @@ CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_WCACHE=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SUNVDC=m
 CONFIG_ATA=y

-- 
2.54.0


