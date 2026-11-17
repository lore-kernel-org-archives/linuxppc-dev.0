Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70008606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBmHypt3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCw6MPLz30V1;
	Wed, 18 Nov 2026 04:44:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937452;
	cv=none; b=J29dlEmM61eYAF5acyc4ZyXY5nPASs9/MLCloKtRoSLGdJ8VFrtrQbUT0pEhYDgKeBnlPgUjpXQ/BBfUR7n2BluOXETr5gcvVsSaMv8hSwvaarLpq42zj3tv+s47DAjNx3SbOUf0PxWxwY8wMlUU+WMRly9C7m7lCaaBaMNQBOHDc40sHbEXfOgf4IC//MEANX6oVQScjMeNFseysVtPaplJjE1oHdbtPWwRr/FBdRmmOdJKFQW+2J6y3i6ma0wlh3RrU8MZ3yBPCPB+3a0GKYWGMaZaYz0pzSWWTqDx0xci8wX4Ji8thG6TyzhzVhHpOqvFqkjRRxFdKGNKvJYnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937452; c=relaxed/relaxed;
	bh=UAukkJGWhtB4bDYNB6heYhfuniD4tNoKS9Q5n4s2vgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4/oSAwk3OjcbHSs1OZ0uXtMVv+mhw1OwiB/UEGmknkxqH1yezDPm3zVA14Zlztj745JGqIwQuVPrsLf8hiqO1dFWx+rRYqLcfylk7OxINNoZ+OFa0m8my/4DzX6HELqiPJp5qQI7DIOnBeQtEg/s8mgBemiyOb64e7e1jZmO8e7+cvN+Qw/0y+SQhHSWKk4X/YFVzPNjwq6FkQJw5DVcDZVd63D5CdwvfycohDaK+XFEXS1UYyDS/j4HFLU7pUW9XHt9Jw8pvN1zWdMjNaJhF0Es7UubgZAR7pWV0phIiAHqm/e9eAGECtRiYNe1bJQNhbwV0u9ALvrS60qOyI++w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBmHypt3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBmHypt3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com [IPv6:2607:f8b0:4864:20::b129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCv4hkcz30Vf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:44:11 +1100 (AEDT)
Received: by mail-yx1-xb129.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so6137511d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937449; x=1795542249; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAukkJGWhtB4bDYNB6heYhfuniD4tNoKS9Q5n4s2vgk=;
        b=SBmHypt3A0+T7jmtJ1U/30gbDsPqbyoGkdYcbmDpLBn7oulHRifZqmeWyyFfVss+p5
         n9874RqvTgbsj3T+gAX4YubZAVPcIkpCfx/br/fzyH/YCiFchGllxq8vjiWYKupdMi4A
         5/OPGm97USnwZ7JWpqfA5RQh9Tmoj6milfmmfgzVSwYquSIcaT6h9o22kM9CR8y08O+0
         vcJyX2jluscXXaB4Dxcr1/KuF3ZbGBS6Pp018MbFUqlUZ8ZIWTLd9z8W2AS17KNMfIsM
         nESgf4Yv3o1MTbVUi5uiFwq58SEHaTsrXRKpSghYzw733IwYAaLEGIRPesbz3oO4RQ69
         loPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937449; x=1795542249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAukkJGWhtB4bDYNB6heYhfuniD4tNoKS9Q5n4s2vgk=;
        b=IdKB/x9Z1qin+SszyXzEfm/l/dxfAm6ZRTvRngqHa22/3CIT0gVkn31vsGtFUzxkIJ
         GVrMHMYBOUQab2kor9YfsHJNqQcEas8H5C3g8fhtApJzxkKlz7/6WvMApadswL3NVaIJ
         f7j68LgoOcao/c1yucgm1tVYD4GbMpwWaAQmaEf3ExnG2geXDoGq6ooEmAQjZ2VUMf4d
         kdUVEjzhQR0GQl3IOPO0ZCjNxOXDXEc4Aq9IaPwWCgWbNsWW+15pBExnqAnFHsKaWaN4
         wI9BJTKEULZhEXodqxgHDE1qkRKveP+gofRlWXfYUJ62Y+sxroAzr6+ntvHnqZWTq4Uv
         DADw==
X-Gm-Message-State: APuU4Z/AmUo9LwxcTZYWelPNHtZD4hPTIP3mh2FSK+A4S8mVyF8VH7/Y
	v5vUMfkIQUa/N1mqWInazie1OQOevS4vZesuQm/7F/pS1f8R7Qh5t9Tk
X-Gm-Gg: AZFdTZee0/XmGieZuy2sQ0f17W24KliDLcGVSj7o5cQlt4msuXD1N6Z2/FEjtf4LtrU
	bbWwBWQk2bB5NP8+bNSxn/ER+vcYGGyp8delYYsimN72aFkD9/Kb+YefAD5Agk9e/yYKNgWfa8n
	/g14YumY/n38LXY6BLuVSL507g3L6cfNE9h8dkt9fTuEYgxJeljFR0pASfH5jmERcrocZLNrm7L
	pEa/IFPC/g20z1x3p8EQayCy6Kb5DHN6lmAI1ZEKjM5K8FiTBKBtiW9tm1rhTp0yDcV9Eqbscsx
	CIx3E7Im+K1ypZt2SdwNmKRZiOvJPJ9C2Syo111IgjA3+teeZ4qXNe8ZsZ9rPS8c/wUeQAyzG0u
	zp3sSgqtBfeHuhdxyNMBInHyLuhpWs/GqTeY64TbrmQLJYpaoro0fDsktY1stis76jsINp6/YDP
	ux27Jp2ebtgVsodSpO5Sr9h+x1ihIqEV5CDY0U0Gp1eGuVpgU5aXuIIyDFiUuodB5JyhecytI5A
	deOJUaKJFc4Oi76ZZ+RijCIjXO4LQhbgyR/THMRmVo+QPchWlyNbIN3s6V9L4WWd5a0vUMDMoX6
	AVeYftHopYzGndMPPKrs7MNTL0mOKhc7iCEn8KNObEXWnQZNivDN3qzkfocREjd6kYwAe4uPJCo
	nRV+dl7MaEIeoBhHkOoLkMNuXvmhtqx1a37/+k4xDaXoI76SpMNfFX9mMk4xyAI9mJz40ygY4yC
	AkhM2s/oC9YuxlQZyV6Q==
X-Received: by 2002:a05:690e:4002:b0:67d:a6fc:6bb0 with SMTP id 956f58d0204a3-67dd401f905mr128079d50.89.1794937448762;
        Tue, 17 Nov 2026 09:44:08 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd40130casm203716d50.13.2026.11.17.09.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:08 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:59 -0500
Subject: [PATCH v2 8/8] powerpc/perf: mpc7450: Export event names in sysfs
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
Message-Id: <20261117-ppc32-perf-v2-8-2072e9b90009@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12943; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=sLsCcHCLh+fTE6VophMP1tzd+H87oqTiU5YtIFpFnoA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIqcaWF0uUvj1dT7DjH7fR2X1Jav7JLVcXuXKxnvH
 r7iwBfGjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLlmkxbD/8zJujXmXe
 KPHn6uijV7enC2VzXb/7TYjmfrV4QEa26S8mdkeBBl1NEtKm30I+9DqtFxSwVTwwfMTKKOxzae9
 j+11kSFGwA=
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

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
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
2.56.1


