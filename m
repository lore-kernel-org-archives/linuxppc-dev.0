Return-Path: <linuxppc-dev+bounces-17497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4BED58E7A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 07:59:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPWXg0FwNz3btS;
	Mon, 02 Mar 2026 18:58:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772438338;
	cv=none; b=U9uz6IWU3JJ9qTJuWR2xmsgYNc5zZ0rUz78wvkstcsD78DGQpgF5BztB4vq5N2jD0ooPc2+q5TXGnrdd5xcWpR+TsQB9wEVQqxZySu5Fm8882MFF0YjoTWFysCCdt3Rutbtp7HplkvqBgKHLBVuEfgXpXv3tCM33y487BK5/Tzb9fFGGuhPjPCGPwljnc7elURAvSlQ/A+qVW9nkLbCxmdRChdzQOvohe19UhZOWZ93Xai/znVLTguOWegAsw8Tnqg17fAAByTrRX8HNhz94XHUebUe0I2AWCj5FeyWFVGCkAM9riqM5K0MVSNXcEmoEQ0dOGlrG/bnHqvKiHAoBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772438338; c=relaxed/relaxed;
	bh=UF10sktaE3a/u60QuU3fU7HqMA3bwXEWu54Wnq4Vn5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEi4T3dYzd2KYZ+U4c9DH+lbEPBeUuY6u3jGMw0Y4hnZ+BjB2LbcuQVcdbz1f7mumrqs16vsaXenUrDVqNa/P+Q4Cy6Xea6XDl0pjMv7r3ZNA6ejwxVOOYH/3E8/3pMmxNzD0L3vAh7ywS+VAQVZ4E3K6+sHDUWc0+YgG/mwtT2OFapE3Qmld5wQJ+nl7+eIJ1oscxYjK1fXehXkUvbvQjuHUhqvFW8fpY33l9UnkQPnQKs5FkYc5RVVmStLoJZ7nINf6Rz5HVciALWua0NZwPkwu5jRECNZ0fgS8WG6HIEvCexoXfmOFsF3Bqf9osviCSmllDZ63OYjow42KWSpRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ciydefi2; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/oOqZJOd; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ciydefi2;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/oOqZJOd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPWXc4zqPz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 18:58:56 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772438331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF10sktaE3a/u60QuU3fU7HqMA3bwXEWu54Wnq4Vn5g=;
	b=ciydefi2+IGpGjxuJ8S0Pi+V3OE2L2KTESiiSpFlWMdULYcmkYxxE1PJyxSZo34YX9HCvC
	otxxjHp2oFTPL9j9x3qD59f3ZnvENSKPwzlcjDF9gwOAoWjmGg+Kl2GOzjsuuqOkUN8EFR
	MpaBg4Wm8BR5LSNmS/vo72/wV/m8ujzC+zXJsxM/E5eHSDwg5a+SCYVX5LcbFGs9WLZx1o
	IqabJtHg5sn7IO0PwbjNhXU3mLreIj2ehewv2aXyfQnB+vS6/6g72GHvLiu7IUXCA2Dns3
	jj6Qctvz2ySNMQjcEbRkObXtPQ32W4ozS6FFjJEQYmO4+ZGx86/y86p5sT36/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772438331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UF10sktaE3a/u60QuU3fU7HqMA3bwXEWu54Wnq4Vn5g=;
	b=/oOqZJOd60lffdI+2m/cDGB+gvLeO1GfCoV5HvJr4+3CHFqEyKt8w0Em37WkJfh2QW+Rxk
	lrrT3Gblc0IA2uBg==
Date: Mon, 02 Mar 2026 08:58:39 +0100
Subject: [PATCH v2 3/5] s390: Add -m64 to KBUILD_CPPFLAGS
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
Message-Id: <20260302-vdso-compat-checkflags-v2-3-78e55baa58ba@linutronix.de>
References: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
In-Reply-To: <20260302-vdso-compat-checkflags-v2-0-78e55baa58ba@linutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 David Laight <david.laight.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772438327; l=1115;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BTq+tG721IWvmNZKRhmYuiBTJvXYohTSP94/jYKFkyc=;
 b=sX+mpo7qFfoRgBke0bz6zAxXtqo1MhErKWEmsMFk1R+7DQ6DdvNT3JOeYuQjWk75pK4XrWWHX
 /ugF1GYyl71DtJ1gQ0FcfcZ9SjFd/F4MkzoR7GPOsO1elfICLhEYH+T
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some non-code files, like linkescripts, are preprocessed with the C
preprocessor and make use of regular kernel headers.
As -m64 is not passed to those preprocessor invocations this leads
to an inconsistency between __BITS_PER_LONG and the C type 'long'.
An upcoming consistency check will be tripped by this.

Make sure -m64 is also defined for those preprocessing steps.

As KBUILD_CPPFLAGS is inherited by both KBUILD_AFLAGS and KBUILD_CFLAGS,
drop -m64 from these variables.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index d78ad6885ca2..02bc948a4a56 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -12,8 +12,7 @@ LD_BFD		:= elf64-s390
 KBUILD_LDFLAGS	:= -m elf64_s390
 KBUILD_AFLAGS_MODULE += -fPIC
 KBUILD_CFLAGS_MODULE += -fPIC
-KBUILD_AFLAGS	+= -m64
-KBUILD_CFLAGS	+= -m64
+KBUILD_CPPFLAGS	+= -m64
 KBUILD_CFLAGS	+= -fPIC
 LDFLAGS_vmlinux	:= $(call ld-option,-no-pie)
 extra_tools	:= relocs

-- 
2.53.0


