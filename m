Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A998606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmB4Z7M5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqK606G4z3bh6;
	Tue, 10 Nov 2026 12:47:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b12c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275241;
	cv=none; b=MBKgC1C4eBKIUcBRWJfJ+2G0lVy3f3lsaihOP7iTniNdhAoOBvrs7SlwXmx5HChKVXOCviCHQ3p49FrcPD+Y0X8IwI4HzGPUs8Ri3DvpJbcVhfEQ/vcD5ndJqokwaX073xn64vDNTgP5NmXeNABaPIOtEgDeGccS5HFB752IgsZpbIuY89B0WjOXvd/zlk2Q5C8ObdGEOxigAQlm+ItFUdQY9HW61HZ7EVcAsw2SKSgTfrP+QyVWixYwbChGey5S9+yOfGqQCkLiVyqS4jClODW8w+gVAK8t+ud1oUNJWB1XxGaRTCZSqp3ZB20Ub62B+gRItJbVYzeGNrQQEi2VpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275241; c=relaxed/relaxed;
	bh=h28cYnBZXuG7be9hyogKSpkClI5KorW7Rr7qbRnfXWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/53PlD6ve1S7H9TAyJ7L2hRl7Q+Wp/8No2DtZI+4xoQu3FVSqoqF6ksZvLij4VUxT3Uhz0FYy6sJzlQjcaV5Fkr/w+gKlS6AH1sGZFiQ5iXd7Mhje9wIkbNkUDbXb+3DSF2WfVeIO8Fa4rDO+X/5D/32pxF4EgtDSOyoMqv/VrduyPEgMwQMNLOw/IY7m278xN4Du6zNsGomRlpOX/s9Tzx8N6RpOiRJv/bbg4bCb5aYaUdIwQJsADVQ0rFANc8ldvaiGGEk2/tVLzWiK/uSJTLEA96oPqZRZiaWQ/43SiZyFx6ZxRq7w/841C9mKWVfsXoFYG7wCVOolrxFCPYcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmB4Z7M5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmB4Z7M5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqK50PRYz3bf4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:20 +1100 (AEDT)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-679334baa1fso2000756d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275238; x=1794880038; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h28cYnBZXuG7be9hyogKSpkClI5KorW7Rr7qbRnfXWc=;
        b=PmB4Z7M5S+KZVyhuKswjCGHdAYRfSFwmYyaVtgvTqr62ybYjPUToEawGjFHw4d9VCF
         fYMGPWCOchFc2/Ovc6haj9trdaK8f+e+b7t3BElfABE0MK+o5ex79bkN4jd6iZsAridv
         1XQ0rf/VF1vX2tSUJusWhhtgGpfbMQxxIU3mAMT5FNDFgsaL/63b8KGVL+a/bABl8Fjk
         HJLdC5+9TTUXE5svEqvjJHVYx3hOg/GzJ+fvrn0hy2uvEGI8sNn+uIxekjyHb+9uWLtc
         p6tVlYgSFqexF5PF2pezhDnrCIDwTkdvYvOJR5xjWMbhdOk1uSZTSZ3BwZfKDGVfZGho
         FaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275238; x=1794880038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h28cYnBZXuG7be9hyogKSpkClI5KorW7Rr7qbRnfXWc=;
        b=Js5alrcVVLLB8F45peWQwK16cyC7a/GFv0z4IlkZ7kVs4n+A0JOWqkKYt8AzZvX+OG
         4GVRhNTcRnZvjMMRB2Kd1N1m6gJHqfNdSRLYXwP6iHRrMqfMKeMLuvYqOWLwYklSReds
         Xr3MMIYdKdDzdMzvw4Xek/Wq4TIdjaVzkGjkxMBrHYc9eLLv4GPgox/qTXbqzbcBbQGg
         xcTttDfqR8kEKSfhQ+96ggMvMmm2TaWVlmQvpbLg8Rk9s6WqZz0IZMqM0tL5ABq67zbZ
         FYmf26gEyB3119/RAPTo+5qz5Xm9n0YF82vyTCiGGeY2GhVKR/duFlvG0FQ5dsiUzmCh
         Y4OA==
