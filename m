Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB2C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:48:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074F221479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp7Sr5q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074F221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VJS61vyPzF33P
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 13:48:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zp7Sr5q6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zp7Sr5q6"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VJPB5B50zF13x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 13:45:34 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id d4-v6so1852460pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=SB8E18VCe2hqVZebZluZKwAiwdDumXTWMu+bGyXEi80=;
 b=Zp7Sr5q6iDteIUAUEu6z/SELbWnYWwNk9jgDmgc93iUNYS7VcH6eXB1qQqtZo5TKVw
 KfZ9FDLhkXWlH3LqSkg0QoV8BZfjplLQB30B5XgA40Vb6snhx5kRNa+eh1PAesENh8NN
 K3tRDiIBv+vhrYCWnTUrc4FxC1sGuxkpyeH+Vu+8ff5nuuiMQpr46MYtcEJ7xODfVgfX
 x4ezuMlrfylx0+3ho6V/KU8mZ/JjR4XBeIv2xsL5x+TUwKcoO6TIni8S5cpzOJqAZfOL
 BL4SMyS7X0h7VltRUGF6wFW/PjKSSQ0Zt4/op6rjxa6B4buwj2Y/2k9m95HojGsqey6U
 VA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=SB8E18VCe2hqVZebZluZKwAiwdDumXTWMu+bGyXEi80=;
 b=KNZ/pm1Au9sYLBJ6L33vyE4wRnyrksx9J6inwKOhpUqzKUz86xJ2hjPkbbHmBr30vn
 htHKYmXGzh59OeyXoFXkEaDu6lTTrDm6/VKlCs5s8sLB2oVJFEj2Fk9msYIwoEhTM3a3
 bGndAkGtcKCQEKmAWFjbvStk33dzPsC/ezA/mrKPKlhGtKFgBnHdUcZEX7yhU7r217Ob
 Adc2NzcuwwC62UdhXjWMUPhvkLTjziLvJvxQ8acmpzlGADnyrAJci+S5lUMLLaymYnBN
 pV4cBpYplJWc6DaQEtIuNjBU03AbKViwPY3SCTXpueTo95QLT0/IKRNQC71IKhRFkq67
 zu7g==
X-Gm-Message-State: ABuFfoi2hACXZTOseb0MNonJ0DfZSrC0asz1WL5Y4RakGFI4PyYxHjDy
 qzUw2V57ytmDorMR4okqeg/1AAJf
X-Google-Smtp-Source: ACcGV60vG4xRs2rgVLF6562cMx3li1lp0xUsullkJRct20MQMzEpbjhsTVJg724Gyln7Hzz7BX9CIQ==
X-Received: by 2002:a63:30c8:: with SMTP id
 w191-v6mr27648434pgw.447.1539139532110; 
 Tue, 09 Oct 2018 19:45:32 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id i80-v6sm34812467pfi.87.2018.10.09.19.45.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 19:45:31 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 10 Oct 2018 13:15:25 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc/boot: Build wrapper with optimisations
Date: Wed, 10 Oct 2018 13:15:21 +1030
Message-Id: <20181010024523.4921-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We currently build the wrapper with Os. This builds it with O2 instead,
reducing boot time when decompressing a compressed kernel. See patch
2 for details.

I've given this a spin with CONFIG_KERNEL_XZ on P9 and P8 as the
petitboot kernel.

Joel Stanley (2):
  powerpc/boot: Disable vector instructions
  powerpc/boot: Build boot wrapper with optimisations

 arch/powerpc/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

