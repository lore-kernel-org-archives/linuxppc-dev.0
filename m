Return-Path: <linuxppc-dev+bounces-23641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E6DC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 16:38:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv96J0GLYz3bps;
	Tue, 07 Jul 2026 02:38:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783355927;
	cv=none; b=K7IwoSfDndU9YNqYMMNCOmFTqT76wf+YlPOvyjUk7uKY2UFoL2D2Fbnb30OL11BurjRApEGPuLtRlaRie8wy7gSvowyaeKi8cDc3crppL3f5p+gE8+IuYhTHwT5GFcFMPTpsrOwihb5fz8nxDgSZSImSKrKx/duQIIjhuMyn30WbKWw2F6yiLAz5HBs8Rp6Y71Qbts/DVqJ6jLZYiyW626m0zehiVt2yBJKZVADDg6mp9Lw88EIZCnVS78Dk6TOu4DdmeVFtOJqi1eIZpbiBH8DbNZQFQSQfhv4p1iKIwGr807SrMg5ZltqiLzcAA+vPaRZRL4oqjhh/KQIo3kbD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783355927; c=relaxed/relaxed;
	bh=q3YBRTaja8Io8T+OBzHFe+6+gYpexbpRi1HdwVacSuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXO8/9NWo3oJ2kdE6si2kZTwHh87Yyt6fkHq+4/5HtYigqbz1OM1IP2/p364bPHB+wWA8R2tXfj9T97HH56XrEQPv4Rzamh+I0+Nl81lvxfLPJVRqVZB5B7cNLbe1GaaGdYWrEdP0lDG4HKNITfSAY3RE1A0TwioCugbqrahD8dpSCf/3quBCLJCdKJlCwR/VEphFWe/7IzY7+pvHsz+cfgH4+MlLpFSPuhQDShKJawrvwYLp6RSL6bKI2tGiPqUAY57lQjRPOcJKP9XTfkc8yGsqVzvFQ6CtqiO+t5mK6d9nT+AzPVfe8Z+FNX3F9A4Gy7e8kD6QRzkxb4rKuAYYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=myCqSuKh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=myCqSuKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv96G2fZHz3bby
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 02:38:45 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2cacb8416a1so26395015ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355923; x=1783960723; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3YBRTaja8Io8T+OBzHFe+6+gYpexbpRi1HdwVacSuQ=;
        b=myCqSuKhQ6u5NeKnJvTpxIa1ccPo1GX8hS+4iX7GfcOrIc28QbU2YM+E698496dARA
         7+TUMfS02pSyTKZxdWFfWBVahBTfrLGKVG2h9dcMnHPXH15HHdlSr1V4Rb2i9ZPlwq3w
         6i2S9Gy8DwGg19U1HhlJMllHJXV1tuDmM2e0htNyzgmRdt3GLx+tQZr5pkfxvdhY704U
         YtfdSmL/JWeWmAukZ3zd5DLIlHHRp4w2iZqzFTd+4Q0XW3OCeyBXB024SFV23GHRanCl
         1lbuuRvaYmRBbB7gDn9foqPRPhUybX4WYyher3yqjXRUKKuZvNgNQYOkiagZoGceN0lQ
         gvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355923; x=1783960723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3YBRTaja8Io8T+OBzHFe+6+gYpexbpRi1HdwVacSuQ=;
        b=dLWqqUIoxGxM76pO1RLIWQGHjDkDPY+i1XtYCaa9raYxE5+Ibut3OAIVqTaLqJQ+U5
         fhCbzyoyO0dEFJSW4XHW8c7TJEjLRu1OFAXqsm9pMSGIg295h4rZsYDEBEYVnvvcxgmt
         7PFmLquVOghm/w7CiK0o+C6jF2kZXXpkOPfgHVLoxyq5B62+DJZsopedor5mY0E9me1W
         Yn1brZAhtTokS9ktTJmFSVWvtQRtkxIPJwbFtgyiBVNUb87TeUSEidH5lJTAltP8Nsbm
         kH3c271YzQW1Vf/b7kSpKGVfQmm2jXgWocFvm65H452TQvT14oHmxbVMpdkzVqOFNMze
         7KEA==