X-Gm-Message-State: APuU4Z/cYjlWS36MkqvNEVsSi+wVbEk22+1ABL4CuRFZAhrRrzV3fqT+
	TWm8y5Ac3jGzpcMRJ3i77ndXWm17qVGHsh39cIeei5RfZw9JHAR37qdLRnAGdCuC
X-Gm-Gg: AYBFou3Hlw6HsHfiElETZfif3GZo1DR+7PcNlx+n4dwcpKnPISOvqAJqK4JkfW+pgOZ
	JHOhzRGrGQhgVocZrl3d6L5tBDyMfqe+EcTWYJA9Ew/xMzNmEi3JU44ExfOGqP3F3BEl7sYz9cF
	RTJXk9brtrZe1w3FIIkvSlIKuu4QFOknUd+wGFOpQk9HIg0M7gCXKuyE3RlzrtoWH3Dd/dPLDrr
	AOtRPhBL6/zteeoa3o0dqmM1+L5CSpwPtWDu5jmAnFnThANFTfXjrttMRd6kGX1GUwWHtlliQ6p
	rTNoQqu50Ss7KJ4o2Og82KDtFOQMs/xOZJ3+pW7NCm5rQayIBShdUd99we+rVxw8znQgPVEpBJe
	mCCsWTIwNfbSFKIEd6JESDpzuMqleddkuodHGNwd2hz7qidqGNPmaLnC+pNwflOm4+MXR4nu5/V
	dMkcDD52gqnI4VwSWUiPH+hILMUyEIfPhrbifm7btQJwM5qcJx9pdw1029hT334McbtECJTA/1o
	CsDe4JlaGbs1loHwy89Y04u/1hYNwety+vOOCsvJE2sWtDwHH+yVtzdim1JXDF/+FzEfQyb7IpH
	h6VjSlRBKrg3IJfUAmMOc1qFNWuSoqIzlYrxO5vAf3NgM8IVcr9nPz9b1NU/fniAERl7va6NY+n
	3Y2vIp9S/Lg==
X-Received: by 2002:a05:690e:144c:b0:677:b426:5072 with SMTP id 956f58d0204a3-67c56736634mr603152d50.47.1794275238493;
        Mon, 09 Nov 2026 17:47:18 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a2653sm716843d50.8.2026.11.09.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:17 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:07 -0500
Subject: [PATCH 8/8] powerpc/perf: mpc7450: Export event names in sysfs
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
Message-Id: <20261109-ppc32-perf-v1-8-a6e8a55b3b48@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12892; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=VsZKSJ/2LgzVYo42rgJzY5sLs2GlxN/rAYf7DIw3mww=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU/Z5Rt39LX1msQ3at5HReRO/n3DKTtlwZHrpbk8z
 mplrt53Oz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaE04M/51/PV6vHJ
 F9zkXopfPfLfw+aYZC/EbOCkqLq3ULHlc8XsfwP0616VrV2zviBQwN8byP7LdtlHvyU+WbsLFp6
 KomzkpTJgA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

perf list shows only the generic events for the MPC7450 family, so every
other event has to be written as a raw code.

Name the events in the manual (MPC7450UM Rev. 5, Tables 11-9 to 11-14)
in mpc7450-events-list.h, as the POWER7 driver does.  An event that
several PMCs implement at the same select value is listed once without
a PMC, so the driver still picks the counter.  An event repeated at
different select values is listed once and reached through the
alternatives table, whose comments now use the same names.  223 names
cover all 279 non-reserved select values.

The 7441, 7445, 7447, 7447A and 7448 have no L3, and their L3 events
are reserved.  Hide the L3 names when CPU_FTR_L3CR is clear, which is
on the 7447A and 7448.  The 7441, 7445 and 7447 share their PVRs with
the 7451, 7455 and 7457 and get CPU_FTR_L3CR, so they keep them.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-events-list.h | 250 ++++++++++++++++++++++++++++++++
 arch/powerpc/perf/mpc7450-pmu.c         |  68 ++++++++-
 2 files changed, 315 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-events-list.h b/arch/powerpc/perf/mpc7450-events-list.h
