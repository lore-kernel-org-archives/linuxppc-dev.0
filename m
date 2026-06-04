Return-Path: <linuxppc-dev+bounces-22037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C998CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:20:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWQCr3vK3z2ytj;
	Thu, 04 Jun 2026 23:20:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780579208;
	cv=none; b=iSQ/Yw6BkT/EJHmw2p9diNm2iepGh6HfJgUEWAks09TfmcWYzcH1/EPs5ZegoonVH9kMqHEVlfDTe7RzAHrYV/+rCM00CllclLlrr9TWylHsuI0Jafj1w2HRypBwnvP2De8lY/dOyMHEo7EJwD+OD7qG7pMKY6RSViO7ZIGzTrFjrQ1PZyiZO/dbFwBbSxfF3AyNczkgVT4tA6uk+tc1Xp6gVyqFBqRCicocyUthemS71kVYQAMOgd/J90tbxoudtOCPNObTitD/sK33RMRjqz7z8WcLqLQT6hpVPS3i8d6CtSqy0alBZRsW1eI6f6drDgnLu2scC8LCJrD8YKYSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780579208; c=relaxed/relaxed;
	bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwIc6kHlXE8AF9Wd53L7zLPfH/ffJj1ECZzAWM5ocCxsRp+iS2rKlxaubVQsPZKIO4x3i/K3v9+wHNTHSuH3a9MWKAEeXS2q1aEsvMrYx6E1E2GOLS2Uj5XmYoiHCulzLb9YnkM5p2W0q02LLpyv0yYaVjqI9QUEfoNhcXd9RELdSXDuyg0cXBvF2ofUkmGy4O1gu2nnHQwtPVUL7VPC35N1sM+8cGlib9eKNvPoKazaBSTBuuZU4BmfrwxwbOFAY60E2ArtOGKpVNM5rUp2Mk5CgdbJdO67L30dxAcr0pN2qQwnADts4K5ACUWLs45Rqj+mZklOiGPw93FV+NDXFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mg8sRknb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mg8sRknb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWQCq4nm2z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 23:20:07 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-45eec22fab7so389185f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579204; x=1781184004; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=Mg8sRknbh60R+ZRXXHCyGL3ABHgvPJ4NL3VT0FrhabHWCEUG1d9DXzSbQDsXuZ7TEV
         XtDgZRRlR4LiHfVXsAOhnivz/jRLG1OsFb80h0SmKwZT73TcWo2gLk+/cjLGrJc1Ofa5
         C0txwZo5qXSIm34RmLspmguUGterfEAWEeCooEFgTC7glzeT6uok0JNJ1SyLfwfQaY2P
         IgcWrBRlR5RluzTKrgGlq0nEStIieeYBuyg7no0X64FHgtM0f+d6F9K6Mit0AHVkloma
         RDDEUCftPLK8beJHayLZ9/NySpQhPsgvlN8NmHmbTgn8sET2M4N4o/68Q4LpcIJxX3gE
         PsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579204; x=1781184004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=s2zVPjAlivVVHHaRMvTZZbAlwCqZUvAvkqhvTMMgYwaq31Wz3X0r8PWmyY17IaZ7Cw
         UBSByaBFYdf3gwsx76PqXvo25MQjFgSXL6gfrKiZGJzna0qh4lbfniTrVlAsX4UWg67U
         v8Hmi2n5eJy0GpaSeTrKBPjz8iVVSAgmmzcA/UQWPuLxlPNZwmSCzgsuNyX5e8GTst8A
         IUHTDGvBdbDCnzZHxMjxfnA7eS2GsYFrCgWjFWsSIwmIgCYsEga5iSwwVJI3CWj3l+j9
         r1ArUyuyNnDeX51trHlmGfQfp1f3PEtqMWkIZHNF86FI182qZjRDTslqArsIvEoqcNSt
         qnfg==
X-Forwarded-Encrypted: i=1; AFNElJ8RprEmujPJhcfZQWke3hd4YDi/3qM6rs6zSl0IXvIWF/vQRgsgKx2eTHooG1wH4evHmUQlLQNvAd/8yn4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YztRd98z1lw8C2KauMPy0HPf5ibLVlmZ96BC768CdtAApx9kaKz
	Mj3+sptIbqf//ZAwGLU6fHOU9RdDaTaJmct5MisMYYYsYLBNDbD97VrF
X-Gm-Gg: Acq92OFJM8gAOMu746P44UugJPecwcAXD16uM7UPteBbotXY+VHmqa5kjHynNccfk5/
	QhRdZUTkTSx3zKDy5kIFhi+01vqMS1NfzXq0sdu/46WqPQwyZP/I0t0buuwF2qvchvrKvu/vqA9
	WlCwuF6SfXnF5psGm/oGEENEendohTSEaa9TEJ6trglL2aWiBvDhd+v9a6npqgTBWNI01gCMleH
	Nhn0cfD1vUyD0ZrqBNR8lX/SwfCtYaKQMfKGTRvYwvKKstJ2Ap0eWV1pJUtkRyZ8HJPyoUiJF4W
	otreMAdDpxfn1qDM1LVxdzHjzTo9Bw1tCoJs/+0p8i+Htb1/grc0ujFNaBnPloAQyOTNN3RhcpW
	K9Wut06cGASxJviE75Ni+nzeA4bTwN9+dKCrd3a6pXC8j5XT1Tucs3VQHP0zxROGPPijMzYhPtw
	FFoVS38+mUkTSANvy0xxR5WHz5anU8hFYf
X-Received: by 2002:a05:6000:299c:20b0:45e:7418:a3f2 with SMTP id ffacd0b85a97d-46021846dc0mr9148505f8f.26.1780579204445;
        Thu, 04 Jun 2026 06:20:04 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm3398435f8f.32.2026.06.04.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:20:04 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:29 +0300
Subject: [PATCH v3 6/6] sparc: Remove remaining defconfig references to the
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
Message-Id: <20260604-remove-pktcdvd-references-v3-6-e2f06fb4eef4@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=T2wQkK65vboZ4IeGnr4NbeD+9D8laMYxlcwY9lW95Qo=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vUry7hfsO25sPz06cyFgXWfhXOy1B3f+N6v/xxft
 T7rWuWjjlIWBjEuBlkxRZYX5663bdhzJuBekl0LzBxWJpAhDFycAjCRvxkM/8PWMczLnZQ1MVVk
 61zh9Gc8zi+v3191c++BLfadB9vXLZzB8M+6u/j1BddEqaaNtVEqK99Nb7E/mlw1+8ssJ3HGyv3
 3njIAAA==
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


