Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE7606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQGvYtNL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqJt4lWdz2xfK;
	Tue, 10 Nov 2026 12:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275230;
	cv=none; b=cBcFXcU/o64StddyUE5H527mF4zZjN/ph/kbM6pDM7FGopiHrgJgoeSqz0lqM+eOInHp+Im8S+mkpjcBPvopBHlWfSDAq/l3ey8+Mi0ELRYEtWBLPbK5NkXWnc7WYOigeEJm2p4laPHeIumXCecQ9yrnwRmySWuXfQg/NJ6nJkG+qiYWBZgrmaQVENxHrUkruWutI+cJkXXDqR2Y+ES/3cCL7Uf0TfnE/AZzhIQqHITrRwHqo2ff4eXFnvfR2dp3BHzcqI1DXtdzp0q+XUYcJ/iGi7EoJZEZ4BDDc5p6oy0XuO+MkYMLJnPDzyQc6r9t7PIEx5QpOv6+BB0e6BbICg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275230; c=relaxed/relaxed;
	bh=LEL6AlxKvcl+FsHW/JpDCSgOXBqy0gm0MHpKrHu3wt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qc9W8MF87/XZ3jMMNFTqhQZ2xEEYZKp3xC7+yTDU2Si6z6j10szCN8AeN/CUeLuE1cvp3efvp9B7TeAtqE6CBUUxyLIB5xy7V9eHoW9OKWSc5efP+XRU23hFvMGXyWJp6c9UMGM4A0kBTS2ObB9RwgwHws9yGS1zKoud28tUHpFmsR+qp24GbSGh3EQ0ak+mjJjuKDwjG4Uu7diPL7oR3PhRelVaa5bnzVDSA1vrw5YwviMMrWjBYPUG5UmaMfoynntTJcZOw73HaIzth7oNBjBlaUCm3nbhKzGCupPtGYLxQ5doLPapX8mV1gEKqJddoJzNq9DRakbjgjorD9okPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQGvYtNL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bQGvYtNL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqJs4Ynxz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:09 +1100 (AEDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-8b331cad3cfso12048057b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275227; x=1794880027; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEL6AlxKvcl+FsHW/JpDCSgOXBqy0gm0MHpKrHu3wt4=;
        b=bQGvYtNLYdlRL32OkBDLMzcYUSmLLHWqepjKd6N7zmkp0PFiAz0mz7kYfx3mCWbkIQ
         yol5PAgDsW1zX+1d6J1S0odjrGbUGrOlkXbt0HMf7Kd/gwiu66m4SUHmBsSchiqkqvST
         niPRzvLDyNFnh7Lanqjx435XKYZmgStInvh69UiFepSgULPw6RAQUnoHp2sDj3fAe9vn
         0JtWWzGNmYLxAY1n7Cw5teLkfLgWTkhOSUl4wR/hGMvwb5XqyMG2P8n5dKQJs4yG359L
         yQFVYuiH7w7/8vtGIm4pX7pfG94yiWYyWv1TSIGhaaMj+ucd+XOgOLxHzmB19IC9FdsL
         xQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275227; x=1794880027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEL6AlxKvcl+FsHW/JpDCSgOXBqy0gm0MHpKrHu3wt4=;
        b=MzqjD2+eXzOdrdmUjEbKH4i+I8jE/7jXvQTLIF0ibijQgvFfaVHaIq/NUQ2Eq9x/+K
         JKfXy5Q6RcDWLod/xI/NL1gTt3KkGF9iktsGxdz15XbMUwrNiddUYxDXrR1F3jHDEdBl
         MIDQGFLYBTeBapIQgzcMoDQp5B5FfnavadgQ/eErXk6ZdJVM0+k7kYa1/vU7S4tAJcvq
         4thyHh1ligPZ7VdSj9pYIGkMr/Lkss/LNoo1fOso7DvxpntrkIYA6HFJxNWl1/assHbb
         ClFhesmrTwtct2W+qw+hoDG+OsDqQUO41seak1pplBQAAoKZo0rDYA6SdC1kkACuOfwU
         Hb5A==
X-Gm-Message-State: APuU4Z8fVRm6GZ5QTrgpxhoJfh9SoZiGCT8vJdDopSW141TpA1fO/VC2
	TPAiPj+/O/+9MA+zbe+99rXIUq+rWMB5yaKYwvbmr3YHg9bpaFOiahymrgAGo9BU
X-Gm-Gg: AYBFou3M1Bf94LCTo6vbZx2vwvMatfrmFpwHmrZ0RyarxiXbAJ4bKkH79o+BSTamgt+
	xzJBKLmxcM1nzVywaTPK+pm6itCb9EpANTgUOOecxFhGmGKotHiU37G1MsApgf2j5oRHjxaTxNt
	Q+AgNNxzPE9j93hThdtWhd0N2W4RO7Q5ACzsQCSxVaYnw8ZxVhDOoUNDOrIczCa6ZTt6F4NJHc4
	IKsopAUdleN6Woiw6JoI7OPTLhXvdIcyrs2Yqf+3VjijI5F749ao360Z7qc8QUlsfNB5/OlCZd2
	xBb4QwqiIXHF8dig7M4jK79+16txsw1T0STiAA9VkFSi+yWixza/+uUOb1guhoGaTrfHFvNOsew
	S6+riE29goGXh0eQxDIIL1+OiAzCWJgt095zXROVXmrCZZQquNxGUVDGSIcA7Uyfo/t3IpsCUyO
	z4jSAyEOSF6XYzJOVv5UPl0if4SOwGAGNiD/2jK53/VKgGQYjKI3cJIff873aSj8gzPSlboNeMM
	J9GqFwrU2bIYAbe1TEEKT2tSPVnBROLVs3cHjTfRxwatL53A7UW6dDbNWkfziIpFeqMaGQgT0Mj
	Rz9jNKNIupL+X6+sLw6rLYIaKPiC7ruP+erhElkylN09X8AufQkhv/mV4OcBMkKeBAjhbeEPkyH
	KvdB7BAGMZNpF/RmTTsRknYlbRAZ/Wng=
X-Received: by 2002:a05:690c:6893:b0:8b0:f116:122c with SMTP id 00721157ae682-8b392990bc8mr8088637b3.8.1794275226465;
        Mon, 09 Nov 2026 17:47:06 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bbf5sm8565117b3.1.2026.11.09.17.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:05 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:02 -0500
Subject: [PATCH 3/8] powerpc/perf: mpc7450: Remove the snoop retry
 alternatives
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ppc32-perf-v1-3-a6e8a55b3b48@gmail.com>
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
In-Reply-To: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=B2isEpMHoLMsZdennvH5DlkcYkdYOHPkZFHl4koTbVQ=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU/p3cXQepCVz9FSfCX/p22iUrZfVh6YXGbGlTgt9
 Gnkx+MXOj6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaafe4M/1Te/dnHK/
 T1hmT+hx/nfyfqTCm4XXb7RNqrq5uspbPkb1gw/LO99uLZklm1tzvUk6rf3WNz2Le5xczg2k/r9
 2+uHTurEsQHAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The alternatives table treats 0x418, 0x50f and 0x60f as one event, but
the manual (MPC7450UM Rev. 5, Tables 11-12 to 11-14) describes three
different events that share the name "snoop retries":

  0x418  load/store snoops retried by the load/store unit
  0x50f  internal requests that are internally retried
  0x60f  snoop responses of "retry" to any access

On a 7448, over the same workload, counting r418, r50f and r60f
together, and then r418 in a group with r41c:

  r418                 1793
  r50f              1546267
  r60f              2266850
  r418 in {r41c,r418}  670562

r418 and r41c both need PMC4, so in the group the scheduler moves r418
to PMC5 or PMC6, which count other events, and reports 374 times the
real count.  Remove the row.

Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 5a882d934645..9890c87c58ef 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -184,7 +184,6 @@ static int mpc7450_get_constraint(u64 event, unsigned long *maskp,
 
 static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ 0x217, 0x317 },		/* PM_L1_DCACHE_MISS */
-	{ 0x418, 0x50f, 0x60f },	/* PM_SNOOP_RETRY */
 	{ 0x502, 0x602 },		/* PM_L2_HIT */
 	{ 0x503, 0x603 },		/* PM_L3_HIT */
 	{ 0x504, 0x604 },		/* PM_L2_ICACHE_MISS */

-- 
2.55.0


