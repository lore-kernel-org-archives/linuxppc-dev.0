Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE3C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 01:11:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594EE20748
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 01:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="O2Re018r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594EE20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXk3h0cZvzDr41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 11:10:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=anastas.io (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.a=rsa-sha256
 header.s=mail header.b=O2Re018r; dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXk1F1vpfzDqXm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 11:08:49 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 0EB4C7EC65;
 Thu, 20 Aug 2020 20:08:44 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1597972125; bh=MbgYPiMEkuBmTEhlcG3CMB4hGpodkI3r5q5EjzwvMFw=;
 h=From:To:Cc:Subject:Date:From;
 b=O2Re018rwO/xupMIPCeSpZN9Tj/p+X9f2BZes/GfXOjGhhfgItfRFaadDTl32m1Y5
 dxz9Uv4xb6BrS5eW0/qCSMbYkX8nucDRVCbX+HLVUlWLwCMEMOKYxOqmnbZdu3KD8h
 M6DUQdgmHvGy8v3wnpdaUnpC/kQdPA76yUmpo+dzKz7FRQ+dNvIBiSYRXpjKRQ5vrJ
 vbmxkgvu+w5+HeZWjjEY8X9TstyT68ukLYPUybrnLdpTHnBWe1dJWVp7C6O/ntTWQR
 cfiQDL7K8SoLJ5PZ2vCooYcVw1xNd4jhbDKECJBLSgDfoIjOlQ3mJfd6JpjRgkXWbt
 4GjGZycM8me9Q==
From: Shawn Anastasio <shawn@anastas.io>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] Reintroduce PROT_SAO
Date: Thu, 20 Aug 2020 20:08:35 -0500
Message-Id: <20200821010837.4079-1-shawn@anastas.io>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This set re-introduces the PROT_SAO prot flag removed in
Commit 5c9fa16e8abd ("powerpc/64s: Remove PROT_SAO support").

To address concerns regarding live migration of guests using SAO
to P10 hosts without SAO support, the flag is disabled by default
in LPARs. A new config option, PPC_PROT_SAO_LPAR was added to
allow users to explicitly enable it if they will not be running
in an environment where this is a conern.

Shawn Anastasio (2):
  Revert "powerpc/64s: Remove PROT_SAO support"
  powerpc/64s: Disallow PROT_SAO in LPARs by default

 arch/powerpc/Kconfig                          | 12 ++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  8 ++--
 arch/powerpc/include/asm/cputable.h           | 10 ++---
 arch/powerpc/include/asm/mman.h               | 31 ++++++++++++--
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  2 +
 arch/powerpc/include/uapi/asm/mman.h          |  2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c             |  2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  2 +
 include/linux/mm.h                            |  2 +
 include/trace/events/mmflags.h                |  2 +
 mm/ksm.c                                      |  4 ++
 tools/testing/selftests/powerpc/mm/.gitignore |  1 +
 tools/testing/selftests/powerpc/mm/Makefile   |  4 +-
 tools/testing/selftests/powerpc/mm/prot_sao.c | 42 +++++++++++++++++++
 14 files changed, 107 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/prot_sao.c

-- 
2.28.0

