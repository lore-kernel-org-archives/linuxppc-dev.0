Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF6606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eVR3Ru4Y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fb+iCiKk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1FX5CYmz2y7p;
	Mon, 23 Nov 2026 20:42:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795426960;
	cv=none; b=JKh9gS6JXWI6gIjPrC86XbWGwoZjo89gaPf53OV5t+246TGaHG/g2Ihj7bmpNM7prvyLiJzEy7RCnNmb+8PxNnKntD2JvlRzsBVKGsvsVIpdy/qOiSzJheGorJyLceWtPnVPjXy4Bxpve9QpTJCiAwo27SqwQFiDSYzfZMlxevADscZDZwWFzM/+ABxcjdrZQ8hFbPL/PJHb2oDOfv8b85Biht8xZUE/Y/zwBnK520Hn/jMBUo1K9G/v5Yd0Y5OOSA1SN2dfWYbbSPskIHEkiGs94CKqk5oYmSmjoZiiwi2z3EgjOO7i/MMYhbjvBfalkQENvGyH0fAtqSdwHMHZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795426960; c=relaxed/relaxed;
	bh=12rCIot4Q1y046Vzp8EdeFdJZwXEj1gxqogCrSz0YUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MvgQU4gcRL0UqqJ9JnZU7R3ZyGG+yWCOYC4Paf1Nv5ENfaLY/nlzwdPBOUNXWBlQWe/NpD4jTiD9o1j7Le0x1g+assCnfkRxXKYCCWvDDbW6IGR2Fjj4Xo2X6lWyQ8R2WqvgBwGF9fEtl69FUkZYoTKexEK6mgkqWbT9B0WJVZ1Ezz1bgck99CoslKV9xjR4GS31l5IKiz3XsFRt1jXymUOG7tv3g3zWRxK0ntncwGI7K+4yRGHVpykO9KgxoIiGLJM9ijW4pog+Xw2aJa2Pkau8u900wg6HISymrygLsKFOucdlvz4jShwFmKQ427RHfKnjM1gDtOEMldadqNDDPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eVR3Ru4Y; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fb+iCiKk; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=eVR3Ru4Y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fb+iCiKk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 307 seconds by postgrey-1.37 at boromir; Mon, 23 Nov 2026 20:42:39 AEDT
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1FW0xPVz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:42:39 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=12rCIot4Q1y046Vzp8EdeFdJZwXEj1gxqogCrSz0YUU=;
	b=eVR3Ru4YMLUxoE2oBeLnHegybGHZ1wA0UbD4tiFIxf5sSlq+p3wJdzZpk1ObDTCcQrza1z
	sy98hHXx+8xzinXaJ18cQFrVUiJIc/UcxxCx104dR5eQpHKjKHCYzESkf81Gf3OdfKYFU/
	eii4VqnD+bVQRxDevExQLyGum7btdJKvvpx3Yr5ardHDzDIHP6aGihnfy+77XqVSz6ZQgt
	47xh6w/Vwimk/bHTNf5kdhLgywTu1BYGw396QHdIBvHSpQXvrSULdDcD2Khd3VZ6kMCHkn
	cKpXfzLviy+wczOkqv+t1GeRU7hURAtZmDFbfCzTh8szA5wnR/Jki6meRytmbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=12rCIot4Q1y046Vzp8EdeFdJZwXEj1gxqogCrSz0YUU=;
	b=fb+iCiKkolSfl3maExBNRcPmG1YtwmtD8FIgojBmtd/T7xWBvxDvLsmVcOv8h0gdh8FVpL
	vvdYhx+u/oAeYgDg==
Subject: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Date: Mon, 23 Nov 2026 10:37:05 +0100
Message-Id: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ6CMBCF4auQrq2ZTiOCK+9hXJQylUlMMS02K
 OHuFly4kOU/yftmEpECUxSnYhKBEkfufQ69K4TtjL+R5Da3QMASFNTSDDKRHfogI79JmmA7WRI
 4pNq5qilFXj4COR5X9XLN3XHMg9f6JKnl+vU04KaXlARplHKgG4PWVOc7++cQes/jviWxmAl/T
 g1628HsHBqr0RwV6fbPmef5A6qlb4UCAQAA
