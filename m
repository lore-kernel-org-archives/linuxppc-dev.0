Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAF8C83003
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 06:59:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4FF206D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 06:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqYNa5E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4FF206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Bq9w4GcQzDqTp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 16:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=iqYNa5E0; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Bq7q6XFCzDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 16:57:11 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id s18so574656pgl.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/6JyT2xaRj3teNFbje95z/LRcfHmPJ1SD5MPC090I04=;
 b=iqYNa5E0zos2zYLWOAA4JDaVUprDTcLm7dbzqBKEwwJ6CJlqdbuWa/8hMfzORE1gUI
 gYXtvd/ktm2AtXDOiVZVrsXmSNuJfthn/PVtogzcbm/gaTqlzsKAApSswtTTQD0JKcmy
 TftiRSNl9+o3xt2w1M1cIwyvvGvWmrnWDzUYbIhfht5CHPVuFd3rSe6WI9opsQ8xEZLp
 D/h2yEtVRdvXO5yEDNFPs+Qy6K78qbF1DmSfHxRJPmB8cABwc2WSwakYubYPCNYw0wP0
 I4Cr0uzYli30TzU3ZKrp6YSICe6AUhxnpHbvCfSJxsTa93mo1+6uCsFYnDu3xkuxnaB3
 leJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/6JyT2xaRj3teNFbje95z/LRcfHmPJ1SD5MPC090I04=;
 b=Uno5O+wBEB7MWjJHTqPfccRwiFaIJt01qglMMmO+XDtWUb2yd9FQxF1UbgZKVFvG/i
 xCcZluHLVH3mWxLRANrVCrgpj2Xn8CsEiOdhQgxIS/X4PV29LaC4oZuSfygRgiG19pbP
 3c2y5+d9uOrQTBHZMc5VMikOrLNVuvaFpmbiob+3ckll+Lx0obmUoNRkDtRMHZt/+bzP
 gX9BkT8H24GJX37gyyooB+Jx7xUE7rUgTBRCcOoC9vmpl+EEjF1ILFAXJZCyGFYUv5om
 STI3pSVcFP0IYqqK6HEES0sn1jvl8v5IIFJ3+g0AnQCi0Ryw+aQ77FltS6YZrFIGM2OJ
 6aYw==
X-Gm-Message-State: AGi0PuazLpL26pYkpDh03g595fn3Jkh6VT7OUWrYXrCs9plHrCn6+KyM
 yKW4FshCz3K/Se69Am9KlQ+q1bz6
X-Google-Smtp-Source: APiQypLEurF7kCJkrRatsuC0fK8F2v6kQWdhlW8mwj+iJMk3foYIeG3bHyxdygdOup3D7v3rOIWmfg==
X-Received: by 2002:a63:5009:: with SMTP id e9mr30167614pgb.381.1588143427095; 
 Tue, 28 Apr 2020 23:57:07 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.220.177.17])
 by smtp.gmail.com with ESMTPSA id a26sm254660pgd.68.2020.04.28.23.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 23:57:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] assorted kuap fixes (try again)
Date: Wed, 29 Apr 2020 16:56:48 +1000
Message-Id: <20200429065654.1677541-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Well the last series was a disaster, I'll try again sending the
patches with proper subject and changelogs written.

Nicholas Piggin (6):
  powerpc/64/kuap: move kuap checks out of MSR[RI]=0 regions of exit
    code
  powerpc/64s/kuap: kuap_restore missing isync
  powerpc/64/kuap: interrupt exit conditionally restore AMR
  powerpc/64s/kuap: restore AMR in system reset exception
  powerpc/64s/kuap: restore AMR in fast_interrupt_return
  powerpc/64s/kuap: conditionally restore AMR in kuap_restore_amr asm

 .../powerpc/include/asm/book3s/64/kup-radix.h | 45 ++++++++++++++++---
 arch/powerpc/kernel/entry_64.S                | 10 +++--
 arch/powerpc/kernel/exceptions-64s.S          |  3 +-
 arch/powerpc/kernel/syscall_64.c              | 26 +++++++----
 4 files changed, 63 insertions(+), 21 deletions(-)

-- 
2.23.0

