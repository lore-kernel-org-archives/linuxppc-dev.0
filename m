Return-Path: <linuxppc-dev+bounces-20518-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2140DCD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 11:16:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Xs04MVjz30Pp;
	Wed, 06 May 2026 21:16:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778066212;
	cv=none; b=J1rrAfC4bOlfhMN7CNvD6p1aTuJMkXV/UbyMxn7YbSjBUpE4pYsokUBrxdxs5/LxsDjqK5R2el6ykn9jxN7OSNPjabJRwFG+1O7jqHxyQlksOZAxDDDEFg0xe9DvVo0jPfr86A8rOxrjmU5OwTKJx90HRZLjpNeEt8LWxGYRCKF4xsKX4VqYpOqM5Ce3uRWZtfP20Jbfniw4bzJJRRrwiB/Jz4G58Gyyg9nLNMAT6Mtt46XbJFurHDvCl6sk78RtyZ9BcFjmbkFlEPuOXl9oae1MKoARTTkwCZDlbMYE4vkPR9n5XlhOeRIcK2ZmFeGcMelA90dZUJ+OTqdoIp5wGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778066212; c=relaxed/relaxed;
	bh=mzUCgE4R9ZBXTM/Zus2HFTCm9+5cChUmtqF1FgPd4FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZM1m1jI7Eyoni8Vh6jBEv6QG85dVHgVLEjJuWKRTq8VHU30zXLs61JY1SkBRFzKGHsV7C4t8ZE5InvQufKcRsuSos2lmu1u2jcwvu621OEtogj+8XFrqWCetXpi4R055qnocr6BaCYVRtfB0r9C2V7TcA554+JzHI+1v6czTDN8t1KaE52NpXLTMdRfWiU0Li0L4fpdHcNNk1yDaEThDkNQN5sTFuAjriZTG66SIXPsD5ak+8amTn9zForv5KzCmEAs4e/Ke660CtTuCOcrwbYgYCpNJpv07vA9rFi7+MSyi2/0UEV7eUPhERbsDEvRNEAb9TnX5oplJ1+crRwsbYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=G42llmsp; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=kWq8w9ns; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=G42llmsp;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=kWq8w9ns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Xrx5dbDz30DX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 21:16:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=mzUCgE4R9ZBXTM/Zus2HFTCm9+5cChUmtqF1FgPd4FU=;
	b=G42llmspsz5W53eBNTiq/ZpZ0nrMBEnsLDD3u+l1US/9WqbUmJ+tjxr5NP4VJFz9q4slVg7Osaclw
	 hOuHNHJyYvlqzfWX6FqZNaZCuRwSgnF70NXW3Zyhg5fwyGBY9SaY+NfhhrzI+bESUAuNWcBKyxW5tu
	 8VwT4XqI8UgGwht4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=mzUCgE4R9ZBXTM/Zus2HFTCm9+5cChUmtqF1FgPd4FU=;
	b=kWq8w9nsR2RvVSHinNFmMiGQ9zzmppV3xQmNrHJJr/caTLPlJ8NJcvqj+245KMGmN5/cuc+Crks61
	 Gc033LyF7O21pxmsWEZmeVOFn8Jn7dMlxWYZ3D5oPveaFAzAk3YWYGeja5H75lqZX8zVynLaHh8zqC
	 T5T6A/J+R2QLSobbCFdc9IJbqT/exQ8+rl6CVLtAmZjSI7ltqJL1PxHXx1USg99May3/4PNrNQy2EE
	 AEaRs/gJI3Yu1UZ8xgcj5teKvx+NCRPq9o3Sy9ISqEYZ8SRH4OA6c2Ivtpt9hu5MZusI9s0VsX2ONE
	 Qm62MjHasVn0f4YWlkEWKFKfZsCr9Qw==
X-Originating-IP: 20.82.50.241
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: e4f9875c-493c-11f1-8f51-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: e4f9875c-493c-11f1-8f51-f54febe22707:9
CFBL-Address: prvs=058643e936=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id e4f9875c-493c-11f1-8f51-f54febe22707;
	Wed, 06 May 2026 11:15:32 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 47A9F80525F;
	Wed,  6 May 2026 11:15:31 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 19A6B60B7D47;
	Wed,  6 May 2026 13:15:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	kuba@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
Date: Wed,  6 May 2026 13:15:29 +0200
Message-ID: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
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

When the device is removed all allocated resources should be freed.
In uhdlc_memclean the netdev transmit queue was already stopped. But at
this point we may have pending skb in the transmit queue which must be
freed. Therefore iterate over the tx_skbuff pointers and free all
pending skb. The issue was discovered by sashiko.

https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hitachienergy.com
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
v2: - use dev_kfree_skb instead of kfree
    - improve commit message
    - add missing paramter in for statement
v1: https://lore.kernel.org/linuxppc-dev/20260504161145.2217950-1-holger.brunck@hitachienergy.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index bc7c2e9e6554..417e8e4c111f 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
+	int i;
+
 	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
 	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
@@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
 
+	for (i = 0; i < TX_BD_RING_LEN; i++) {
+		dev_kfree_skb(priv->tx_skbuff[i]);
+		priv->tx_skbuff[i] = NULL;
+	}
+
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-- 
2.52.0.120.gb31ab939fe


