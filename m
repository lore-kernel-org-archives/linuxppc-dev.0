Return-Path: <linuxppc-dev+bounces-20662-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C839CD37B2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2026 21:49:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDGj64Vsdz2xnK;
	Mon, 11 May 2026 07:49:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778433263;
	cv=none; b=nBroBQt7syxfY36zKet1wxsTeEVjCizXe5gb3ErRIHfTi+9P9ofSe6s8nxs5Yh1WNl9CIEo1aRfeeP++qITMoMVaanICL6Ha2c+CzmyhRZysxjsA1GKBsjmQfeo1V20iG8BmOBb77ZWQ1c5VkC5ANH6Io2C94IiNH2Ng1p5ffHBpvl8JJzZi0mKdduAR7LZqmd8n8NVkVuC2qpKzAFB0fkA/lNiDFckAXTTYT6helCxK+q005KCeFF9Sl24PBplLJxpvbqMD/ipn2zG85kqo1x4gBrYrh8QgOR15Eou1NaPYDyUZ43GXlTdV+a5tNGqrKnRucV51X+F+FJlaeAWL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778433263; c=relaxed/relaxed;
	bh=ljxyGF0XpRcmphShZNeAA60z8jVSJUpH0HQBwb34PqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4ZQzhec8SSaWln3FSxqWB37JgI5HOel17hsEOM58LDAItl9kxNy0P0xefQGch+/RSAACabNyb+JXIDJoVPohz/WMitSzeY3nB+GF9nPifV7DKa9Gho6NtBh2acKdl8hPzjxNHslUU1s2ziHE7lYbi53O2Mc6u4rOP2Fm4QaWR6DYe5+0AA7C3nQ3NpueZsUaH7EuzOQi3Qb54ViT1yJ/ZuzzEkkfPZ6I3TeJjOr8i7hiAnuPEuJObzD3S0amZxz9K9qyQnyxk/cUoSyoAW/aMfvidtZFUiTmuISMDY6HPFwQignWlN2yvZeG15iAVchzjcGHcOCGEmGd6E3HRyh3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bCrCDPYg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bCrCDPYg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gD8bd5ptdz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 03:14:20 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1460593b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778433257; x=1779038057; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljxyGF0XpRcmphShZNeAA60z8jVSJUpH0HQBwb34PqY=;
        b=bCrCDPYgPfjkJaMb+PdSF8H5KC1ns+W6pg54YxxAqaUx9OMTq9h9ful11LUT99jQSh
         oSWX9t6MQt5DCsg1CWUAN22LchsIpwmqvpWARVDXU92jxWWujnQ8uVVDkzNdKFEoYhuf
         OQ21zGT+XZ7HG0LrUsLdiS7DVGN5Ap9pSqb9sS8nOZ+T8I1+bgc4sZ0xzPzxnb+myAFN
         7mTmbumVlefVEQ4wYIOF3EdNgiU0GVnRznX84PqwHy7bAum3NQaGWomrQkI54fbxLDvR
         Igz6JNdybeIANCUXuYCDzjBnxH5dH6lnxsdCi8nuPMPOBKr8d6IDxXMBAjh/VYnNQuhC
         882w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778433257; x=1779038057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljxyGF0XpRcmphShZNeAA60z8jVSJUpH0HQBwb34PqY=;
        b=fcnhrheK7Hx3eGbR3FF28WLq7UK7ws32TFfox8i+3MCWNigHQqs8QD9CVmu3dwcqwM
         MoZ3vf3mHN8GCiKurYcMeLrfl+eQ+1mCC6ZozTQHqd4eHfDS/fwHO8rZV5/t9A30kZAw
         muRqU1USYRjYyr+sJwET6BawCSF1womvhKJKVnLE4BKj2wHTVMlWCPDBuadz9/n51VYK
         8b7+b7o5GN1de66xwDVE82jqgxAayhnJeTyLBcvZEz1JWG/Qngr+N6ywi4J5dFhuycFh
         Z9NLESbvzMQwfe7/bZbwWXnYjrilzvyA+p9URa2+pRWZYuArZ/AhE/rgJSamsbMIpY4w
         e3IA==
X-Gm-Message-State: AOJu0Yybo6hfW0hes9i4lcZAkGhdNv3FUOjN2J5s0Fno4grscymR3Kzo
	FIcGeBQQrSv/E9oBHG29E2TtAdFFi1CWtZn+QZOAXjc1Q+VrAZGqmVJ4
X-Gm-Gg: Acq92OGyRBSWOMVgLj4dSWuHnr96A4tOT9Qo+3iAAxEW3RLYpsMBmPIQoA5aDG4dhtL
	U+5bTTVakKpGAJ0OZVQCj7GUi9503hDwkhyN4lgRm/9vVLofI8aiaZQp2pFdH26+zwu/kdKYqSK
	5n2qJM+VVPqMzL5sHjGsNcB4m8gZTgsfOTWFwAsNfcfGmss3m3d5jcUOPYhKaCvrkk3mcJ1THvV
	g1FwjW/YkhYZtjpeAk6ULFcM5PgQhILxYytZFpRcVwCKVdnFZZCw0dfobtntaJ+/sHxxs9/70aK
	E8Y9pDSitmtx4dni7PP8DdJEUJHkGD/nX4k87uYk7Y5+hYB5GMn7HP1iMj7ytScxJzXo2+M99sH
	u5fLDihhMNBz5EWSD2prpVATZxbg0ikIPTlgKfry7heNdicalID4+rT6Ae9NIgOBe9b3Cw1IfWb
	dW4xneqmxDPRgR/HYLVJpsND8iwBsV
X-Received: by 2002:a05:6a00:4098:b0:82c:e09b:3f76 with SMTP id d2e1a72fcca58-83cf6e732c9mr11292717b3a.41.1778433256778;
        Sun, 10 May 2026 10:14:16 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f381sm21799778b3a.6.2026.05.10.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:14:16 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 0/2] powerpc/prom, of/fdt: fix chosen node handling and cleanup
Date: Mon, 11 May 2026 02:13:51 +0900
Message-ID: <20260510171353.1406018-1-ekffu200098@gmail.com>
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

Hello,

While looking into boot information, I found one bug fix and one
minor cleanup around /chosen node handling.

Patch 1 fixes a bug in powerpc where /chosen properties are read
from the wrong node.

This bug has existed for a while without any report, so I don't
think backporting is necessary and I did not add Cc: stable.
Please let me know if you think otherwise.

Patch 2 is a follow-up cleanup that drops the now-unused return
value of early_init_dt_scan_chosen() and the dead checks at its
callers.

If I missunderstood anything, please feel free to let me know.

Best Regards,
Sang-Heon Jeon

Sang-Heon Jeon (2):
  powerpc/prom: fix /chosen properties read from wrong node
  of/fdt: make early_init_dt_scan_chosen() return void

 arch/powerpc/kernel/prom.c | 20 ++++++++++----------
 drivers/of/fdt.c           | 10 ++--------
 include/linux/of_fdt.h     |  2 +-
 3 files changed, 13 insertions(+), 19 deletions(-)

-- 
2.43.0


