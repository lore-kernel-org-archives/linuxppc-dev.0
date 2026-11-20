Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D262606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7mu6ofz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1v65c4Dz2xmh;
	Fri, 20 Nov 2026 15:04:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147490;
	cv=none; b=n0C5OH1udWTXKRK5zUuJXDyqW1lBbAZuS+PBzPtnIx7Ug2H64zMWlPiVJJXeJ6TLX0sAnq7J4xb0zBo5E1+cPERGwUk9DAbBOvSyCaunoY2f6OGinK8da8U18HjUcV+0Y+FoPbpvHau2LeaTx13Fp/YWfgWgBrGWnryWUBXdnS9j4zQtWTEQF3jO3JPw0+3hf1ZLtNH17LAhWrqSFIdoAyLaiOdguJNJVm2MGU0V0nt7RVcgg7xamWnxCjL2YuwHKpdEDfKhlKoqATDtDVNWsIfQXnNZKhue5Wnich9m2ALnlhc6zBxyR8pbcCgLJHD/NPbor1vViyiTWhJglzBsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147490; c=relaxed/relaxed;
	bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z4Fwy3tmupvXjBJXhzrpDRnjXCkXLb0ArsIdXzNXMPt2vGoZIWEK7Nryni1Ktsz3gmrhVdKZL7fYk2KdgHZBlL8ycWXi2AXifg8B2WotAqbggsvrA5RErUeQIcH1jVFfm/jN8+h88RSKLFTTqFTRaR0cS1HsY1deBDKfVsXijswCrd25cOhCUCOgXAArQVxi6kTaf86aIgneR2O8h1x7Ss39jq21fPLD/HLAtuOAa14vDYrCvjnkI90gNdydPyeUGB0JtB3NZau7L0/w3/PM4ICM1gvAR1x5YEqAxVfVUxNzfyjXI+cgCztP3KjCg4yq3QP0gVomSop/1EB2tbB+2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7mu6ofz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7mu6ofz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1v61Pjpz30Cj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:50 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-33fb4680717so1121852eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147488; x=1795752288; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
        b=j7mu6ofzJSEPhH1wasJkQcU5Veu0F8SQWnBGSp7l4nu/M6eijQ2D1soxhegLstqTmD
         3vrNqVbl8jvlvTE2aifYiffmXB0KehUohv0ppOqEAO0PONM3nf+LMCePe6wwsJxZ8w/v
         YB6s6AFM80rwgIU5p6Ql0oPQxkcC2bZme8hszKqqyKQlXAc/3dMM/jRJNVRp39Yg0uk0
         OjlqJ3+h2yWljiiPaAS20vM94459+8X26pIT7Q8KevbPN4PemCS4+J/VKmWwSjvN5Ke7
         QYlXrzzL1zyVRQcIQGPXeyfaLii0agmBoixrqCwtNHLLQGoNC0J7OsSUCfGdMMP4l1xg
         1/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147488; x=1795752288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
        b=jBM4iRWPXTofMzlGGfddCJ8w/NYYz6X9PkJouM0VqiCSYmtwt0ZGcCT9Az9cYqt40p
         1/LfnGagOu9k+1mDiMWhoBXUr4JDR82MRbs0JhGre9vhCmzgjlsSDdxy3zDSToD1eCWH
         WpS7IbH5bsgSwIXG1afbCCySRyNJmL1uuSKQ8pme/d7mc8L3iLgD4zuxJsMjfMDTgjcu
         wNpus01p4YBs6VasJTQc1D8xczqT6faQj7lH3HLqO6zrMLnQknk3httD6s+c/f+QaiCs
         5GT79d3/YJfNLKZTHnBLCW8AlZrdCQId/1r3yA2ZbzWoljuFcYGh/rr+/d6Ka1y+c3yS
         Dovg==
X-Gm-Message-State: APuU4Z+Xv8f8R5Ob6SiWFJQlwjdmwu+tV0mV/nkdxAozgh0UPfyd+DiY
	bZM8q+WQ/4jt0asN8kmzCHwEP9BR7PJdn1wubFH26jORGSlBrkkyGtHSOwzFXw==
X-Gm-Gg: AZFdTZcl5NcGKzQHs/XKo0mCebxdoThnSl+HyvSAnE9Xgl7XQaj6H8yBuSnSlx1gbiM
	O3iO+svigGBKKvXlupWnJH2fsBhsBqaIxFMJ0iKfXKS3rIOyA0jCDuWgEWjMH48AJS5bVJupKQS
	7ufMdTqtjW8ZhLccUO5QfAr0fo6lwqkc/Ja4zuNlnpiNpBkuDHx6WDVOXGszIKjVRx2sMHKVYV4
	KEeVQQFqgGjIn47o+0kfAvIjvZ62ja174RjgHmLmDAhO9Y2fW2M9WJohBcP0MD8wdvrWj8J0GhA
	O8KmFh1hL+FO46UIeK97Et/YAi6sGMEDWHjn1AnnmWc+mKZee0a4U6sbn9wHM+4q7GU5T5966XY
	7ywqGOEAiG5FZfHIH4WltvDMGlnRwLQO3g4VOzUZn0g9HF0O5pXthrO+0oU4U1p8T5bDlPkte6Q
	ktdNpV6uUOvNcMq73dODpSu6qdt6LO/vvUVCGSIOleskv6sh0v3oCCotZFlC1mW71cnV7ZRa2eI
	jn9EXuDMIzPrYMYapE3cZt7Hx5Ot2irayGrtIJFobuqU18rqiFK21X0sQKP1Reb27uqJTBePtJK
	fsbfl+15U4+fo3j9TovDzCn/m+cEBalE7w==
X-Received: by 2002:a05:693c:87c1:10b0:384:4451:f6d with SMTP id 5a478bee46e88-3856e947af8mr1470253eec.11.1795147488137;
        Thu, 19 Nov 2026 20:04:48 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:47 -0800 (PST)
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
Subject: [PATCHv3 19/19] powerpc/powernv: Enable context analysis
Date: Fri, 20 Nov 2026 09:33:18 +0530
Message-Id: <5544d7d1734b8b45b7f1216daa619a2d31bd5d4c.1795147055.git.ritesh.list@gmail.com>
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

powernv objects now build with Clang context analysis enabled.
Turn it on for the directory.

This checks that each lock taken in this code is dropped on every path.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/powernv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 9e5d0c847ee2..834a56122aaa 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS	:= y
+
 # nothing that deals with real mode is safe to KASAN
 # in particular, idle code runs a bunch of things in real mode
 KASAN_SANITIZE_idle.o := n
-- 
2.39.5


