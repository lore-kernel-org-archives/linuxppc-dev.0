Return-Path: <linuxppc-dev+bounces-18823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38D410A1E82
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 11:54:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhMdB13W7z2yVB;
	Thu, 26 Mar 2026 22:54:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.193.30.102
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774526062;
	cv=none; b=aFde7qzn2sXz+/JM5s4Flcf0wHGAsQsrwaxqiTbucN0WFPLsgbcCdcoGHBWLeZ+jCHWhMzoGPckalWcPpbC4LW7fWhog6io594NaTeXY2TtrUNX3aCtfrPH8Q07Knm8oZhiiT603OXk4uNHKbFZPOoiXVnn7K6wYjC5z/5jx2MH/q4/XNjaQvDYBydwwRjX+djBVfQGsux3p8gAwPFlJnDiXojZ1Gn8pzE4+tX4iIjVg8eJrygU66oJRpsLm9qpTZD/0vdYxNFZy1jlm2npFiaQcCqsUUJqzDH1AUM/FvSwFTZ6K0gqmysm3GSGpOUWZ95mfASm2DfzK/ki1U20gWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774526062; c=relaxed/relaxed;
	bh=8mHjX6TyFjTvn38dtQM0Lm04BitL+7nkhimd3emS1kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StKRmI4PC6kI3r1m6RoHCT4gYQMkM1HZBgbIK58F78E5B+jqxCBB8jgXzPCvHleO2ei6upA1+c6sM6qnvyew7v+P5BwKqL3/ik0eg0DgSOI7nODLriAtvOUr4xmITwkHorQ8UM0GwAVnARQhfgN11n/3JqYMQc6feDu2UMIixJwge1ChSatngrq4ORl8GRs5iN0PZLmbpPz2PLUpEaoboTpIS1B2W3uvTrBj30Q+5VKLpz0rV88WwRxoRZfh0eN/YFLV2moRjszxIq1Aa3K8u38eHCXbdTcAcPMkmJvQXsY0K7pY9+jRESrci/F+VbhooT/h7JLeH1C/ad4u/9/pwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=EttU+o/X; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=DX5BS2EL; dkim-atps=neutral; spf=pass (client-ip=18.193.30.102; helo=out-ip0051.fra.mailhop.org; envelope-from=tomas.alvarez-vanoli@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=EttU+o/X;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=DX5BS2EL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.193.30.102; helo=out-ip0051.fra.mailhop.org; envelope-from=tomas.alvarez-vanoli@hitachienergy.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 6616 seconds by postgrey-1.37 at boromir; Thu, 26 Mar 2026 22:54:20 AEDT
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org [18.193.30.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhMd83yrdz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 22:54:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=8mHjX6TyFjTvn38dtQM0Lm04BitL+7nkhimd3emS1kk=;
	b=EttU+o/XnPHkJD4rwjXLcgzFDrpVVM+OAICmStV7bHdRklsCbBPF+vONzoNwPeZYS36fy/i7qjT/u
	 FZreIzjyra/AJJ5OdfxBQ7iGUUP4rCzLjV6k7pKODpl/cbdVevVSHbdyVGnoh8tQH+sQX0mWe01oHN
	 smrdXk6zfD2ltwj4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=8mHjX6TyFjTvn38dtQM0Lm04BitL+7nkhimd3emS1kk=;
	b=DX5BS2ELcF5LRmkWdpnlBlYpALo4eUSN8ksowOdXkgVgcxxPc0+E6FPcXplc+A1JBWgWJrXcrS4Cu
	 RKJHd1n8KGWaCLP/zvVbrwTNKO8Yny9pUnv/6KJhRQwdSdmojuo1Oqq/TNAsa4TEDyEJcSYATpniSo
	 cwAzaf50hHkomC4cgCIBH784t1DZV2sAzHT1o1gqx5bfML0OG4bWObqelAFCaxTDYfanBZ/0/lLOVU
	 nbbfK8b6yR7uPUyrOP8Got6k1RKnE8USfBy30L0o2nZweohD6aB2m7GgcYFVck9r5eP+HJd78dBorI
	 6yZf9x7nTt01CZgFSnsY56s6DDRHskg==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: f387f247-28fa-11f1-8751-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: f387f247-28fa-11f1-8751-f54febe22707:3
CFBL-Address: prvs=05455ff80f=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id f387f247-28fa-11f1-8751-f54febe22707;
	Thu, 26 Mar 2026 10:02:53 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id 7BFAC161F;
	Thu, 26 Mar 2026 10:02:51 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net [172.31.41.203])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 0474960B7D47;
	Thu, 26 Mar 2026 11:02:51 +0100 (CET)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com,
	andrew+netdev@lunn.ch,
	Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [PATCH] net: wan/fsl_ucc_hdlc: cleanup ucc_hdlc_poll
Date: Thu, 26 Mar 2026 11:02:32 +0100
Message-ID: <20260326100232.904289-1-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Immediately after setting to 0 we are adding to it, and subtracting 0
from budget. Replace with just assignment and no subtraction.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index b72ab9951875e..3bd57527b1be6 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -628,8 +628,7 @@ static int ucc_hdlc_poll(struct napi_struct *napi, int budget)
 	hdlc_tx_done(priv);
 	spin_unlock(&priv->lock);
 
-	howmany = 0;
-	howmany += hdlc_rx_done(priv, budget - howmany);
+	howmany = hdlc_rx_done(priv, budget);
 
 	if (howmany < budget) {
 		napi_complete_done(napi, howmany);
-- 
2.47.3


