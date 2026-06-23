Return-Path: <linuxppc-dev+bounces-22953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713B7CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 02:26:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glQmV6fhqz2yY1;
	Wed, 24 Jun 2026 12:26:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1043"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782226384;
	cv=none; b=C/gXpo3CRFrXccXbo7rbQJyu+poMWmdFcEZ+gKICQCu5ZazYEbc849ZHVawTLItYiF/94Zc0YA9bxm555pFMiQ0szUYwhH3ViE5I2t3hCjSo+45QMuBTxrB3bjhmRXvxqKk0z/62ZPxDdzvaiZHsTPP1bwThRsH/pAJzB6VjuCe+eJrjZ9xHYGqZoBaM08OCSoCDUIlK1iCtgQgu0uMkdUMTlt+VPk7vGBxjh/EwUKVMaw+r6darE9FBSbhJNI2wPAoYdtPKoZnTCIqNOFXt7Zp3gUpuK1b05RKONxLLjpcBP9d6LMOtu+E2AD6KB4LwklahFErraR9C0E8IFD6wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782226384; c=relaxed/relaxed;
	bh=AeJlYzH+Z0sCek8zGKSy/7esmMSr6MOi3Ac8XXBZWsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eG1OqEJh28z2CeonyrMwJaUnrrXxGsCKIX50BSOk3XdDY/6ayB5f/Vd6awBYHbPIh+teHBIizzgSv8KgF26QLmTMUmgc4rR8pXqtId24SxU0dAkpCy7WiSb13lv3J0pP3Fg16bJ2hyJwwXS4a1u3QLU/tmnkenfXzLIWZMwFbviYCrfjipxisYYMZmgdq1WQdxHpWIhE0pf+d7UDglP0Bszz5sjWSngTWb9YKjcOBfA05ThPpc1hQ5tb8oIwg1DyXSnbhCSOPRnRbGbXEshrAzog0VujncSMQY/dyRjcOcGJVvjuU501ukoqIaGpa98CUdIwTq4DUjMkSNe1ft1Ncw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b/Dx8TLz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=taoye602602@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b/Dx8TLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=taoye602602@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl7NG0tmVz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 00:53:01 +1000 (AEST)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-37d7c265ca5so1912a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226377; x=1782831177; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeJlYzH+Z0sCek8zGKSy/7esmMSr6MOi3Ac8XXBZWsY=;
        b=b/Dx8TLzwTvMRqk0wE33C6n/6Ng/EqZ5m02v3AwNdlJ1KNo5BMykGNDVXybWdONSAF
         ckNPDNAIYTgr0PJZX0Uf8nE+heNEwXsdfGu7vjthb2YTr8S8Ha72buenfWCSolfs2E4G
         vu21RkuT0sxbdE2wr7mCBHiJCmsmCrobjaDlcMBS65asfxByZa9gsEFecHmAyfG59wmu
         TT3hJblqixpJGFFCnRf1zTMpQX9puIdWddwk1978Ja+PF6S+6QhU/kQAW/IwUaoks99I
         k1wkCMJ6LdK0AfrEoRHHcHAVPOSyqdOR2nrmUEGPDicy8wNdHXXQxXGkkElFRoAJLB+D
         jMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226377; x=1782831177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJlYzH+Z0sCek8zGKSy/7esmMSr6MOi3Ac8XXBZWsY=;
        b=JuesJ1aB3QlD/tWZ779Vr4fR0/KiDbo8kZHE9ad9DhBnPOZin5wtuBi3QpxLGzL+W4
         8ClB3igo41iMxHBO9fGjENi78sy5PHQnSS4OnbMrQeG9uScCLrS1UhYC3HiYhcAyzPPT
         ERrhJ4fhqb90bot7ZrZcKvTa7AwP5oWlpqE6rDkMTlzuGRIU2ItBRSpOjDK8f0/o44yQ
         AVyTnjdu7lyY07oG2VGCbytdPlYSJYY88eZ4mjT0EBTakXURBcGIUuDlTFlS96KucJLj
         UK7q9WWUTCJqP3pK7AP5WaMKKBNTB1GCQOrDfazzZDXC3UkYdZulwL51woWX4/1I4DXH
         /0Cw==
X-Forwarded-Encrypted: i=1; AHgh+RoTnftHpXUs75c/A83ADlNVjuxtudfN3159G4vE32U5ooB7+CRt5qcph9KOt2OA4RQsok7Vf13v+SbnxSo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzt8+9/xSRw0haJFo3S9DEDzNSBaapgy6iMSHzMFeCdNxRWWX79
	W5aqTSkcEf06iJTTLQoK5E78otl5N+I7Jw0Q+uGgNDhXIP1wl+zbo4E=
X-Gm-Gg: AfdE7clePDBFzYf7ls2UoBjBtfXvTx7oPgkkDwo0RodyGrzhm3Itx9gtRdPwt8rVCLp
	GRE4v7uub2125WHXjw2r3lCW1ooONHb0yI/2Ouy8wQpI3bNJb7xQJepVKXwgomVSpUz1iFljm/U
	HuJaZAPpREitvFf3g6cm38y5DnNH6e5Zi0Hm22/xqhXQ0c8Q9z/rxOTUCrUu9dbWnfObvDovjDY
	LUOYEFypoYoR9HKN8JpCT8+OyjNyEJixORPhbf/4eTzrouMR+nmyom0NSfM6iPPAuKWbOAtC2wh
	ZJwc9ud8qm6QxrgfVeBOp2rVkZ4/dhljfzbKhKZ+Adqnobl3gwTchE13Xc8dZpjMglvWz9tjeBN
	S67o0tCRlW1HQ/wB1OUC1d85rU3OE3v7rBjhaJs/H/zxlNrhj9i75eMcPAU1krhHSOidwYHol/O
	K0ttWgExjInu6avRfTRi4zHg06
X-Received: by 2002:a17:90b:3ece:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-37d15fbff00mr22298281a91.3.1782226376807;
        Tue, 23 Jun 2026 07:52:56 -0700 (PDT)
Received: from localhost.localdomain ([66.235.111.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cfbsm108727065ad.45.2026.06.23.07.52.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jun 2026 07:52:55 -0700 (PDT)
From: TAO Ye <taoye602602@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAO Ye <taoye602602@gmail.com>
Subject: [PATCH] selftests/powerpc: Add SPDX-License-Identifier to count_stcx_fail.c
Date: Tue, 23 Jun 2026 22:52:37 +0800
Message-ID: <20260623145237.32583-1-taoye602602@gmail.com>
X-Mailer: git-send-email 2.50.1
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

count_stcx_fail.c still carries only the original free-text license
notice ("Licensed under GPLv2.") and has no SPDX-License-Identifier
tag.

Replace the free-text notice with the equivalent SPDX identifier
GPL-2.0-only, matching the sibling files. The copyright notice is
retained and no license change is intended.

Signed-off-by: TAO Ye <taoye602602@gmail.com>
---
 tools/testing/selftests/powerpc/pmu/count_stcx_fail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
index d8dd9a9c6c1b..51a7565c6435 100644
--- a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
+++ b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2013, Michael Ellerman, IBM Corp.
- * Licensed under GPLv2.
  */
 
 #define _GNU_SOURCE

base-commit: 4708cac0e22cfd217f48f7cec3c35e5922efcccd
-- 
2.50.1 (Apple Git-155)


