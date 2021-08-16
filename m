Return-Path: <SRS0=Fnpn=NH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B67C4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 08:26:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B6A61A0A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 08:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53B6A61A0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gp6gx0JPmz3dCY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Aug 2021 18:26:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=czsVNgGx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=czsVNgGx; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gp6ds1j3Sz30RV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 18:24:33 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id
 n13-20020a17090a4e0d00b0017946980d8dso12151231pjh.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0/BQ5I59R5DvReXc9OPs6E0JDRNhr4UM8x2hWwNF/QE=;
 b=czsVNgGxtJ66p3SWs9L8qRacGPoxa3qns0K9P/5IErUUaw6RnGyatJgbpxr6aCdLRk
 Wb5z2ro45aF2X7x3iJrFt7Jh5VSiXiG19Odp/Iq5+ZSlOaeCTpPcRoFl/w3Ahu/jo3yK
 JJJG3B2ukq5kQfVSufycB+EhuO4DEceIk172+G3IalMZd587+E1jGt9qxFZQOjn8XSvF
 po3SsZHSqEMtHMvCVQ7Dot/W1XwexCfAuwOdmcg4TYlJGgmahMczZIdHw4sEOAlcP+ad
 6VRwM1B/I7GrerrdEo2jI2sJKXRguL+Jyfkg7N/i+zTpcr895VqCQ1ZZMAobbj0cSRlj
 Xl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0/BQ5I59R5DvReXc9OPs6E0JDRNhr4UM8x2hWwNF/QE=;
 b=ohN0Virpu25Id4XVak1zw2ps5Oz8ykbiN3MzcFcDvUbRqzto0d6YUgoOFTzby/tdcK
 vTKagxo2H/8YLzaaBLV4nT3fwguu71HA14i5gKqs2VipUsUXsWOU6n6grp3GP5ZV35gA
 YwkrDhxWy2JfPSU/TRbncCWCKAWgP3u4jbyxdzC3iGNdEhQNxVU20d6Q0euW6wWuQiHC
 XywBUur3xCWV2GG86k2yX45i2qyevqmD0m+cl/sJssjy0D02V2RV+IraCOvqiFNETjh1
 aePSPGNw5TisA6bP9obuHWouyhdUJUY9ax8QKyohTiOAiiER7nLb6Nfmcj+2niwoJU91
 TCVA==
X-Gm-Message-State: AOAM532fnm8jBt/uIMdwAsokQvKEc4cpbRdcMzldFZCOYfW8VhJHW53l
 rpa196o1aXmOv0Chvq3SoZk=
X-Google-Smtp-Source: ABdhPJxeoN3QyUpeWCld+aS4ckIZiPENGZSjmvs3wspn4a6QUXz3wLdpxgoYckhvdoxRe6D47xi6OQ==
X-Received: by 2002:a17:90a:f10:: with SMTP id
 16mr15821535pjy.80.1629102270769; 
 Mon, 16 Aug 2021 01:24:30 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id u24sm10542358pfm.85.2021.08.16.01.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 01:24:30 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: Fix undefined static key
Date: Mon, 16 Aug 2021 17:54:02 +0930
Message-Id: <20210816082403.2293846-3-joel@jms.id.au>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816082403.2293846-1-joel@jms.id.au>
References: <20210816082403.2293846-1-joel@jms.id.au>
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When CONFIG_PPC_BARRIER_NOSPEC=n, security.c is not built leading to a
missing definition of uaccess_flush_key.

  LD      vmlinux.o
  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.kallsyms1
powerpc64le-linux-gnu-ld: arch/powerpc/kernel/align.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
powerpc64le-linux-gnu-ld: arch/powerpc/kernel/signal_64.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
powerpc64le-linux-gnu-ld: arch/powerpc/kernel/process.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
powerpc64le-linux-gnu-ld: arch/powerpc/kernel/traps.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
powerpc64le-linux-gnu-ld: arch/powerpc/kernel/hw_breakpoint_constraints.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
powerpc64le-linux-gnu-ld: arch/powerpc/kernel/ptrace/ptrace.o:(.toc+0x0): more undefined references to `uaccess_flush_key' follow
make[1]: *** [Makefile:1176: vmlinux] Error 1

Hack one in to fix the build.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/security_features.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 792eefaf230b..46ade7927a4c 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -39,6 +39,9 @@ static inline bool security_ftr_enabled(u64 feature)
 	return !!(powerpc_security_features & feature);
 }
 
+#ifndef CONFIG_PPC_BARRIER_NOSPEC
+DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
+#endif
 
 // Features indicating support for Spectre/Meltdown mitigations
 
-- 
2.32.0

