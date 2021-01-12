Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4231CC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 13:51:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E6E23104
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 13:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E6E23104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFX6d02YNzDrBp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 00:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oR6AOFX+; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFVxP1SSvzDr1D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2021 23:58:17 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3AFF23125;
 Tue, 12 Jan 2021 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610456293;
 bh=g/q85gxojvycMJTot6idqg9w5y5eolE+WzXgRWDptTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oR6AOFX+Z7VmAw4iui12Fh6GyU+8hX9+q+2EPsCAQmvLWPbft4h6qfDwIUGHgD3IA
 DysPAD4F5XxmYG6x6Fwkw5M22qw/KmgWX2MFWNQdQQ8320k9XyYZyHcwGCclP+vUz+
 v2Yf39i1HJNEjZLsECWqUHAu36UGbeJnSVCtf0zLKfVt/kEJgKCYPgYPtUY1bYizb7
 RnVLBzk983+v/AUmxVa3g9Zv2GQEDU0k5X7ovFmZ9YIqFCAddKcl4plfTKkWMIxV9H
 M7ONDDxLvIVwa+HBV6UzORGcGmmBqqrpq6rP2nwqjseSmrbghRmq1Kp1UKEEshh3uM
 a/BogkgLtYasg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 2/8] ethernet: ucc_geth: fix definition and size
 of ucc_geth_tx_global_pram
Date: Tue, 12 Jan 2021 07:58:03 -0500
Message-Id: <20210112125810.71348-2-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125810.71348-1-sashal@kernel.org>
References: <20210112125810.71348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

[ Upstream commit 887078de2a23689e29d6fa1b75d7cbc544c280be ]

Table 8-53 in the QUICC Engine Reference manual shows definitions of
fields up to a size of 192 bytes, not just 128. But in table 8-111,
one does find the text

  Base Address of the Global Transmitter Parameter RAM Page. [...]
  The user needs to allocate 128 bytes for this page. The address must
  be aligned to the page size.

I've checked both rev. 7 (11/2015) and rev. 9 (05/2018) of the manual;
they both have this inconsistency (and the table numbers are the
same).

Adding a bit of debug printing, on my board the struct
ucc_geth_tx_global_pram is allocated at offset 0x880, while
the (opaque) ucc_geth_thread_data_tx gets allocated immediately
afterwards, at 0x900. So whatever the engine writes into the thread
data overlaps with the tail of the global tx pram (and devmem says
that something does get written during a simple ping).

I haven't observed any failure that could be attributed to this, but
it seems to be the kind of thing that would be extremely hard to
debug. So extend the struct definition so that we do allocate 192
bytes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/ucc_geth.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 5da19b440a6a8..bf25e49d4fe34 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -580,7 +580,14 @@ struct ucc_geth_tx_global_pram {
 	u32 vtagtable[0x8];	/* 8 4-byte VLAN tags */
 	u32 tqptr;		/* a base pointer to the Tx Queues Memory
 				   Region */
-	u8 res2[0x80 - 0x74];
+	u8 res2[0x78 - 0x74];
+	u64 snums_en;
+	u32 l2l3baseptr;	/* top byte consists of a few other bit fields */
+
+	u16 mtu[8];
+	u8 res3[0xa8 - 0x94];
+	u32 wrrtablebase;	/* top byte is reserved */
+	u8 res4[0xc0 - 0xac];
 } __packed;
 
 /* structure representing Extended Filtering Global Parameters in PRAM */
-- 
2.27.0