new file mode 100644
index 000000000000..b79f2fc675bf
--- /dev/null
+++ b/arch/powerpc/perf/mpc7450-events-list.h
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Performance counter events for MPC7450-family processors, from the
+ * MPC7450 RISC Microprocessor Family Reference Manual, Rev. 5, tables 11-9
+ * to 11-14.
+ *
+ * Codes below 0x100 are the events that several PMCs implement with the
+ * same select value; the driver picks the counter.  Events that exist on
+ * more than one PMC under different select values are listed once, and
+ * the others are found through the alternatives table.
+ *
+ * EVENT_L3() events count only on parts with an L3 cache interface.
+ */
+
+/* Events available on several PMCs */
+EVENT(PM_CYC,				0x001)
+EVENT(PM_INST_CMPL,			0x002)
+EVENT(PM_TBL_BIT_TRANS,			0x003)
+EVENT(PM_INST_DISP,			0x004)
+EVENT(PM_PMEXC,				0x005)
+EVENT(PM_PMON_IN,			0x007)
+EVENT(PM_VPU_CMPL,			0x008)
+EVENT(PM_VFPU_CMPL,			0x009)
+EVENT(PM_VIU1_CMPL,			0x00a)
+EVENT(PM_VIU2_CMPL,			0x00b)
+EVENT(PM_MTVSCR_CMPL,			0x00c)
+EVENT(PM_MTVRSAVE_CMPL,			0x00d)
+EVENT(PM_VPU_OPND_WAIT_CYC,		0x00e)
+EVENT(PM_VFPU_OPND_WAIT_CYC,		0x00f)
+EVENT(PM_VIU1_OPND_WAIT_CYC,		0x010)
+EVENT(PM_VIU2_OPND_WAIT_CYC,		0x011)
+EVENT(PM_MFVSCR_SYNC_CYC,		0x012)
+EVENT(PM_VSCR_SAT_SET,			0x013)
+EVENT(PM_ST_CMPL,			0x014)
+EVENT(PM_L1_ICACHE_MISS,		0x015)
+EVENT(PM_L1_DCACHE_SNOOP,		0x016)
+
+/* PMC1 */
+EVENT(PM_BR_UNRESOLVED,			0x117)
+EVENT(PM_BR_SPEC_BUF1_CYC,		0x118)
+EVENT(PM_BR_UNIT_STALL_CYC,		0x119)
+EVENT(PM_BR_TARGET_HIT,			0x11a)
+EVENT(PM_BR_LINK_STACK_PRED,		0x11b)
+EVENT(PM_GPR_IQ_DISP,			0x11c)
+EVENT(PM_DISP_3_CYC,			0x11d)
+EVENT(PM_INSTQ_EXCEED_CYC,		0x11e)
+EVENT(PM_ALTV_IQ_EXCEED_CYC,		0x11f)
+EVENT(PM_NO_CMPL_CYC,			0x120)
+EVENT(PM_IU2_CMPL,			0x121)
+EVENT(PM_BR_CMPL,			0x122)
+EVENT(PM_EIEIO_CMPL,			0x123)
+EVENT(PM_MTSPR_CMPL,			0x124)
+EVENT(PM_SC_CMPL,			0x125)
+EVENT(PM_LD_STR_MULT_CMPL,		0x126)
+EVENT(PM_ITLB_SEARCH_CYC,		0x127)
+EVENT(PM_DTLB_SEARCH_EXCEED_CYC,	0x128)
+EVENT(PM_L1_ICACHE_ACCESS,		0x129)
+EVENT(PM_IABR_MATCH,			0x12a)
+EVENT(PM_LD_MISS_EXCEED_L1_CYC,		0x12b)
+EVENT(PM_L1_DCACHE_SNOOP_HIT_MOD,	0x12c)
+EVENT(PM_LD_MISS_ALIAS,			0x12d)
+EVENT(PM_LD_MISS_ALIAS_TOUCH,		0x12e)
+EVENT(PM_TOUCH_ALIAS,			0x12f)
+EVENT(PM_L1_DCACHE_SNOOP_HIT_COQ,	0x130)
+EVENT(PM_L1_DCACHE_SNOOP_HIT_CO,	0x131)
+EVENT(PM_L1_DCACHE_SNOOP_HIT,		0x132)
+EVENT(PM_WT_ST,				0x133)
+EVENT(PM_CI_ST,				0x134)
+EVENT(PM_L1_DCACHE_LD_HIT,		0x135)
+EVENT(PM_L1_DCACHE_TOUCH_HIT,		0x136)
+EVENT(PM_L1_DCACHE_ST_HIT,		0x137)
+EVENT(PM_L1_DCACHE_HIT,			0x138)
+EVENT(PM_DST_DISP,			0x139)
+EVENT(PM_DST_REFRESH,			0x13a)
+EVENT(PM_DST_SEARCH,			0x13b)
+EVENT(PM_DSS_CMPL,			0x13c)
+EVENT(PM_DST0_FETCH,			0x13d)
+EVENT(PM_VTQ_SUSPEND,			0x13e)
+EVENT(PM_VTQ_FETCH_HIT,			0x13f)
+EVENT(PM_VEC_LD_CMPL,			0x140)
+EVENT(PM_FP_ST_CMPL,			0x141)
+EVENT(PM_FP_ST_RENORM,			0x142)
+EVENT(PM_FP_ST_DENORM,			0x143)
+EVENT(PM_FP_ST_STALL_CYC,		0x144)
+EVENT(PM_LSU_TRUE_ALIAS_STALL,		0x146)
+EVENT(PM_LSU_INDEX_ALIAS_STALL,		0x147)
+EVENT(PM_LSU_ALIAS_FSQ,			0x148)
+EVENT(PM_LSU_ALIAS_CSQ,			0x149)
+EVENT(PM_LSU_LD_HIT_ALIAS_CSQ0,		0x14a)
+EVENT(PM_LSU_LD_MISS_ALIAS_CSQ0,	0x14b)
+EVENT(PM_LSU_TOUCH_ALIAS_FSQ,		0x14c)
+EVENT(PM_LSU_TOUCH_ALIAS_CSQ,		0x14d)
+EVENT(PM_LSU_LMQ_FULL_STALL,		0x14e)
+EVENT(PM_FP_LD_CMPL,			0x14f)
+EVENT(PM_FP_LD_SINGLE_CMPL,		0x150)
+EVENT(PM_FP_LD_DOUBLE_CMPL,		0x151)
+EVENT(PM_LSU_RA_LATCH_STALL,		0x152)
+EVENT(PM_LSU_LD_ST_ALIAS_STALL,		0x153)
+EVENT(PM_LSU_LMQ_INDEX_ALIAS,		0x154)
+EVENT(PM_LSU_STQ_INDEX_ALIAS,		0x155)
+EVENT(PM_LSU_CSQ_FWD,			0x156)
+EVENT(PM_LSU_MISALIGN_LD_FIN,		0x157)
+EVENT(PM_LSU_MISALIGN_ST_CMPL,		0x158)
+EVENT(PM_LSU_MISALIGN_STALL,		0x159)
+EVENT(PM_FPSCR_RENAME_QTR_BUSY,		0x15a)
+EVENT(PM_FPSCR_RENAME_HALF_BUSY,	0x15b)
+EVENT(PM_FPSCR_RENAME_3QTR_BUSY,	0x15c)
+EVENT(PM_FPSCR_RENAME_FULL,		0x15d)
+EVENT(PM_FP_DENORM_RESULT,		0x15e)
+
+/* PMC2 */
+EVENT(PM_L1_DCACHE_MISS,		0x217)
+EVENT(PM_FPR_IQ_DISP,			0x218)
+EVENT(PM_LSU_CMPL,			0x219)
+EVENT(PM_LD_CMPL,			0x21a)
+EVENT(PM_ST_STR_MULT_CMPL,		0x21b)
+EVENT(PM_TLBIE_CMPL,			0x21c)
+EVENT(PM_LWARX_CMPL,			0x21d)
+EVENT(PM_MFSPR_CMPL,			0x21e)
+EVENT(PM_REFETCH_SERIAL,		0x21f)
+EVENT(PM_CQ_EXCEED_CYC,			0x220)
+EVENT(PM_CMPL_1_CYC,			0x221)
+EVENT(PM_DISP_2_CYC,			0x222)
+EVENT(PM_ITLB_MISS,			0x223)
+EVENT(PM_L1_ICACHE_MISS_CYC,		0x224)
+EVENT(PM_L1_DCACHE_LD_MISS,		0x225)
+EVENT(PM_L1_DCACHE_TOUCH_MISS,		0x226)
+EVENT(PM_L1_DCACHE_ST_MISS,		0x227)
+EVENT(PM_L1_DCACHE_TOUCH_MISS_CYC,	0x228)
+EVENT(PM_L1_DCACHE_BUSY_CYC,		0x229)
+EVENT(PM_DST1_FETCH,			0x22a)
+EVENT(PM_VTQ_CANCEL,			0x22b)
+EVENT(PM_VTQ_RESUME,			0x22c)
+EVENT(PM_VTQ_FETCH_MISS,		0x22d)
+EVENT(PM_VTQ_FETCH,			0x22e)
+EVENT(PM_TLBIE_SNOOP,			0x22f)
+EVENT(PM_L1_ICACHE_RELOAD,		0x230)
+EVENT(PM_L1_DCACHE_RELOAD,		0x231)
+EVENT(PM_L1_DCACHE_CASTOUT,		0x232)
+EVENT(PM_ST_MERGE,			0x233)
+EVENT(PM_ST_MERGE_32B,			0x234)
+EVENT(PM_DABR_MATCH,			0x235)
+EVENT(PM_BR_FALLTHRU,			0x236)
+EVENT(PM_BR_SPEC_BUF1_OK,		0x237)
+EVENT(PM_BR_SPEC_BUF2_CYC,		0x238)
+EVENT(PM_BR_LR_STALL_CYC,		0x239)
+EVENT(PM_BTIC_MISS,			0x23a)
+EVENT(PM_BR_LINK_STACK_OK,		0x23b)
+EVENT(PM_FPR_IQ_STALL,			0x23c)
+EVENT(PM_PR_SWITCH,			0x23d)
+EVENT(PM_FP_ST_SINGLE_CMPL,		0x23e)
+
+/* PMC3 */
+EVENT(PM_CMPL_2_CYC,			0x308)
+EVENT(PM_DISP_1_CYC,			0x309)
+EVENT(PM_VR_IQ_DISP,			0x30a)
+EVENT(PM_VR_IQ_STALL,			0x30b)
+EVENT(PM_GPR_RB_EXCEED_CYC,		0x30c)
+EVENT(PM_FPR_IQ_ENTRIES,		0x30d)
+EVENT(PM_FPU_CMPL,			0x30e)
+EVENT(PM_STWCX_CMPL,			0x30f)
+EVENT(PM_LD_STR_MULT_PIECES,		0x310)
+EVENT(PM_ITLB_SEARCH_EXCEED,		0x311)
+EVENT(PM_DTLB_MISS,			0x312)
+EVENT(PM_L1_ICACHE_MISS_CANCEL,		0x313)
+EVENT(PM_L1_DCACHE_OP_HIT,		0x314)
+EVENT(PM_L1_DCACHE_LD_MISS_CYC,		0x315)
+EVENT(PM_L1_DCACHE_PUSH,		0x316)
+EVENT(PM_VT2_FETCH,			0x318)
+EVENT(PM_BR_TAKEN,			0x319)
+EVENT(PM_BR_FLUSH,			0x31a)
+EVENT(PM_BR_SPEC_BUF2_OK,		0x31b)
+EVENT(PM_BR_SPEC_BUF3_CYC,		0x31c)
+EVENT(PM_BR_CTR_STALL_CYC,		0x31d)
+EVENT(PM_FBTIC_HIT,			0x31e)
+EVENT(PM_BR_LINK_STACK_MPRED,		0x31f)
+
+/* PMC4 */
+EVENT(PM_CMPL_3_CYC,			0x40e)
+EVENT(PM_DISP_0_CYC,			0x40f)
+EVENT(PM_GPR_IQ_EXCEED_CYC,		0x410)
+EVENT(PM_GPR_IQ_STALL_CYC,		0x411)
+EVENT(PM_IU1_CMPL,			0x412)
+EVENT(PM_DSSALL_CMPL,			0x413)
+EVENT(PM_TLBSYNC_CMPL,			0x414)
+EVENT(PM_SYNC_CMPL,			0x415)
+EVENT(PM_ST_STR_MULT_PIECES,		0x416)
+EVENT(PM_DTLB_SEARCH_CYC,		0x417)
+EVENT(PM_LSU_SNOOP_RETRY,		0x418)
+EVENT(PM_STWCX_OK,			0x419)
+EVENT(PM_DST3_FETCH,			0x41a)
+EVENT(PM_BR_SPEC_BUF3_OK,		0x41b)
+EVENT(PM_BR_MPRED,			0x41c)
+EVENT(PM_BR_FOLDED,			0x41d)
+EVENT(PM_FP_ST_DOUBLE_CMPL,		0x41e)
+
+/* PMC5 */
+EVENT(PM_L2_HIT,			0x502)
+EVENT_L3(PM_L3_HIT,			0x503)
+EVENT(PM_L2_ICACHE_MISS,		0x504)
+EVENT_L3(PM_L3_ICACHE_MISS,		0x505)
+EVENT(PM_L2_DCACHE_MISS,		0x506)
+EVENT_L3(PM_L3_DCACHE_MISS,		0x507)
+EVENT(PM_L2_LD_HIT,			0x508)
+EVENT(PM_L2_ST_HIT,			0x509)
+EVENT_L3(PM_L3_LD_HIT,			0x50a)
+EVENT_L3(PM_L3_ST_HIT,			0x50b)
+EVENT(PM_L2_TOUCH_HIT,			0x50d)
+EVENT_L3(PM_L3_TOUCH_HIT,		0x50e)
+EVENT(PM_INT_RETRY,			0x50f)
+EVENT(PM_SNOOP_MOD,			0x510)
+EVENT(PM_SNOOP_VALID,			0x511)
+EVENT(PM_INTV_LOCAL,			0x512)
+EVENT(PM_L2_MISS,			0x513)
+EVENT_L3(PM_L3_MISS,			0x514)
+
+/* PMC6 */
+EVENT(PM_L2_CASTOUT,			0x608)
+EVENT_L3(PM_L3_CASTOUT,			0x609)
+EVENT(PM_L2SQ_FULL_CYC,			0x60a)
+EVENT_L3(PM_L3SQ_FULL_CYC,		0x60b)
+EVENT(PM_SNOOP_RETRY,			0x60f)
+EVENT_L3(PM_L3_RAQ_FULL_CYC,		0x610)
+EVENT_L3(PM_L3_WAQ_FULL_CYC,		0x611)
+EVENT(PM_L1_EXT_INTV,			0x613)
+EVENT(PM_L2_EXT_INTV,			0x614)
+EVENT_L3(PM_L3_EXT_INTV,		0x615)
+EVENT(PM_EXT_INTV,			0x616)
+EVENT(PM_EXT_PUSH,			0x617)
+EVENT(PM_EXT_SNOOP_RETRY,		0x618)
+EVENT(PM_DTQ_FULL_CYC,			0x619)
+EVENT(PM_BUS_RETRY,			0x61a)
+EVENT(PM_L2_VALID_REQ,			0x61b)
+EVENT(PM_BORDQ_FULL_CYC,		0x61c)
+EVENT(PM_BUS_TA_RD,			0x62a)
+EVENT(PM_BUS_TA_WR,			0x62b)
+EVENT(PM_BUS_RD_OK,			0x62c)
+EVENT(PM_BUS_WR_OK,			0x62d)
+EVENT(PM_BUS_RDWR_OK,			0x62e)
+EVENT(PM_BUS_RETRY_L1,			0x62f)
+EVENT(PM_BUS_RETRY_ADJ,			0x630)
+EVENT(PM_BUS_RETRY_COLLISION,		0x631)
+EVENT(PM_BUS_RETRY_INTV_ORDER,		0x632)
+EVENT(PM_SNOOP_REQ,			0x633)
+EVENT(PM_L2_PREF,			0x634)
+EVENT(PM_L2_PREF_LD_COLLISION,		0x635)
+EVENT(PM_L2_PREF_ST_COLLISION,		0x636)
+EVENT(PM_L2_PREF_IFETCH_COLLISION,	0x637)
+EVENT(PM_L2_PREF_LMQ_COLLISION,		0x638)
+EVENT(PM_L2_PREF_FULL,			0x639)
diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 9bed5c238f45..4ee7b1a822ea 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -22,6 +22,18 @@
 #define PM_PMC_MSK	7
 #define PM_PMCSEL_MSK	0x7f
 
