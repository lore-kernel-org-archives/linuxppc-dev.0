Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvb6h0of
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqK00jLrz2yD3;
	Tue, 10 Nov 2026 12:47:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275236;
	cv=none; b=f2EbAjRB1XZgwPgHv0tGgawx8WSytVQ0RRpYf3/CSoW4LvRhnDdf4wF6NqFNE16YXDhHwNWGPC1nWZ8KxtgZTqaHYfSw8nk1kfZiKNWc8az34VmUD1SfJ5LGR6o9gZa/Y9Nteu5hiTeLDv1R9UyRZTFexYeFjPor6pDcbcukGcgdMfzJe+ISZ5VkTvnly76A+C5SH9vb1kx5JqcIH3Wjno++ZgNsUcPWXgHkaEJTTbZXGI0iPYhCcCRj/kEUvmzZrpDIcNUWNOo0MBHKfkuIDq24w/mcdMcw+UFXXXsF8HSvqvl3/N8yrf78qNbL5Ezenax5TBZpBFQfbzH5ZdjfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275236; c=relaxed/relaxed;
	bh=Et1r+gIQ8MTuvycC4HRAx5tJUodeAXGWjzSxkw1zFH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e66LtdUjDrEpYthSz51KpY47WL8m2HeCKHmuxMGcQkrrovw5YGYA5u85OOFkKlJEYqk0jS2zOaTLcHte+hyxSeSYyX4R+XMh4FJMBPtMSZysS6JJKBlBzAgQBqGBR7qVB44xVEOyt8UJgedwInZCpwR4jq+B23yPPhPbRW1kpFU056rR1y4oLYzMYey4HZ/o587dirGaRPvPchyGEM/t1fcjd3RiPLVSV+9q9+1mw+FD1QlGRTmfISysQje8eibrgCLaW6M2MY6SIzYoYe08pkJZ7hh2u6y34z0W29Hu+eg0/wbt2cRi+bxKS3/07iwo2VUEA5udL9yEGS+qIPbuZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvb6h0of; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nvb6h0of;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqJz2K2Wz3bWX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:15 +1100 (AEDT)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-67bef25eb92so2148750d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275233; x=1794880033; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Et1r+gIQ8MTuvycC4HRAx5tJUodeAXGWjzSxkw1zFH4=;
        b=nvb6h0of6rPyGmdqNannj8MsHQ6BGQw7ZAoVQcGkCV2dovmGN65aRub9YScSKwVkoY
         AxuWfSolsDoMu96/wsKeD3hMzhx5+WGpe04DWwVG48DXzUGa3F3s4JmfgIaluj7fA2RU
         Of9G+xcwWB16xVYsnfbLq9ddlhYtvngGmaoSWp2tbXGRhHEONL/Odg36S63SLbC4wMPx
         Opgeb6rxZv6hyhwriBL6lQAKWgYJXkx/wuXM/FWqk2fmNosAmk5wT1BEiQy15gqiugbS
         sBBS3maVROctFjj0aWpqRk+7JWOA8tqVjtblSPa9/mdk2L/xQaudGcc8MkvOJrKvcWxj
         TuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275233; x=1794880033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Et1r+gIQ8MTuvycC4HRAx5tJUodeAXGWjzSxkw1zFH4=;
        b=qxIkY4a2Qr6VYjbUXSCE6/hZ2QIOKC/psMT9P4gehUzaIrCBTsPHSKXxWga1O8zRVf
         gkXZVMX2LGT+ajyMvIjD/s61S5ZcwlP8D8TW5Hlh5yxktbQobgAa9byBCBV9InaQK681
         ZtuUhVrBjxQdszX8wxuLtNiziahUjh4a6u/ey8Mrse4Y4azSCRmySCQCSVnl79OPf6MB
         C2XiA8pMuaWP1L0LoOZFo3YSazsTbGbrQVkPX09O7a6lYPMVUWE46dnp0lOEgNZSr6hn
         d4xVEDCjf1QaOejhO1Jf7X3IDwcvrCUJKuJoe2d44vuZBPHVCKriSq1tH1Nk3ou9YvnX
         Orlg==
X-Gm-Message-State: APuU4Z85cdRaxoeIoxNCRniYv+Bn0ORPtbltRf2Drum/444vNtrY8UQf
	hIleUoVQSFlvKuyKi5m1G1O50mKvY2NmSRWPYkb2+tPlog9Vw8XEmrgOfbGyBimT
