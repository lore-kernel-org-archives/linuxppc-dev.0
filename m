Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0FD606A335
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OUUyIFQ+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqJr2H0kz2yD3;
	Tue, 10 Nov 2026 12:47:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275228;
	cv=none; b=VdL4sFc9f8/jPTTb1Gcqy2rX7vH1nbay3G9As9mfflzWBcoTflnISWfAEIXhWo8WcTutDLLzTm/bLYfC5vp2wFEywzExItW3Ee+vv5E6X0p60vx+r5gtBolv+LAWPktegKyXL0/OcUgmDtoc/vqgnmYPX6FCIgxESMXM1QNUNSxzvf85zUWOvJqtfDeL5X7hxkGnlvseV7u9UkpCdngMT7fpcyUo8O8lVLF0TjljayubQk8zpBUvlyHa5IFavAydWzk7KK3WuGKbQydhvWYaRKxwFT81JCS7s3fR0ac+KMQiIbhrqh5OEjU0VzTRrC6ETP0GImcthA89W3MPaSCXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275228; c=relaxed/relaxed;
	bh=jGJ0/Ks/pihSpRb1JBHByL4V+Y6xXcN+aNUYF8zbHaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcLpgaf1ns8H6J8OkHHQzL4yPx4A+bVgTLpeLaWbAT3dpkuvc2lpR6Gp/oyi+DCPcKb69RUD90JnTiiCmlm6wkERwR6Uzu/jlhptmwr5OHFF1Bj9ielmnUMTEw8xgFqVDa9JjUJ2TyzLe4E9tSZOYjA1IFtOnVKiY7UZTLmNIYf9LcjDyAw6CS6c/YqkcPXh46wo3dQddp02Dx2MRGfjZwDjPeImWan3eOSI0L/4faF+vJUqguSlSQiGU3NKq4aTgevvuHsXmT4hcHwoO0ljlkEAUDrJPw58IlQojydusKjlrznqjqMxDxgMdyUdoAM/eVzzXvs50dw9em47Uk9ivA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OUUyIFQ+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OUUyIFQ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqJp4nVzz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:05 +1100 (AEDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-8b32bbd39d5so12064027b3.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275223; x=1794880023; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGJ0/Ks/pihSpRb1JBHByL4V+Y6xXcN+aNUYF8zbHaw=;
        b=OUUyIFQ+S2xqfBRkl5VC83cmx3PIDPot9yQT2YRIqqY9Wtu5n3ET7vtbvRb9eAr2Qv
         /PF/A0cs/VlBHigdmx9UrGHtZbiQaHl3XcNafPs9Yg4WmYdjgLU2e+Tp6VbLZnwnPHot
         31kPBaiDP9CWmZ/a0E7RO1wW24xG6QXs7vKQp7gb0uISRz/Qkdv+M/I1ECoKGwv3XctV
         mSQcNuoPH2uuFr1EL62Qrwfjnb/h/NAojOjwnY8IeszKNUIladlDfCk8ogMcbqgyr/Bk
         SbE8EAYAdn2ClFh6K/4tqJSKbA3IqmH5M8fxAjCeEjnYfxMFsmk+s1GDv9kgh/qdVmdO
         mpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275223; x=1794880023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGJ0/Ks/pihSpRb1JBHByL4V+Y6xXcN+aNUYF8zbHaw=;
        b=sOPEyXaqdzRi7V/1lZb19zXnpHU7R6bzYxSNF8p8SmLcxGJZg4CpLYNt15d9/35j5W
         hloFDHE4XwlSntH4Qn1pbFQJw72cY0h/KbeB233tl/Rh9C7sftlm1S+B53zO2wkIS6Yx
         PiCUR50ztJR/eiGelIgWML6pLb/6KhV4BWTIlhYsfezgoexk30qJ5J24PjKjcPFrJ/UI
         XSzR8Ht2paMCFFriKz8MOAPV7E5a435LoKXn/qP3OSU6asfW2nNCsyzFjL0yXgGfaqJX
         vLXenJQg67kajoOhayV3uY3xGPl1Am2ctja3/tWqrpBUIH6oJ3bvysCX95VoAVWXUUbE
         +xyw==
X-Gm-Message-State: APuU4Z8Kurj9fGg6ardlZY18RukJmLxfK8EXq1k0QMEd/xO3h2MQnNWa
	hwHBOWODkAKPB19BCtWtbnOSY0G7iIQZifYCi/UOipk2uZjpTi2ErE5y8L/VhH4V
X-Gm-Gg: AYBFou02Y9i4HyvOtxuRuEzODmGxoZvf+svcXZM4gTIHseiQb7GP35rdn30iFMTM77g
	mdtqT9vj997SBUreRUU+z1Wq/zl8QHKfklNnYhRsUXI0pY5CI2vsb/eS+tYxEZjvhEYkeznQqL6
	LMRkxjCkcyyfGWQOf/etpu5kOzXqT79CsURnksyiaGu8q1CuW3lcUZbiArrnJt2cWnxZRlcKbT0
	0U6sqMwc0CWNCKXSUMtHcXsk4rtNRa5ZuEF3SBUDguvEORnHGbMicTIlgrnoz9zR5lire/Bb+HM
	5KctzCK+TpOPcoB1UQfg0u/K8ZtGLmn9OgR0fL4sIAQP7PcoOYrL3C+mMoso1hjxLBwH203E/YG
	Bv6tFU5Y3CkSdKTNMYXJm0DvaecPSwsVrW4MsM6rgt5fWeIW2NeJqslFSozrEVB9RWLn7aofbZQ
	Qb5c0mHKgJ7OrQt3/IGgdqnUWjpJKv1nfIvqej91CfqS0ITekzNYTgt+4qEl8I7rl+T9eI0Pbiv
	i4OmPN3k1L9RNs1jx4e5EHfY4hwiE4J6ehmUsWQaB7AQT6LfuSdkoqbzYwqdM7wQysdS1P537fI
	IBVuapn7MTyW5k7Uf3tGs7oAgMp3WXqG72IW5gvmOzq87HAt/WLhtj0Xhk0HRWN9kwGLb1ruo5P
	TosjAE37r7b17o9yfzZMFAvnQ5292P/Q=
X-Received: by 2002:a05:690c:c4e5:b0:8b0:d9c9:3fc6 with SMTP id 00721157ae682-8b39297cb6fmr9708997b3.13.1794275223447;
        Mon, 09 Nov 2026 17:47:03 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393415af1sm8332117b3.30.2026.11.09.17.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:02 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:00 -0500
Subject: [PATCH 1/8] powerpc/perf: mpc7450: Event 0x30d does not use the
 threshold
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
Message-Id: <20261109-ppc32-perf-v1-1-a6e8a55b3b48@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=JVPs4xK10+lf7V4KHLv5gsEsm8ka9yQlvDi3PWABdjU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU95nDNljb+T7+sPPyfxaf7nyWa+vZnFfLpcd4TVp
 ynPXmVrdXxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1sm8Z/gfeCuqzs/
 v0xf7zRbedtpdLO3unC8Vu9Wg922fNojg99QHDf9fMdbyXG2Mn+oXpKqyP/6TdVuOduGz6uQ6bf
 buvnf2ymRcA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mpc7450_threshold_use() reports event 0x30d (PMC3 select 13, FPR issue
queue entries) as using MMCR0[THRESHOLD], and the comment above it marks
the event with a question mark.  The manual (MPC7450UM Rev. 5, Table
11-11) says the event counts the valid FPR issue queue entries each
cycle, with no threshold.  PMC3 select 12, the GPR rename buffer event
next to it, is the one that uses the threshold.

The only effect is that r30d cannot be counted together with a threshold
event that uses a different threshold.  Drop it from the list.

Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index db451b9aac35..564f6dac3a00 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -65,7 +65,6 @@ static int mpc7450_classify_event(u32 event)
  *	12b	Y	PM_LD_MISS_EXCEED_L1_CYC
  *	220	N	PM_CQ_EXCEED_CYC
  *	30c	N	PM_GPR_RB_EXCEED_CYC
- *	30d	?	PM_FPR_IQ_EXCEED_CYC ?
  *	311	Y	PM_ITLB_SEARCH_EXCEED
  *	410	N	PM_GPR_IQ_EXCEED_CYC
  */
@@ -92,7 +91,7 @@ static int mpc7450_threshold_use(u32 event)
 			return 1;
 		break;
 	case 3:
-		if (sel == 0xc || sel == 0xd)
+		if (sel == 0xc)
 			return 1;
 		if (sel == 0x11)
 			return 2;

-- 
2.55.0


