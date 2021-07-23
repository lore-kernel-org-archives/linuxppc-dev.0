Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DAC4320A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:33:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4860760F23
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jul 2021 20:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4860760F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWgxc5ltlz3d9K
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jul 2021 06:33:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=merlin.20170209 header.b=MrigMiJP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1234::107; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=MrigMiJP; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1234::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWgwK6KpCz30Dh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jul 2021 06:31:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:Message-Id:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=ofZAW+UaR71j9UoQ0PtTi8+53+8czkyvj5AoFyOvyWU=; b=MrigMiJPDyUJT7VdGd9BGODHcH
 XQEdEIJ/5aDpQuGiqICskIsIOfA/FFxq8txgBS/6OOoW+9r36pAH6/vpy/Mg6ZzxmCAIRDD+LLv6u
 NcfBtmrWlrsasuTPwT2g4ULbcUOOEmfGhjt2Y8MEjxAwNIhU8KBRz7ejbI9/LSKr8dS/h4obso7d8
 OpQVYMS0ocjQniY5K++G3CRro0VHhfA2Tsh0N0f2IwVMD4/cCe3OrdO+E8uHroNu6Upy/yVlsQ4Ho
 ZN3bc7t0lRO/JOdd0DqugRY86kWi1eOG8bUu6s4ho6GzhNGyZa71rjgZt6h7wNKKUSNArNxUyJ1LB
 A0uaKcew==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m71pi-009Bif-FF; Fri, 23 Jul 2021 20:31:46 +0000
Message-Id: <cover.1627068552.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Fri, 23 Jul 2021 12:29:12 -0700
Subject: [PATCH v4 00/10] DMA fixes for PS3 gelic network driver
To: David S. Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Date: Fri, 23 Jul 2021 20:31:46 +0000
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dave, Jakub,

This set of patches fixes various DMA related problems in the PS3 gelic
network driver and adds better error checking and improved message logging.

Please consider.

Changes from v3:
  Rebase to latest net-next.
  Split 2 patches into 10 patches.
  Fix checkpatch error.

Changes from v2:
  Rebase to latest net-next.

Changes from v1:
  Split the v1 series into two, one series with powerpc changes, and one series
  with gelic network driver changes.
  
-Geoff

The following changes since commit 94a994d2b2b74420c6fff5100220c2b636317242:

  net: phy: Remove unused including <linux/version.h> (2021-07-23 17:54:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-merge-dma-net-v4

for you to fetch changes up to 7aa1d9b1b4ffadcbdc6f88e4f8d4a323da307595:

  net/ps3_gelic: Fix DMA mapping problems (2021-07-24 13:02:14 -0700)

----------------------------------------------------------------
Geoff Levand (10):
      net/ps3_gelic: Add gelic_descr structures
      net/ps3_gelic: Use local dev variable
      net/ps3_gelic: Format cleanups
      net/ps3_gelic: Add new macro BUG_ON_DEBUG
      net/ps3_gelic: Add vlan_id structure
      net/ps3_gelic: Cleanup debug code
      net/ps3_gelic: Add new routine gelic_unmap_link
      net/ps3_gelic: Rename no to descr_count
      net/ps3_gelic: Add new routine gelic_work_to_card
      net/ps3_gelic: Fix DMA mapping problems

 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 983 +++++++++++++++------------
 drivers/net/ethernet/toshiba/ps3_gelic_net.h |  24 +-
 2 files changed, 559 insertions(+), 448 deletions(-)

-- 
2.25.1

