Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAED606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGaFXU6t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZGqh3Kn0z2xjN;
	Wed, 25 Nov 2026 21:58:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795604288;
	cv=none; b=G7amwKBPJLpSL8jV5nI8ur+OR8Lp53StxaXJmPCEhA8fMAIuiGiOqFU+YMJHAPeD0e+xacXuVQEbjjbhIqy9A1gJ/gobopJO9wyzIMChk4Xjh3NsU4wk1N7zHPYDVRZfuA9615WLMJ5RZ0rS8aT1yyXxQYDTqp6YsSc1S/ww+akYBolTDZvwLDabB3z86vkzrYMXdBTeXglfAaPVewP98k+6y/d7BKgaHfhrJ9GjoVWG2kPAYYYtM659Zfd4dKnFyCVm0SxqSxh+CHqXAh0qWbZpilFwip12YjxXjMKEAdk6EiYbowaeaLI1nLmHTUrhso9qPaVMoCTg3Fc6BZrfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795604288; c=relaxed/relaxed;
	bh=ma9UfoRjDo/vf7lSsxwhVENTykC06T6QjtKAp1TLkxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdVayvapgqF7dtuKHEMUG12G9SHqXLwEW2kaxXp9KYDg0RUcPFe84t+6+IlMmXdaXtFF2woQMQ4FGIuTL07x8/Ml53A3Df3cXRWSolKpmT1mPfbRtUZJeTaediADuQ4eF0apf0T+4EejKIEQdIuOS8wqyvXEMokvFv3n4xZEx8GpxzbCncAPdcyYQR6YoMvAV5ul82vEbyzRbtAgSJ0KLyPVExijpD/zSi9rGRhclfFwYWocOME51LRvD3ftxKkhIaDzxW/KD/aDXC4/6OUkcBDiHxPCuhxsU56WNLQroAvu8K5ZccuQRwQqPS3EgZcd+tyPL9TpWmVpjR5hxVHGhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGaFXU6t; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGaFXU6t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZGqg43bGz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 21:58:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D0D8403B9;
	Wed, 25 Nov 2026 10:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D7F1F000C0;
	Wed, 25 Nov 2026 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795604284;
	bh=ma9UfoRjDo/vf7lSsxwhVENTykC06T6QjtKAp1TLkxU=;
	h=From:To:Cc:Subject:Date;
	b=LGaFXU6tkAjlp4FwLaCiw8HhFEZ9KSWPrUR5rbSverB8y29jXBPbMKVCllhr/8QNE
	 NA0wA3lX6eiSTGHbgxsU38UqXoflLaqdDNYUcTc/K+lXYgOzFLjz5uI2GUJUJ4c93J
	 mhi7Pw4P8wq4JdGjF0PhVlzzFRVTGz2fplc9rFkMdUU1RQT/iZpzb6cA/3g2FBQUFb
	 iPyDrscsKK0R2aA4dJ+9U3/idq5SkMNPwd4MiR3EITCyOnzkgEi7IyolNGM/7J3/Ek
	 R8SMakYaATG5nftz8PHYhci+3lJjfVjlRXYI466dSU2vJCbSMIusi/mlK6nII511kG
	 kLX9ZqFaVSTlQ==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@ozlabs.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh/windfarm: Fix fan ID bounds check in smu_set_fan()
Date: Wed, 25 Nov 2026 11:57:35 +0100
Message-ID: <20261125105737.273342-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=blum@kernel.org; h=from:subject; bh=TdtWrvYtQfd8uYU8MDm+CKlfHrwzUShEnMvlQ5goIVw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNls+xVLuWdfSM5t5N0hOWXaidWRzBeZ9Gt+XFxSl+DFx ai5r1a2o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACZSUMnwP3i+3h1ugb77WXXz uhRPifzVbP3nvLD5jJ6k7tfUnBuxQQy/mLO2J1asM82ZVrDAnHXRzA0bFzLs0j1pm/2qwrTs1Lv DzAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 14-byte legacy fan payload contains 2 control bytes followed by 6
16-bit fan values. However, the existing check also accepts IDs 6 and 7.

ID 6 stores its value in the last 2 bytes of the buffer, but outside the
transmitted payload, while ID 7 writes beyond the 16-byte buffer.

Reject IDs greater than 5 for legacy fan commands.

Fixes: 75722d3992f5 ("[PATCH] ppc64: Thermal control for SMU based machines")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/macintosh/windfarm_smu_controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index 9adceae74345..f430f160f246 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -74,7 +74,7 @@ static int smu_set_fan(int pwm, u8 id, u16 value)
 		*((u16 *)(&buffer[2])) = value;
 		cmd.data_len = 4;
 	} else {
-		if (id > 7)
+		if (id > 5)
 			return -EINVAL;
 		/* Fill argument buffer */
 		memset(buffer, 0, 16);

