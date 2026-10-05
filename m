Return-Path: <linuxppc-dev+bounces-28899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642EACA5FE2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 03:47:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hylhq055Mz30W9;
	Mon, 05 Oct 2026 14:47:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791172074;
	cv=none; b=DSms5GpIslxf4rmnEHOQ5MEJlRLGqmysPbs/iB2dJPkJaep1Pk2KpgRg1sQ9adZ+xcyQal0NnL2SBGU1rUD87EdYvowchR17W8IZrszsPkARi0KZI8FzphXwcvb5nEZu0Ar7fMeJEK4FyUlFCAnkOC75nfd/gSC2W/vmN2kHzLT/7w56LErKtvbH6W1CJ7+MGRgdviRM3etlrEmMP9oCE22BKXWA27Yniw8kwIeSAHAGVXpdLuzXnWlIjOTQYFwVNmTr2BZAAsMv9QCMfwvA1Tz9vRR0cwcPEhFP71D/O5pI+e9TTX7eqYrXygZ0BWxGegngjEDwi5+/oaujYjxghA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791172074; c=relaxed/relaxed;
	bh=BuztXYMaK66Ygvug6vAZf8NRi0Rh3rDwmnl655YdZxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfrTonKmkT03gerw4O8ICXrvCMyi7bqimtmn89Rk5hQMh6SYaAiLkj62f0T9/7Snv4pka+k7LlTRH6BlTE4M8mGMKnTJH3W1grOhs9uuY/t5dDMn2BiDCGX0MpXa/cFqOjNibiftanb84MUyyu+sBVQXz6aFFgFPpUtVP56yBWpqKbivWheSMZf+ri223tetx6ja7B3Lndx4KvX40AtJ849bTEIizNbFvznSrcddnezYKEW2GQ2aNe02oPSss6p70Z1RCq8yKLmmqyWyknPopwLoihA3F+ijTX/FR/jWADOq/CUm8QNaHDFB5G+ImRfvfpdW7ETtSjlTmrDzuCWjUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iMj5isA9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iMj5isA9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hylhp26Xhz30WJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 14:47:54 +1100 (AEDT)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e46a15703so1580346eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172072; x=1791776872; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuztXYMaK66Ygvug6vAZf8NRi0Rh3rDwmnl655YdZxI=;
        b=iMj5isA90lm6ajnbvOxpCrwW4+ApRfJNQHhe1ywzoOmXwKItI0knhws9/fbiq6owA6
         gd2xE1bXz6+nZmFpzz0daXGUohWhnrZGFZU84Xa8/K+UcO+dw7tar/s7H147pye39xzg
         +0umlMEE8B5W3R3YOuF7Q4PoviBvz3UTSJM3ewhCobHI3Bia2NBa5P+mirVfASofS3AQ
         iuu0Xpa5B/shHkN47HjQ17FZCGzOrGDxHyxYpKC9x3GKpcNMx/qMowwTBZdPHRvjtP6e
         cYriJ8wOWUTtpmFvb3WuZhsFKeWJ97GwkMF4JS7O2c4y4zCpBid+IXN5nKNJBQG1QeQh
         ddWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172072; x=1791776872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuztXYMaK66Ygvug6vAZf8NRi0Rh3rDwmnl655YdZxI=;
        b=i8CL/GEwXEzuFrJYyfsNwfwXajIvjHnPojv0fH1PPR808rWQSSs+aMSlphgnbESlo2
         vLDzy6EcdHnYEJQMKU5BAwr2fQXY5qUXUIF0fDNs6NyBYsagaUct8UzvqTPWJgid9aZI
         kOLgmv+q0QabEPJWYxR086tblBFa7DvNgMMxXgKF2GwXevPTeMu29RyKL1FmtqYiaFK2
         B/csczGWqPgmbT1hSSckNo6u0wkYa7qGxIMJov+ne8jTTNLmVP48iwnEqpnqmBxAcKj1
         fGS9Y21+gw6DndtBoAUkvorLFXPHMRP6Fp7bJ70XmAgqTsbCWgipa5DlDrTTXTgwY4+A
         9Ebw==
X-Forwarded-Encrypted: i=1; AKwUvBxEaJu9nPd593Xf/296BmBOjFnQsAphB9MEBx0xa7+6iccGH+ujmyO2QKp4TXVxJRXrsqZ81PpKvbO3qOs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lgMlI+Z0Py1GIDjwYhVmI/ENiFEz9hSFSwgnVfJ+Gurdj725uM
	8qQ/lEhiCEhxUVQZ22aonv7k2vrn1Tn0HtZYYcZ05YIrJLtka7BoLAFT