X-Forwarded-Encrypted: i=1; AHgh+RoCG/jOk8Tyd0MbWIojLzquBxTfqnrY2qH93iHgTQs4CDrGH0SQ1vgbCj5DjkPdTgLpKzpzLPT8r1rSLDI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1VBj6wwitdlujiyiHHK3lONCfK2Csd2gfH7OHGIELOXVu+Gzd
	DzT2ZZOtGv31sKQ3WZcKjTWT5vStQTEkhmdUwMeQkkQgLHFJ2JgqblDz
X-Gm-Gg: AfdE7cl+cPgyF1AiUzE1a8XTekvDIvRZ4qTO8+Yhe6kM4iPVnpFEVxW2OMejaunGWTq
	Bv4Uj3JHd05vCnUAkBFvZviPdF1sBm7WIPEDxBJruaOjlIk3xtKIWxNDv8Ilb9INhiFZzPxVUhD
	Xs0lbRWMMsUnqD0AnwguVrWRyW4PY7dhQLRquOfVgRDvRBWYlH7ftMsmUdNqhROr0+xznTQu5GV
	DN/6asVhRpqJ7+wM8HYg5mnsUd/eLy2JwNFLUEz0ASG+DVicM2YzNi7UmicdxKeYY1iwwYVXQDR
	CStGszzxiZkVM6qZ3fNMahBUJHV2125UgN/fYbUef6kcAfqtk6vD9ydrF0cF7ZXzFbbn+OOLgwL
	nFN5Y9Gp+jnnA8FWUFhd2shOhn75HOo9qLog+ZbdEIwUs56KZcr74VNnq+TQn4Eg22q0fJxRqol
	akqiG10vQ=
X-Received: by 2002:a17:902:daca:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2ccbe729635mr13347365ad.14.1783355922667;
        Mon, 06 Jul 2026 09:38:42 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893a8dsm53103305ad.73.2026.07.06.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:38:42 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	x86@kernel.org
Subject: [PATCH v2 0/5] treewide: remove unreachable memblock_reserve() return value checks in early boot
Date: Tue,  7 Jul 2026 01:37:48 +0900
Message-ID: <20260706163753.193875-1-ekffu200098@gmail.com>
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

memblock_reserve() can only return an error after memblock_allow_resize()
has been called. Before that it either succeeds or panics, never returning
an error.

Before memblock_allow_resize() is called, the return value checks of
memblock_reserve() are unreachable and can be removed.

All the call sites are in different trees, so I split the change into one
patch per arch/subsystem. The patches are independent and can be applied
separately.

---
Changes from v1 [1]
- add reviewed-by tag
- rebased onto latest memblock for-next

[1] https://lore.kernel.org/all/20260616182959.2429774-1-ekffu200098@gmail.com/
---
Hello Mike,

Like the previous memblock cleanup series, could you review and take this patch series to the memblock tree?

Thank you for taking valuable time.

Best Regards,
Sang-Heon Jeon
---

Sang-Heon Jeon (5):
  x86/setup: remove unreachable memblock_reserve() return value check
  sh: remove unreachable memblock_reserve() return value check
  powerpc/fadump: remove unreachable memblock_reserve() return value
    checks
  xtensa: remove unreachable memblock_reserve() return value checks
  Revert "tpm: do not ignore memblock_reserve return value"

 arch/powerpc/kernel/fadump.c   | 14 +++-----------
 arch/sh/kernel/machine_kexec.c |  7 +------
 arch/x86/kernel/setup.c        |  7 ++-----
 arch/xtensa/kernel/setup.c     | 13 +++++++------
 drivers/firmware/efi/tpm.c     |  7 +------
 5 files changed, 14 insertions(+), 34 deletions(-)

-- 
2.43.0


