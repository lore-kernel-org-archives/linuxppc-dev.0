Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FE606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yy0Ry2b7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCn5pLVz2ylj;
	Wed, 18 Nov 2026 04:44:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937445;
	cv=none; b=Ofbm12aT+3yvD+xPGxs4Kx4zMyOXZTbqjhPPOj3Mva8FZJwaD6GXbAiRp9B/HuL5+2BqtIv5S3i6PV+Dj5UcFA2C5IGatpiPJKorhILFnYC/z1BCk5S0MTKfZzKD94Q1OKI338+8LKVjT6Fx/PBoYcwdGTTViQzRaJlN7b9TvksEKXhB5jCAcSEdfNRYpqrWFM0ZPGJG4itNwC7z6z5i1B4GBHJg8CtGPk0DXPmNIFZ6/fEzOiYYFcRWC9HvHp2krLqP1hrxlRHAhAwKQJU79pMZ/CSBVQfYecM95qN1jMj2GmBVRKbTMCvtqEeXcbzMsq4KjXpevRLtAOmW6jZJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937445; c=relaxed/relaxed;
	bh=dXq+KxKE6avnI0gNIGnGOuZ6eBs1eeAKd8k4EoiQ16w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJyxG9ce2U3PwZsH+v82N/6j8Vi5oHcHoiG9KYRWuMJhP+/94Zil0SpQLqE+sDHu1187ySYWhrZkv7JUwrXbU5BaUTY3T0p+cuSGnkzHrIIM3CLVui0iqfcfqguvm/9JDocHI5/PYSVV6i2V/3RLDUcmKgK3nnPNSEy0+aN/HvS2QKgYlNN+IuPKbILv8F/QbOU556bgul28bKhuQP/zovOPlmvbhRSIBayQXvBfWUepGUY1DfoARKICVRVofgNsuZvNu+sftrt/aFCz761nHYU+YgtpUjPY7RzPCDeFkxAM3oQqz6ShUfgp2JnYpM1tQGL2c7qaqXNRnb8DL7q06A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yy0Ry2b7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yy0Ry2b7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com [IPv6:2607:f8b0:4864:20::b12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCn0vLhz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:05 +1100 (AEDT)
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-67db6d4054eso2949857d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937443; x=1795542243; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXq+KxKE6avnI0gNIGnGOuZ6eBs1eeAKd8k4EoiQ16w=;
        b=Yy0Ry2b7FL1tl0+pfAQ1KzuLCSuor61FQFP8Tcf/SXH8VYZLAIHMw2Yk+7FheumZXD
         RVb23N9Z/SVz+dYVmKWmcPrBTVrObpD66lmiMneYX7J59pKhg5WYJWWtfmScgkM+tNJb
         QsjZ6dgevMi3WVkMZo94F1XzEIGI1nM+wkYKj1y/xGzgUJq9chcIjRiCFXoXcIbz4WRN
         oAdaeJp8jMp/Cgak6Y1WGmYM9H/a+6TUJIrPd0BGnX1GxTLnrcje9znOsKQAUWxp9O/w
         u8fTCZCknjWDHghA8fI5GzVuxbsLwH8PYy3GTSvz0Dr41TJfwl4KGfbK1DStpnO8Wg4y
         4XVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937443; x=1795542243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXq+KxKE6avnI0gNIGnGOuZ6eBs1eeAKd8k4EoiQ16w=;
        b=gE5SaMFjlDP30BzW9bF2BKlBEQKW3zjh7gNgEVTsiUBgItgAIPN7N0hJo4IDJFKHAY
         ergG4mEVYKX3X0RF+CF+zqx6dBqr4sBh5hEDb6C7qFj3w1EZ50uMoZIsutakKXxi2y1f
         +wDSRpMN5vi6TjJIdPsq8IPau3NBnEvvTw/oH26iLV9/neIfmO+BfAEd77ZhIKxA66eX
         Rh8YB/mmp5RpNEJ4gegkMUH7DawV5WetrDJVeo/K0ZbMLThd/aJ4Du8UpELkF/QbViqu
         PqYWSLzmsrpFxa1j2iskXR8YXWSD2T+TlxRoh81CQaaPr1RqF89/BpILqTn1xppvnivG
         3eCA==
X-Gm-Message-State: APuU4Z/n0fjxduYI1H03CbCHdlHvZ580l55eyyraCTnM8+bB07LhbhKa
	sKwO4+KSh1cLL2zRjNpianK3C15UkQ6uwy/5LRJ4HmZH1FW3/zrDIuSm
X-Gm-Gg: AZFdTZeLU7Yqhmxrea/HX0y13pOaqz4orL7COE8vu0bR/snwmn3iKo5xN0ag1yZ3VUd
	gBR93iOqCZqfULVrPb+Ty8wcK+/ZoIAnjGPO/Vn1+UMzuRnRiIriQeTHtnLv66RbwgvukZVWNZC
	lbut9lRl2BbTzE0VFZKSUB4VbCmSy6AZ2ymMU0PXhugCWLWM/Kritrgi/RGO1W0IxTK+Q/rV/GJ
	Llj+Emth0tnyrhCvU3EKg/OJym7RmtJtp/O4ckbhQ/Q26qhwB0rAbY1KV2V1nfQ0mJKDI5TTJP3
	ERk6vvMl5F1Y9n7Wq99qtAlUiHmozwV0KZ6f1HKUti4NE5rKd/hVeDZXQ2BBSaJVVCaYPa3xnx+
	u/jS9QEGj6dX1Vmk0ABgkGWVFL0855ytdej35e5ggUAFPjdO95+OP+LO2OEmyJKlXkhKpvq57cs
	Nk9XB0c4ot/1FHFFRazMlDMknxkJvfGYHUcJB5EIbI49rkbHYij61r1KI9HUGRtFyESVt25qEw9
	U0CEbEIC3dGKEZ9hDscrIGpFPez54Nr33+tdA3EM4YqB7tMG1EEEQUSHAB0tA+C1YaJXHjQ2Pro
	q0BwTGJYHBR5n/SZ0gMDPUcH2kiPWxAAHGeu7Z0ghsQWZzP8SigysT8fatofG6JQDIewYcmhcgc
	3BHQeAOuKiG1A1eEnaVqCAW5PO4mXsO6MGi67r2W6oZI96QuCOG/GaybgdC5Y9UUIW8VgjMBT5k
	SLCHyF1Duky6U+MleQkA==
X-Received: by 2002:a05:690e:4399:b0:67b:e531:90b3 with SMTP id 956f58d0204a3-67dd3fa46d6mr79067d50.33.1794937442644;
        Tue, 17 Nov 2026 09:44:02 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fdf1d0desm2366887b3.1.2026.11.17.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:00 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:55 -0500
Subject: [PATCH v2 4/8] powerpc/perf: mpc7450: Fill in the L1 data cache
 events
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
Message-Id: <20261117-ppc32-perf-v2-4-2072e9b90009@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=+x3dIo87AbGKQ1Th29uJ8/+OYXWAn+kLXmjzlUcDcrc=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIqY+J83YuOq/SnP1dNEd05hzo7r76/Ky5JOz8gqC
 jbYdHlSx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFxzQJWRYYKljGTKlA
 L1DK+Y5punrnxYKPrx8mwP/ydRf7ccPClU94bhf5S86rLrnloLDPje/Jts/mHruiTTAjGNyW4/L
 Ce0Sh8MZQMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The L1D row of the cache event table has load and store misses but no
accesses, and nothing for prefetches, so L1-dcache-loads,
L1-dcache-stores and L1-dcache-prefetch-misses are not supported.

The MPC7450 has no L1 data cache access event, so approximate the
accesses with PMC2 select 26 (load instructions completed) and select
20 (store instructions completed, PMC1 or PMC2).  These also count
cache-inhibited accesses.  PMC2 select 38 counts dcbt, dcbtst and dst
line fetches that miss in the L1 data cache.

On a 7448, a loop with one store in every 32 instructions counted
645840841 instructions and 19773839 L1-dcache-stores, about one store
per 33 instructions.

Loads and load misses are both PMC2-only events, so perf multiplexes
L1-dcache-loads and L1-dcache-load-misses when both are requested, and
refuses them in one group.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 9890c87c58ef..27337a03ebde 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -362,9 +362,9 @@ static int mpc7450_generic_events[] = {
  */
 static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x225	},
-		[C(OP_WRITE)] = {	0,		0x227	},
-		[C(OP_PREFETCH)] = {	0,		0	},
+		[C(OP_READ)] = {	0x21a,		0x225	},
+		[C(OP_WRITE)] = {	0x014,		0x227	},
+		[C(OP_PREFETCH)] = {	0,		0x226	},
 	},
 	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0x129,		0x115	},

-- 
2.56.1


