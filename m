Return-Path: <SRS0=d5Dh=4V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE71C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 04:32:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5776B20838
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 04:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="wcFCoJnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5776B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48XLZd2wktzDqX0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 15:32:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=wcFCoJnn; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48XLXl1GjCzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2020 15:30:46 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id n7so303227pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2020 20:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LO7nEFTUA11enrlntZOqIslob1jC9EHnhi7KR1pGwtY=;
 b=wcFCoJnnA2XtoVhD5Y5icVKPTz7htJ2GXxIes8arYMKdbS8tsEyYQ+Ymf2ZqTA3oJz
 Mz6PSL/wN7eDqtnKlkptvPppB3Fix8+nPQZcJ8UtqZL/dkaoVYBhtsgGP79uENFYMsjs
 O01NfWX8r3jFIvtoimoL0zQ5lQMhcW7YyZbxjpWKGqgyF3yKOcn/qlLtyk/WiNdPO1+a
 15wAAPaUMhJxMrdyXK+CXOP2vQaULrn2MdK8EpkQznX9HChG0rREEqx78qwTClgpjfij
 91dRrxNq/d8yL2vmJ4KJ31rkcBWEpbLLvJGH+WZ+SUnzwM8OCGukhWO6KDF25NonAXOU
 nliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LO7nEFTUA11enrlntZOqIslob1jC9EHnhi7KR1pGwtY=;
 b=GuvjFz8qIoUb19WpHAmu/Mnemf7CmaOmdqJcpc2Ceu9xizOk5m/usoYXguUIMOcp1+
 bH2e1k2PbP5P2b50T5tHObnhJapRcMYliG1BGtqKWEEhdlHAQOpXy8hDK32JDbqsFeve
 46IWKCe5GXWMO/x9opj+NAIcZfumwHQScj46mAarXeSavADvDO+Vsc/t1NJkDN0aTICy
 AJLkn2o8zv3TOIpU7cc3bG4k7xcFfrGVPuhjLV+n8E2axeHNJo+mn0tpfHtGfz/j2QF7
 vMXBkdgrfry38Y1+/xLVKCEu62cv4R++LvITF+Y6d1s9G+bdL40FuUs7SiN5sWQks0CU
 4Y4g==
X-Gm-Message-State: ANhLgQ2KDGemu656K4VrHkbLtU4szLX2dHSe/Be1KE3cUWaAvy0xoFDS
 3EqYIiYrnWEgXWYQi0EVpxdtXQ==
X-Google-Smtp-Source: ADFU+vsBAJqV5WyoQ0vbapI19L2vafQ6MJFe9Ca1ajez6r2ZxVZ9BV+rH9xoXoQl24p6gfcPO9wuHg==
X-Received: by 2002:a63:5826:: with SMTP id m38mr847545pgb.191.1583296243516; 
 Tue, 03 Mar 2020 20:30:43 -0800 (PST)
Received: from santosiv.in.ibm.com ([2401:4900:16ee:7b5f:eac:4364:ff14:3aaa])
 by smtp.gmail.com with ESMTPSA id
 y193sm10775723pfg.162.2020.03.03.20.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 20:30:42 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: <stable@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 0/6] Memory corruption may occur due to incorrent tlb flush
Date: Wed,  4 Mar 2020 10:00:22 +0530
Message-Id: <20200304043028.280136-1-santosh@fossix.org>
X-Mailer: git-send-email 2.24.1
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
Cc: Sasha Levin <sashal@kernel.org>, Greg KH <greg@kroah.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The TLB flush optimisation (a46cc7a90f: powerpc/mm/radix: Improve TLB/PWC
flushes) may result in random memory corruption. Any concurrent page-table walk
could end up with a Use-after-Free. Even on UP this might give issues, since
mmu_gather is preemptible these days. An interrupt or preempted task accessing
user pages might stumble into the free page if the hardware caches page
directories.

The series is a backport of the fix sent by Peter [1].

The first three patches are dependencies for the last patch (avoid potential
double flush). If the performance impact due to double flush is considered
trivial then the first three patches and last patch may be dropped.

This is only for v4.19 stable.

Changelog:
* Send the patches with the correct format (commit sha1 upstream) for stable

--
Aneesh Kumar K.V (1):
  powerpc/mmu_gather: enable RCU_TABLE_FREE even for !SMP case

Peter Zijlstra (4):
  asm-generic/tlb: Track freeing of page-table directories in struct
    mmu_gather
  asm-generic/tlb, arch: Invert CONFIG_HAVE_RCU_TABLE_INVALIDATE
  mm/mmu_gather: invalidate TLB correctly on batch allocation failure
    and flush
  asm-generic/tlb: avoid potential double flush

Will Deacon (1):
  asm-generic/tlb: Track which levels of the page tables have been
    cleared

 arch/Kconfig                                 |   3 -
 arch/powerpc/Kconfig                         |   2 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h |   8 --
 arch/powerpc/include/asm/book3s/64/pgalloc.h |   2 -
 arch/powerpc/include/asm/tlb.h               |  11 ++
 arch/powerpc/mm/pgtable-book3s64.c           |   7 --
 arch/sparc/include/asm/tlb_64.h              |   9 ++
 arch/x86/Kconfig                             |   1 -
 include/asm-generic/tlb.h                    | 103 ++++++++++++++++---
 mm/memory.c                                  |  20 ++--
 10 files changed, 122 insertions(+), 44 deletions(-)

-- 
2.24.1

