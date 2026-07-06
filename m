Return-Path: <linuxppc-dev+bounces-23642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE28C44500
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 16:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv96Z4g3Nz3bps;
	Tue, 07 Jul 2026 02:39:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783355942;
	cv=none; b=W3uO/z3IOqWHTaDlQo23tiNrirDIPA1X2kJnvQFg1JMI6nSsvTnOXULhHtzTksfseaS/+A+bJEG4w37MydTY4vG95A9gC3zZiT6dV7AMTi4bI8vEMOgHVtGstIqCe/KPdf1D6I93n7MrB4P5etkHm4jSdjBHovPAVsddkeJRrSaVfFmKka36sNVNWOn+iRVYPfpO5ozvYFHJ4iliyjNf0/IDuhLDK7UX9UWVKuelLosYdh44lSgy1yCuNo/qSGYTLFkaLA9aT9MQQ6CrgF8wusP8ntEfP0iRYfbrrXZawmMc2E5Zgcnwkqr2L4orI3mzdmfDwZJmW3LMs7pLySL+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783355942; c=relaxed/relaxed;
	bh=3Yf91G0E96liVZH8Q9brrUTzp4Zjh9n4mTBgTUdMqis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwZwCsTcGda4aI8O+CXfAoscfi1LRDL11EO6OnYYMqGgT6PpkyTxofK2lDgbU7ANPhkUBAbdYUbDN9KA6TQ/2PkB980JuLgu8E17MuxN3zQOcUTMOF/QJPEkeucCi4VFKRxVed7//S62FAe6l/jdb+Rn2h9lOYTaLb0eq/fKoNjZp05FIbPKqm8yZr/S8++Wsk0V2rQJ7xYwzM/9Kjd9mko2yzFOubvOUlcPWkEM/IPAUdH9LpcY+zmHMZJdHyuxIWYdWb4saY5TDP8siGvb+Vex13PbEgQe9puisyVWfcpQWINI4MpmZYp6XrxW9SB6XeP2p/Iu05ACB8/zB2ItDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pp5oIK3d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pp5oIK3d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv96Y70d4z3bby
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 02:39:01 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2caced6038eso263205ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355939; x=1783960739; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Yf91G0E96liVZH8Q9brrUTzp4Zjh9n4mTBgTUdMqis=;
        b=Pp5oIK3dVnUtyWj5w+HuTGholpGnn0eYNbSwSDOkZyFFYWfmS97xaqBVLmy+SwrMUl
         +DJ+IpUKrAjJg5F+KetZKeOgg2wFFFk8IWeT18qiClXKY0eU9/cu87QGi0YMzKgQ0k5Q
         wHMBelMfbETdTgbvdlP8K4Pum0J6Q77aa8RvvgiB0Vsh9eVJ7wUs9mw2qUJ85nsNR6ZG
         4MWweIgtSUOl3sdk5bCvmqVBMk/yLObtwx8wVPKnKdVqrQfwyBRPjzcda9wlQqAJT37L
         KQt/3wRPCuRxsSKPo97PsBWqMkS683OE6cvhypA4XoTgL2knJWVCZl2CxW/pyU9xhytb
         7v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355939; x=1783960739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Yf91G0E96liVZH8Q9brrUTzp4Zjh9n4mTBgTUdMqis=;
        b=sQQISkyHrDoEaB5ZuJ9/7Sz3+lkN4WqBCG6IikfWd/gfHoYzyDxcnCVJKIc8VDFvGW
         e+X3Yfcdh4hzxMij1ALjOvZqUxJObBGgy1P5zpm7X2K6jNrDyeptgadSB4TExEbSDb90
         oc2Ij7TdVuS0LHLtMcqn6OwVZRGxP9BgNgFT96ZhQDXBRoaU0LndgbwqtzzkacvFjktI
         JbSxMA+YyPOYKgbQfuVEEuYCK2MluqGhphOKzDNd6RjzD5BFMBnJfkSNosGp+ckpphu6
         c9Yz6WrIIX0obO1a9pv7nFLMxMZjUKVi+dC5L5XRZsPzp+E39lStJt9Peke6ECQA8fZh
         RIMg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9tO9dcCPOX3WWRxmbEO/XNxbGL6G2M5ez3LEAKgidcupLyBSoSgdGq2QDUm38ITCwWCS+d+wky7CBRMM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy97EE6UkN4tca3kpPyU/4PwKxcDH9sXYCmhI+VoaqHa0bhvYjc
	ntX+yBbKb2aE1Z5Xf498O151RvEwLEI9N7GcfSeXg7GoH6u4OQVhZUre