+/*
+ * MPC7450 event codes.
+ */
+#define EVENT(_name, _code)	_name = _code,
+#define EVENT_L3(_name, _code)	_name = _code,
+
+enum {
+#include "mpc7450-events-list.h"
+};
+#undef EVENT
+#undef EVENT_L3
+
 /*
  * Classify events according to how specific their PMC requirements are.
  * Result is:
@@ -190,11 +202,11 @@ static const unsigned int event_alternatives[][MAX_ALT] = {
 	{ 0x505, 0x605, 0x621 },	/* PM_L3_ICACHE_MISS */
 	{ 0x506, 0x606 },		/* PM_L2_DCACHE_MISS */
 	{ 0x507, 0x607, 0x622 },	/* PM_L3_DCACHE_MISS */
-	{ 0x50a, 0x623 },		/* PM_LD_HIT_L3 */
-	{ 0x50b, 0x624 },		/* PM_ST_HIT_L3 */
+	{ 0x50a, 0x623 },		/* PM_L3_LD_HIT */
+	{ 0x50b, 0x624 },		/* PM_L3_ST_HIT */
 	{ 0x50d, 0x60d },		/* PM_L2_TOUCH_HIT */
 	{ 0x50e, 0x60e, 0x625 },	/* PM_L3_TOUCH_HIT */
