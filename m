Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82532606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LU3MiBBq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCr5nRnz2xns;
	Wed, 18 Nov 2026 04:44:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937448;
	cv=none; b=MQHHIqGIu+IiNnwwy5RB+/SFa5iQKURi0hrRP4jgREX75jSzrpjugH55HIHSt0LphjTigUt7sM5l/BhZoxoX/vxUpG7D305fOOtGB55IvK6ZhtFP46EJnyF9KHye6364/JOYrVXGjqkVZlX1iHSGECdNDbUYzPHfyqWeBzUXg8OaIKKlXeNasZBFGFonUZN3BySlZYeJMyTxnNtOWwtkXUFLYWLt5450jG8gJqMiKnZJBcZ4NnQaXR+tRWhDWItKHDgV5BS5FhdGPeNeHyBz/1nWNX1rF9aHqQDHwFiySJr/mq/QHhZ9VPPFCvOgCq7iTlF59cT38ZHBcAnmadPEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937448; c=relaxed/relaxed;
	bh=uKVN3cMMqKcQp/QJBvqNbe2qemW+gMKwHZ5x6CAtQXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQejGrnT4Rtb9HKxAAiPQCJftvG5xLoInq6gEYGTadVXGY3JvGltwEB9X0+42fTl5ViiydfAdBBd4N86z3Dk0rpef6DkBAE/ng3cWuKo4Jtic+GzENek4Dc6ypf5FmZ6eQEV/ZsVE9iWgtV4toyp2Es7sSBtOh7nSNKScobMcryLMC8xDp1jIun/BJ29Luk1/eL7DFfduOzhoYE7N68gP37NyuZ3LIEphOOXn5yKjLuSneUm7S/ZNPL3b+zoZT+StrCQw10u48mCkh3RyMh+i+n6/AUFy0ZDzReEep6ctXVz11lU7uMOF8uQSmeQNNO6koRHIiXgBgDrEaQSoxT7wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LU3MiBBq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LU3MiBBq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCr14LJz30NF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:08 +1100 (AEDT)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-679a2b5fe87so5312386d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937446; x=1795542246; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKVN3cMMqKcQp/QJBvqNbe2qemW+gMKwHZ5x6CAtQXY=;
        b=LU3MiBBq+CobtcaJ8mSqViHywG/+Zc1lDxKj/JpJDdAFZXYzrJeFiy4MWG9dcGcbD0
         ZdDGrE4IH5ncvx51+TowBWmNz2AUeN1zG+s4LI6Sfm+hqY5Z1a+NBp1YJ3yBcFR9pxRL
         myTyZbvepIwcA5kCcOg4BUTkj6Rkp1I7RCOKlsHLh9oMT5iUkBiVItpZ4J5ong9VgweF
         q1vYLSwvtDJCBdyvpJMqseeUWk4nwt0VZH/dscyQlsTqnTqUElyHpJZSZMr7m16VfhJh
         caESmQWJdWqGxah6pGSs03ZjPHqx4Aey2juuG05jkrzRcuY0bZb2BtF2U7axkGM+zEPe
         uRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937446; x=1795542246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKVN3cMMqKcQp/QJBvqNbe2qemW+gMKwHZ5x6CAtQXY=;
        b=lw56GgLIazugiTVNyhw+fZ2vvjC5oOsXfE+SObVH7W+/JJjH5f2dPc6PWbWgaZVizZ
         ft/ug+O26ozWODVwu2mNmmdDKF6EEkC/POZrcg7497c5u1nuJy5oXIib64VW7iPx7KDl
         7G6XxkP7EhcRwBPk0720Na6aa/3f4TlP8QNIQ6aivJCzKTcUVtzfrGra43Fb6A+F1ik3
         h1e7z3KFAWus7CFW+CyUlOQ6fIzBh4a2ULV69qhw0+d679HVSpJGFtFPF2jcsibU9R0F
         3r1WAZ2kvGhBqoK2sgDSSMH5bSL80ejPtrETy/M1IanyBBa2nEK1qcYwctJyAe7gwust
         BhCQ==
X-Gm-Message-State: APuU4Z+Ccj2vOeAAxnrruAxeHRUslQAXJqrC8bsgT1MhJ0Feswux/OFI
	osOOI//DBTk3rOlyfN8cALWlFGtBHVkEnl9Ks3cbin1cZ7frAgv9EBuG
X-Gm-Gg: AZFdTZcWG5aYTA3SMj0cSsZUtggYrhIsA5Uo5zCw2Ew+zy3uvXIjYpRCxivaWpITjuZ
	UsVYq1WRfDyd/0CbQ+w2vJ8zi1lXVSBPH3TFRs65ROKKwjA929ihHN+Sk0za0md4rPG/AGzxVMF
	ji6uwTL0DF2bpDgcp2O0oOWwagbm+60I6ifXdnVnzcNPoYu256aXn/F4L4oERmr52X/ffhFDRrp
	B6hShmIncl61aGu5hFPvfAROX5LVf7emeEu4EN01gmcBKlqAV+h/AEUIf6I/1eOsOEQEmXf7zBu
	jTOlGpNUPAVvH98P4XDU1LnZkEpwQrtvOPE2PufJldrkb3P9wr1OeLpf47EVTr4jy/nNQLHexwH
	QAK6kxcwa7i1R5/JdvLFoaRmUHYHbljUNxpCTDOs0GYDCIfqqdZgb2kzndhhdoihcgMIGhQBjRo
	w0WTL28EpWzfTAia3yRBH8m5S9/kXhBAHkqRLmP42/ob0vE9dhD4zMAtYL6MytaA0gj1lo7FVwP
	x6h+S3OlCQW7dYrAVCGlYkr0l7ehBy0uCgcQ+VCvKJ2Bj0QffieR9+KmdfqKiiCcG8mt95ElUT/
	TR1EUDoiGAwP0PXWAz1dPlFpszJ1oxYnWKR9pX7s9letHwqEGotbu/qW3JWupl0kzj2HBVstCcj
	3GXyN4aqYn3nXTHl6TptH6iljuDehvSrhK/gPas8cOw5JD/ZH9yqb+16/o1RNq460blpQrxYaQb
	qnvBwsK7Dj7u/BinIBgg==
X-Received: by 2002:a05:690e:151b:b0:67d:c37d:331e with SMTP id 956f58d0204a3-67dd3fe9f53mr89877d50.119.1794937445825;
        Tue, 17 Nov 2026 09:44:05 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd3fed5e0sm205158d50.5.2026.11.17.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:04 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:57 -0500
Subject: [PATCH v2 6/8] powerpc/perf: mpc7450: Export the event format in
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
Message-Id: <20261117-ppc32-perf-v2-6-2072e9b90009@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=+lEsdbEQj8rALkNtLr6OeVNtXuxnotW+z/AE7BFI7fU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIow3N16UvC5FRNL39GZdtxmbzjET2xz5U3g8q1fM
 vXtt2fTOz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaahdEM/wtPtj3MO6
 Blxm/SKP0vU1B9+WuWyutW2drcW/dcW3fu+3yGv8JaW57+nbfc+vWxTPfwR66vOawkHCq456rPZ
 L0dvU69nw0A
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

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
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
2.56.1