X-Change-ID: 20260109-at-vector-size-arch-6e0f2e9ff8b6
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Andy Chiu <andybnac@gmail.com>, 
 Magnus Lindholm <linmag7@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=3299;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0K3qhqEWg64tqQPsXMhmXxkKgiRN0V2EEQPpHTYxv4A=;
 b=Fe8nQiRi3Kfc2ylHmmPvMPRVTTjkYlaqoKTjn4kvNkLesW4z62H7gN1D51+mJJRRBnWysks5K
 2YBQSucEVjaDRaSt/FqXQnlQcInw1lzhzM2T6nWBTe45/TAM3F1ehFZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to kernel-internal headers.

Meant to be applied through the asm-generic or execve tree.
The default recipient list was huge. I trimmed it to only the
architecture lists.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Rebase on v7.3-rc1.
- Fix some include guards.
- Link to v2: https://patch.msgid.link/20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de

Changes in v2:
- Rebase on v7.3-rc1.
- Pick up tags.
- Link to v1: https://lore.kernel.org/r/20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de

---
Thomas Weißschuh (15):
      MAINTAINERS: exec: Add more auxvec.h variants
      auxvec.h: Move AT_VECTOR_SIZE definitions to linux/auxvec.h
      asm-generic: add an in-kernel auxvec.h header
      ARM: drop custom asm/auxvec.h
      x86: Remove AT_VECTOR_SIZE_ARCH from UAPI
      arm64: Remove AT_VECTOR_SIZE_ARCH from UAPI
      RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
      LoongArch: Remove AT_VECTOR_SIZE_ARCH from UAPI
      s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
      powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
      MIPS: Remove AT_VECTOR_SIZE_ARCH from UAPI
      sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
      sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
      alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
      auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH

 MAINTAINERS                              |  5 +++++
 arch/alpha/include/asm/auxvec.h          |  7 +++++++
 arch/alpha/include/uapi/asm/auxvec.h     |  8 +++-----
 arch/arm/include/asm/auxvec.h            |  1 -
 arch/arm64/include/asm/auxvec.h          |  7 +++++++
 arch/arm64/include/uapi/asm/auxvec.h     |  6 ++----
 arch/loongarch/include/asm/auxvec.h      | 14 ++++++++++++++
 arch/loongarch/include/uapi/asm/auxvec.h |  8 +++-----
 arch/mips/include/asm/auxvec.h           | 17 +++++++++++++++++
 arch/mips/include/uapi/asm/auxvec.h      |  8 +++-----
 arch/powerpc/include/asm/auxvec.h        |  7 +++++++
 arch/powerpc/include/uapi/asm/auxvec.h   |  6 ++----
 arch/riscv/include/asm/auxvec.h          | 13 +++++++++++++
 arch/riscv/include/uapi/asm/auxvec.h     |  2 --
 arch/s390/include/asm/auxvec.h           |  7 +++++++
 arch/s390/include/uapi/asm/auxvec.h      |  6 ++----
 arch/sh/include/asm/auxvec.h             |  7 +++++++
 arch/sh/include/uapi/asm/auxvec.h        |  8 +++-----
 arch/sparc/include/asm/auxvec.h          |  6 ++++++
 arch/sparc/include/uapi/asm/auxvec.h     |  8 +++-----
 arch/x86/include/asm/auxvec.h            | 12 ++++++++++++
 arch/x86/include/uapi/asm/auxvec.h       | 13 +++----------
 include/asm-generic/Kbuild               |  1 +
 include/asm-generic/auxvec.h             |  7 +++++++
 include/linux/auxvec.h                   |  5 +++++
 include/linux/mm_types.h                 |  6 ------
 26 files changed, 139 insertions(+), 56 deletions(-)
---
base-commit: a6b4ba7acc23ac0fb680449981982f308ea75036
change-id: 20260109-at-vector-size-arch-6e0f2e9ff8b6

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


