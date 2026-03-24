Return-Path: <linuxppc-dev+bounces-18744-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EADFEC11D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 22:34:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgPwj5zFRz2xlf;
	Wed, 25 Mar 2026 09:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774391669;
	cv=none; b=QJ+EXdQPEYwQZuy4cNH26JSN6Sel9BHAqa5bhC0XiNMbbZDeVYAyku0XrvVLf2MsUEPztPhdeEyqbrElfQQErohc1NX8xjwsxgi+j5O+OhsEhNH2AOEK4cP+ziKbn2zjowcOubHCmf9YxhEfOWNugX+ySYQ7SCX7YKwudO7hYNz0QRs1yI3B3dhaPYYKYLReLPY9v90j+kASES6Xpf8UaInKCcXg7Mi2uN0vwf6AKNaS9ckvfkgprHUHeZ5QOt4NJEnMouoVMY8+rRD45itMdVISLswBGTMC+64ugkqTUIiKXBsRnwnMQrO3mFR2WSCKbal9YE39tFTYctfsgGmj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774391669; c=relaxed/relaxed;
	bh=9kw70daChVFhOHDmdtNwQp9MncWFEFeR8i+QDxsH2cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqPvlGO5PRWfWAH9HujIccQ1bTBdhykvlfHy3LyJ8KcZ7J1AoOxGJo2q6uawNaVJrfTFLMyXuTdEClC5t2z0E3aXv5/qFNfFEBDlRzmnW/RvkLInFiZJTlg7dWtr20PVNHszetlr6KgfvbNJyrfMmNd10UD0Al9OPDoBzIpAC1mp9QurRrjhkFlI5PNybzVf6wA7vOenuDNx4N2P6Tm1fBuKm//XFJu5oFRtQHNJwFoSYfXz0pkP8BU5Yfrl4eUWko2EKmptT5Am9VNJh+HpkwNytAEr+/Li6KJ9wzyyejylCpU3Xfm5ovzyLOXTEKsoQo8f3pPp1Qd8gbjyPXftvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bInkP22m; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bInkP22m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgPwh4KrTz2xSX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 09:34:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EC4BA40554;
	Tue, 24 Mar 2026 22:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1FC19424;
	Tue, 24 Mar 2026 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774391665;
	bh=MblaW0xP4HmyYQz3x3ZL7IUOWvhc1ECQYUTmSfXN4/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=bInkP22m7nMFnKEWUYwH/x4FRSROq0svEEH5MDHpZ+ompDxzxsgAzThXboUqycay7
	 UX5ejEw2x+vzSLwXIRtnVmvKruesuOcVNbW1R/t9Q5uMKyfTX7CQeo9sTgZagC2oO/
	 sPxQB099EJobK0YtwRF5+/q2WgcLcaNx8F4IfRK2UugHnXzncOq0dQgEj+m+zSWDCn
	 L4+Hm+asWy0OZxUEXM4n8YGZvsgr6+vfNyuRx3Dyy6+s8VR4GZxCGmSEQ75sT6W5By
	 lX4lMDRFFw41znhMUg71L3A2uOZnJoFfHqPgcYxgd+sjhS0itr3nEoIl8XEz0T7/Cs
	 4TRIAn3CayBpQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: qe_ports_ic: switch to irq_domain_create_linear()
Date: Tue, 24 Mar 2026 23:34:16 +0100
Message-ID: <a9de2f351ea71e4b794baaea8d9d790fbfac8d26.1774391374.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=chleroy@kernel.org; h=from:subject:message-id; bh=MblaW0xP4HmyYQz3x3ZL7IUOWvhc1ECQYUTmSfXN4/Q=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQeFsye28H7gys0xN9D6tUeNq6eE3Xnj/JufC+vrH9ff +7K1IzHHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAisbsZ/lfGeV/YFVcoMPO8 oqrc4T32c8XSb11z3vTs9YeScj2B2YyMDOdDNhnGa30y0T2zd7rm+dtvnlb/31rWq3k88dadxU5 ZcxgA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is about to be removed, replace by the
more generic irq_domain_create_linear(),
see commit 42b8b16fe56c ("irqdomain: Drop irq_domain_add_*()
functions") for details.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 5e3fae19f314..9b0bba64e91e 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -118,7 +118,7 @@ static int qepic_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	data->host = irq_domain_add_linear(dev->of_node, 32, &qepic_host_ops, data);
+	data->host = irq_domain_create_linear(dev_fwnode(dev), 32, &qepic_host_ops, data);
 	if (!data->host)
 		return -ENODEV;
 
-- 
2.49.0


