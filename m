Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AD5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:06:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB572083E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="BrXxIle5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB572083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440tpm586YzDqLy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:06:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="BrXxIle5"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440tml4y79zDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:04:54 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id m2so1635934pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aJtgJKULdVQyTQeyjVq7d0hsODUhMoYLlmrHlz0YnH8=;
 b=BrXxIle5Og6nSnCvQHDAnorMIVbw44YwMysQ1uvda0HadJNFv36be2NEE2oIjOJyK8
 /rfEEbDpB8jDzDkxoSkCILDZt6/gZE6K7z10ZafI9V3v4YGk3XjqpkvdT9YL7UpgNz7A
 Jz4UfWNO3NNK3xUKN+ABx9u/3dEZZdrI2bixI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aJtgJKULdVQyTQeyjVq7d0hsODUhMoYLlmrHlz0YnH8=;
 b=ZusG4R3H3UGESyzXShjdvIK9tNrTxwtSaCIOuQdCuWUpdAeewBMdlwZd06mvqv+SLf
 gE2Xs5+euKA1JXjazudhrveB/aLFKHiz4Y7OL6Z/Ceu+q8kuqN0S1iKK4RaxyzdCM/IZ
 oL7n48QVfhX9034vQ0P0nog2JuZ54Sz20eS1AS0i44R3TtDUgS9uGFtotdT8y5HvD+Fw
 LA3MYiff6QixH/3Cb5kxXx33UlxRA1RrWarlMl9c3BJCx0TTgIDIt4/pnOH/TOdGJ3bj
 ekQj4erJMTdjU1mwelFl+oqCuVECQtRS8nxfnvHER7RhaJJKt4PS9oZv4Eop6vw9mg8s
 g52w==
X-Gm-Message-State: AHQUAub8oAB23hh7d+EEjYQjKkPt2Et5YU6/+5kh9PH03wwLlhlfSiQS
 nhlDV1it5a0T1fBXkDclOajMIw==
X-Google-Smtp-Source: AHgI3IYFclTpg1yUCvZCrGeSX4bqNFXbsCrjVRHckNgA5vkqcvQZmANeGE2ZGV7FFa42xv/Oula+Jw==
X-Received: by 2002:a63:fa58:: with SMTP id g24mr2497932pgk.390.1550189092401; 
 Thu, 14 Feb 2019 16:04:52 -0800 (PST)
Received: from localhost (124-171-165-212.dyn.iinet.net.au. [124.171.165.212])
 by smtp.gmail.com with ESMTPSA id
 c4sm9195580pfm.151.2019.02.14.16.04.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:04:51 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFC PATCH 0/5] powerpc: KASAN for 64-bit Book3E
Date: Fri, 15 Feb 2019 11:04:36 +1100
Message-Id: <20190215000441.14323-1-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to the e6500, a 64-bit Book3E processor which doesn't have a
hashed page table. It applies on top of Christophe's series, v5.

It requires some changes to the KASAN core - please let me know if
these are problematic and we see if an alternative approach is
possible.

The KASAN shadow area is mapped into vmemmap space:
0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
To do this we require that vmemmap be disabled. (This is the default
in the kernel config that QorIQ provides for the machine in their
SDK anyway - they use flat memory.)

Only outline instrumentation is supported and only KASAN_MINIMAL works.
Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
ioremap areas (also in 0x800...) are all mapped to a zero page. As
with the Book3S hash series, this requires overriding the memory <->
shadow mapping.

Also, as with both previous 64-bit series, early instrumentation is not
supported.

KVM, kexec and xmon have not been tested.

Thanks to those who have done the heavy lifting over the past several years:
 - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
 - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
 - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/

While useful if you have an Book3E device, this is mostly intended
as a warm-up exercise for reviving Aneesh's series for book3s hash.
In particular, changes to the kasan core are going to be required
for hash and radix as well.

Regards,
Daniel

Daniel Axtens (5):
  kasan: do not open-code addr_has_shadow
  kasan: allow architectures to manage the memory-to-shadow mapping
  kasan: allow architectures to provide an outline readiness check
  powerpc: move KASAN into its own subdirectory
  powerpc: KASAN for 64bit Book3E

 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/Makefile                         |  2 +
 arch/powerpc/include/asm/kasan.h              | 77 +++++++++++++++++--
 arch/powerpc/include/asm/ppc_asm.h            |  7 ++
 arch/powerpc/include/asm/string.h             |  7 +-
 arch/powerpc/lib/mem_64.S                     |  6 +-
 arch/powerpc/lib/memcmp_64.S                  |  5 +-
 arch/powerpc/lib/memcpy_64.S                  |  3 +-
 arch/powerpc/lib/string.S                     | 15 ++--
 arch/powerpc/mm/Makefile                      |  4 +-
 arch/powerpc/mm/kasan/Makefile                |  6 ++
 .../{kasan_init.c => kasan/kasan_init_32.c}   |  0
 arch/powerpc/mm/kasan/kasan_init_book3e_64.c  | 53 +++++++++++++
 arch/powerpc/purgatory/Makefile               |  3 +
 arch/powerpc/xmon/Makefile                    |  1 +
 include/linux/kasan.h                         |  6 ++
 mm/kasan/generic.c                            |  5 +-
 mm/kasan/generic_report.c                     |  2 +-
 mm/kasan/kasan.h                              |  6 +-
 mm/kasan/report.c                             |  6 +-
 mm/kasan/tags.c                               |  3 +-
 21 files changed, 188 insertions(+), 30 deletions(-)
 create mode 100644 arch/powerpc/mm/kasan/Makefile
 rename arch/powerpc/mm/{kasan_init.c => kasan/kasan_init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c

-- 
2.19.1