X-Gm-Gg: AYBFou3TFIHza3GAogYLrjOc7Kms4i9fYxBWjGb24p9SH09ouHL1LLsQxgPqN5ya1/p
	TfWblFn5jlO/1SIsRNsEl31Zdj4kdM0qJWIy1vHB6fDrg7sRIBuc2ICb2uRpY4M3H6HSvfFaMMa
	yKxrguuXuYO1ig/dqJffclHGP+tYQ3Yk2X9LhSwQZjYozoIJYkvXJngS0UitXhoxbHqym0K/KzO
	ogTSJV54rsuXibmdZQn8e8M7wwl9IsOU3YPNUPv8/b9Hf5Z2g7pStYBYAOEo2iTc3gBQg2IuMy2
	a1YUqgx1WDYCZk45GpQKDoDBTaknjVQ/49/ePI5evvMBlyt/zXDf2NdQuNAF6F/azoC7ut39TFf
	G4Gui5/HzMWw8HbEQYzYeePPkMB651G/yKkKfV5QuJSDvIdvapxls/sZzM7YhozexOUeJx84cTx
	1A3hPD2cORD8zkYKHST+1tdbz5JG/nMZyZiW3UTVvRlBRSaRV1h8T9UaVdoMlvO8okxh4iLdrel
	E0MpfyFqMyiN9j2/Ekq93oNQH3BzKV3JDelDOYv8UgoM8EHo4Cl5dJ5FVZx
X-Received: by 2002:a05:693c:829b:10b0:351:1251:dada with SMTP id 5a478bee46e88-3511251dc63mr9052789eec.33.1791172072369;
        Sun, 04 Oct 2026 20:47:52 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm10840958eec.17.2026.10.04.20.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:47:51 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v6 2/5] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
Date: Mon,  5 Oct 2026 09:17:25 +0530
Message-Id: <2affbc2727a4fdae1d187dada40a26e0ab581c4a.1791014924.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791014923.git.ritesh.list@gmail.com>
References: <cover.1791014923.git.ritesh.list@gmail.com>
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

KVM selftests are built with -fno-PIE/-no-pie so the binary uses fixed
load addresses.
On powerpc64, GNU ld default links at 0x10000000 (256M) which is also
the MEM_GPA, so the identity map trips with the error:
  PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f

Put the test slots at 512M instead which is past the ELF.
e.g. failure w/o this fix:

./memslot_perf_test -s 514
Random seed: 0x423558ef
Testing map performance with 1 runs, 5 seconds each

==== Test Assertion Failure ====
  lib/powerpc/processor.c:235: !pte
  pid=371 tid=371 errno=2 - No such file or directory
     1  0x0000000010018293: virt_arch_pg_map at processor.c:235
     2  0x0000000010008b3f: virt_pg_map at kvm_util.h:1325
     3   (inlined by) virt_map at kvm_util.c:1571
     4  0x0000000010001cab: prepare_vm at memslot_perf_test.c:353
     5   (inlined by) test_execute at memslot_perf_test.c:816
     6   (inlined by) test_loop at memslot_perf_test.c:1062
     7   (inlined by) main at memslot_perf_test.c:1136
     8  0x000000001001d713: __libc_start_call_main at libc-start.o:?
     9  0x000000001001db47: __libc_start_main_impl at ??:?
  PTE already present at level: 4 gva: 0x10000000 pte:0xc00000000002018f

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm        | 1 +
 tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6e672484a22f..a7ecd7a242a9 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -262,6 +262,7 @@ TEST_GEN_PROGS_powerpc += kvm_binary_stats_test
 TEST_GEN_PROGS_powerpc += kvm_page_table_test
 TEST_GEN_PROGS_powerpc += set_memory_region_test
 TEST_GEN_PROGS_powerpc += memslot_modification_stress_test
+TEST_GEN_PROGS_powerpc += memslot_perf_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list
diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 844ea9b7bb41..2913a4de4cc9 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -30,7 +30,7 @@
 #define MEM_EXTRA_SIZE		SZ_64K
 
 #define MEM_SIZE		(SZ_512M + MEM_EXTRA_SIZE)
-#define MEM_GPA			SZ_256M
+#define MEM_GPA			SZ_512M
 #define MEM_AUX_GPA		MEM_GPA
 #define MEM_SYNC_GPA		MEM_AUX_GPA
 #define MEM_TEST_GPA		(MEM_AUX_GPA + MEM_EXTRA_SIZE)
-- 
2.39.5


