Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6717606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+wHkq/d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1ty4TNdz30MY;
	Fri, 20 Nov 2026 15:04:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147482;
	cv=none; b=l3Fo3KtZCVumLzhup13JdEDyZvBAphgyCeleNYt1z51K6b6qfmKS4t6Nzl2jCgSJYDaTCcEg+jqQyheVz/YN1JS6/AGJlT3w+z/hmsVwsH8dxzrc9NrOZ/G2fgtQvjPsyTyTpioHulWjwIa57dOSqzUwYByX5E3IOqugJlBKEs59qTIpHPlm6yoMTjjnFdhOV1xv8bz31EsuTCuMrEIw/3lzJ/OoZcYSHatW90yN4c45pRo0TYIgZJfe1IhHaM9Cw6kPrkB0/0c2KUHJovuyii3rDerJ3aTrMViTPFO8WeZq9LYGXKBtp6DZGfcw+h3GPV0fMjIigfacIuN3DDJTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147482; c=relaxed/relaxed;
	bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GI0w2hApPA/p+kSZO2wWq78p/wcREG/DYG4z+dtLFCVQSyXq7oQuOSsUfY2I9GdTgmae0unc1kajcTJ1N3kEgy8uXtBccxWbaojsGDSsWa4BlYBqBAvSs1GHz6V+1G+VEa+r5StfeWq6/DNMWzqR/c8Va4eeTaXM6BdMzY8Pdq/TVj/uz+hejzwa6feboz+ORssRGK/QK2vk7q9GoYEh//52LKyAZmQz+NevglTPGICeAocpsCbuc+JcCaDcaJnTIFAhKz2H+p2an3qAZGN57SEheLK4NpeGXzfwvVGYiSddBRNZUzqRsscg5TJKqDaMkcN+CuKdD8HB3thxUxUFFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+wHkq/d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+wHkq/d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tx6c7Sz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:41 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-33fb4680717so1121646eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147480; x=1795752280; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
        b=p+wHkq/dORSQAMva0TyuZNVJiThQNqHLPV1zThOKgi5/zgFN7OYHbysQUuheyaoJja
         CnPDlkZBOKp1FZ/BtfFad3ekHGFR6nOsrmuGilOnUHWmlU+r2ldIO/QJvqneX4U+HHuF
         qZKamSyWwvBXX6xIC0jrYe+M4isOeOHubcI1Uykispnw3bgJwQRUJKuKFGh8h6ZLl4Xl
         BTXL4+aeDziIOO1w1hEZYTJmrPznUTx1MFIk3PdBwne2DxHI2Tf3dvkQehkslyRGTRFK
         WO/875L09Dh3fq0vOVAQFSL+LMY/jIpvcTBtsaB4M5W+hLm61aNqItZymDs6ZfTtr20R
         VTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147480; x=1795752280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
        b=hZMdDY6MhfrOCEAS1mXV9wB8TpicmgWIXXj8Y57MlM6fkVsLvPoZUwtFFji0jeNQxx
         CXVXhnfE/ZIyNoMvCv7AMMdFDVeXXqyDLUwvSXsxGXa2tCe7LbVTjqRV+FCOkkaY4qg0
         VqdBBr7HkJp1vdpq7KHvHlWXXhVgpu+LsMTVhP2VDUZOAPwMfH2jFqteXzlBv7a4kEiA
         JRJeoPudLKuj5nkzpg5DKo2j0L65x0p89vvGIXHfDvdQoujBNl3rNMVlV9NvnpmzZcJJ
         oAp7EQGgNzneV5FHyw9e6cYQvdAXbpf7YGOpC4urIKFwQCaknFTPFobunCaOiWNzFtw+
         Ogfg==
X-Gm-Message-State: APuU4Z95uqT08Py16rMKZt7MPKcmfMUEg39GaAGg+mLyg4nWaOtY5Eh/
	RAJweAjrBXTu/O1HEcmuwE96cKwfvhpUNTTy4S4snGLa8tag+BZhYi6jywpEHg==
X-Gm-Gg: AYBFou2Nkh25Zg4dZNdceX24I9nz32nGGkgx85quSSkZ1Ip36TRJH98Vt5ZeDKhNA1M
	X9DmPzol7O5p8R8eTHAlwb4I/BoE7WBUKxOI4/nElWbrW/iuDK3UrEIlMQuyHHk3z9qyNKoQIg6
	lJ2a5inqRpTHNQ6Bc3BjS7sf6ZgO9fJHyjVr8icFrdEmD8/zfdLYNSpgiU1ZTTjrH9gyQEEzIWb
	1ud7Yg5ZgbEwIRwtZ7QUctuvQmZUwKsO05WodKAzJ89M+XUtMTCkJz1M3fp7BkXt6NF2sbL2PBx
	BXpXE6YuC7kdOOOYRnwIFUuh4aDhCJv7N17Z57QwnbvoDWArl6cXgkyXs+WFhCrBkBWcqFsYVT6
	S2oJZbLQ07YNhU0YBtepeTr58x9tuVIlvPsJipGik5or1o0fN/goLHQNQFo7PLrzccSZjcvQWjU
	1xVp46wFFJsclz40T0G004GjfBA18aPlnF73SfzMURlz1VfipjXmY0z6WVlq6tQGhvPKL0kXLGN
	Ntu01NSVP7abrvxoqN8uvc8z2LkoLIYsX8SnVw56c1qY3utny6HU75j16kR3sUzsSNogxcclVFN
	O4dKXrBeBZZF/xamtY9WMAa9uzLuLXIYCw==
X-Received: by 2002:a05:7301:4617:b0:36a:1e0c:e28d with SMTP id 5a478bee46e88-3856c2c506fmr1462609eec.4.1795147480140;
        Thu, 19 Nov 2026 20:04:40 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:39 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 17/19] powerpc/pseries: Enable context analysis
Date: Fri, 20 Nov 2026 09:33:16 +0530
Message-Id: <778a4d18674535c24b406f6134f327d7af34fcbb.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pseries objects now build with Clang context analysis enabled.
Turn it on for the directory.

This checks that each lock taken in this code is dropped on every path.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 3ced289a675b..d5f9beec33cc 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CONTEXT_ANALYSIS			:= y
+
 ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
-- 
2.39.5


