Return-Path: <linuxppc-dev+bounces-29181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FBBCA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 12:22:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j22st1jNpz3by2;
	Sat, 10 Oct 2026 23:22:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791634930;
	cv=none; b=URhQkzx1imzApxaJUJt+O3SiyFJczjhSngCvKBiB+7V0O9Px+j+9RxvmqKvJBE5Fk54cl8vpltoloYR1v5LQrNyD3e84syNjvHhnqam31AgsQ27dEfHL/VfZekK+RW3d0cuR4mgXKiIkqoXgU7tDT3RlOPzqiQrBqkUPL9bcKWt9+ZZNvJgG0S91ZbbuRkPd8BjsIvpRZqOeW4zngWPIp8oannU8MtQD71jQ70dGoLAsjZxCKLfBjWopQFsYZpq+frbE4h48vWn5HPYp39wPXIc72O+r/cz6cLr8v3dVyp9HUfKvqpoGDaoJNSV9trVDXccNTd0DEfsFAkYzjm+6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791634930; c=relaxed/relaxed;
	bh=OQBXMXTlhy1CovXj6ndFCC7fPIXVPzECjvtJukEq3LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTFU4vBSEmCzz9XcDi6BDnkIZHOoiODL/40VVXZFYbFa/J0kryuUiVSjLbDb0mYA8aSZakXCK86St29iFh/YBFrv09SkX1x/STZx8AANVnerGFxu2yRMESOYORXY6Chh9wrv4K3DvfjHPF5pOlQQjHk7ngWSsUmV8zUiVOUIwBKE40xkUsYcdw82Ys8vYHVFgZ/A/M8GcpGBEjksPS0zkg9bQj68q9DTJqcCufKyN+d/gLqTJOy9MF/Z8TjUP8F96jSlOH+z2ItfzWysxuQhT2ggvygHuD7KTV6iV/JIkw8j+UVR97NFfkiE20mb4N2ydD0nJe19jwwO/mvjkCvn7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lsoLzTjB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lsoLzTjB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j22ss3jRtz3bSn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 23:22:09 +1100 (AEDT)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-15354aa70e8so531020c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791634928; x=1792239728; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQBXMXTlhy1CovXj6ndFCC7fPIXVPzECjvtJukEq3LI=;
        b=lsoLzTjBPzk8VKkf1hx+GdY7tG5iWbHET6TCEFtqBM86NCCfySLEZZB9MeUQ6fzyAz
         TqeOeahEhV0Wpj8uN11Pkpft8MOQ+sX2chV5Ifzksulxhof17RDA0mVd31KL3MSNqRrM
         BHPwO9Y7ZrqvNuGgzD2VQ6+ApL5+uLeVkccBH2TcgySY4Frqh7vwYw/nDXWy/boexAQS
         BRwt6RH+/4n88XJyR8uKIcOS+A7aiPLsoZYjTPYPx2hqVvlSVH69M/0bMeqI6iaYbmHt
         G+2uJQr5PFk7ZCRVBs3QVOCDcMhcfznUqxsrsNyOLhih0QIVhmhSRdtbM+E3kbRAFgbq
         2HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791634928; x=1792239728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OQBXMXTlhy1CovXj6ndFCC7fPIXVPzECjvtJukEq3LI=;
        b=FK+GTUFA83pJqoG8SONTIl5kjf8i8J7++iaaWyIdbkbk7ygOkqcqISGjbn4zb+00Pv
         ZfLzG+QtfKt3Ixx3/lGDRoFNQhXbZa5Vtg1ILeYa3k3YzvbnW/7Zad8IMggcRsAAdSc6
         a+yE2y0QL/kbkrzF3oL6lifd+SDtHnVdn8vM6diUA7ZT1GFigV4NbwAljrLU2mYVN4zn
         UdR1fYHxTdz3D5V4in3CtWk5sdYTNEZ2XZj9+c51TV3hgh7hRTFPU519OzLD0YooQRBR
         2Ihic/PerwA3MqjJ3XRWFWEbEPDmJzp3a+y2YC7YFTUdhwaFm9N/YHQ4sSL873Ni63VL
         j3jg==
X-Gm-Message-State: AFq9FYJbb+5hEF1MEJCXF6n9Owy9l/o4E/FBAAIdNHWvm7Xk0+E6cr+E
	je6VIGCGwk3mx8zb1w6bBXvXNnv23ZVyAAoHZzU+dJEr4xpoG0VZ9AuMjkGihLZM
X-Gm-Gg: AYBFou3CQDbKNUkIk66SHmptfIWugQnosIoO+vqrjpeKUYKhBC4k6RSt7LejO18Fejm
	3QVbisInQjhF4Fa6PihCN7Mel5RfjIKy9oePpzggdL98Bwrvsl0U3U+CDizsm1k3s0/t7ryQKf9
	wevnN/acNX0KNnNJB2BKrrRZm9G9fVhpC+Lts4poqZOXaxYSdC5HWIZIS9eeMigTMRyiNekuT02
	ndaiO9FadfdFk/+vBm9x9aVwoczjCd3Tv/9DvOVqCNY2hO8eOcghf2wsfyj3usQGF7GFN/NLotE
	D0rvdjRlXP4iS+hrRhaSW6WRCKqY2DwoV+kXMJOf0+K7YpkXNf8sXTENhc/GL7g3eFe1Rtht9hp
	Jdw+dfCRW1uPlCSYRvHDkfs1etr6WtVCeZeD5BBJc+cIwHRl1xXWhtaddv3PrYsOwcQtp+52dKr
	dZ8nsCuTy0nETxYk84tpMgGFrTEIlj4Xxu3NwDluBE4msnTSeUMKWmdYj3lBH3/l0WDBKAtnqz7
	1lcmRdvWqqQf1rVrAme40AP52CNATtA4oVbvsPbBT/M9T11vb8wcvCp4DcI
X-Received: by 2002:a05:7022:3a88:b0:14a:88ce:74fb with SMTP id a92af1059eb24-16a61d5c320mr8327477c88.45.1791634927663;
        Sat, 10 Oct 2026 05:22:07 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm15401816c88.5.2026.10.10.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 05:22:06 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 4/4] selftests: mm: Enable memfd_secret for powerpc
Date: Sat, 10 Oct 2026 17:51:12 +0530
Message-Id: <80c52d3311e732619c0c339b4a03e92859ba98a1.1791608423.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791608423.git.ritesh.list@gmail.com>
References: <cover.1791608423.git.ritesh.list@gmail.com>
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

Now that we have the needed support on PowerPC Book3s64 for
memfd_secret, enable the necessary selftests for the same.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 2d5366196e30..3ada7f5f4151 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -70,7 +70,7 @@ TEST_GEN_FILES += khugepaged
 TEST_GEN_FILES += madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_populate
-ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64 loongarch32 loongarch64))
+ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64 loongarch32 loongarch64 powerpc))
 TEST_GEN_FILES += memfd_secret
 endif
 TEST_GEN_FILES += memory-failure
--
2.39.5


