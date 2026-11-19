Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D083606A33F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGgC5Bm0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNk0DqPz303B;
	Thu, 19 Nov 2026 14:39:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059589;
	cv=none; b=b4i0jc9tqa1kqF4f/cZhVaVm03HB3+VlU4FyBbgTWZJL8RURKI6OkPJd61sy1+mR7hvJQNKWP//bG1PBdwla2zsMfG+MsrfI9EpwUcLE0p0UsO+tXLe1hekr/0kmcyBaXA9okm3goLghxwWrMQAdS2+ixiovknkz2z3gPpqwoAof6T39+nslPKErDAGaZc1k4S3zdtgh2WNOL/3p6aFnoIZc/prK9Ht/LOShhDAMVibA3qKpDc2tXvSNhFvbKaqYAd+0Z4LXALnqFJZMqv6ySaB+9gSjPXci9oBE4WHqgrYF9/3nNRJ8XnATm733j5Y3IE/62mXO0f90kPKaXHY+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059589; c=relaxed/relaxed;
	bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AM/AThoX6EY5k4IkmLiEWk3XdoHOZ+DdZRZmNmjpGm/N43iwL+RonyqcXxTpczRBQ+r1xbNtjGeQl9aiTTtpcHAkY8F+U+qPKKXiav2WqBLL6E2GdMcTMnk3FxoyoaX9dAlMY8UdZcg8H6J1XGx6ELdEE10OfJ2IdkebggC4cR/smvxmYpjXu4Rrhe9f9ifCbM7D9qjowg3Q9+56iRowkbNlPnLz6nfnmnx1iJBf168zjdOOxMWIcXD1UzD+6QTQovYRW3DPr/9dne1Wi8huymhEXXqkNGA6NLdrT2i85O7/P/2TUvmA/GF2NciVtZ59TJ7vN4ABl1RgyzQyGsuu8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGgC5Bm0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGgC5Bm0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNj3Gw5z2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:49 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-38431138772so483717eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059587; x=1795664387; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
        b=xGgC5Bm0qWNMDiLP0nArPsg76JlfEWR8Sqv9bemBa1Pqm+7L2hRHDKAh0VuhT/LNH6
         3w1Pi5Ug59GdfKcg4lhevTKdersjQLReqGoVP+volQUhYnNQs1Bc+Vg47g0m8n2pwudH
         tzZCjcG8aqcqzjl/gvp+xF/Kf2Nk8o394I+RHiFlEgDoUR7tNyLxvQwlQwU+E4BcjG7z
         7hI8+zWvqvZSUn72jpgkNu5YWUj47/WAQe4dyxx+KcD7quScvdXHoU3wBMwbR4qbtLo7
         KYlvJ6yM3ZTdElObqpZtBQJ6EQLgpZ+EZLeqgxgY071geox8jpaZcYE8vVXmoEtUfW7k
         +TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059587; x=1795664387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FRWWslO+/BIQXfzsm8/OFu4CVVZ4h6+o4ax7yTxGRKw=;
        b=mzmbFNWdefvIPl5bvudH+oBKZ6l6KEJSJCmj0ZQ6X+CSwsEBPe4+H6XEYf/lHZcxnT
         HEh1iABzcRfpYxqycOdSkdgk/cC9ASUFchjVi/Ad9RsnQyIhCk9BhRkhxTG4di80ilI0
         f/l65EMsuM0Uxcv75n8cU2kRnkX3+4MXeGW560y6croH+KtYcEWUmzxVl+8bK4XHtxjl
         HfyX1sZOb+esyb3ksIxCBjPQ9i9zIGNr2NKh9UcpKa3/FGGg++iIoou2kLGiZyAryTGv
         cC4JbPDEJ/C9LqE/WzWdgz6o82mEf/oLzKAR1SumRWHU27y95oFcvRhl6gmZfhJlQiI7
         nwTA==
X-Gm-Message-State: APuU4Z9wnp8TO82sAL6fI4cNCJFDduOLFcJLfjtjov/EEc49k8436mR9
	DwrY1jN+TsSP8PEYjHiz+y/J6wI6ayVrYC2Qv4GKr3gYVz2QqQquDJgMXLJArg==
