Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DF606A339
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQeFe6cq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCj0xkzz2ySk;
	Wed, 18 Nov 2026 04:44:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937441;
	cv=none; b=h4q3orW51Gjqq8wwBE9MiZNnV1oRStqucWXLIKeC5bqQhg7vwBmw347bEJcuDhI77O8oOfLSlc9Yre1NqYaTuYfqgpWGKelphISOVFQWtUh+BQOexVchDK40lMxgjcy2oeEntSksE6YhtQLSlZOOut6uAcixp7CPHtNfTGZuAWelPf5UpyDHviZAjWbbRisS2fBB8+WBBC5VqJ5p+VSAvSa8sXM9ZXM4+EJbEZvppoPZzJXg5v9wdMtDgJfBR883+0SNxT2tXpJh1CYd3jMF2a7oJQVKHF6RppUpKdN5HXJBcAdZyZZnsDsBOZpBQssvwDvV0eTU9OZKVPa7SokTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937441; c=relaxed/relaxed;
	bh=/eNHuGNPRSSMiJpVC8xJULC+1p4MqcbiqGuhs79KBVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zn5FpkskbdxopidFcXQyE8HAkNucToKw5sUQKd8E/f2A6cZgliGIDYEvNsQhXaU6dXCgqjz33JeQtXQQb2AsP6fILFME8id0FtKrfPgXHd3ehcoaagc+ViZFVWo0oFgETQiSS2s8OiJiFSyey690SZDvdEML7PS3ibAkshCpCywXbf6VhQUZHpLu+Fsy5kEPUZuzSiCMOXq5S8FEwlMNXsvwwk9jinYgx3WpobIhpmHLQORwdP1vZARAzYoO1rs+5jdSf0Of1LjCFhl61CpYXYV0cmuk1uzoXlnQA46c5Bnl8UT3J6U0tlPaBGUa3hDD+CQXpu+dLU9r0zceiqO3SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQeFe6cq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sQeFe6cq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCh29rbz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:00 +1100 (AEDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-8b4cc793704so24668257b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937438; x=1795542238; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eNHuGNPRSSMiJpVC8xJULC+1p4MqcbiqGuhs79KBVQ=;
        b=sQeFe6cqAq9kSyMHayFHnvMtG3xW4l58z8K0E3TlgApGVUS/9dgVUY5gSzpqDkWdB1
         tQYhT3wvdz1PL4R2KyBG1dzPSzmX0+WDrmrJ1Ym1TDFHETTiF8HfSPGFedSTFz0II9c/
         XNAmJ5OpSYKXnl963MGfZ4vHkXqBx15o9imVxIWxWPsVmrthon+vBQ9xRdzzjh10jnG5
         HcB61yEP3lyPWHwrEYkU62emmB5x9sJklpR7Evyl1F6XmgyZsUH0FWOqbOy/s33selKd
         4RDsTGMEaRaOZOMbinEJtj1Zs76UYDMXwriFjjsa3y69VBmX1sRyF5dOOL5SHRfQVLQk
         z9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937438; x=1795542238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eNHuGNPRSSMiJpVC8xJULC+1p4MqcbiqGuhs79KBVQ=;
        b=jOGWBJArSrExTOXVWf0R0+nwpH4Z5Vc0Xm8kmddIIjPGTAH8qInRbUTbevx/CwNq6o
         88BASSdGxUoFrqKY3mEXwm1J7P3xfTECftDEQv/pwatjDxq1HE9Tw0jgmBxltUtQxnk6
         WWrKSdLRqSE3DMQ5FTHms2z5RmSs+j6PM1xJlFylHkdoHDONlLSi2+WyIrbXdDt1Jt7K
         f6yUaLU/AF3jCCuzuUIDyJxaIrro0bJgl9li5hGXWI2aGB2WmByOhBjMBJWFHJMdUML+
         dEPIZWY6HTI9iv6SvPFx2fNcb9xTFbkMAs5RoTP53Q9MkSe4mIHsvh8lYbTIsaOjt1TS
         QD9w==
X-Gm-Message-State: APuU4Z+kSJogcGOniDK2T7ikxg/4FQnrCyIkpNV3qAqU2CUqbzvvNyyS
	OYO4JzHn9f+BXgR7XYOjlZIOAQgaCMX6Swk29oVOUtH29Td4ly3gTynX
X-Gm-Gg: AZFdTZeQANucGpMDcT1rCujppCRz/9Csvwei6h2MUMxfh1NjwysRqKrdSKhvLVecE2X
	ZErOCG5Rb/UbY7ZLxHIAJMtaOOKRjmgCn3VasJbKOVMNQXhGgZNsXvKvPhRnYZKU4tC6mVfiGZM
	Y+mEk4Tv0FeAuxln5yCwq3dLxGILkm09V5girsSV8Bl8gfZNBidQYELwPHBXq17rC/a2ZDNFNQb
	Ha0izU6lQtZNVbIhIEUYXEu4GgIab6VzxGyqO4yVc5Rrn821Iqf3IsYzQixYdIKV1VsEexZrWVp
	F2I0HNJONTPyJqgiDD6NVvTRdkO3svUW+0PEl6zzKrQVUeV2GYoOHtvc6YrgyREr+yIcU8MeOLX
	1z9c0Fp5u+hsz4irPP++aclsy8YG/mFnn/k+CY2e94x6X619/osVaPEM1velrIYKibDreB2MVzM
	EZY264TMRtl3d62Uu53L6j/lmBCnhMIYBzXZWfyuzxd+iB8EN3Z6wnTtLyPBU49tCPEG9flpE9V
	/8WmscCYtWrjmzrR2rsN2ZgQxAFeWW8Dk8sgLlJOgb4nH+qzBC7H1tu5rfS4KbHBmwzQjWjb73g
	PZqo0b0nK4goPQT9zsX1UtMBk6QgQhOxdPlRvM3WtnP3hgts22mlWqjgUqEvTDl+w+VOu1q0ie9
	Kl+xMQcjpnfSeT9TKx9mD7h1xlVzgSqTA3ipm1S7cg/HGNLmonxVXfevjoYAMRL8jWrTz7BGpc5
	SiSwoq3VdYxfn8jlKOkg==
X-Received: by 2002:a05:690c:295:b0:8b0:a252:77c6 with SMTP id 00721157ae682-8b4fecfa355mr1877b3.19.1794937437826;
        Tue, 17 Nov 2026 09:43:57 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe057c1esm2157217b3.20.2026.11.17.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:43:57 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:53 -0500
Subject: [PATCH v2 2/8] powerpc/perf: mpc7450: Event 0x634 counts L2
 prefetches, not L1I
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
Message-Id: <20261117-ppc32-perf-v2-2-2072e9b90009@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=l6MRbbKx2CqbfCj9gw3r5hMtF8fjZGAlB1GPrKQZrPo=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIrwfPO8fI97e7CIyVz9Vh3BNQeMNx3tXc+VHZyWe
 OlT0Wn7jo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLkm/DLD/zSOC5+WCn
 u+OH/GSMktU87d4vdHByXfd6lHJI8WpjZLBjH8D50r8Jh9StvFAjOLIpaZNvxdcYGrlfhDfE7kK
 W1aNW0WFwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cache event table maps L1-icache-prefetches to 0x634, PMC6 select
52.  The manual (MPC7450UM Rev. 5, Table 11-14) calls that event
"Prefetch engine request" and says it "counts new prefetches allocated
in the prefetch unit".  It is the first of six events about the L2
prefetch engine (selects 52-57), and the MPC7450 has no instruction
cache prefetch event.

On a 7448, a pointer chase over 64-byte nodes counts r634 at 0.00 per
load when the working set fits in the 1 MB L2, and at 1.00 per load,
one per L2 demand miss, at 4 MB.

The engine starts a prefetch only when an access misses in every cache,
fetches from the bus, and also fills the L3 if there is one (section
3.6.3.2), so it is a last-level prefetch with or without an L3.  Report
it as LL-prefetches, and L1-icache-prefetches as not supported.

Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 564f6dac3a00..5a882d934645 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -370,12 +370,12 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0x129,		0x115	},
 		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0x634,		0	},
+		[C(OP_PREFETCH)] = {	0,		0	},
 	},
 	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0,		0	},
 		[C(OP_WRITE)] = {	0,		0	},
-		[C(OP_PREFETCH)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0x634,		0	},
 	},
 	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0,		0x312	},

-- 
2.56.1


