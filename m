Return-Path: <SRS0=bT9L=FC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A0C63697
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 07:09:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4168122275
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 07:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3+syg2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4168122275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjjKW0HwNzF0RF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 18:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=l3+syg2M; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjjHd184GzDsPb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 18:07:40 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id o4so3739028pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 23:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=80cZRa6DY2WJtqGfVyPLANbeYfDEscKkkay6pVYA2aQ=;
 b=l3+syg2Mf4aw053csQE+dTDInc4SFZIuTep1XdzIvXF4HINeegyBlT2ZTRf0ReZqLj
 YY3FlHpkOaD07EJs6A1PI86wlGE6JN2mvHhy42klYIHmQDg0lssh453QEMokyVdf1ss8
 IdbctNhfc0LZnXEuQzgyx+I0jPEdeOPKcj9LKGFe+ZYXqg0DEzWwNBmXOW7d4Pxpufhe
 otZVO+jiIHX6HB5Hr8D1DLqySpJagjXP/us3YKWjysZBGwPNhexy5nXs2E4b5KuhDLxp
 A98mcym3+DSrAibkM23qNGVjh3Sn3NXaOi2cT7sOQBWKlTaow21RE3WlEtfeyPJl6nfe
 cuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=80cZRa6DY2WJtqGfVyPLANbeYfDEscKkkay6pVYA2aQ=;
 b=EPn/tPLfFM8ETV59lZ9fuebt+Rx+Kq1r6DGR+iEKmMnQCBHQG3V4vkGg2HvTWeyDyK
 Qk50XYQ7gmh2zbXA8+jcfyXxWTB1sukksx2tRgb4/BiS7p9N13bMxEecm2bveM2i+ZUr
 Eo1zJbu2bK+9jhxuxlmwGhZpNWiZJtyjLmYgB8gPy/gkX2iX2RR2xSdFNP+os0hQjodV
 Oo6p9v8Y5AEPBhYQ7aiD8dZNcvd7yP6q9pVJbLqBBt722gnPQIFHMrwsMSJRhYgppZHJ
 aQLZZFqrKaOBqd3gZwQYSC6K/VJeGJIAgcc2wQzY15MJO2FeUjlNGZigyRrWyOgkXsmR
 ZOxA==
X-Gm-Message-State: AOAM532F1kGAxjEAqt1LGQXyvufOz0LBgyBZLzBMZkbDdYXnA7+BqbqG
 CIWUiaHi9+a0fU5S2y8lWNZECd8RDpE=
X-Google-Smtp-Source: ABdhPJwRVGY1ubWi9/oculm+y+cZpPgZ6MjJ6LYtHmHgoMkGoa9EVXg42FeReeIgzv6AAjk983t8yQ==
X-Received: by 2002:a65:44c2:: with SMTP id g2mr4925662pgs.256.1606547256927; 
 Fri, 27 Nov 2020 23:07:36 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
 by smtp.gmail.com with ESMTPSA id e31sm9087329pgb.16.2020.11.27.23.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 23:07:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] powerpc/64s: fix and improve machine check handling
Date: Sat, 28 Nov 2020 17:07:20 +1000
Message-Id: <20201128070728.825934-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

First patch is a nasty memory scribble introduced by me :( That
should go into fixes.

The next ones could wait for next merge window. They get things to the
point where misbehaving or buggy guest isn't so painful for the host,
and also get the guest SLB dumping code working (because the host no
longer clears them before delivering the MCE to the guest).

I have a crasher guest vmlinux with a few SLB handling bugs introduced
which now bumbles along okay without bothering the host so much.

I don't know what the picture or high level strategy really is for UE
memory errors in the guest, particularly with PowerVM, so some review
there would be good (I haven't changed anything really in that space
AFAIKS, but as an overall "is this the right way to go" kind of thing).

Thanks,
Nick

Nicholas Piggin (8):
  powerpc/64s/powernv: Fix memory corruption when saving SLB entries on
    MCE
  powerpc/64s/powernv: Allow KVM to handle guest machine check details
  KVM: PPC: Book3S HV: Don't attempt to recover machine checks for FWNMI
    enabled guests
  KVM: PPC: Book3S HV: Ratelimit machine check messages coming from
    guests
  powerpc/64s/powernv: ratelimit harmless HMI error printing
  powerpc/64s/pseries: Add ERAT specific machine check handler
  powerpc/64s: Remove "Host" from MCE logging
  powerpc/64s: tidy machine check SLB logging

 arch/powerpc/include/asm/mce.h            |  1 +
 arch/powerpc/kernel/mce.c                 |  4 +-
 arch/powerpc/kernel/mce_power.c           | 98 +++++++++++++----------
 arch/powerpc/kvm/book3s_hv.c              | 11 ++-
 arch/powerpc/kvm/book3s_hv_ras.c          | 23 ++++--
 arch/powerpc/mm/book3s64/slb.c            | 39 ++++-----
 arch/powerpc/platforms/powernv/opal-hmi.c | 27 ++++---
 arch/powerpc/platforms/powernv/setup.c    |  9 ++-
 arch/powerpc/platforms/pseries/ras.c      |  5 +-
 9 files changed, 129 insertions(+), 88 deletions(-)

-- 
2.23.0

