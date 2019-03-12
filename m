Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B39C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:25:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB40214AF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 01:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="PeDsZPvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB40214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JHNg0pxBzDqFM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 12:25:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="PeDsZPvS"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JHLg3DpszDqDr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:24:08 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id r124so508256pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FmK5X23/h5mAYC9jtCtr64U65eKHiWBV32QbvgbCF70=;
 b=PeDsZPvSzstzNRZb+SW6WJzrduwf7fPDNepjN0Ew0wHf+Rf7MLMOYqfTHaP8jIRAWd
 Wx0a7dV7oRgFY8t4eVz9TqTS/gxZ6zQ8vtPxOeBlJ1qp9FeFhVTMmoDgNFCur5qmY9FL
 fDfSDlPfovxhRIku/qie/ejGfQ89pp650b7QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FmK5X23/h5mAYC9jtCtr64U65eKHiWBV32QbvgbCF70=;
 b=aUJo0aji1Gl3QQN5kuDbQwAjAvXPyyFTbye69LOXBtcujb2hHkPayd3VJmV9cqn2Lf
 Zu/JlRRvOJhwqlHEYlWrz4fo3Kgy1lvVXcSmY4n/rz8n7O90ceh17+O3QSPMxSAXDcaf
 TtKYdxvlEaSvgNnQvqIIG6xMUjtqBgj+KE3YCjW+I6b8L+9OAdD3mN5saN494U9Hn5Pj
 EcT9nEnfFuc2/h4XFUEx1DpFyE8JETv7XkiBm7yLKCNRaVkh0LxQaYHvnUAN6dezSN6B
 gXULGnjMa8DPeLfkauYtmU0dA1H48+AcgxE5GvFeFEDyq5FVgbQMAv+9gG5nEIBxNt2A
 TTvg==
X-Gm-Message-State: APjAAAXDtQisbdeGhSbI1f/UjlPrcTr5p+1CyWWAKTWFrkRVGU6L/hEO
 tnSoRBPCDcgProNeHZNnnnOkyA==
X-Google-Smtp-Source: APXvYqzCKcZsXFc134asCsJaa+E3uL68ATkI+UPLXa9BrnrYO8pgiKXaE0xGJx0PR1wuSK6yc2kP1A==
X-Received: by 2002:a65:48c1:: with SMTP id o1mr10530019pgs.94.1552353846217; 
 Mon, 11 Mar 2019 18:24:06 -0700 (PDT)
Received: from localhost (124-171-102-1.dyn.iinet.net.au. [124.171.102.1])
 by smtp.gmail.com with ESMTPSA id t185sm10890847pfd.165.2019.03.11.18.24.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Mar 2019 18:24:05 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: aneesh.kumar@linux.ibm.com, christophe.leroy@c-s.fr, bsingharora@gmail.com
Subject: [RFCv2 PATCH 0/4] powerpc: KASAN for 64-bit Book3E
Date: Tue, 12 Mar 2019 12:23:44 +1100
Message-Id: <20190312012348.4854-1-dja@axtens.net>
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
hashed page table. It applies on top of Christophe's series, v9, plus
the proposed new version of patch 2.

It requires some changes to the KASAN core; we use the less ugly
outline readiness check patch proposed by Christophe.

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

While useful if you have an Book3E device, this is mostly intended as
a warm-up exercise for reviving Aneesh's series for book3s hash. I
expect that the changes to the KASAN core will be required for that
too, but I'll check against the book3s version before I send a non-RFC
version. Once I do that I'll revisit the vmemmap decision as well.

Changes from RFCv1:

 - Use Christophe's new version of outline readiness check
 
 - Rebase on top of Christophe's v9 + the proposed changes to
   string/memory functions

Regards,
Daniel

Daniel Axtens (4):
  kasan: do not open-code addr_has_shadow
  kasan: allow architectures to manage the memory-to-shadow mapping
  kasan: allow architectures to provide an outline readiness check
  powerpc: KASAN for 64bit Book3E

 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/Kconfig.debug                   |  2 +-
 arch/powerpc/include/asm/kasan.h             | 73 +++++++++++++++++++-
 arch/powerpc/mm/Makefile                     |  2 +
 arch/powerpc/mm/kasan/Makefile               |  1 +
 arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 53 ++++++++++++++
 include/linux/kasan.h                        |  6 ++
 mm/kasan/generic.c                           |  6 +-
 mm/kasan/generic_report.c                    |  2 +-
 mm/kasan/kasan.h                             |  6 +-
 mm/kasan/report.c                            |  6 +-
 mm/kasan/tags.c                              |  3 +-
 12 files changed, 149 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c

-- 
2.19.1

