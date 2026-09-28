Return-Path: <linuxppc-dev+bounces-28386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768FAC9833F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htdHG6m3Zz2xmh;
	Mon, 28 Sep 2026 20:44:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790592298;
	cv=none; b=L2DZt+/U4bHYniKCu2rXhmG4gJS6kniQwau4ekWyMatp3gBiqSL/TeO0TelB8TcaGSeGzIouIHQ93UjqSXpl6exS4SGTDc9WAvtKq5E6T/XtaVsdKE4Qz8e/Rukju8e+2PhfnjbKhj1KzinhYZ6KrWJpvd+8mw2u1IgO5r3G6drqZHzecNONV3lrQRvaIHKkt4GJ4HCI0XxliJ2P4fXtL/xWn2WFCZ96D2h2vUIesUvS9nB0VeHuB4sTLeAb6U3OBTf5aipcNiu5SuEVkaC+/eu1vpFzprTahNCFb+X3QCj81T65DgoHE8oEsaKJDTODzyO/ZRxxrkqeNbRwB174UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790592298; c=relaxed/relaxed;
	bh=VXrsxqEkO2pMgqNAsSSYfKdxs+2sCp96RSLMIL+tOrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcLoXvpbwa36fJltF8JIHnb64iYCwHgKIXuuSTz23Mlu752YemS9VZ9UPtaarKxRo1r6pLsWkgQaHAhGrn+noU6Qw8xAXG5nueB7bKX69tstzMDVDV+dPgWOkDGZx2Mrzv8BSuDw8JyVCwYYN/R9YKkaAGzwzKYB3Kl8Q05klbruHx/GOXunrUTzFcU/cdR1NGxXCvXVF9Quiv2PbDfv5Q7hD/ee+sZqImO4xGtn/NmqcmxVp6hziJ5dKTrKPkWH2klxz1EP2OTHvvqaqTilFZygIwnfcVAsYvTUiyQAq91D+1IBtqg34zDigqdc5unN+jj+7JO4+eFq6geCy9nKQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oXyTCyYH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oXyTCyYH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::2b; helo=mail-pj2-x2b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x2b.google.com (mail-pj2-x2b.google.com [IPv6:2607:f8b0:4864:39::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htdHF6kC7z30W5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 20:44:57 +1000 (AEST)
Received: by mail-pj2-x2b.google.com with SMTP id 98e67ed59e1d1-3a47d5764feso230676a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592295; x=1791197095; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXrsxqEkO2pMgqNAsSSYfKdxs+2sCp96RSLMIL+tOrE=;
        b=oXyTCyYHjrBAHtvczIba163csEjqnTitde9KZ/yzfytKXC6LIRhVoktMmK45uWL9vM
         CQ1Dil2y2uBBXeA1Yn6NupfrAkC/4Uuz/MN0H9lnGAfeGKmENxj9xDeIhvZgTxAuFxdS
         THjQ+5l0lw+agxdnvhJeH89laSd60GOBTRmIRB6RIwSdAnQtmmdTTO7C/0s2uwfhSrzo
         yuWxjonewjthcgRide9SxNK1UOXrBetS8IwoJaFVsr99A5lq0i1holrsJLkE85z8GG+b
         RjDwzE0r/GWAuP/537STsXuI6l8DKEJLaKBQTnD9MsM1uQktp0vyjlJW5/o/qFqEpmuy
         ZFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592295; x=1791197095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXrsxqEkO2pMgqNAsSSYfKdxs+2sCp96RSLMIL+tOrE=;
        b=HI487dYTejqdgleylbpnrBaW8qSm5k4PUsTkmD+wGoGaJWb389BTQ6e+vpUVsKK5Gf
         LJbEAzug5Vu6oDCYeDktnm1euuAIE9i/vpdIVhV9KsgbhAbEYItXumPp0LYYyJqw63AC
         j8IgBndAcRJU59yOaDj3SckxVxi+sxLwzuscKHR5a2zsQupSpUk6ccY2dvoCF6kgDmAI
         VMpitOczZCjvRa8nPm+P4fF8R7b1v7yw1iRfIW1AaV6e6GKLu3tJa70Odyq3IYqjJMi+
         G8y0scdLBlVq1pSVQIVp/XNCxU5zHfQh8tIrmfNZZpmdD9BQFXbXsr3mNmCJJgadZIdl
         CgVw==
X-Gm-Message-State: AFq9FYIk9lfJHSvzvlYS2CvzQ5ZD576B6lhP0PpvhoWIWOkBtpjvbZ5K
	Ys9IvT0OOwnAj4n7mtsL3m09e2Ubo0g+4/q9MOAMviM8HRpx6+v4RpNGylrkYw9G
X-Gm-Gg: AYBFou1hTLBEErc1whwgBmfXPUv7nceMW3WtzHIQLQASIoAa3VzlYSsj3Z5HG/FShpE
	yGh+aEuEjdAPTuT9i15K2XcfjBv/VqcFXPDuNbyKj1zeA5aMhrgTStUMP3U0SPANG2iYXsR030x
	+WcC/s1Un5eZd8IBbmFzOlqhvEFWBnzM9BGEUKXzkWoYvur9ZXXJFTtDgX3e3xGKNc2/mnOBGOR
	naiYSRhbC14sO/xmlAorcGqH89k4vvQadTpUP8FOF5thm0SyQ9wmBM5CgrLkgdUeAjN3iCZ/kCd
	Exx5blfUf2++tMYNWDLFKbX6WXtfrosXBA0V4tWSaM9lyDTyyiKtKSF8gV7E5JkTj4oVJZeO5C5
	4uNKiAZGuiV4NGqVThgoujyvFtCm6e5Pch98h1VC87rIuhSJxrgsVtEztaMfQfKmQjAIUYXh9Sv
	pHgXuu8kaIBMPUJoEBqdXUWizZdGPk0MvcDUQtosigE5OAg2QGURN57ezoOgVoWAwLumxzm/m+H
	7AlI2nDw4fcf7F4ayMNlrFNHxAH0QRKSeXaH2u0NmbzqaD54PnMa4qY9aGr
X-Received: by 2002:a17:90b:1845:b0:3a0:e8ac:9f7e with SMTP id 98e67ed59e1d1-3a0e8aca8d7mr4580986a91.35.1790592295405;
        Mon, 28 Sep 2026 03:44:55 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm27071975a91.12.2026.09.28.03.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:44:54 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/6] powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
Date: Mon, 28 Sep 2026 16:14:31 +0530
Message-Id: <04e4dafde56fe4b055fbd763dc0e119862073c6d.1790590014.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790590014.git.ritesh.list@gmail.com>
References: <cover.1790590014.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  iommu_api.c:380:1: error: __ctx_lock_RCU 'RCU' is not held on every path through here [-Werror,-Wthread-safety-analysis]

mm_iommu_is_devmem() takes the RCU read lock to walk the preregistered
device-memory list. On a match it returned true from inside the loop and
skipped rcu_read_unlock(). Hence fix it.

Fixes: b5952f8125ae ("powerpc/mm/book3s64/iommu: fix some RCU-list locks")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index 60d00c9e7f19..56d9aa6cc8e2 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -356,6 +356,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	unsigned long end;
+	bool ret = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
@@ -371,12 +372,13 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 			 * and the caller needs to distinguish this situation.
 			 */
 			*size = min(1UL << pageshift, end - hpa);
-			return true;
+			ret = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_is_devmem);
 
-- 
2.39.5


