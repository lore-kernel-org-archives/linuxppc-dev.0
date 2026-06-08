Return-Path: <linuxppc-dev+bounces-22206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058CECD8C92
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvXj3TT6z3bsX;
	Tue, 09 Jun 2026 00:28:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928901;
	cv=none; b=TboFOMeVrCltlVAPnaquLejDDp3vztYqUEBVCh3QKmtpPyg+lZUlVCsU19+l/ZE0AxsQ5CNRMumkpkn5cF/5dTYYiMow7qyaeYHDoMcJJlluZUvUMuF85/MYPVnC3l91EFDwXDGxKaaPSf5vTcY2+CSDzPkar6CMZ/ir+W9YsPEg1QQ+PygQCgOd6uV+HMgaqh2cGBqVBSPUPrGeXnW/+2JVAFYt0QSMZk3Sw+ABA3Hv4qQCozXL77Ri5kZoZb/29S4C/zWS8xQYZQ9WZ9lV5cOkMKnJY+XjNrb6eHAfp+1p7ybw9BiyeuxY+dFvgklq0zxe5bZs1PZpDFihuwiqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928901; c=relaxed/relaxed;
	bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGRr9QxLO14he41dCfVBpBZ5hlz+P0Ni5SAOZz4ow1qO1TtG/+r/lYdUgVbzIkGvo7iK/ximY31ee2Lk6cBDwDjeN28H+RZutY7VB8WeRo1skeumcTbKdsOZAjpAwOqSLTXreWKoeVLsy7qwYfx/sf3kgniMSkadQaBck6xkeoN57+8JxtQCMvcIVib/yl/UGtJfFhorxenaYLHPqbJ8kOxFg7ZpslDMMeuNBgEAuez/LWXWhkkWUFMz6DH4IlOXdE7isxozrztleRA/BOoacWwFDtjkGGewWkHslVo+pDDyeR0VRacCczDlDu85GXvEnKs0yvaAMWQtKYfSKO8hKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FnD47Cxv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FnD47Cxv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvXh2sMKz3brN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:28:20 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso2064287f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928897; x=1781533697; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=FnD47Cxv/elMANaTOBidF19X1MpYf4OKjHhHqL9Oyg7tM70AOBJOkBUnxpvL+ybxXA
         O69Sb4FKqzeEVdo+T9GexhmvsXyJXrsceUlugXpoHhtasT11U9JwgIove99pqYion+MY
         N3akazZzYnVxdzFSmCKFgcVBC2vH/vK+ZUf/oVw3gqdvLTCpHvhU5uZ5O/TpR32S82YD
         tCKo+x8S88K56HmZNRp5cC+9XlZ3XQpzWieb74OE5CFpMlnbGF/C+Kl5kZ4BxA9hhsQY
         BQHLLZXmL9bz8T/3fcJVmiI23acoZ4OBuPy+PM4KpTm/n1ZxGUed7A3tABMQm+TGuTTi
         Pwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928897; x=1781533697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qohYqz4B4PBn5o3+UkMj6t+aWtH9uwOMAfqBpeAnghs=;
        b=kyUFn0mlsLJOVwP+VoPnoPFkTzNzOBra2uFXbW+LpxhfRl2fwzarB1syZHW3y/RPey
         Kbt4a1P4CCkOjL73iy27XRAgzl6QuYXyMjKsO/4kvlFaGJbiphFSH6FSrC6D5a9z6FlG
         mfEH/19Af+sFXL+l9GzKjPSKBJ8nUJJ5f+LUETZRIURUbFEM+G/FcuEzJbVvLHqj2+na
         76dKlku3Y3zVEVJas0P23nLNDivuH5I0FIOeZnBQdgmJZwUy9EqwW5KVTjICSARdBikV
         vKDm+3GqpsVZEnUjN0c5mKyhKmbf43m3zS2iN3csNtA5ThAgpub7GYcQ210JBVeHwXQx
         BOSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g2bRwX/QWkLyNMYPljA+67c7spHArvvWdw73NKZxInn11v93nIuy0KetqNT1b3+asQG1DGESWsPH0Y+E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzYnR0BDT5w2iDJxCXnn3JXWFIUzDuzhMbEVd4bgwjZen8y/NxY
	tGQhoKcaBItxy7rplelOJoSf23QeNFxZ2y0ochqcZBfTul7DMySemrwQ
X-Gm-Gg: Acq92OGXjiSdjP9pQYNWrufL7WS7knlSVUPJmNe7gnXktZKEKZCXuxFkFwtvDgDDOR9
	y0vzit1DcAfv7rCJCP/5EGO9MVKpFfR34q8nEOi8Ijx72o6Y4ibvqBv27/8S98XxwSZZE+QqJYI
	JT3ah/Q+8jISTL8pnxzqvLngN8Cxz/J2i8ln22v55dY4MIuB79uu5915Jo6uOMo6Ph+jw9C9h6d
	EYqOBoKkx2cb+De+TvolgGqokTNVpVH9gvSYp2LRrv+nzQmh+AHGU/bxY62yCnf+rZ3wzVNR1ai
	biA8hNCGVoaVpvH2DB2qI7lllj8SGpCEJgJ8eRvRmyduJbtMWpXjY0DgCMkPogUaSQZ9MxofKkq
	SnIhGU/wa46j5aQncLpn+T0WRAQNPeoVX+GHNwZ2dCuuqo98iALLfj5WFU9Nld7DAKilwaH3S6J
	rIEKXd61s0YBeYYk9sw/GwJLO9Wgo80AdA
X-Received: by 2002:a05:600c:1d29:b0:490:50eb:b777 with SMTP id 5b1f17b1804b1-490c2597822mr265428775e9.5.1780928896699;
        Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm58108978f8f.5.2026.06.08.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:16 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:18 +0300
Subject: [PATCH v4 3/5] powerpc: Remove remaining defconfig references to
 the pktcdvd driver
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
Message-Id: <20260608-remove-pktcdvd-references-v4-3-72f88b04cc87@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=iacobcatalin@gmail.com; h=from:subject:message-id;
 bh=gzHc6gkZVQYvB/HNV+tpD+0yf/PTlunsXEIfWYwA01U=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwfmTElx/xK55o6i86kC379LZn9k10kzaVc99Njd3
 jPQfnZYRykLgxgXg6yYIsuLc9fbNuw5E3Avya4FZg4rE8gQBi5OAZjIVFGG/1EhNZ1mKjOin/vU
 q7bP1LpQFJ4t+z+hMjdmjWGLWsGTowx/xW85dQpMajBlsOM6uceUz326+1uFPIOPe7lffQvjmFj
 PDwA=
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/powerpc/configs/g5_defconfig     | 1 -
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 5ca1676e6058..647775f6d174 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -57,7 +57,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index eda1fec7ffd9..5c3e25fd8edd 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -306,7 +306,6 @@ CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m

-- 
2.54.0


