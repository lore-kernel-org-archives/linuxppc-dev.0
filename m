Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E4C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:59:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D62063F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 00:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D62063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dFV46MNTzDqQg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:59:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dFR85L1szDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 11:56:36 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id ADBAFAE80001;
 Sun, 13 Jan 2019 19:56:03 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 0/2] powerpc/powernv/npu: Move platform shared code to
 sysdev
Date: Mon, 14 Jan 2019 11:55:59 +1100
Message-Id: <20190114005601.1220-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is to avoid pseries calling into powernv code. The first patch
changes data structure a bit, the second is cut-n-paste without
changing logic or data structures.

This is not changing symbol names as the NVIDIA UVM driver calls some of
them (pnv_npu2_init_context, pnv_npu2_destroy_context, pnv_pci_get_npu_dev,
pnv_npu2_handle_fault).

This is based on sha1
574823bf Linus Torvalds "Change mincore() to count "mapped" pages rather than "cached" pages".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  powerpc/powernv/npu: Move compound PEs to powernv
  powerpc/powernv/npu: Move platform shared code to sysdev

 arch/powerpc/sysdev/Makefile             |   1 +
 arch/powerpc/include/asm/npu.h           |  88 +++
 arch/powerpc/include/asm/pci.h           |   8 +-
 arch/powerpc/include/asm/powernv.h       |  24 -
 arch/powerpc/platforms/powernv/pci.h     |   4 +
 arch/powerpc/platforms/powernv/npu-dma.c | 672 +---------------------
 arch/powerpc/sysdev/npu.c                | 677 +++++++++++++++++++++++
 arch/powerpc/sysdev/Kconfig              |   3 +
 8 files changed, 781 insertions(+), 696 deletions(-)
 create mode 100644 arch/powerpc/include/asm/npu.h
 create mode 100644 arch/powerpc/sysdev/npu.c

-- 
2.17.1

