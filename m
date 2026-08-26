Return-Path: <linuxppc-dev+bounces-26120-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A27C61DBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 16:06:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVTzv120Jz2y8F;
	Thu, 27 Aug 2026 02:06:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787760411;
	cv=none; b=B85qhHHQmkKy3AW/w6xQR4q+B3diqBfXEerlXSFgMUlz0w7kQfPSXY1Zuf6Fyp8ghCc37FA7/A4QbcXcwGT8zbdqQ+7OZcTiOYMDuJyNzq0tqH3EtGhml0ELlozHc9En7L0Nqd+j474Qx7wQgpbtfpVu/v1RSF9+AvhObeEWy9/E8KJMNxaqkz7YzDwBY8sXdPJWRy9KhHUupQksiBbCVZ9wvIOid6qYBQzUFvD6uBHrYZWzleOuZeORe4sPJpsa8G9x5JinXV3O52Up7n0LiHIGZG7bkl6Ffk8WqTecL+9/qW5uzbVlaQ3RyastuijdL9eu8xl/T+oyTgLxSBrnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787760411; c=relaxed/relaxed;
	bh=qzCRwQtZ9/wP7Z02N7Vz+vk0AFHWhteXZEZwfRjGIOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cK+ogGPDypSuTMsIByiPgcNsLxvgWEFcGF8ZdzZUhUYd0ye/Bt1+5SiY4cnuBGRWKNQlI29HCVdlDP2F8kS3VsIswQyeVO3sycDKtH1K4txbbwnH8EGKzEl2b+VO2EyW4ifq0pbNI9cO1n44TMHcV5YYE1GGN3K0Tjos3t3/ZMEZxFvnhpGDJXFTvqJDVf9JWN0Je3fBTuuWS2DJ81YG3iTuWsUADdq8Tu0XVkVSLiEeafPAA0lJWIE/X4AanTlpw704ud3l/+bZR1BhrJ/ffjNhIvBg4rJyC7r8HYf3Hiom4JHpUAOfqbGau1AcHIddK7azm94eOLlmm9Msu6lWTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6Ip0lEq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6Ip0lEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVTzt0dpHz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 02:06:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CF24D6001D;
	Wed, 26 Aug 2026 16:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8E01F000E9;
	Wed, 26 Aug 2026 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787760406;
	bh=qzCRwQtZ9/wP7Z02N7Vz+vk0AFHWhteXZEZwfRjGIOA=;
	h=From:Subject:Date:To:Cc;
	b=D6Ip0lEqBo7TaC0vEm+4INQXvt0ORtVzNxM0nL9cPiyvLdL7frUynU9l8nVrh5Hbi
	 0DZOfCM9+5b/Vcu2UMnl6mVjQzxwSIy1lFeyN7ApPIueIAThUeKE2Q0S+xVYxRAjGE
	 oJlaVUf6Xvy9L97Re2YL+83yOceM8rQLqjAwTsD6aK2RunFMDywrj1WllEmuoF2gkA
	 tD5KYw8TK6MEIiuyAAx/X3AcTlG3KIUWTAC1VwROaBRfNJnwriTuOQzWUwVEOD8gGg
	 um0nJVih40tK8jMVuZBOsdUj1qcuaS+l6xS72VeBbqm5Ae3ZkcqA4RZcJAfxeSrqXQ
	 tcRvDlIEmmeGQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] powerpc: remove spufs coredump support
Date: Wed, 26 Aug 2026 18:06:39 +0200
Message-Id: <20260826-work-spufs-coredump-v1-0-579e72a7ab66@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQ7CIBCF4as0s3ZIIW0lXsW4ADq1aCyEETVpe
 nehxuU/efOtwJQ8MZyaFRK9PPuwlJCHBtxsliuhH0uDatXQajXgO6Q7cswTowuJxvyI2JHsHEn
 d9/oI5TMmmvxnV8+XX3O2N3LPStWFNUxok1ncXE8VFTsq/qioE9i2Ly3jLmaiAAAA
X-Change-ID: 20260826-work-spufs-coredump-4e14ce185587
To: linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DLaQXXhE3GPjz/WkKul8E4zcEVrz25q2RRBTZmkJ/Y8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT18wvLGFte3TRnstVy/Q9fUwR+BztJKG36qChdzPRor
 zMfA8/TjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksvcXwT/lGGFtVRkNJQt3E
 M5lHJdmWTOFgqDh38P1l67uyboI7DBgZzv7X/zd34swfVvwGk+PO7Pb+/mwHv+2R3R0Nzld2zLi
 3iQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A task that dumps open spufs context adds a bunch of extra elf notes
describing the SPU state. It is the only reason do_coredump() unshares
the file descriptor table. We could make this conditional on spufs but
eh.

Nothing can consume those notes anymore. gdb dropped Cell Broadband
Engine debugging in 9.1 and binutils removed it in 2.34. That's about 6
years ago. So no program can actually read an SPU note out of a core
file and probably never did in recent history.

Note that the IBM Cell blades that shipped the Cell processor were
removed in commit 05bf59fbeef3 ("powerpc/cell: Remove support for IBM
Cell Blades"). The PlayStation 3 is the only platform left and nothing
there produces or reads these notes.

So remove it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      powerpc: remove coredump support
      coredump: stop unsharing the file descriptor table

 arch/powerpc/Kconfig                         |   1 -
 arch/powerpc/include/asm/elf.h               |   6 -
 arch/powerpc/include/asm/spu.h               |   3 -
 arch/powerpc/platforms/cell/Kconfig          |   1 -
 arch/powerpc/platforms/cell/spu_syscalls.c   |  20 ---
 arch/powerpc/platforms/cell/spufs/Makefile   |   1 -
 arch/powerpc/platforms/cell/spufs/coredump.c | 183 ---------------------------
 arch/powerpc/platforms/cell/spufs/file.c     | 114 -----------------
 arch/powerpc/platforms/cell/spufs/spufs.h    |  12 --
 arch/powerpc/platforms/cell/spufs/syscalls.c |   4 -
 fs/binfmt_elf.c                              |   4 +-
 fs/coredump.c                                |   5 -
 12 files changed, 2 insertions(+), 352 deletions(-)
---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260826-work-spufs-coredump-4e14ce185587


