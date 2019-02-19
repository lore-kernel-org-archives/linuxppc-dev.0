Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B84C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:39:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754932070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NnQW0XgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754932070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443nz63x5SzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:38:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="NnQW0XgR"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443nml4787zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 04:29:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 443nmd1dZYz9v4Xw;
 Tue, 19 Feb 2019 18:29:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=NnQW0XgR; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EaSlZ81YLnXM; Tue, 19 Feb 2019 18:29:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 443nmd0XnBz9v4Xq;
 Tue, 19 Feb 2019 18:29:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550597393; bh=JDX4ghw6W53VNRmmthi2b+LTC9thBazhGLY7hWTsvAQ=;
 h=From:Subject:To:Cc:Date:From;
 b=NnQW0XgRYWFT1fioA/mRYm5A67W6ulb8s0wWSWtkD699gRWR+xOHuQKezK+rjsW6z
 nTU8LoyWmMiFPM1vc6BP13GaexZoDxqLSaaVOK4pwpXQlqgw3S4n/krQ8ktrF55XOh
 eSViN8ePCtU2zoUa1psj12UgWeN6nggir7zuK+1o=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B6CDE8B7FE;
 Tue, 19 Feb 2019 18:29:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OdmHD8SHAD9F; Tue, 19 Feb 2019 18:29:54 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CCD18B7F9;
 Tue, 19 Feb 2019 18:29:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 70CD66E81D; Tue, 19 Feb 2019 17:29:54 +0000 (UTC)
Message-Id: <cover.1550597162.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC WIP PATCH 0/3] Your series rebased
To: Daniel Axtens <dja@axtens.net>
Date: Tue, 19 Feb 2019 17:29:54 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

Find here your series rebased on my v6. No test done, not even compiled.

Christophe

Christophe Leroy (3):
  kasan: do not open-code addr_has_shadow
  kasan: allow architectures to manage the memory-to-shadow mapping
  powerpc: KASAN for 64bit Book3E

 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/Makefile                        |  2 +
 arch/powerpc/include/asm/kasan.h             | 56 +++++++++++++++++++++++++++-
 arch/powerpc/mm/Makefile                     |  2 +
 arch/powerpc/mm/kasan/Makefile               |  1 +
 arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 51 +++++++++++++++++++++++++
 include/linux/kasan.h                        |  2 +
 mm/kasan/generic.c                           |  3 +-
 mm/kasan/generic_report.c                    |  2 +-
 mm/kasan/kasan.h                             |  6 ++-
 mm/kasan/report.c                            |  6 +--
 mm/kasan/tags.c                              |  3 +-
 12 files changed, 125 insertions(+), 10 deletions(-)
 create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c

-- 
2.13.3

