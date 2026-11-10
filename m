Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA4606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJ3KvRWg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqK20yDfz3bcJ;
	Tue, 10 Nov 2026 12:47:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275238;
	cv=none; b=dmutigQKHKYF34HEi5cIylympMqfGg3bLxpiXBB13IPT7h+LmIUdU5atLmOhcXf61LHnIm5rr5rjNNNzhRR/OVdFVt58I7VblIrq+n/8anH1ueyqonrzSlGRmgij+ZFZJYNRn70yMs0w5ZNPXVDmZf/m1z4N4WCCraiaHdj/y4DRwS7Ahu8lCtLAGv5Xzsp/+ZuupDpkWL8Z9K6ne4B8IIX3LSNwqcOPVP6+g74LcLONzObqBThDmhr01bL02iXXKPRqoWTAj0qjBfM+vcFf8DMv1CL41Hjmqu6+3lob+LbK7RZkMeXAg3659Zid0FbrHIz8yKxFTpiptSeC6xgJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275238; c=relaxed/relaxed;
	bh=Bpjh/UZ7eC+Zc+giAfbKZXsslkVQ56T637TBtlmPJ+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zibkne8jQ2CRzSFK5l1QowlbTtIjf/Mf/E0VH6tA5ENfPBPBtEcuRR61DzynuLV6ZZdDP5gHlaSEjq1A2bNK2GsnzupLOCP6H/RfDGIRVYU2MzsoNw+LacmU9P3NdYZ3/zoT1jl/KwIgWs83IY5HRgc5GB9LxXuDmJuaPtwAEiwr7Rs6Anl1CV7etsua0Cc1kmZb+BEjvKiSarEkr7HNBbueg1l2s8zFn3PSv3Otki/2hHp9fIRFx4GEcjnIwPfuzmICPOaw/hgpGa2um6OjqtmjTOlxiyKz4nTkztUAqESd4vrH9Kjvju2xK1prVpAx94ZrBWGU4ypOBdzESprr/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJ3KvRWg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bJ3KvRWg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqK12YN8z3bWX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:17 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-8b30477a320so11506067b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275235; x=1794880035; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bpjh/UZ7eC+Zc+giAfbKZXsslkVQ56T637TBtlmPJ+o=;
        b=bJ3KvRWgFZg1EweF1ARUAQjVHSNLTWAQ/zsuVP5fArzwq0dXBrIqbqxzbaw5ln8nIY
         Tniz3Y7YZFJarwGDrN8hxeJTtCtQiqKxA/RzUfljPOr+6H3G7WZmtZxscM3oXY47d2rp
         d9wQm8eSdqiFeQ/q1GQmuwYdf7tRU2Cjyysl1QrPZWZF6KTFtgOIuM7pRJKp/wV9+SCD
         hbOPuPCRZ0aADaIz3SkNMvxpGYosBFcJ4l6DMA6O8dhz8jWGQYFpz9dBvZG9qxLg3rJu
         E1RcC0x8M6a8cgWwkkluBIjKD4R17UA2lH3TOeaal5mtJitgNvTkSaNuPur4g9hWhdGR
         GPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275235; x=1794880035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bpjh/UZ7eC+Zc+giAfbKZXsslkVQ56T637TBtlmPJ+o=;
        b=lF47w2fNr0dhKFWPD5dZX16pmvpx1YD7SwqkWzz0TCb9gtp1cgp2B+/4myecw7vzrt
         Ila15Pe36D2rbHokLuoVQ/Csnpo6LzfMp3zAwUmfgtQGMMJTHgwt0hKF5N0jd+W3IQeX
         SOAW6E5rM1ovDrXkcQoTVqYCenYbgEnm5KhcL7EnF9VQQSZdxL9DLR/mzD12Ttg/xPY7
         8FGR0EKVl0XFEOjZTdCvZ9Io/XiEuja+46sSkxFdERGjrObKkODIIXhvXlyribG7n1tG
         VAIj2qPKhMJnVyCEUO6liDtQ7S5CjEYyEJc4eHUYwbbXY63SF/hbEU0FEadKtZojNiHS
         Ttdg==
X-Gm-Message-State: APuU4Z/qx5L50sTsGwQMXzOKre9cSJ/BodFXs2rU5MOTJBel8QHq7ARj
	wj70SZXXhXsg1ljg1aq0BAcMky77tiMnzqduiesOh0RrUxsjDYBctKLshjnRHUCL
