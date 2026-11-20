Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71D606A6CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLhrYcxi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWQW11YxCz2xpt;
	Sat, 21 Nov 2026 06:33:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795203229;
	cv=none; b=nytGwsZ7OKSQwEAQHpOSHA8NH1422D7CUFM0D0OXq3c7xNq3+be++h8pcw4oROHUfqUuy//oi9dDAgOfpgnSx8HrtKpcsc1nTf+oCKPpK5ubdYlTrGACJzz4MK/436f84ffe57wyHkIXjt2GLJsIhNfFhniy9cGLwujpEeAFLWLqjNWkf6fXu/alNYKm5EyL5BaZ1qwCVewqGhfObLt/50HBTJauXwDvXpc/8nM2SWN9lvCng/ovU8+YbBJqdmifkeSUOHSGuiLXUjkCDaJq62/ZmBoDci4kz6ZbNtmFHvpMS0FhosqUtANHXpte6imegiab1ZDdBiJ9ix11TcSh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795203229; c=relaxed/relaxed;
	bh=CbEMQyFndEQPpa9CfnVe3JHR8goha/OLm3NFkyD+X70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQYagCRec+eFgPLyh+PSjtIOsnDp/hbMshhKwypM1xI4Pr13PPIYuCNv8vK0VXjcAIRIJwrKYIDGUOHUnO8GhvTRw2H8W/bWHZzsGG9x6EY49+YZC+K/jFnSrDjclBPFN5szCu2Y3XIdDQV7x1XSD0ygcLBq8cMAECOpCzekmVTonRIwoNUtecH7qkaIQ3QTi7+P3udgIedN2oCPTHr3N/oCM4uY3BV53+SJLMAhXalHQ2BqoXPATyVO/9oyFuxNIJVP0uiW/QHD9RWvpv3HjDoYooFwpgZLjp8DnspE1Y/YhFo9QPExxZL2qG5wFG0XjcKeDGlh33duf3PV8AnLmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLhrYcxi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLhrYcxi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWQVz3W0Qz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 06:33:47 +1100 (AEDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-8b4d6981c67so8571217b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 11:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203225; x=1795808025; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbEMQyFndEQPpa9CfnVe3JHR8goha/OLm3NFkyD+X70=;
        b=HLhrYcxiQ27bKuiX6H6leWLEDYIGDiABjAeJKWwoMhE4ZvirS+jzbTXpwS/0CJaYPZ
         tHO691joEaoxd6JBvNBZFhzfGGgyuJjdWdkub1BtO1xdXbZEW/c0I0zOvs3Seaq5pm0a
         SxzsVENe4aHlryaWkEUgZQR4PbVBtyhu3O9SeZW99XRe2iL2QVckPGo9xUl85S2KYKYc
         YkOHqj4ka27ZGNrR7ZurqvJCp9OCQpy4n625hSyzTw7H/HdZhZFimKadGv+m14FxXiCk
         PFnV5J9qk9ntUI1gtk4gtFWJH5NTA75Ws762U0iMZzyxtMTBEzYXM8xSiCuGbfQ7ShDc
         dnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203225; x=1795808025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbEMQyFndEQPpa9CfnVe3JHR8goha/OLm3NFkyD+X70=;
        b=s2WN4cQCgXEq8Ndu/BaYS4Xq5NARK4mQB7LVwVT3WeD9CJ8F1H4+erK2SUB6drSAGB
         YNY0xvc4i24CwEoEXQhbaLaUb40tRn4CfX8Pa0jsMDQnzt2CiW1Uu3P4AHHt/5A2BZo/
         AU6nvnDQohHHdgVEDbgAcETnWEtGuzWjWtlW0Sp0rDUt2uwpP3wQvqhjfGgdsyO3mSPu
         gdPBqz/iWbOJYU5Sf+ntURIG4mZGDMIj9z/oyySSjhFNq3dhMsTf6i+yDPSGWOT/BRhv
         6GJyRz/FNUtyS0ZOANCyz0fudB05EMuntBVIAQdXVuB0yxoBumw/qxaqgXq7K4M9gYM8
         DEFw==
X-Gm-Message-State: APuU4Z8SWWQ1bbk8sJ81tM32VfBV6yBtQgyp/LwsUSv5CKpPELvtRMJi
	U1E/jnulzlbYwt1sSxeBpPxF28kpyVxE+UPL/ve2XQ2ipvuFKwXYFv9R
X-Gm-Gg: AZFdTZe2FIhQ85HUD/Y4hap1nq0qiJZSWr3Wh0FY55RzvDVCTLUcBQN3LB0dFnQlxFC
	PyL75CvH/lft/pj1yj92cyBaVkrmdMUetFa1hGiiWcDv0dQLnrIrFtBMSWTdFAy6duz7FlXnP9F
	s1N4VkpLLbQqN0e47St3gckWEFYO1EAFSRC0IMtGJCEj0+f3vYbH3GTyMFl3eIY8uc78SuXbRc0
	C0ca78L9Dq5eI0ptIL65o8+frFc1Shce8PWxbKq2El8WDBUkpPfeDQfzQ4MnaYdiI3N+4jTXKT/
	uV6gmgG07jc0GsYX+F/B8L0f/6KqFpVjH7kMahYD6PzAbBU2b6PtPuBOINIh3lOU8xSiQsAPK0m
	yESixDIFHPA4Y/5poAkuU3I/94BT/hu2GL83pPZuWARBP/6KonGyj6KkDjvv9U103zY0FPLz8SL
	jYcpbCPCGqdhXuSyoUOJZQyXcKTjzRPmp07AkaPEK51mwrXOTotP1IQSaYiOoBAYX9pQ9cBWxgJ
	Gkee8WB0Ck0wJT7jo1hRWQieLzFwYMd41ll6km7dCRUF3HIJoiaMyjuzpNg3MptvH0hZVuTbpz1
	GcpgkXU4sSzpdauYWXstEcBo6628uBelWhINTCGqY0oR0no6MGTDkXP9IGb23uUOTjxlW+aX09i
	BMvpkBPSqyyyDESXoUVZvP+9iCxBH+V9ePRJapXYYFg==
X-Received: by 2002:a05:690c:dc5:b0:8b3:4122:f464 with SMTP id 00721157ae682-8b5204f191bmr23190407b3.55.1795203224695;
        Fri, 20 Nov 2026 11:33:44 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202b085bsm17631997b3.16.2026.11.20.11.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:33:43 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 20 Nov 2026 14:33:40 -0500
Subject: [PATCH 1/4] powerpc/32: Decode MPC745x L2 and L3 cache machine
 checks
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
Message-Id: <20261120-ppc32-l2-ecc-v1-1-98fc8e6e0a32@gmail.com>
References: <20261120-ppc32-l2-ecc-v1-0-98fc8e6e0a32@gmail.com>
In-Reply-To: <20261120-ppc32-l2-ecc-v1-0-98fc8e6e0a32@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Matt Turner <mattst88@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-edac@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7638; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=VRO/XG2kWpmnUT7mAvBKhs8RiHjgk1isVl1A350JWDY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIZFkyxdpOVVbIvCupavdxTcu6K5KtLb2x/29Fn/HK9q
 iN7j1ZuxwcWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFwTf4uR4eSC4yvlz7
 591b5m+dPbm+dsz3YWzDla9mnOxl1T36qvXfeJ4ceGt511zyKV2yJMnVZsCmTffXRX8go/Dr4ya
 b286B0v2AA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the 745x, SRR1[MSS] means the memory subsystem detected an error, and
MSSSR0 says which: L2 tag or data parity, MPC7448 L2 ECC, or L3 tag or
data parity.  machine_check_generic() reports these cache errors as "L2
data cache parity error" and never clears MSSSR0, whose bits are sticky.

Add machine_check_745x(), which decodes and clears the MSSSR0 cache
error bits, and use it for every 745x.  Machine checks without one of
those bits still go to machine_check_generic().

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/include/asm/cputable.h       |  1 +
 arch/powerpc/include/asm/reg.h            |  5 +++++
 arch/powerpc/kernel/cpu_specs_book3s_32.h | 22 +++++++++++-----------
 arch/powerpc/kernel/traps.c               | 28 ++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a3be81c47df3..8445533c946b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -34,6 +34,7 @@ extern int machine_check_e500(struct pt_regs *regs);
 extern int machine_check_47x(struct pt_regs *regs);
 int machine_check_8xx(struct pt_regs *regs);
 int machine_check_83xx(struct pt_regs *regs);
+int machine_check_745x(struct pt_regs *regs);
 
 extern void cpu_down_flush_e500v2(void);
 extern void cpu_down_flush_e500mc(void);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 541a493e13bf..82a85d44776e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -729,6 +729,10 @@
 
 #define SPRN_MSSCR0	0x3f6	/* Memory Subsystem Control Register 0 */
 #define SPRN_MSSSR0	0x3f7	/* Memory Subsystem Status Register 1 */
+#define   MSSSR0_L2TAG	0x00040000	/* L2 tag parity error */
+#define   MSSSR0_L2DAT	0x00020000	/* L2 data parity/ECC error */
+#define   MSSSR0_L3TAG	0x00010000	/* L3 tag parity error */
+#define   MSSSR0_L3DAT	0x00008000	/* L3 data parity error */
 #define SPRN_LDSTCR	0x3f8	/* Load/Store control register */
 #define SPRN_LDSTDB	0x3f4	/* */
 #define SPRN_LR		0x008	/* Link Register */
@@ -801,6 +805,7 @@
 #define   SRR1_PROGTRAP		0x00020000 /* Trap */
 #define   SRR1_PROGADDR		0x00010000 /* SRR0 contains subsequent addr */
 
+#define   SRR1_MCE_MSS		0x00100000 /* 745x memory subsystem error (MSSSR0) */
 #define   SRR1_MCE_MCP		0x00080000 /* Machine check signal caused interrupt */
 #define   SRR1_BOUNDARY		0x10000000 /* Prefixed instruction crosses 64-byte boundary */
 #define   SRR1_PREFIXED		0x20000000 /* Exception caused by prefixed instruction */
diff --git a/arch/powerpc/kernel/cpu_specs_book3s_32.h b/arch/powerpc/kernel/cpu_specs_book3s_32.h
index 3714634d194a..90ca26405c1d 100644
--- a/arch/powerpc/kernel/cpu_specs_book3s_32.h
+++ b/arch/powerpc/kernel/cpu_specs_book3s_32.h
@@ -426,7 +426,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7450 2.1 */
@@ -442,7 +442,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7450 2.3 and newer */
@@ -458,7 +458,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7455 rev 1.x */
@@ -474,7 +474,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7455 rev 2.0 */
@@ -490,7 +490,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7455 others */
@@ -506,7 +506,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.0 */
@@ -522,7 +522,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.1 */
@@ -538,7 +538,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447/7457 Rev 1.2 and later */
@@ -554,7 +554,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7447A */
@@ -570,7 +570,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* 7448 */
@@ -586,7 +586,7 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_G4,
 		.cpu_setup		= __setup_cpu_745x,
-		.machine_check		= machine_check_generic,
+		.machine_check		= machine_check_745x,
 		.platform		= "ppc7450",
 	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 3a8f5416e3f6..4fb1610baa51 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -788,6 +788,34 @@ int machine_check_generic(struct pt_regs *regs)
 	}
 	return 0;
 }
