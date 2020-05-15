Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F34C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 08:02:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ED8205CB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 08:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+xe4df9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ED8205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NgqC19HjzDr34
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 18:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::243;
 helo=mail-oi1-x243.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=t+xe4df9; dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Ngmy0PLrzDq6J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 18:00:01 +1000 (AEST)
Received: by mail-oi1-x243.google.com with SMTP id j145so1471569oib.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3emby2X6CS/NwXVimnw4ZCuF10da/AJemyogu7DSwtQ=;
 b=t+xe4df9iTk581/Dn3YbV0ABZnVoEdYJ5XDw0ohZ5J3HMGEDlXWuCkGfSEe/YOeo/3
 ET/Bv1qOxzCKB00gE3l9trOiFkyctK7RvfNUHeVrjsGfJe5PlyK3QKy4a7xaKk5WS1ua
 G/ymCwbkxGO2Ajf7K9L4hcWBrZOMtpknxVW0phZPpDvqfFQjvpBuypJreJcwMMDUQtvu
 cKNm3WFHguu/CYBYjF9Ylet4wWlogFzMMZQal6L3/OHmulkMBAqTyf133DatPWHVMgl5
 AeLp9sIQvDvRd6Ya0TWRnYS7DD7g4RxMAoCUiI2p9MM4H5qeYpoDNXtq6fjQ0fCImZjK
 zwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3emby2X6CS/NwXVimnw4ZCuF10da/AJemyogu7DSwtQ=;
 b=Hu1dkB5G+sTs7FvZH9IdJhN4RySsYfhvT2ORoVXjgnGm4k1YIJWFXa7RmG44v8tlpO
 tQRMAqdtesa9Td7LDZi+dTbSeBUsm8XzE21nDo+UoUMXOZAD8OI6GDP2wwr1UaCLMtcG
 KfuOdnoQPRtr9AUrZm8b4jPJwX28hWk+MlV1p1NH5JJbCT2ytZ6PBfL9A4BJ0o4RF8Fg
 5TsOMnb62jwJQojBSv2Wc2CMt1ajl3viopkfe8zCUHIikF4+WkosDSmKVYVY6lRrvSvp
 E9MxJJGAGH3QwrVzzHygWsV6stKp8DDYFlKVkGAOzJQggskVBGzvXh1iocRXn/NGFufT
 Fiag==
X-Gm-Message-State: AOAM531StrsuLkavzqHm1GWxw4AdmXE3ucAFEqs107pt4s5Jx/q9GgoF
 ljv+wf3C5WVDJzJKamzeNte5nsxRWywORJafTl+S7+r9vuQ=
X-Google-Smtp-Source: ABdhPJyrR8mKQU59UWhxf8Cb0xcg0eF+jWlZw2tXpNhHAgv2XybqFXKUlX8bJxgm1QC9sI0TVRgt1NWOKVRQmYBbkPo=
X-Received: by 2002:aca:40c2:: with SMTP id n185mr443462oia.12.1589529599299; 
 Fri, 15 May 2020 00:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-30-jniethe5@gmail.com>
In-Reply-To: <20200506034050.24806-30-jniethe5@gmail.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Fri, 15 May 2020 17:59:48 +1000
Message-ID: <CACzsE9quvOQ6RAKzz7j7MtFhx-Ppp6=huUT88EFbri2mezxLbw@mail.gmail.com>
Subject: Re: [PATCH v8 29/30] powerpc sstep: Add support for prefixed
 load/stores
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Alistair Popple <alistair@popple.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Balamuruhan S <bala24@linux.ibm.com>, naveen.n.rao@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

mpe, and this thanks.
----
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1204,7 +1204,7 @@ int analyse_instr(struct instruction_op *op,
const struct pt_regs *regs,
           struct ppc_inst instr)
 {
     unsigned int opcode, ra, rb, rc, rd, spr, u;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
     unsigned int suffixopcode, prefixtype, prefix_r;
 #endif
     unsigned long int imm;
@@ -2701,7 +2701,7 @@ int analyse_instr(struct instruction_op *op,
const struct pt_regs *regs,
         op->reg = rd;
         op->val = regs->gpr[rd];

-        suffixopcode = suffix >> 26;
+        suffixopcode = get_op(suffix);
         prefixtype = (word >> 24) & 0x3;
         switch (prefixtype) {
         case 0: /* Type 00  Eight-Byte Load/Store */
-- 
2.17.1
