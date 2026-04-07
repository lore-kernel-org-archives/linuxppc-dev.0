Return-Path: <linuxppc-dev+bounces-19439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A11AFEEF49
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpYr5DjFz2yhD;
	Wed, 08 Apr 2026 00:32:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572336;
	cv=none; b=kyi65ExAykbEAkVr7mFGvCElh4SuDiSlNLZj3Oq2G7QC+8OdRSQnCXVCSWQ7w42mnw7C9Kt2y1g8eQ4OIyg6STdPMnwCO/QlXkqbGBZ/k4mnQqaRpjVdFIUHgjH72sFp2WyM6OZKElw8y8s4Uywa2e2sZrfPr9tP/B7Qw/RPkrX9BVoSBKYuu8ymYmpozLY4q0PRvRifBwYChHY31/LVfFz/OwPRZwB0t3mDbc8c4yMjAcCKMJeFB5YLWFhnNJHlkz6qCCjcGcQxuw+JDmyY4frXEO8jreHifNSKu8NDRckBRBnV4KzpJu/dALEiYzv4NSGSyAlwJIp12aXxcojlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572336; c=relaxed/relaxed;
	bh=Pe/uIRrlspU3/PcFgSkVRxo4DJTV1t3LxD3GPeG8ybc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alt88xbvZvyhrr4IlKs8i8zD+GP52D9BOEFvA43FO9XERRdjEI24xpYedVeEa9i7LyYi3D1feedsLx31vMJgrcYAQk8GN+rYOfRTXMPoV31wAepIFTxyGe4p7lzw2NIfVO85viGKz6dhw2rWAudzE4BHned/JimmsyvKe+b7M8dNuk51EoyY3+ueptPS4EFF44SEk8kepKjpWJuKOO3+2FgVVzyLxf016iV2tP8Tke17tfJMyVvAiZE8z1usx9GrOAUYT6UzLdksnGnBTvQD0nA+ZtujBg2iXp2YnPskL/eZ6nVokTlvlRUJzNx4Rbj3HRZ2OAtolahfLBc0vpdTqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fdRxuSCU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fdRxuSCU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpYr0Xsrz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 00:32:15 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2b24fede2acso28354235ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775572333; x=1776177133; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe/uIRrlspU3/PcFgSkVRxo4DJTV1t3LxD3GPeG8ybc=;
        b=fdRxuSCU2tSzYyPyisYzQIJXFsFzB92F2yftnyEgafFNEOkM8dPDjAX6A3hSWWkush
         kVX730Kt6/VVvIsYoWV1IHa1PGVuHV7ggNE+MMHIsgFkyfPF2hQVYDIdZx8KNG27iK2u
         JoPwnYfcnLyC+5NDTZTmqpxSMW7eWJc/uYabF7TVxzlNW0MnV5Fx/+PriC7PXh6mp35m
         lbgg8uuRrS+Eh+gx29x0w6nKhUOVJBG752qFc4yQbYcrZUSWobdL3QRB/MQoSC1gmpmA
         0ASlUH8UhUv8UR2gYlEfCKbGdz6t9AjiSiMLsN/WbxjrJmGzedOpTpjeNPjnNnOZIQnl
         lk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572333; x=1776177133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pe/uIRrlspU3/PcFgSkVRxo4DJTV1t3LxD3GPeG8ybc=;
        b=WJ2uMrn51fzRTn9nMTv/PUXUd4nbB9rohu8LGNfauAjJE0MvN4k0WGYzYOM6lofBbe
         a5hh9u6LA36uXUeqieRRe8aQhnuk2XAK7CzL3PcZvknp8HAGw8RTXytla+Os+fTONFmg
         i8pu4+HqyIJigm4H/cDB2rECzN6As2t+lK8dnQ7nE0vQNcTskdv8LwDpWtEGxWJwtbg3
         4DofzPUA3C78V4jbLrw5SEfmE833JmH4jrkOMBtAvoC0XokpwIsWItBOULUi+uVQ9JZr
         OJ9F8PQDECF32d/sGizxzLyz0Fikoqxr/sWXOBN++XQ+8kGFqXcaVZl7/wLOl4M9giio
         LpZQ==
