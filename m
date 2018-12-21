Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF7C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:43:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3527B21903
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3527B21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LwvS2Kd6zDqTY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:43:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=diana.craciun@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Lwdy1M9vzDr1P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 04:31:15 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B673A1A012B;
 Fri, 21 Dec 2018 18:31:12 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A9E101A0033;
 Fri, 21 Dec 2018 18:31:12 +0100 (CET)
Received: from fsr-ub1664-009.ea.freescale.net
 (fsr-ub1664-009.ea.freescale.net [10.171.71.77])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B7AF205E9;
 Fri, 21 Dec 2018 18:31:12 +0100 (CET)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/11 v2] powerpc/fsl: NXP PowerPC Spectre variant 2
 workarounds
Date: Fri, 21 Dec 2018 19:30:26 +0200
Message-Id: <1545413437-5538-1-git-send-email-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Diana Craciun <diana.craciun@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Implement Spectre variant 2 workarounds for NXP PowerPC Book3E
processors.

Diana Craciun (11):
  Add infrastructure to fixup branch predictor flush
  Add macro to flush the branch predictor
  Fix spectre_v2 mitigations reporting
  Emulate SPRN_BUCSR register
  Add nospectre_v2 command line argument
  Flush the branch predictor at each kernel entry (64bit)
  Flush the branch predictor at each kernel entry (32 bit)
  Flush branch predictor when entering KVM
  Enable runtime patching if nospectre_v2 boot arg is used
  Update Spectre v2 reporting
  Add FSL_PPC_BOOK3E as supported arch for nospectre_v2 boot arg

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/powerpc/include/asm/feature-fixups.h       | 12 +++++++++++
 arch/powerpc/include/asm/ppc_asm.h              | 10 +++++++++
 arch/powerpc/include/asm/setup.h                |  7 +++++++
 arch/powerpc/kernel/entry_64.S                  |  5 +++++
 arch/powerpc/kernel/exceptions-64e.S            | 26 ++++++++++++++++++++++-
 arch/powerpc/kernel/head_booke.h                | 11 ++++++++++
 arch/powerpc/kernel/head_fsl_booke.S            | 15 +++++++++++++
 arch/powerpc/kernel/security.c                  | 28 +++++++++++++++++++++++--
 arch/powerpc/kernel/setup-common.c              |  1 +
 arch/powerpc/kernel/vmlinux.lds.S               |  8 +++++++
 arch/powerpc/kvm/bookehv_interrupts.S           |  4 ++++
 arch/powerpc/kvm/e500_emulate.c                 |  5 +++++
 arch/powerpc/lib/feature-fixups.c               | 21 +++++++++++++++++++
 arch/powerpc/mm/tlb_low_64e.S                   |  7 +++++++
 15 files changed, 158 insertions(+), 4 deletions(-)

-- 
2.5.5