+
+#ifdef CONFIG_PPC_BOOK3S_32
+#define MSSSR0_CACHE_ERR	(MSSSR0_L2TAG | MSSSR0_L2DAT | MSSSR0_L3TAG | MSSSR0_L3DAT)
+
+/*
+ * On the 745x, SRR1[MSS] means the memory subsystem detected an error, and
+ * MSSSR0 says which.  The MSSSR0 bits are sticky, so clear them.
+ */
+int machine_check_745x(struct pt_regs *regs)
+{
+	unsigned long reason = regs->msr;
+	unsigned long msssr0 = mfspr(SPRN_MSSSR0);
+
+	if (!(reason & SRR1_MCE_MSS) || !(msssr0 & MSSSR0_CACHE_ERR))
+		return machine_check_generic(regs);
+
+	mtspr(SPRN_MSSSR0, msssr0 & ~MSSSR0_CACHE_ERR);
+
+	pr_err("Machine check in kernel mode.\n");
+	pr_err("Caused by (from SRR1=%lx, MSSSR0=%lx):%s%s%s%s\n",
+	       reason, msssr0,
+	       msssr0 & MSSSR0_L2TAG ? " [L2 tag parity]" : "",
+	       msssr0 & MSSSR0_L2DAT ? " [L2 data parity/ECC]" : "",
+	       msssr0 & MSSSR0_L3TAG ? " [L3 tag parity]" : "",
+	       msssr0 & MSSSR0_L3DAT ? " [L3 data parity]" : "");
+	return 0;
+}
+#endif
 #endif /* everything else */
 
 void die_mce(const char *str, struct pt_regs *regs, long err)

-- 
2.56.1


