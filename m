Return-Path: <linuxppc-dev+bounces-23018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC9BCDE008
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 11:08:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmtFZ23WDz2yYd;
	Fri, 26 Jun 2026 21:08:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782472098;
	cv=none; b=DVcYc6kCTMZspYMgbgDh5O3sUlWvjzHSB7iIUIQc0IjNXE8KrnBurfczF6KMFixwnUy1e6WizYUlIij0xeZ++FCuyFa5Dn6uZV36e+lA7HHB+U80F7iFtlTzZ1v6rhPFzz6pfd8X+rGrz5WZoLOygqT854hjph6zdxL1huckMdPoRFTcOhJnHWxVVK8DGLzxiOWwSERo+/kF4xu62mPsIC0yIX7IzflNJ0RGoismFmNwrfTARi1YIZRPoFsUCY+/fbi5MrCkGnKZqN0mrgN/PBn7VZr+k7frp1/FfzVOI18rj5HkT+ilDBp19mpkkjtH4w0mHhA9YVPiLMLtpQaufw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782472098; c=relaxed/relaxed;
	bh=MGc6VVjGp64vB8J0Golhy+1n3cqG9BmD37kVmIrQuUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyNLt5mAI7eRwvz6UXdz5Sm0FIRKT5NAQsm4JwWFVAVkVvmYtL5pxHtszYUYWJIrFXAcF+lj5DIXL5MnADFjdcSZnTdlt4m0wEDH0ZVoqdnfszt9p7sRK00e6iPEEK9lC+mYrkYifft7gmH6mqpGgFmIUcR79Ex/JrbHIgOGOqnmTwYdq53EQ3+tgBWalTP9vkWCBsz7Grkoj4PQQgx8qxIgXLaEBEpGQklabyul79rst2Z1cqlsI0pAXMNNdS5Va+y2RD/JiCa9jlYM97LQZi0LaK1+QPvXiZvUEj1GmuqLLry8vt66M9kBj9HVxuLa1C+aBqDC4e5nyB/ZOOf+Ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pacMIG9t; dkim-atps=neutral; spf=pass (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pacMIG9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmtFV0hJ3z2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 21:08:14 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782472064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MGc6VVjGp64vB8J0Golhy+1n3cqG9BmD37kVmIrQuUE=;
	b=pacMIG9thAzNG6DkEioZQp+nD+sKMEXS1T6f5EKezioOtsf10cwM3hRAUVf/JwXno9NWg8
	QIPXHL2/eBmOdfQdLivZovAMVrKuEHMHtQyvBmsnO3h7qIABpB3d+mJTVXNt0oxnz1n7Xl
	UaQh1zYOkOqOcD83RplrgCbmwwvR+PM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: Simplify attribute description check in papr_init()
Date: Fri, 26 Jun 2026 13:07:18 +0200
Message-ID: <20260626110718.4367-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=thorsten.blum@linux.dev; h=from:subject; bh=MA3OVJEUNkdMomBsMxjyee+rPW4jpDgQPCabfzgQF74=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl2selFXBXd1z8ppNhP0hWO2mwgn79alHuuwNKgjol1Q S/uBhl1lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwESuHmH4X/Bkuvi0b71m/Z4F 4veehW14um32uQSNe/+WPprMndBuO4mR4X7f2u7F3Rf/zmqaXRhzK3jbDx+d2Zzd02Z1yvyT+c2 5jhMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Check only the first byte instead of scanning the entire string with
strnlen().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/pseries/papr_platform_attributes.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
index c6159870de0e..ff8adda02341 100644
--- a/arch/powerpc/platforms/pseries/papr_platform_attributes.c
+++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
@@ -325,12 +325,8 @@ static int __init papr_init(void)
 	}
 
 	for (idx = 0; idx < num_attrs; idx++) {
-		bool show_val_desc = true;
-
 		/* Do not add the value desc attr if it does not exist */
-		if (strnlen(esi_attrs[idx].value_desc,
-			    sizeof(esi_attrs[idx].value_desc)) == 0)
-			show_val_desc = false;
+		bool show_val_desc = *esi_attrs[idx].value_desc != '\0';
 
 		if (add_attr_group(be64_to_cpu(esi_attrs[idx].id),
 				   &papr_groups[idx],

