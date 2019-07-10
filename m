Return-Path: <SRS0=3PCM=VH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C85C74A21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 14:33:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F86620651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="qFUgm1H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F86620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kM9p60b9zDqKT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jul 2019 00:33:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stackframe.org
 (client-ip=2001:470:70c5:1111::170; helo=smtp.duncanthrax.net;
 envelope-from=svens@stackframe.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stackframe.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=duncanthrax.net header.i=@duncanthrax.net
 header.b="qFUgm1H6"; dkim-atps=neutral
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net
 [IPv6:2001:470:70c5:1111::170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kM6L0Rl7zDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2019 00:30:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From;
 bh=hQBC/hvq+BCaNtDhw4z/VJLTgPoTPP4x+PgvCWk6Ysg=; b=qFUgm1H6jOaYHyIt4RRMSIrSjR
 0FVZYXa39xxE0VJyJ0wqivCtnrKz2O2gkSMZ/ayWJcTVDo5u0O5Kco/M3bSPHP/d/SwMT2SglBWXk
 5sCzKrJRsmGebHlFnra561fre3XR08lPpaDsbBAmQlzNEcc1Ydf++r2j9v6J9NhxRR6g=;
Received: from [134.3.44.134] (helo=t470p.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1hlDbp-0004hm-EO; Wed, 10 Jul 2019 16:30:13 +0200
From: Sven Schnelle <svens@stackframe.org>
To: kexec@lists.infradead.org
Subject: [PATCH v3 0/7] kexec: add generic support for elf kernel images
Date: Wed, 10 Jul 2019 16:29:37 +0200
Message-Id: <20190710142944.2774-1-svens@stackframe.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Sven Schnelle <svens@stackframe.org>, deller@gmx.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi List,

this is the same changeset as v2, but (hopefully) with git format-patch -C.

Changes to v2:
 - use git format-patch -C

Changes to v1:
 - split up patch into smaller pieces
 - rebase onto powerpc/next
 - remove unused variable in kexec_elf_load()

Changes to RFC version:
 - remove unused Elf_Rel macro
 - remove section header parsing
 - remove PURGATORY_STACK_SIZE
 - change order of elf_*_to_cpu() functions
 - remove elf_addr_to_cpu macro

Sven Schnelle (7):
  kexec: add KEXEC_ELF
  kexec_elf: change order of elf_*_to_cpu() functions
  kexec_elf: remove parsing of section headers
  kexec_elf: remove PURGATORY_STACK_SIZE
  kexec_elf: remove elf_addr_to_cpu macro
  kexec_elf: remove Elf_Rel macro
  kexec_elf: remove unused variable in kexec_elf_load()

 arch/Kconfig                       |   3 +
 arch/powerpc/Kconfig               |   1 +
 arch/powerpc/kernel/kexec_elf_64.c | 551 +----------------------------
 include/linux/kexec.h              |  23 ++
 kernel/Makefile                    |   1 +
 kernel/kexec_elf.c                 | 389 ++++++++++++++++++++
 6 files changed, 427 insertions(+), 541 deletions(-)
 create mode 100644 kernel/kexec_elf.c

-- 
2.20.1