X-Gm-Message-State: AOJu0YwRXacJiFUS9uyuowSpEuIoHSW7IhlgQKOgN8iPgqBoeEmKhH7f
	C/6S/WyIgxbaAfGHrqYTPLNQb9CiFmLbXLKLVMY2C7/bBVf/+PeD5SpGwbVUWg==
X-Gm-Gg: AeBDietkjbKafe+t6COoy6QhzV651KsNZXMsDtTRtevG5MO9/Wu5Dcm4GNwgM9C3HNr
	XwpKtmtpH36s3CETcd7FFSqzYMFiBwBjf4itinWKnDBMBV10ReNIO8qkH1dBP3/EiYr69QBxZwt
	KEC3DWPVBc1SRx8ApzWapLmL1rrKh41BU0ZX7LZ2Fv9D9WkPjO/MQUTBo35CLSqJdEUOoc65ATK
	poEgGWnvx5Lxxux/MFa2/M7BJ//Tjlt7L9ItMLf+gARyqOgFnME+K/DjaikjfTOypXlskSEmilI
	2f9tY5bS0bFKhsW/yKVlF6H/yyTQt5XV49S8NaGcdtwNRtWMzlp4K7/96bVaeCOCWm8TS/LIHU2
	ucxh5QofT2YZYyfvi7rUFg1wi5hMGOVZeE9/BHHDMhKlb08P+gYy+FbMkkzPylAuVPTOn/Mgz0G
	hFSXh/VHo9Upu3jvnaY6rX6aG0US2VZd9NC+C2HSvVkodepTp9ng==
X-Received: by 2002:a17:903:3b84:b0:2b2:4ffc:a7c4 with SMTP id d9443c01a7336-2b2818b3addmr165803545ad.24.1775572333419;
        Tue, 07 Apr 2026 07:32:13 -0700 (PDT)
Received: from Mac.localdomain.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbc58sm181201525ad.78.2026.04.07.07.32.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 07:32:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v1 4/6] pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
Date: Tue,  7 Apr 2026 20:01:38 +0530
Message-ID: <108d32a56d9d4630ed2ba7d8ecce9679adf8671f.1775569027.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775569027.git.ritesh.list@gmail.com>
References: <cover.1775569027.git.ritesh.list@gmail.com>
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

We don't really use task_struct pointer for anything meaningful. So just
kill it for now, and we can bring back later if we need this for any
future debug purposes.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 5 ++---
 arch/powerpc/platforms/pseries/papr-hvpipe.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 57ec50e3e883..7242a14eb5ec 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -487,7 +487,6 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		return -ENOMEM;
 
 	src_info->srcID = srcID;
-	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
 	/*
@@ -497,8 +496,8 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	spin_lock(&hvpipe_src_list_lock);
 	if(hvpipe_find_source(srcID)) {
 		spin_unlock(&hvpipe_src_list_lock);
-		pr_err("pid(%d) could not get the source(%d)\n",
-				src_info->tsk->pid, srcID);
+		pr_err("pid(%s:%d) could not get the source(%d)\n",
+				current->comm, task_pid_nr(current), srcID);
 		kfree(src_info);
 		return -EALREADY;
 	}
diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.h b/arch/powerpc/platforms/pseries/papr-hvpipe.h
index c343f4230865..4bdf7bb2fc4d 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.h
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.h
@@ -21,7 +21,6 @@ struct hvpipe_source_info {
 	u32 srcID;
 	u32 hvpipe_status;
 	wait_queue_head_t recv_wqh;	 /* wake up poll() waitq */
-	struct task_struct *tsk;
 };
 
 /*
-- 
2.39.5