X-Gm-Gg: AYBFou0l6Hu+oi23T+neByk8hI+v5UiN4G8x1KdMzY6o9k+d475AOpT/dY0C9iDkVte
	bYaZ+INq6n4tnyzS1jAQ1X6WofseGtc5x9Hny/4Ft2Ge0ARBcl1jCyBcV/RK83rz314WN2BZ4b5
	sLG7Z8UXwBaD0kH21fWRfIfNQCUV5XNTNNoreJkfSke9OBZLpzeuWiT+g5emLrguyulWv3uG9ju
	EPkOMQQH0XvqwQ6VNoSi+0fkVn+Us2gREium2J87y7kouznJql9wQTKo1L6fCaOsF2PlOpwX9X9
	AyKpVnq0a/C6fNB3aMdrjwVaCQIHnXzRyLaCMBiI2mnqTIQXyokF99q1Z8i6ezK/ta7DLDTHuIr
	pd6f5mD7WFQ/d+b46a3YhTNs8w3WexKB0Bsvysu2t3T/gTbyRyGyGCvIVHQfjdurx2TIrDjGssy
	inQxDwaskIUBOZE+nSwY10k+pePZM/WEL/NqKPZg5UEM5E1VsjoSDBWfPd/xxFT5HFwLaCQPQZb
	tI1x22kOwK3lgRDBx9YNbecCwGBjzQbgjKwdY26PWsb3osTM9Ae+2lfcGL8EFXAE5hSYGNW803e
	PX7vCqd07BavKyzaY7LYfoqHC1wLDvw/Lt5xyrQ/aWuoPGQ+8NUTgWSftSennoW2LVoXtRpZYOZ
	KjTTO3WIRwQ==
X-Received: by 2002:a05:690e:c49:b0:679:980d:996c with SMTP id 956f58d0204a3-67c570e9d29mr668665d50.54.1794275232987;
        Mon, 09 Nov 2026 17:47:12 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589e9b4csm693780d50.15.2026.11.09.17.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:12 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:04 -0500
Subject: [PATCH 5/8] powerpc/perf: mpc7450: Add the PMC6 L3 events to the
 alternatives table
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
Message-Id: <20261109-ppc32-perf-v1-5-a6e8a55b3b48@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=l5OzSa/snacUuw4Hvm7vZ0uo46L9Lthln/uI94gjUHM=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU+5+3rXyqtMKy9KT6nycVtaX2x669insDbO+w8bS
 nh+bn+9rOMjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCuuSbD8Jt1j2r9+7
 f5apctb2kVbS6YXl/9f4qJ1eP2STbP1s6OkOBjZFjR2G6rf2vdDqO3R5/OOXVZLu6VD3MDX83t3
 Xcb1nhe0GYCAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PMC6 repeats five L3 events at a second select value that the
alternatives table doesn't list:

  0x61f  L3 hits, also 0x503 and 0x603
  0x620  L3 misses, also 0x514 and 0x61e
  0x621  L3 instruction misses, also 0x505 and 0x605
  0x622  L3 data misses, also 0x507 and 0x607
  0x625  L3 touch hits, also 0x50e and 0x60e

Each is the same event as the PMC5 code, so add them to its row.  The
scheduler can then move them to PMC5 when PMC6 is taken.

Not tested on hardware with an L3; the 7448 has none.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 27337a03ebde..b2fe977cea16 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -185,18 +185,18 @@ static int mpc7450_get_constraint(u64 event, unsigned long *maskp,
 static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ 0x217, 0x317 },		/* PM_L1_DCACHE_MISS */
 	{ 0x502, 0x602 },		/* PM_L2_HIT */
-	{ 0x503, 0x603 },		/* PM_L3_HIT */
+	{ 0x503, 0x603, 0x61f },	/* PM_L3_HIT */
 	{ 0x504, 0x604 },		/* PM_L2_ICACHE_MISS */
-	{ 0x505, 0x605 },		/* PM_L3_ICACHE_MISS */
+	{ 0x505, 0x605, 0x621 },	/* PM_L3_ICACHE_MISS */
 	{ 0x506, 0x606 },		/* PM_L2_DCACHE_MISS */
-	{ 0x507, 0x607 },		/* PM_L3_DCACHE_MISS */
+	{ 0x507, 0x607, 0x622 },	/* PM_L3_DCACHE_MISS */
 	{ 0x50a, 0x623 },		/* PM_LD_HIT_L3 */
 	{ 0x50b, 0x624 },		/* PM_ST_HIT_L3 */
 	{ 0x50d, 0x60d },		/* PM_L2_TOUCH_HIT */
-	{ 0x50e, 0x60e },		/* PM_L3_TOUCH_HIT */
+	{ 0x50e, 0x60e, 0x625 },	/* PM_L3_TOUCH_HIT */
 	{ 0x512, 0x612 },		/* PM_INT_LOCAL */
 	{ 0x513, 0x61d },		/* PM_L2_MISS */
-	{ 0x514, 0x61e },		/* PM_L3_MISS */
+	{ 0x514, 0x61e, 0x620 },	/* PM_L3_MISS */
 };
 
 /*

-- 
2.55.0


