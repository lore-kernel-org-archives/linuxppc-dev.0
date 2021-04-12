Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C32CC43460
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 07:51:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD1961356
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 07:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD1961356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJgt4709Dz3bxQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 17:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=J15qDNvN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429;
 helo=mail-pf1-x429.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=J15qDNvN; dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJgsZ71MCz2yjD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 17:51:12 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id n38so8682167pfv.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ghAZbXCnYZv5OC+rtIwdziC8cQB3Sr8op6xK0fZMBD0=;
 b=J15qDNvNiePUPTiNhNaWD5Wbd6HvlV7qiMPXaiov0HPCr2EL5luqhLhX3bb2rXX/EI
 eBhYpWPxcBkZI3KrLq0QqdU1ZbsdYXEY/o7SSNGRhrk1QjXFSwtiknkcYArMQpqQH/8g
 ncAkBu4sZDb/864NS3XwubuhuA5qIPF/NFKLHhJ2AtcvTzqltgMTeyvnsccxFt1ReiQG
 A2ib/0frOKUf4zhKHLTW4Phy+8VDMwec68iENR54vvoWszW3sB50xWOk3wqZKiNBe8Ck
 YLmzvBkFGhlpV1mzhukkjMaFFdyBzwCKYCzGLlz/0IIQlIS61pC1YL9e2q/quCw64yF/
 7neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ghAZbXCnYZv5OC+rtIwdziC8cQB3Sr8op6xK0fZMBD0=;
 b=LSJDS+4LQBHHAC3v/ZvAPkHTl3CH9AoGNaCf0dxfdqzl0Zc+lUos1FreizFzOWhqI+
 7a6xT8LMSTu4VG54i8z6AMaFbXgixaCXL16aRLHmDxKGXaWAs2LhoiG8pHrtQCNEd/oI
 SmIceDYOAnx0ZKFlOOcmdMgL2IYHPTFC/gohSCV5XBJXJMSrlDbzzU+4FNG14xxx7tI3
 tUELyHFdzwXSyF5JvVXUn1bSa0MJTZrSWhVZSmJkoX9A01Aq7tYCFvuM290fnfPYXTJY
 3FZgmM8b0yWJ/Uxz8BvioxnmDgmMDVTDQ8O7xU0ZZttt6CngzZjeGURWbxqs44gFSECh
 lo3g==
X-Gm-Message-State: AOAM531628sLkfVIf3cQQy2AGsMWZa1lPEvZwCSL5WehqA2HCIYMcpdf
 SGOz84EdV7GFJn0absAAcm8=
X-Google-Smtp-Source: ABdhPJzxcnnIBC9LkW1u96hVOEfdPeulPsnwRQTsPa+PuYMmzfVDOmE0o0ryvRjgLrW2Px94cPAiQg==
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr25143629pga.203.1618213869155; 
 Mon, 12 Apr 2021 00:51:09 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-90-211.tpgi.com.au.
 [193.116.90.211])
 by smtp.gmail.com with ESMTPSA id i18sm606180pfq.168.2021.04.12.00.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 00:51:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v1 0/7] KVM / 64s interrupt handling changes
Date: Mon, 12 Apr 2021 17:50:56 +1000
Message-Id: <20210412075103.1533302-1-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the second batch of patches split from the big KVM in C
series.

This implements all the changes to exception-64s.S required for the
subsequent C conversion. I think they stand on their own as good
patches.

The main things done here are to make the code more amenable to
adding different KVM interrupt handlers (rather than just PR and
HV), and moving a lot of KVM specific code out of exceptions-64s.S
and moving it to arch/powerpc/kvm/book3s_64_entry.S. Calling
convention between those files is changed to mostly match the
exception-64s.S "GEN_INT_ENTRY" convention, so that's a change but
now you only have to remember that one for both cases (either
branching to KVM handler or continuing to GEN_COMMON handler).

This is tested with HV KVM, nested HV under radix L0+L1, and nested
PR KVM under HPT guest. All seems to be working okay.

Thanks,
Nick

Nicholas Piggin (7):
  KVM: PPC: Book3S 64: move KVM interrupt entry to a common entry point
  KVM: PPC: Book3S 64: Move GUEST_MODE_SKIP test into KVM
  KVM: PPC: Book3S 64: add hcall interrupt handler
  KVM: PPC: Book3S 64: Move hcall early register setup to KVM
  KVM: PPC: Book3S 64: Move interrupt early register setup to KVM
  KVM: PPC: Book3S 64: move bad_host_intr check to HV handler
  KVM: PPC: Book3S 64: Minimise hcall handler calling convention
    differences

 arch/powerpc/include/asm/exception-64s.h |  13 ++
 arch/powerpc/kernel/exceptions-64s.S     | 250 ++++-------------------
 arch/powerpc/kvm/Makefile                |   3 +
 arch/powerpc/kvm/book3s_64_entry.S       | 158 ++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  13 +-
 arch/powerpc/kvm/book3s_segment.S        |   3 +
 6 files changed, 220 insertions(+), 220 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_64_entry.S

-- 
2.23.0