X-Gm-Gg: AfdE7cnCK8Rtfp/E7nwXbe5GfSzPo33g/v1BM68+8L+LUYx11v2oV8nI8Dea8WIJ4Wf
	QWeU2F85J/ey03d+9CX2azRR6qFto7msUpzGnGMB8bBp2zKMHUXeoZZMY5yWfkgLLNXUUMdRnkv
	TN0nzTqQStgxK+Cu4jSPK+qRb3Y+cKpS3TY/gx7S20t0ObznvKaDiImZ1l908JVGwOg3gqpZ6a9
	lnGOwJGhCt9TDg9hC8vhaqdAAm8sMgNPfBW1idJvIOSFbHh3ERP3hDQa37YpW1b2i864xCi+xr3
	tASkkF6crDaNmwIOQcWn/CxnTeCtq5hatErZFZNV/M0ECTWr2UltxF9P4Lb4S4q7t6+Mk1LdYrj
	4EtPmsVL8p/VoSp4xlmMBh1rcfu+50/buXzwUeaurmZbdFSVmYnRdPQTDS8qIpoxXQI9YeJBaKH
	BGw/wMrg0=
X-Received: by 2002:a17:903:3903:b0:2c9:e9ad:3ed3 with SMTP id d9443c01a7336-2ccbd7d2afcmr15968075ad.17.1783355939040;
        Mon, 06 Jul 2026 09:38:59 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893a8dsm53103305ad.73.2026.07.06.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:38:58 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rich Felker <dalias@libc.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Subject: [PATCH v2 3/5] powerpc/fadump: remove unreachable memblock_reserve() return value checks
Date: Tue,  7 Jul 2026 01:37:51 +0900
Message-ID: <20260706163753.193875-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706163753.193875-1-ekffu200098@gmail.com>
References: <20260706163753.193875-1-ekffu200098@gmail.com>
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

fadump_append_bootargs() and fadump_reserve_mem() both run from
early_init_devtree(), before it calls memblock_allow_resize(). At that
point memblock_reserve() either succeeds or panics, never returning an
error.

Therefore the return value checks are unreachable, so remove them and the
related logic.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 7f79c9aea4a9..1629a82b9528 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -154,13 +154,8 @@ void __init fadump_append_bootargs(void)
 	if (!fw_dump.dump_active || !fw_dump.param_area_supported || !fw_dump.param_area)
 		return;
 
-	if (fw_dump.param_area < fw_dump.boot_mem_top) {
-		if (memblock_reserve(fw_dump.param_area, COMMAND_LINE_SIZE)) {
-			pr_warn("WARNING: Can't use additional parameters area!\n");
-			fw_dump.param_area = 0;
-			return;
-		}
-	}
+	if (fw_dump.param_area < fw_dump.boot_mem_top)
+		memblock_reserve(fw_dump.param_area, COMMAND_LINE_SIZE);
 
 	append_args = (char *)fw_dump.param_area;
 	len = strlen(boot_command_line);
@@ -632,10 +627,7 @@ int __init fadump_reserve_mem(void)
 		    (fw_dump.ops->fadump_setup_metadata(&fw_dump) < 0))
 			goto error_out;
 
-		if (memblock_reserve(base, size)) {
-			pr_err("Failed to reserve memory!\n");
-			goto error_out;
-		}
+		memblock_reserve(base, size);
 
 		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
 			(size >> 20), base, (memblock_phys_mem_size() >> 20));
-- 
2.43.0


