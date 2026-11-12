Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B466606A339
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVr4/I2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQQzs3tMMz3bV5;
	Fri, 13 Nov 2026 03:38:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794501481;
	cv=none; b=CMUXUIb8mrqMiwIBiqB/er5rh516lFrCMgz8VS6DSb1XPCeMm3CXLiPReOfa808AVKebabDWmkpaecBuUbXwcUknu/5y+pZ22PDfqGYw0u4DhX1cBW2O9pFIC+jBIi22NW1epcsejbO19/n4bNIosKy1leA5uTuP89EgW4yTTop9r7oNdvHdgLCEjfUDkeyUd0A8z40tE7LL+w9gKf3bLguJn8pZW0PyBHyhC/KZ95zLeo2STHIfEGHb/Gno7yMdKU2A7Pn62c8amvNAZ7hbeZGZedcrlNTZwJ5gv9QHJMlkJWLVy+3Y/SRYLoJib1ldz5BZK4eyvo1J/dIkP6gADg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794501481; c=relaxed/relaxed;
	bh=AgVuF8ZXFRiJrZlfw+yYm3jlF5vIF5HJW2x7P71O+Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFd3uJ8dHf3ljSXhGWRO8o3b2nY27ci9Db9mOV+Dc4XreMxgjIvD5JwgV4B0knM1baodm0Nb/n5alie3pcbg1oAT8q8mB1bRuYqwOoM8Xdr/V4sN4hDUxiSJPP3By38Wzwvdv8FSvXSRe9+c9R3PZhRm6/IlpwkpQNvWcF0t1LrD+Oc9j59Z1dkDCBUH8vB/GqP42UKrhUTS6aV3nZc05a7BdCbm3UAcpQLRsN1V48aLoG0UMEOIVbn1H89FqZYsXO7nKaFsgqc7AIm2mF+vXLsnH1e2dZbvLE/5mD/xQbZJUnkm4vGYhG+XYsv/IRlzb2FKb3PkB0NBpnrFbIDSGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVr4/I2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXVr4/I2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQQzr6w4wz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:38:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DC6762313;
	Thu, 12 Nov 2026 16:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBEF1F000CC;
	Thu, 12 Nov 2026 16:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501478;
	bh=AgVuF8ZXFRiJrZlfw+yYm3jlF5vIF5HJW2x7P71O+Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GXVr4/I21EXRfq59LPVJh+GmLyWYGYkNNqjQsKf3zPXFlW0NWJtf5rPpcYS7KOSdX
	 cuvsiMR6wRMGlfXHs45dfh/aiyCJKPpwkJ7InATFRZtni627BvP/NEfYa5Ri9Wl7Zm
	 MbwX+2ixCbawrFxG2m/qE3K5amQhVt9WGB8GswGm5IwnOCODWz265MPKp37n2GQi2l
	 M1bo6PXczS1it8gll8U/oh+d1dTFskrjXYWMy/I7fMgUryBIBX8Q1mPirE6GGU5+RQ
	 WyRFjq2bSV9lTVbdhV9MZsFaflA7hPleW9EzEyCV0hrkShXp4EzDcRquIE/QuL/MiG
	 4H11/+PoqQmwA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:07 +0100
Subject: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ok0CVH0NZbW9pFZQURYCmgK7NHT0tqdpELAezILCuX8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR1hPytaT0Fg3571WX5Pc49l9Ljm5hpfSjOaFKiXc
 /+Nd/DXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksrWFk2DblYlb2+wtcAm9f
 9Urw2pVlH9jjtld/qn2aTOpzlZI/+owM3+QcSm04dq2PmNo4h83lzbOWLSZyi39PsZWtrdseFlz
 CAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

copy_oldmem_page() maps a page of the old kernel that isn't in the
linear mapping with ioremap_cache() and copies from it without checking
whether the mapping worked. If it didn't, the copy reads from an offset
into the NULL page. That oopses unless the copy happens to be a user
copy, whose exception table entries turn the fault into a short copy.

Return -ENOMEM like the other architectures do. read_from_oldmem()
turns that into -EFAULT like any other short copy.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
Cc: stable@vger.kernel.org
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/kernel/crash_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 103b6605dd68f..1543917bd3e1d 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 	} else {
 		vaddr = ioremap_cache(paddr, PAGE_SIZE);
+		if (!vaddr)
+			return -ENOMEM;
 		csize = copy_to_iter(vaddr + offset, csize, iter);
 		iounmap(vaddr);
 	}

-- 
2.53.0


