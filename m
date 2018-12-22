Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120DC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:44:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D63321908
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D63321908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MCb20nv0zDqYM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:44:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MCXv5J1pzDqRH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 15:42:55 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 (helo=home.buserror.net)
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gaZ7k-0000W5-MH; Fri, 21 Dec 2018 22:42:53 -0600
Date: Fri, 21 Dec 2018 22:42:50 -0600
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20181222044250.GA7651@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 galak@kernel.crashing.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Pull request: scottwood/linux.git next
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Highlights include elimination of legacy clock bindings use from dts
files, an 83xx watchdog handler, fixes to old dts interrupt errors, and
some minor cleanup.

The following changes since commit 8c6c942d33f2a79439e86f8f406afae40a5bc767:

  powerpc/eeh: Fix debugfs_simple_attr.cocci warnings (2018-12-20 22:59:03 +1100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 5f470b3638a4ed03df79b993ece819cac2f4ca7e:

  powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL (2018-12-21 22:07:54 -0600)

----------------------------------------------------------------
Alexandre Belloni (1):
      powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"

Christoph Hellwig (1):
      powerpc/fsl_pci: simplify fsl_pci_dma_set_mask

Christophe Leroy (1):
      powerpc/83xx: handle machine check caused by watchdog timer

Sabyasachi Gupta (1):
      arch/powerpc/fsl_rmu: Use dma_zalloc_coherent

Scott Wood (3):
      powerpc/fsl: Use new clockgen binding
      powerpc/dts/fsl: Fix dtc-flagged interrupt errors
      powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL

Yuantian Tang (1):
      clk: qoriq: add more compatibles strings

 .../devicetree/bindings/clock/qoriq-clock.txt      |   6 +
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  15 ---
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts         | 128 ++++++++++-----------
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts     | 128 ++++++++++-----------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      |   2 +
 arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  18 ---
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  18 ---
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  70 -----------
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |  16 +--
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  18 ---
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |  47 --------
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |  30 -----
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  16 ---
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  44 -------
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  22 ----
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  61 ----------
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  24 ++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |   4 -
 arch/powerpc/configs/fsl-emb-nonhw.config          |   1 +
 arch/powerpc/include/asm/cputable.h                |   1 +
 arch/powerpc/include/asm/reg.h                     |   2 +
 arch/powerpc/kernel/cputable.c                     |  10 +-
 arch/powerpc/platforms/83xx/misc.c                 |  17 +++
 arch/powerpc/sysdev/fsl_pci.c                      |   6 +-
 arch/powerpc/sysdev/fsl_rio.h                      |   2 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   4 +-
 36 files changed, 218 insertions(+), 556 deletions(-)
