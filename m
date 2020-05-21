Return-Path: <SRS0=dcvz=7D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 01:45:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2533A20756
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 01:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2533A20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49SCBC5GyTzDqYd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 11:45:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49SC875jMCzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2020 11:43:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49SC870K6Rz9sSc;
 Thu, 21 May 2020 11:43:51 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/7] Base support for POWER10
Date: Thu, 21 May 2020 11:43:34 +1000
Message-Id: <20200521014341.29095-1-alistair@popple.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: mikey@neuling.org, npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series brings together several previously posted patches required for
POWER10 support and introduces a new patch enabling POWER10 architected
mode to enable booting as a POWER10 pseries guest.

It includes support for enabling facilities related to MMA and prefix
instructions.

Changes from v2:
  - s/accumulate/assist/
  - Updated commit messages

Changes from v1:
  - Two bug-fixes to enable prefix and MMA on pseries
  - Minor updates to commit message wording
  - Fixes a build error when CONFIG_KVM_BOOK3S_64_HV is enabled

Alistair Popple (7):
  powerpc: Add new HWCAP bits
  powerpc: Add support for ISA v3.1
  powerpc/dt_cpu_ftrs: Advertise support for ISA v3.1 if selected
  powerpc/dt_cpu_ftrs: Set current thread fscr bits
  powerpc/dt_cpu_ftrs: Enable Prefixed Instructions
  powerpc/dt_cpu_ftrs: Add MMA feature
  powerpc: Add POWER10 architected mode

 arch/powerpc/include/asm/cputable.h      | 16 +++++++++++--
 arch/powerpc/include/asm/mmu.h           |  1 +
 arch/powerpc/include/asm/prom.h          |  1 +
 arch/powerpc/include/asm/reg.h           |  6 +++--
 arch/powerpc/include/uapi/asm/cputable.h |  2 ++
 arch/powerpc/kernel/cpu_setup_power.S    | 20 ++++++++++++++--
 arch/powerpc/kernel/cputable.c           | 30 ++++++++++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c        | 26 +++++++++++++++++++-
 arch/powerpc/kernel/prom_init.c          | 12 ++++++++--
 arch/powerpc/kvm/book3s_hv.c             |  3 ---
 10 files changed, 105 insertions(+), 12 deletions(-)

-- 
2.20.1

