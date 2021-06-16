Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDBC48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 08:03:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFCE613B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 08:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFCE613B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4d3c1VZHz30B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 18:03:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=QPnQjC/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::42e;
 helo=mail-pf1-x42e.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=QPnQjC/i; dkim-atps=neutral
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4d316qlBz306q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 18:02:52 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id k15so1543715pfp.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cw10uFtM6j6ivpIAHKyfGYAPjF+AZvHLGbY1I1Cvnes=;
 b=QPnQjC/imXfUDfxqjiSI4NF+/NKMtw6Adrdw/ELeXbXZra76qgDP9zC6J1U1y9NOt4
 u3kgAKeQQuREYzGZQlZMFN4+Pq0lK/VqesWv/DqZLZyDm6UlMjUAZqIob+QtbqgV6ZMS
 Cop5PE067jtkmcXpYSnRdeBlAyFJ/etIcr1Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cw10uFtM6j6ivpIAHKyfGYAPjF+AZvHLGbY1I1Cvnes=;
 b=FyhGebutdzaNYAt+ZnDafDkE/7XJDNz3zWd5yjw4H/3KPEWh7hp1HzYfNp2sDl8dWd
 AZlBDj+LE2GNzeoDHP0UKDZa7rYjpAhDLMpInUQIZ+6plYg6aknellxnNaxhp0k5/yE9
 nC0l3Q9fbarZ8VVyizE9jTz69xPutOPWSjJpDhu4TbgkY9Qd6URJEzBxS+IaS3aXqcDP
 h8BTnIxQM6yer7E4qrZUOnEdOrcIM0EusaT1F0PpDcy5Nm1SD5cX/ZzjMhdOjmU3eqjd
 +7XujitdhQtZ8ai/j5Yw4a/5esoufz/SE9SPqQhi9yVYZer8jOnj5v/9s++cLtKhdi7C
 Jd2A==
X-Gm-Message-State: AOAM531ajxnhlWzvvqhRNGvP0XY37dlwPbc5kbBEjm9TDkqkUjJ4a9bB
 Cte5ZsBhyJpWP+3iIisLeDNuLQ==
X-Google-Smtp-Source: ABdhPJy5hVPBnk/1qjUJFKWZR7abAM3qeGiX96PaDRnrHnAkkctatxXsM4js2+i2npCAT/eew3P16A==
X-Received: by 2002:a63:a805:: with SMTP id o5mr3777437pgf.328.1623830569286; 
 Wed, 16 Jun 2021 01:02:49 -0700 (PDT)
Received: from localhost ([203.206.29.204])
 by smtp.gmail.com with ESMTPSA id k19sm1408921pji.32.2021.06.16.01.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 01:02:48 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, elver@google.com, akpm@linux-foundation.org,
 andreyknvl@gmail.com
Subject: [PATCH v13 0/3] KASAN core changes for ppc64 radix KASAN
Date: Wed, 16 Jun 2021 18:02:41 +1000
Message-Id: <20210616080244.51236-1-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
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
Cc: aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU. I've been
trying this for a while, but we keep having collisions between the
kasan code in the mm tree and the code I want to put in to the ppc
tree.

So this series just contains the kasan core changes that we
need. These can go in via the mm tree. I will then propose the powerpc
changes for a later cycle. (The most recent RFC for the powerpc
changes is in the last series at
https://lore.kernel.org/linux-mm/20210615014705.2234866-1-dja@axtens.net/
)

v13 applies to next-20210611. There should be no noticeable changes to
other platforms.

Changes since v12: respond to Marco's review comments - clean up the
help for ARCH_DISABLE_KASAN_INLINE, and add an arch readiness check to
the new granule poisioning function. Thanks Marco.

Kind regards,
Daniel

Daniel Axtens (3):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  kasan: define and use MAX_PTRS_PER_* for early shadow tables

 include/linux/kasan.h | 18 +++++++++++++++---
 lib/Kconfig.kasan     | 14 ++++++++++++++
 mm/kasan/common.c     |  4 ++++
 mm/kasan/generic.c    |  3 +++
 mm/kasan/init.c       |  6 +++---
 mm/kasan/kasan.h      |  4 ++++
 mm/kasan/shadow.c     |  8 ++++++++
 7 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.30.2

