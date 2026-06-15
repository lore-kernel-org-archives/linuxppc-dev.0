Return-Path: <linuxppc-dev+bounces-22651-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C87CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfFTd06Vsz3bxp;
	Tue, 16 Jun 2026 02:10:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781539844;
	cv=none; b=jfDtiSuf6zuVZmRUM1w43L6YFSBMbsl3UkDrHGyAVaU3zztwIOn0/rZaPiVPsUE3fL9hc5pG6KkoAPOM4TJUi8CWI9xEWKMUiLHhN5RiMKOYB3GBYWJ8wmYOdkVH26ziTzGSNUexYCDQDc3FdQ+ouB0fU03vk2hlz6GvmXqmjae0L83E3O4jgYaZCAMS329VNfWywchsfFvj/BCTIL7v5/eUlPijyWDMF6Gr975ngpWp3Js9xH1oIQWDePuNEbc8icsU+Dz6Vp9ATxoqW5xsTO4mjtslSaMOk9NP75vFUqy27ZYFCxmWlpv1tL6uUqPQpzaQx2JYyT15n2lszqUpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781539844; c=relaxed/relaxed;
	bh=s2Nu94G1QYwV0Emq9ZE/vR9zmqebZOy/GJaBCjCaRlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osFQBnXuyxLat4MEgDOCPbFro2cPvVPMNNZB/AzGU4z4QBQedw/BxsQARG7E6CoMUbL79TU/7PsGMdsDuCpw2dG86yF2/x89cjZwi20rGEPbuOrIw7smuglCPrRz+IorMICUBa8JB2tnsYJ8iSl1ncZ+yZakg2pFg3RAz8uoE8q3mNLcY+MT4xdGgQYcELTcUSnz5pLhV7/PEE9aaafPMEk02CwDKtWr6ZA8dsnc43GrNRVI0k4KyMAy8Oa0kXHuoTAxxYbn2Zq7UykCS2XaAH/zP3649Z2ZpjbfARvb0Gjpz/cWaes4jcN9x7DGd2ttJE5atwezY4CVx4RM1Yio2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRKdXCq/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRKdXCq/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfFTc17T8z3bxf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 02:10:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 976B842A3E;
	Mon, 15 Jun 2026 16:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241071F000E9;
	Mon, 15 Jun 2026 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539841;
	bh=s2Nu94G1QYwV0Emq9ZE/vR9zmqebZOy/GJaBCjCaRlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hRKdXCq/Di0yDVyM/BFZpVJYk+Eo4IVGGmK6eddql8FPf7QRcGa/NKyve+FzWWm2n
	 nJADHQ8tH3yvoRTcOANZzqjjWF5Y530YCZ5LYQjvz3u2xlCGiREWdeA70FlL5gEn1Q
	 Svf4/E+Q7kC1Ie0zaz5N7hCkhTAMur2BdHw4GGOv6qLkW00aBTzr9VYF5SH8xyP1ud
	 V+xPI13vuxiIZZNAwZG1o2v/AayOoKL2gptSuYRVmPoWHRLgBV+Gky8QdCg55vlxgG
	 PB8jN8K+g+cr0IfwJFCDqygIwgK4O1j3UISteGwd0/qeAPTbN9MmZvOp0HBcbTA+Uo
	 tzspBhR4Uc2ig==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 15 Jun 2026 18:09:05 +0200
Subject: [PATCH 09/19] powerpc: define DPS root partition type UUIDs
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-discoverable-root_partitions-v1-9-39c78fac42e2@kernel.org>
References: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
In-Reply-To: <20260615-discoverable-root_partitions-v1-0-39c78fac42e2@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=1H9x4pEZJ9qkAPBU2nBzdn+Fy1Js3SiNM+vLUchH+X8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkGylctNHnUtn/wDAwTbLtt+l0x56bd++Z5sgGO2cJ68
 wI2hWd2TGRhEONisBRTZFlWzsmt0FHoHXboryXMHFYmkCHSIg0MQMDCwJebmFdqpGOkZ6ptqGcI
 ZOgYMXBxCsBUH5vF8IdDcvnNvUHJDBJxkv7/nT87dn5N25FVWr6v4MqhD5vaewQY/md4LHCZUZ1
 vNLtYcH9OxvxLB7XWdrQcfNx8+LBMxPSrk1kA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

DPS [1] assigns GPT partition type UUIDs to operating system partitions.
Root partitions use architecture-specific type UUIDs so the OS can
discover the intended root filesystem without relying on a root= cmdline
option.

Define DPS_ROOT_PARTITION_TYPE_UUID in asm/dps_root.h for the powerpc
endian and 32/64-bit variants described by the specification and select
ARCH_HAS_DPS_ROOT_PARTITION_TYPE_UUID.

[1] The Discoverable Partitions Specification (DPS)
Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/dps_root.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e93df95b79e7..e611280a6057 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_MAP_DIRECT 		if PPC_PSERIES
 	select ARCH_HAS_DMA_OPS			if PPC64
+	select ARCH_HAS_DPS_ROOT_PARTITION_TYPE_UUID
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE		if ARCH_SUPPORTS_HUGETLBFS
diff --git a/arch/powerpc/include/asm/dps_root.h b/arch/powerpc/include/asm/dps_root.h
new file mode 100644
index 000000000000..6b3592a73d3d
--- /dev/null
+++ b/arch/powerpc/include/asm/dps_root.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_POWERPC_DPS_ROOT_H
+#define _ASM_POWERPC_DPS_ROOT_H
+
+#ifdef CONFIG_PPC64
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define DPS_ROOT_PARTITION_TYPE_UUID "c31c45e6-3f39-412e-80fb-4809c4980599"
+#else
+#define DPS_ROOT_PARTITION_TYPE_UUID "912ade1d-a839-4913-8964-a10eee08fbd2"
+#endif
+#else
+#define DPS_ROOT_PARTITION_TYPE_UUID "1de3f1ef-fa98-47b5-8dcd-4a860a654d78"
+#endif
+
+#endif /* _ASM_POWERPC_DPS_ROOT_H */

-- 
2.53.0