-	{ 0x512, 0x612 },		/* PM_INT_LOCAL */
+	{ 0x512, 0x612 },		/* PM_INTV_LOCAL */
 	{ 0x513, 0x61d },		/* PM_L2_MISS */
 	{ 0x514, 0x61e, 0x620 },	/* PM_L3_MISS */
 };
@@ -398,6 +410,55 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 };
 
+#define EVENT(_name, _code)	POWER_EVENT_ATTR(_name, _name);
+#define EVENT_L3(_name, _code)	POWER_EVENT_ATTR(_name, _name);
+#include "mpc7450-events-list.h"
+#undef EVENT
+#undef EVENT_L3
+
+#define EVENT(_name, _code)	POWER_EVENT_PTR(_name),
+#define EVENT_L3(_name, _code)	POWER_EVENT_PTR(_name),
+
+static struct attribute *mpc7450_events_attr[] = {
+#include "mpc7450-events-list.h"
+	NULL
+};
+
+#undef EVENT
+#undef EVENT_L3
+
+static bool mpc7450_is_l3_event(u64 event)
+{
+	switch (event) {
+#define EVENT(_name, _code)
+#define EVENT_L3(_name, _code)	case _code:
+#include "mpc7450-events-list.h"
+#undef EVENT
+#undef EVENT_L3
+		return true;
+	}
+	return false;
+}
+
+/* The L3 events are reserved on parts without an L3 interface. */
+static umode_t mpc7450_events_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int n)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+	if (mpc7450_is_l3_event(pmu_attr->id) && !cpu_has_feature(CPU_FTR_L3CR))
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group mpc7450_pmu_events_group = {
+	.name = "events",
+	.attrs = mpc7450_events_attr,
+	.is_visible = mpc7450_events_is_visible,
+};
+
 PMU_FORMAT_ATTR(event,		"config:0-18");
 PMU_FORMAT_ATTR(pmcsel,		"config:0-6");
 PMU_FORMAT_ATTR(pmc,		"config:8-10");
@@ -420,6 +481,7 @@ static const struct attribute_group mpc7450_pmu_format_group = {
 
 static const struct attribute_group *mpc7450_pmu_attr_groups[] = {
 	&mpc7450_pmu_format_group,
+	&mpc7450_pmu_events_group,
 	NULL,
 };
 

-- 
2.55.0


