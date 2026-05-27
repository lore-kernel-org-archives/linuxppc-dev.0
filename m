Return-Path: <linuxppc-dev+bounces-21585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A991CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQTxh3mTQz30Vq;
	Wed, 27 May 2026 22:50:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779886248;
	cv=none; b=PDLRxa5/Q/NyGTRC7LwUcQ50+MUCso43N0xe7hEQfWRgAtY3IVmPVqrRF/P2dipiItvCpW5dtDJDjU08ZNYMJ7yOa3YRzsXE/NIGm9PfXa7CwLUill6kbNftCdD+3T/ppyL6WMGup8JHpdAC1R2vvRk1TViH6vCUT/XbrThwyqmzCLETf2FEYQQDJyVgbUgDIga/cQoBot+4kIERfK8psvlIk61RNiL7W1WjlNWpT7eaFoW0Flizut/l9dxEiABAPmTKX4ZAScw30iHdzTDkN/tIBnidzFLxww2Gbu4wOkw6jklQo0fgla3NPACijbUkOVc2qWLc3OtD/neEhtwQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779886248; c=relaxed/relaxed;
	bh=9mgdd+DnUFLn0dyt4Tw1vt7I7z+j1EUlNtFttHUygxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHxKbSfJfhM1swfHxxR9zffBuMBrL77oz4m39M2JNS5yfB3KhSSSGM0PUCR205hkCsnh9Nt6rMnY+S1gfYt3Z+kFcoaur6V8fEdFuK0XGrd8BxndUd3bVZpGZt/8p9ElyuNATvah48Et/+1xJW4op6xISz7TznH0OSr5rsOgeQZ0A3aZIdP0d0NMBPKtE0Fq89tHISJVgudDaivBT7NBqTRKZV9OATNnGIcLvoB6M0P4/BsSrRrwgzH6e8sEPbnwMigtB3j8hF7UWsgKaVLdMWqSxoaKqwS7Yko/T+jHQasvSpMHwdobiVylicvlNL8dE2y8ODdjTd9KotHBEck3Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mbxfDr4P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mbxfDr4P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQTxg60WPz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 22:50:47 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b458ca2296so87425045ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886246; x=1780491046; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mgdd+DnUFLn0dyt4Tw1vt7I7z+j1EUlNtFttHUygxs=;
        b=mbxfDr4PSe7DcOXTNNr/omz0lc1ntogqSTZF9zw2Z3g8wirg5EU+S8+32zGE4O8RZO
         v7YH1UIWx9DCjlo3i7NOb3m8tptiY5+o61gqUMc3XOaxx2bVtxNwbIrxFJKzd3uH00gF
         Ct22d+ggiz0MTw/Jp2mP03j3HORyvgL0JQ+8utYk4ZvzL7j5zo/qRotnCI+/2+gQJ051
         WedgbPPkBvvVqWk8FBhetl+dkF9YL2s+0i8yTqBv13/i3Wi8ukwvKZwbXUomY5mFIR1A
         VCPuKD1iu0XX0V7KzAQcN8bGZ3JxripJDwpG8LO1rlsjOeGEBOK/jp3th0usNErwVw7+
         QkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886246; x=1780491046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mgdd+DnUFLn0dyt4Tw1vt7I7z+j1EUlNtFttHUygxs=;
        b=qoWXRnfEYKvVK4xA0GZaIJK8OEEgLduBeX3Ud2EdF/DCGq/qsa/ZIY8P6KAN2BcQ7s
         tincwj0rqSpwTriiW+BA4noi8bvysDPJRo6t8j41yaaY5wvAEp54UkCBN6QWxHq8lgKJ
         XwW+AcI0CNjxbgDhjL6xZiuBnEKY2tm8ruL7Iqd2+fQCDZGw6MBFbm0WlwU2cNRL7uul
         5pWExZuCwhAGwcV02f+J8TM0RC0xMo1qC/bljOJfCojtjTprEWCybtj5ZuR7SVPVBVhX
         C4Le2TDLTiOZBhkcD71RYmy6bz3CIzG4E47TKGPXATFq5aM34px6FTYTmG63lzuHfoQJ
         y0Gg==
X-Gm-Message-State: AOJu0YyiPKVaTmwa3UM4bz0IoKMZh6K0fO3Tze79eOcx1RCiM8JIEta8
	B6hLhxj5kH90YmBiVqascCI+cLWG4tMhkT98I67V8pwq42Cb6LrhYj5U
X-Gm-Gg: Acq92OEXDg0txWO1ggHR7OnnklmVD+7K3WrUTHQPsM/Ck9VEqdBYDtGWEdimybnn01t
	Wtamc1abKCM56ZDypGhMsfByAqcUbDpIgWT4H8t5ihZoE6al2MPu7Y4CSPqXHa68VlMAgQ64Jhy
	/OLW6glbu1pfUP01eVAX9po6Wc0tEQaMT8A8r6cVXTMj4TDoqdO3H57gKZxvG/9V6fK34FRfmaw
	eN/ARsv1A8NN2X8YQ1tr1anTaaAEmZjiMR+hTVOfcrD45axkq1jqxmkYfLnnEMS+cH44ItPZMyh
	mACa8E5EMIvsjmkTc2YWH8ceLFSLYc2+vTyio7ZwFdrF/s7QIYTlMKTYOya0aKmG4P6Koz65Pmd
	omQEFXR8AUKiIvPEbvxpXG9IKzweqfOGAKY3sgVbck8gZCmkhZbCWpzlgfMTEej5MREI8JBioYy
	NhF6gizwqmQRN+weZrS9PRxUKo7TD+yNs09gxNWuBzrAwYVzEIdZ8a4mja+kEK
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2beb03776bcmr229059685ad.10.1779886245826;
        Wed, 27 May 2026 05:50:45 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:45 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 07/10] KVM: PPC: selftests: Use s64 instead of int64_t
Date: Wed, 27 May 2026 18:19:56 +0530
Message-ID: <3384018316098997b673cec914aae501a6359ea7.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
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

commit 286e8903aed14 ("KVM: selftests: Use s64 instead of int64_t")
made this change from int64_t -> s64 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.
It uses the same method describes in above commit.

  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/int64_t/s64/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/powerpc/hcall.h | 6 +++---
 tools/testing/selftests/kvm/lib/powerpc/hcall.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index f923b3f5e233..21b2bf9180f1 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -10,8 +10,8 @@
 /* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
 #define H_UCALL	0
 
-int64_t hcall0(u64 token);
-int64_t hcall1(u64 token, u64 arg1);
-int64_t hcall2(u64 token, u64 arg1, u64 arg2);
+s64 hcall0(u64 token);
+s64 hcall1(u64 token, u64 arg1);
+s64 hcall2(u64 token, u64 arg1, u64 arg2);
 
 #endif
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
index cd10022572a5..d5f5282654ee 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/hcall.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -5,7 +5,7 @@
 #include "kvm_util.h"
 #include "hcall.h"
 
-int64_t hcall0(u64 token)
+s64 hcall0(u64 token)
 {
 	register uintptr_t r3 asm ("r3") = token;
 
@@ -17,7 +17,7 @@ int64_t hcall0(u64 token)
 	return r3;
 }
 
-int64_t hcall1(u64 token, u64 arg1)
+s64 hcall1(u64 token, u64 arg1)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
@@ -30,7 +30,7 @@ int64_t hcall1(u64 token, u64 arg1)
 	return r3;
 }
 
-int64_t hcall2(u64 token, u64 arg1, u64 arg2)
+s64 hcall2(u64 token, u64 arg1, u64 arg2)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
-- 
2.39.5