X-Gm-Gg: AZFdTZeVp4bdVZdl0VGJs8bO92Iw7QnM0x3acheW+FXt6j5MQqpVEEqY3xdQK4LPpI9
	RC8iK2ipDHaR5ApircVGaWKBUvC5OQQTNp0Qn1FGB4Lnp0kZmLaYn6UmVc1qPS+2ynOSdJu/iZ8
	EWDfDYnaHA8eD26hdsRE7xat78KZFY4yDxSokgf0DWfZGXj0YCQe6uHUuw0tWMNqqHqGCYoIkz6
	9P1cvodwNenEE/mh4jI7zTv/NtRG1/svHLbmycyllSv3e9uQouGpk112YcocLh9kPVfw/TzTAH3
	5cIfrQsrNthHqwPO1/tnkl32GGlcq0LGxNwBXk8CUfNE3bfS0LD4ysTdRN/1uuwMUJExp40JgyS
	D8cG4zS9tNQayb1IurxSQv3QdxOFxLv5KMebCUoTNuOWHiZTmEPXcAyWU17mLHTmI26kCC6YWyu
	5bA4Z2L4Qt6ernGhiRaNVsVw0Bo0P27n8EUxNR2+jfpxu9TVbBA0wphzuLo7TGOz+dysE1WIPcE
	sSR6FJResJ+PBRIVkekenC91mdQGKc5uBTs7kxNhtfZTPThQ3yHNjlGqf+km4kdaiaW2QjCEe7k
	CRFXCnT6zyxFGQ4t42tJy40ISpn+liO6Sg==
X-Received: by 2002:a05:7301:18aa:b0:36f:2e77:93e2 with SMTP id 5a478bee46e88-38281523ed6mr4502295eec.28.1795059587100;
        Wed, 18 Nov 2026 19:39:47 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:46 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 05/18] powerpc/mm: Rework nohash TLB broadcast locking
Date: Thu, 19 Nov 2026 09:09:00 +0530
Message-Id: <ce4051abf3e8256e67232880f5381ba2f420887b.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  mmu_context.c:141:2: error: releasing raw_spinlock 'context_lock' that was not held [-Werror,-Wthread-safety-analysis]
  mmu_context.c:147:1: error: raw_spinlock 'context_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]

  tlb.c:257:4: error: raw_spinlock 'tlbivax_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  tlb.c:259:5: error: releasing raw_spinlock 'tlbivax_lock' that was not held [-Werror,-Wthread-safety-analysis]

This reworks the locking in __flush_tlb_page() a bit to satisfy clang
context analyzer requirement.
Also steal_context_smp() drops the context_lock, so it needs to be
annotated with __must_hold to inform the clang analyzer that this
function holds the context_lock.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/nohash/mmu_context.c | 1 +
 arch/powerpc/mm/nohash/tlb.c         | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/nohash/mmu_context.c b/arch/powerpc/mm/nohash/mmu_context.c
index 28a96a10c907..bdbe1f55f388 100644
--- a/arch/powerpc/mm/nohash/mmu_context.c
+++ b/arch/powerpc/mm/nohash/mmu_context.c
@@ -95,6 +95,7 @@ static DEFINE_RAW_SPINLOCK(context_lock);
  *  -- benh
  */
 static unsigned int steal_context_smp(unsigned int id)
+			__must_hold(&context_lock)
 {
 	struct mm_struct *mm;
 	unsigned int cpu, max, i;
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 07a2db16c2b1..9297549aef41 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -252,11 +252,13 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 		/* If broadcast tlbivax is supported, use it */
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
-			if (lock)
+			if (lock) {
 				raw_spin_lock(&tlbivax_lock);
-			_tlbivax_bcast(vmaddr, pid, tsize, ind);
-			if (lock)
+				_tlbivax_bcast(vmaddr, pid, tsize, ind);
 				raw_spin_unlock(&tlbivax_lock);
+			} else {
+				_tlbivax_bcast(vmaddr, pid, tsize, ind);
+			}
 			goto bail;
 		} else {
 			struct tlb_flush_param p = {
-- 
2.39.5


