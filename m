Return-Path: <linuxppc-dev+bounces-26464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED959C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 07:51:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbBcp0zZGz2yrf;
	Thu, 03 Sep 2026 17:51:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788421897;
	cv=none; b=cdvcqkiz0Fg2HAVjSuqY4vt54a5oNow8PyXinWIgs7wZ7XdblQbrsfoLofoZjhHlNdHZVeNOZ1dH92BsALi4/M2J2vLrZ1IoY0mUTXLO0Z7Qf3BUK2KZ/oZTnKhb3/HHEwLXJTTSmpdpt/yq7zcapYGJGjFHjaf8D9vgUXxhZ8AvxTwa3PzXQe7MlBfUR/ymn4KyOeO4MbUTmhwO66DbYyEagWvOwZ7D7jaXRixklSCGI4yye+1xCjJ/cyXT4HmbNxjLCucjekmwRbQd9Qa7T73kJgJpoMxt/gmtbZg8XLsedCKPUvjyCafENY7bSWyRESq8yRd0aNX9lA13CBPyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788421897; c=relaxed/relaxed;
	bh=5KW4JSiXbH9maSfkULvZaqX7CoVimn1QeXod/ruf3No=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FH1J/stc1IDl47/4g0A54Wx9D3TYhU7JmoKQcJ9jNJkepV6lG5aftgSFnR/zkzjNIDbWES7lZztZX3lkhttRzGi9htNt20ew2AUiIZZI4BgL5Djugrl0iv3ABpRifh5Pl0Q1Z9Z8nFt1XILfcFSBaCjyOKOAgXUxVpMlDZ0ZN1YvHuHMQ+C6+KkVz3v7y6w3hYOd1XTg3l4+HiTS4gyF7QFMeuuznkywgLuMEgQW/CT5hb0AAl2LIIxMfKRZN17oQwPUP2xplWd2N/ipd+c55+yn31/w4ea3ac89FDznmc57fRWAsDYS1d3s8Fo3NZr8Aa/x+jtfIfUPELyVeiANZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sP4GAzlf; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=74b6hxEu; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sP4GAzlf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=74b6hxEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 603 seconds by postgrey-1.37 at boromir; Thu, 03 Sep 2026 17:51:36 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbBcm0Rwjz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 17:51:35 +1000 (AEST)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KW4JSiXbH9maSfkULvZaqX7CoVimn1QeXod/ruf3No=;
	b=sP4GAzlfiwyJ8SlAiXB9hhGatHqYn5Vcn3KyodxJkAO1wj/PHMlbdW77kFZude743RnLhd
	B5QZwXUkCLLV6Wvnob5GUovY1H43zZVNWtGF5UOAyDtw0h84ySpzYI64iVVJEIHvicRsJY
	pD1ld4DRhtbdgnX9NNClO75WOFLSWKxzBq3iHywNs/5YkMjYPN/hkHQCvUYgFe8rIWuTxq
	ufYRd2Yn9ZInjWVURzxboS8uymqnHI7MPJc3Ye+zTbYZ7DuMs5zMOjmE9Qpb0t7EMovaQc
	99zQAQl51CjfPmTlBPFogtZ+kwL7ycovS8bv8r+JCiyjj17qoIK0POFSFj9veQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5KW4JSiXbH9maSfkULvZaqX7CoVimn1QeXod/ruf3No=;
	b=74b6hxEuHiaYbO16J3R8hRN+sLyi/sfMIBBYDtJQpn5U/qxoOZMHYwATNk199oaBFFJwuk
	Q6njN3w1wiL/mPDw==
Subject: [PATCH v2 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Date: Thu, 03 Sep 2026 09:41:15 +0200
Message-Id: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZhpSQi48h6GRSlTmcQU05YGJ
 dzdiluX7yfv/Q0iB+EIl2qDwFmizL6APlVgJ+PvjDIWBk26IUUdmoSZbZoDRnkzmmAnbJic5s6
 5dmigmM/ATtajeusLTxKL8DpOsvquv15N+m8vKyQ0SjmqB6Otaa8P8UsKs5f1PDL0+75/AAd6e
 Um6AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=3129;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3s3XptoE1X5UpOSAIz59e0R0lZLIvWXcerejp7RbE+E=;
 b=XVy2EwXriKXi49fdKmjGDzcDgmWqDqa4Nz8coc0Bonz8f2R5uqRepUP5lWAxCUStMn+bsNf9+
 GanZj2c8Z3BAevBQ7Rcfu7kM1Xymj/tUjcr033fxv07isChfPk+ufoG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to kernel-internal headers.

Meant to be applied through the asm-generic or execve tree.
The default recipient list was huge. I trimmed it to only the
architecture lists.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
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
base-commit: 2698961599195990117a0fa240118ecf2f8e7453
change-id: 20260109-at-vector-size-arch-6e0f2e9ff8b6

Best regards,
--  
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


