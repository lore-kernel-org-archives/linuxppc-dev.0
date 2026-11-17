Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63922606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rINm1LSu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCk6zb7z2xL4;
	Wed, 18 Nov 2026 04:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937442;
	cv=none; b=i77adHy2YLCQ4FbwpIyU0IamchoNtY0riUZTOv+VtEzxgD7Mu4FCUzJx/tA6DWFDpzeYnvqC2EXLNSODzRx+ZtXnrjjsbooeRZEb2Q+EfH3QvlUnfcSP9DH70ZKlrAITcyZl985k9xFXoiRBLpqYkNGZNBElYREMPL0A4/m7jsr9EloLrdVgfkDBE8oMiKPdqCIKvOnJkM3P9pqTSCIS9wNe6a1p5j3Qvync9JSFeLLW6T+ZBcX+vq+4WO6380ebYEMiodkrLtXqQntaoNImdi4ievBEFLa7X9idXE4OTC/71TBUwRqx1eRPMhcLRNQERxPbZJbG++c3LbQsIGtR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937442; c=relaxed/relaxed;
	bh=3Q050ARbfSsfp/DpsjpaNEHeBUmHeSTY5lbv5E8BhzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arGA56P7qAyyC8DkZR2//b0QyCm4fJ22xYpdKWcepfA4LS2+QtrXakxy8c/r9aKHi0cVLLL2XZ4uZwZ3ph6BD9xwVW8MMThtQX/hklR0z0qSMp7gXS+kXSknHX+BpVoBBoWmbUvpjpH9sdAPqXRTJ+NpV+hZxQ0gozN9SUHNZqlPdbuyATZA8xK0NlBM1G60CHpRPwunhTBOqFtCaGtocVAaNoSDire/jcdzGfGaaRbfj+3j2Pft9Hu7wUWSWGdMVNG6TAoUfZ1D5k/b0zfk+UZ6eVwDILrEObvTlxbBmVrUlGnQIrKVMB6Mdl8rINYGS5+kLSjjyrivBMryaxMQJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rINm1LSu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rINm1LSu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCk1NfFz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:01 +1100 (AEDT)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-67990a45e02so5307830d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937439; x=1795542239; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Q050ARbfSsfp/DpsjpaNEHeBUmHeSTY5lbv5E8BhzU=;
        b=rINm1LSurtgwMsaL8HKo79GWM3hmfgHutpqeWZbN/UE7Ln0YbenXHe4Xh/0AeiBcGN
         dpMaYRg1+KAcrxFVuBKR5IxQuWf0rX1dolqfzm5O2K42HlL5y/oNfjykBdTb7kNSpBGz
         wtuOCRb+D6waxlx+XbcpFQCK4vXjEnKnve4qsub9es+FKYl4IGXldw3GJqSlgn6jYojj
         ShjP/b8oM41pGBNsM78QnkAyPKmBfOx8/0JVzFyVaiy3lh2v4AsPdRVCOV4aposRHvf0
         G51xAxFwQo7Yqf3n06pFwujlfKKT51WdVA9PrpdAJ1Ldvf0QXew2fhkGUirR8/BRbHzZ
         dxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937439; x=1795542239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Q050ARbfSsfp/DpsjpaNEHeBUmHeSTY5lbv5E8BhzU=;
        b=lvIwTyuBtJaOZHCVe9IWV1L3/qVxNnuSRVlm9BcSOHUm3/qgbXYpx3lMgw96mqHKrA
         0y+EtkuB4jv45Vmka5+iiMGGJBXD+wrL8y8FpstZTkBwyZwkxHtqh34qBtK13UYnqa1L
         XIuGeA8LwfdvQw0xdqEMmvAa9NwrrT1bGm+7jAswP+8cpJITttnevZbqdLwcQJfBExTt
         K1hcwf9KxoYOXBSroGHt/XMwOr0mKDodqo+oGtj7Lv7vKG69Y5Ki0syAMPrlz+G4hWDM
         /jVB3leTc045HQu6/LReTSkgg1GWwZiw5PA7wTL637fK3L97oYRPwQgaxIN+I1kl/P4s
         Xjog==
X-Gm-Message-State: APuU4Z+uhgm8hi/LrGxMzP7G2+IoJlQv8KhvXfbqXlzBmmGLCSEAEDkd
	YRNssD0OkikiO6udM3UYTzIlKGYV4q63K7qH0SNWK41COs2j0HnGIA58QyV/XFNeHGE=
X-Gm-Gg: AZFdTZcDZIy6mi4/NjVeCRE/3incEpqRM/cY9h0Wgxr/kl2Yyb/nu6Hc4VYDEzRrJQq
	cC3in9zrdZbf7qx8FlZQfYRNBDdH3gIXtBqbmfTQPA0lnF7XglvrwRYCbUltAXdkMpBdUcDyzy1
	WWBQCxukTKY1IP1yjH/jLcWfht89lno4WzbC3flwOrL//QxX3t0loYY7CA1/raLUkG570jT6Fsy
	4htoT93jT/gLdAMKOza6HqTq4Pt+rMf9uBuFKdDltXKdZYQ2G7t7U/SGVYWYxv4MCcCytCmCLtz
	7Ycf4BPFP6XNYQ8YwdtEmU4m9XCG53IobX8xfBiDyTOQXre1NaA1jNjdPnVeLk0hQuCMCSpXgfY
	MH3a8yK+Udvu0XvcHn5s3z/05dOi2QQ3j0F7Jqu2zu7/P7mAMblwZ3O3xNxasUn/9Hnh50+o+rL
	I3iCGF2QqzCfgTF8KnxHxLFhvXW3f/YpQbcaw34+B7vZ94e1Z+TWl0CuVpTZPQ5wYLYQGl07tZz
	q8jVRKxtugKoq1Cn08Vw+xSsP7GJYlz5mYHQm17w6GLbDfQJLyK6iWKppBBpBDor2nq0IJBkRhd
	OwocfcUbxQwwRVxtLgweEA7wolZlRfLLW412pjvfehUXj7L4dJ0+yC0v7H8EXu2FhGpyZ3UmPrF
	R22XVYcKHMy2Nv1ni0iBraiDPi/3gubCPOhtb+UAUr6E8CslqdiGrGrkkEwvDD5/gz79Z6KId+w
	4n+S98piI8t+zzgylj0A==
X-Received: by 2002:a05:690e:4388:b0:67c:23f2:20b5 with SMTP id 956f58d0204a3-67dd3fb6e24mr106276d50.80.1794937439420;
        Tue, 17 Nov 2026 09:43:59 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd4014325sm203579d50.10.2026.11.17.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:43:58 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:54 -0500
Subject: [PATCH v2 3/8] powerpc/perf: mpc7450: Remove the snoop retry
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
Message-Id: <20261117-ppc32-perf-v2-3-2072e9b90009@gmail.com>
References: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
In-Reply-To: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>, Tanushree Shah <tshah@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=NvUKFAnJYvy3hOkaAuE7MQC868qaMwIEUUCzFRI0sLA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIoQ0e9ON3pcLOb7VES0uou7TuCJFbeX3cStB64ff
 ldjdmh/x0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFzz6z0jwyuXVV2bkz
 RnrligaK7KXcjjULaTY8eDBa9ixTXkF/Tu+M/I8EEm98C0c1eNHDx26N19Obkq1Ob7j+kFLMtKe
 ++veildzAoA
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
Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
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
2.56.1