X-Gm-Gg: AYBFou283zIgx0pqFd86r4h2BEowtQjwAMqkoivk4P/xWxg2sH5LaMHn5pn0i+XTbBD
	EYb3LT41SPkrkK0Sci89vrMoCDFHvqSiSH5ANkqaWNIzFPLGuylplkbDdoZuI58m8yD1Mo0QpZ7
	sa36+8x4dSKLrKj22aYAGRk5IessrcQAwPB8FAOdN5RCgxOtb8uy00B9lpz0tHtFboSWssunOzK
	aJXCvGxG4qWHfH/04As8jfpVgf4uo6i+ZlbkNxA4ld0EMgVMd8oLoYv27+DdwvWmul81xRrZlPx
	UJ0bIGbXs4RsynND/XmQxUc6BWNgRwiAjPFeZmWv0sM1dtdVvH/XH93/5/DOe2tIzebvHOsGsZN
	9E2OlRc1ulqhdD3L4Y2J0tbFx2nK+AplTZfW0tt9gFWdXaoHeykiXzwoNl4f3Y7RZdpw+iSmhcZ
	eaoc/+1x9eRFmui85pRVfdmheg9VO2arTim2pW6CIUMEKmid6oVQjg1n5FpWUqZ8cBR9M9MGpOD
	fs9d9K3PTd3qcNr/qqyPXw1e34RDa4qtxDh+24SS3XHImaFMfsAIAKGdP0mvBvFbRhWoYWllguE
	cF1s3pVdLQvmkRCxI/FWD/Qbe4uLXFwR8qqYnbMV54a/tYpZX//ECxh6PJROKACqx5IBBDVnvzq
	zkBZNlynAjw==
X-Received: by 2002:a05:690e:c82:b0:679:9afd:c0c7 with SMTP id 956f58d0204a3-67c5680aef1mr689248d50.126.1794275235051;
        Mon, 09 Nov 2026 17:47:15 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933e0d01sm8429667b3.22.2026.11.09.17.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:14 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:05 -0500
Subject: [PATCH 6/8] powerpc/perf: mpc7450: Export the event format in
 sysfs
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
Message-Id: <20261109-ppc32-perf-v1-6-a6e8a55b3b48@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=L7btMy1nXBY1bg9NMBkHPlpV09dJ8lMXLGy4hYCTfyY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU+5d/ne7k/x6j5Z3dE75bjXuh0Jeuf/1l2q4r6Wi
 sz3aZlRHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHPNewVGht49aXyL+8
 2uxjx+vydBfe7Rr9FTzm3kOX4x8YhESdviaTcZ/unYL77gpHX9v/DLyNqD9Vt49n9TMrgmu21rj
 n2p0ZKfN7gB
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MPC7450 PMU has no format/ directory, so perf can take its events
only as raw codes, and cannot set the threshold by name.

Describe the fields of the event code: the PMC select (bits 0-6), the
PMC (bits 8-10), the threshold (bits 12-17) and the threshold multiplier
(bit 18).  A threshold event can then be written as, e.g.,
cpu/event=0x12b,thresh=20/.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index b2fe977cea16..9bed5c238f45 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -398,6 +398,31 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 };
 
+PMU_FORMAT_ATTR(event,		"config:0-18");
+PMU_FORMAT_ATTR(pmcsel,		"config:0-6");
+PMU_FORMAT_ATTR(pmc,		"config:8-10");
+PMU_FORMAT_ATTR(thresh,		"config:12-17");
+PMU_FORMAT_ATTR(thresh_mult,	"config:18");
+
+static struct attribute *mpc7450_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_pmcsel.attr,
+	&format_attr_pmc.attr,
+	&format_attr_thresh.attr,
+	&format_attr_thresh_mult.attr,
+	NULL,
+};
+
+static const struct attribute_group mpc7450_pmu_format_group = {
+	.name = "format",
+	.attrs = mpc7450_pmu_format_attr,
+};
+
+static const struct attribute_group *mpc7450_pmu_attr_groups[] = {
+	&mpc7450_pmu_format_group,
+	NULL,
+};
+
 struct power_pmu mpc7450_pmu = {
 	.name			= "MPC7450 family",
 	.n_counter		= N_COUNTER,
@@ -411,6 +436,7 @@ struct power_pmu mpc7450_pmu = {
 	.n_generic		= ARRAY_SIZE(mpc7450_generic_events),
 	.generic_events		= mpc7450_generic_events,
 	.cache_events		= &mpc7450_cache_events,
+	.attr_groups		= mpc7450_pmu_attr_groups,
 };
 
 static int __init init_mpc7450_pmu(void)

-- 
2.55.0


