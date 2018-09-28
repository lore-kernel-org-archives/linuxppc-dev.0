Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D9C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 16:03:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4DC20657
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYFXxDjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4DC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MGgQ3RvBzF3G0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 02:03:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qYFXxDjE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qYFXxDjE"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MGcj4w5szF3G0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 02:01:09 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id c10-v6so4790526pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=DYD2J8baFTy1b5NmBRkCW2NywtBh2itoU2wDcfk+wpw=;
 b=qYFXxDjEreDdda3gSF7OiRBXB5uG1EjrkfZ9NybK/l1q6kjqsMY2KqCvrfHcmUNmJS
 giSCv3+9swgXLPCaCatbtV7s1QGzPQKxi9OprhnQSRfLSQ/Gfod7+/nmGG39mT94sR17
 JgAuD4WZsBl2FGKFECCXy4GUaOniX/4e/fFqCEzLoYF0PANq5R2meFhi+Q6sdYrW0XMV
 75mVB1JZRpRJpGDxZTD1wcuVgsxMkaFRvFxUlRyz9er5w6NVk1FTxHtDMDAvN4DWMp+4
 ombAG40k0r4t8BNCodwaRafvzicN9Pb9o43whjL6cTnTltkWKx+uJpB9+C1TcTwoxnhM
 2Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DYD2J8baFTy1b5NmBRkCW2NywtBh2itoU2wDcfk+wpw=;
 b=R2VMDot/SfJLac/H4PvNpgkBQqYWrl5XI80Rwny/HVvdkIPUzBhjs0HRZiNrEkHgck
 REgYaBN7qqHVCE9OufJHmpRT72q8zVYgJ8Zis14LcswivYUChHBj8sSmvwbnGclHEAB5
 HyX8w6BPKiH1hNlGAZsxNvKMtblW20pG3TVaGcWGz8aFmNOlWn1UZ41g1SodWDqzvq/G
 2s6JNVh+WGCsLEpByyB0iOicn+ANky/g+/SjZ18hgv+g9JhAIlmP/aCFiLPbrWE7Da8q
 LVIrI3gRrGU/xunXpkQBEPClGFZc4sg4Hb7zF+Vv+olw/OEtTrlKIvEYdewehLRc6M7v
 ax7g==
X-Gm-Message-State: ABuFfojI+H7FF8pddwZ+DnVV4uvY1xq+PScv7K5i6M+bGvbFadFjFZCv
 1vNM0xUvaWt7YXWuCAjvhkCeksMM
X-Google-Smtp-Source: ACcGV62eFTp5B2GnwNZg2KHbJBmrpCmM5ge9mt6QbTGW7xr6ktAOoM5h2dGmmQL8WtcytDcIw2q8mQ==
X-Received: by 2002:a17:902:9696:: with SMTP id
 n22-v6mr17223887plp.212.1538150466143; 
 Fri, 28 Sep 2018 09:01:06 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id u79-v6sm11969725pfd.117.2018.09.28.09.01.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 09:01:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] Fixes for SLB to C series
Date: Sat, 29 Sep 2018 02:00:54 +1000
Message-Id: <20180928160058.18700-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These are some fixes I've got so far to sovle hangs and multi hits
particularly on P8 with 256MB segments (but can also be reproduced
on P9).

I'm not yet sure these solve all the problems, and they need some
good review and testing. So far they have been solid for me.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/64: add struct int_regs to save additional registers on stack
  powerpc/64: interrupts save PPR on stack rather than thread_struct
  powerpc/64s/hash: Fix preloading of SLB entries
  powerpc/64s/hash: add more barriers for slb preloading

 arch/powerpc/include/asm/exception-64s.h |  9 ++--
 arch/powerpc/include/asm/processor.h     | 12 +++---
 arch/powerpc/include/asm/ptrace.h        | 18 +++++---
 arch/powerpc/kernel/asm-offsets.c        | 23 ++++++----
 arch/powerpc/kernel/entry_64.S           | 15 +++----
 arch/powerpc/kernel/process.c            | 54 ++++++++++++------------
 arch/powerpc/kernel/ptrace.c             |  4 +-
 arch/powerpc/kernel/stacktrace.c         |  2 +-
 arch/powerpc/mm/slb.c                    | 48 ++++++++++++++++++---
 9 files changed, 116 insertions(+), 69 deletions(-)

-- 
2.18.0

