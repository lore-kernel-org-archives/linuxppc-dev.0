Return-Path: <linuxppc-dev+bounces-26920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09177C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 12:28:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg0TS1bWlz2yps;
	Wed, 09 Sep 2026 22:28:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788930599;
	cv=none; b=EKaRRYKQUDiLCIrP0ktAyNaTjAkMDsZYI9V6rc3cNpMRqw8RHwN1Y7z9nu2amwM6tvYmtWpmsU7rJ6V0dzeWlMA9yv6pmeJyXl3n3iTWkEpwxD4doxt9PL8VYMolROYRKONRazhGjcswFNjugbdyXzMqTvne6J1gLpdGWNlvSLNHoodN3XtEAB1kmqvmYpOzz99IUCH+r/UI4MCctvjrY6WNHYIyzUg45tfHtQ9g0lynS5BUTjrrtlNpU9//kEW2qIyAuIkITPV97ukse5Kaat8nyaRBbtvdZyCxXeSzvfuausphYLxROlJFxHSMXFi/pK8LaT+aXmjV2ZkqDkb1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788930599; c=relaxed/relaxed;
	bh=j9TdbRSgBViFUc24m7gofNTrR9YA9kT863lpgmDnSEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTAScrhFsqdo3WSPsDWqZQb0pWRK/65M2dDr5pzraD5t55X9wj5osD9JZb0cTzBYNhvkN6Mn+g0wlZohh2nJgPTll3yN8bkKvG3+qUXeNlnelKQsH0Iddd2STLpdARj9EFDNGPty9paDmrLmp9kr3CD+hd86sHhozQ4Xk/R/00twMkq2ghsWBp3TST9d6Dy7YwWjF5Gbx5hfPeP1LLc+MGVoZJIVnqBzYOOTECL7oZ5V31polm5G+LNdk09WPfh/LI61nX0iFFNMy4wifNImxUalADyt2/zWZmVdnq4tPku4ddhIc5RW81h9Q6Ped+Cys56Gj0eJw8bk+b1ONbQkBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=lCIZBBt1; dkim-atps=neutral; spf=pass (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=chris.chiu@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=lCIZBBt1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=chris.chiu@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfplT0XWZz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 15:09:55 +1000 (AEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC9733F620
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2026 05:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788930590;
	bh=j9TdbRSgBViFUc24m7gofNTrR9YA9kT863lpgmDnSEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=lCIZBBt19kyVpWL+RKC06s8Sp9xRo4MM8pNH4NVyzcZ874xH/O7lGRgDmbK1r341G
	 Wrt5+AcKQsbJ4Esswnqq/iW7KyVARy1QCnPKtBF8wa86K+nDRcKZQNO9ZxlcoXlxae
	 YOmvXoKxlzS/gyovvtodH0ckAuOJ53h7j0PNq6KT/jaPwtnUKmkyXSaCrQ3x8G40o9
	 lCPLFriOWN4PctaSeZGpnqUtCbqtDhmo+ZaYneRUiteIsVSuWUd53b54EfX1DE5pZE
	 5jW1Hnm4rVRdl1yvCVbLjYLb0ZxtG3ZhjE8EF1TBk+NdLKuMxT1Qe+Dy1ANvoqQ0at
	 pdcdQfjoKM8cXbZ4mmrGsmojlAIzJLhjLUwYAIrbbwMujkiAFwTTTlv00vNcSQxWsB
	 dDkmLz5EB7GLAgTrrxGWZHilfTYB5J3Yye39/WQhfFzwjgQkOwgspRdJMMxmlWaWho
	 DSeYzzEPjbAD04kGy8IZ9WRc88ADJuYDyyo6mekSFxzBXIVhQUtnLkdraK9tok4l6J
	 GFw7wY1TIL3o4Z7lL8be67j6zHfIu1w749b54GnQS0CtAaRu+K9+xpQ4j1+udfagcN
	 JBYGcSaJYo3U0crr556kvBqX9bXYyZGGgz3zSYQDgOZBnlyhQINNVjIBiZFV06uY1/
	 mFuLvkol+GYlRgo0mZ1Q7Amg=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so6419896a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 22:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930589; x=1789535389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9TdbRSgBViFUc24m7gofNTrR9YA9kT863lpgmDnSEw=;
        b=s1OXxgwIOQxFGZdzQBSA/rF/XObGBg8E0JlCbff95c6s4e/psNYg2PXM2uhxks7pR2
         3+g9KLeXZnQWonfRzGmsw/XXubpz8f5+bN7YqhoEHVxFY0WavIaGfHNb4it47BLJ4nG7
         K8J1Gp8weaYoyzGUhPEarFQ5erZFfA79WHMSO4jxUsH4q/hJi+aUzyZ8SB0KxOGQYdjn
         uN2bcAp8NS2wk0ijgVmTSmHV0WUmSTrRxM964O9yzJ9aquMkw5wlIuIHI6brgd5l8Ifu
         JZIoGpbnfaieh/TbcIeOygdDlsffHMbH4FHoj64jdApFnfJZKvttGAeSgm6Lm2y0ot/X
         nwqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjc7mN1R3frhkFTw7TXo6Li/de2e1VwqBojZjjkWAGpU1APONzXquUxjKZqI/bfdRhpK7nQKjm9E7kAns=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mqxtQSPaw0Mse6Wi0BWhyrw4XsJfoFLW40pcYCEXh/C+8TREUi
	mv8OK3zppvYYlPVWqYnMONHP8kJRThqFZVKEwnqefrXdONH3GzmWCHEsA/+4nG0DuZlqcwctrV1
	jHlRQ+aEVhA2ijiFOJuhXLQCSeDnjzKkE8Bnbii1p7IMI8o7heAh+gKbFr4P65xyp5NBQ5iq241
	lMbvjW+io=
X-Gm-Gg: AYBFou3oMCXd+JR72RDaDodO+coVZzLch1OtbOKfLWYcVPo2eUvp7VbOtt3izkDPDAN
	zUCWOOFUi/5sPuCjOhnq+vJM08OoH69dQJFzFMDBX7hOLxX+LVi9gms8oiIZE6yNHJPzKKmJphx
	YwaaBqKUvLGcgoZKypc1Jv8VJa5g4PgG+i1zKWh5odd/lzhlpvYKFoYerAUGYJ4EF3pWKIj86QC
	njn+RWtCYZfzbVxfGzYiTFJvz/nGc4JAs7IzuI3C3Xkpa79sS7w/nnLyrZq2vVie+RlE39bGdyX
	DKc/VbYeOrvomROlX7qPhTH5sLEuDaErTXeySW3SHWzePBlBEAYLl27UdTbLDb51fD5ZPbh1D+u
	oar2at8fzOw==
X-Received: by 2002:a17:90b:2709:b0:396:7c01:553f with SMTP id 98e67ed59e1d1-39b086533admr46734618a91.21.1788930589119;
        Tue, 08 Sep 2026 22:09:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2709:b0:396:7c01:553f with SMTP id 98e67ed59e1d1-39b086533admr46734580a91.21.1788930588662;
        Tue, 08 Sep 2026 22:09:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c1a2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm19069102c88.9.2026.09.08.22.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:09:48 -0700 (PDT)
From: Chris Chiu <chris.chiu@canonical.com>
To: maddy@linux.ibm.com,
	shuah@kernel.org
Cc: sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] selftests/powerpc: Fix exec_prot test failure on Hash MMU
Date: Wed,  9 Sep 2026 13:09:19 +0800
Message-ID: <20260909050919.3344699-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Hash MMU maps execute-only pages as readable at the PTE level, so reading
from a PROT_EXEC-only mapping does not fault there. The exec_prot test
currently treats that as a failure, while the rest of the permission
checks are still valid.

Use the existing using_hash_mmu() helper and skip only the read-on-
execute-only subtest on Hash MMU. Keep the rest of the test unchanged so
the fix stays local to the unsupported execute-only-read expectation.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 .../testing/selftests/powerpc/mm/exec_prot.c  | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/powerpc/mm/exec_prot.c b/tools/testing/selftests/powerpc/mm/exec_prot.c
index db75b2225de1..bd44f49d8449 100644
--- a/tools/testing/selftests/powerpc/mm/exec_prot.c
+++ b/tools/testing/selftests/powerpc/mm/exec_prot.c
@@ -108,11 +108,14 @@ static int check_exec_fault(int rights)
 static int test(void)
 {
 	struct sigaction segv_act, trap_act;
+	bool hash_mmu;
 	int i;
 
 	/* Skip the test if the CPU doesn't support Radix */
 	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
 
+	FAIL_IF(using_hash_mmu(&hash_mmu));
+
 	/* Check if pkeys are supported */
 	pkeys_supported = pkeys_unsupported() == 0;
 
@@ -167,13 +170,17 @@ static int test(void)
 	 * Read an instruction word from the address when the page
 	 * is execute only. This should generate an access fault.
 	 */
-	fault_code = -1;
-	remaining_faults = 1;
-	printf("Testing read on --x, should fault...");
-	FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
-	i = *fault_addr;
-	FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
-	printf("ok!\n");
+	if (!hash_mmu) {
+		fault_code = -1;
+		remaining_faults = 1;
+		printf("Testing read on --x, should fault...");
+		FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) != 0);
+		i = *fault_addr;
+		FAIL_IF(remaining_faults != 0 || !is_fault_expected(fault_code));
+		printf("ok!\n");
+	} else {
+		printf("Testing read on --x, skipped on Hash MMU\n");
+	}
 
 	/*
 	 * Write an instruction word to the address when the page
-- 
2.43.0


