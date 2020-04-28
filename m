Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811CEC83002
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 02:37:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C81D206E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 02:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncs7F9rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C81D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49B5Qy4fX6zDqpL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 12:37:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Ncs7F9rc; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B4cj711jzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 12:01:09 +1000 (AEST)
Received: by mail-pj1-x1042.google.com with SMTP id a31so437609pje.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2020 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n3kt4uhdwj+VggJPuiouyttfPZqI1r+JKBP+C+/n/4I=;
 b=Ncs7F9rc49n6YkfdVLVlj3xWrahdgZeYdKfLEwE1TlTbX0+vGug60q+s4F8vSmZB7K
 xyKFvI95SqisgrMi1JXG+vugnk5c6WovkqCaMacVU+w0aiaG8Nr9T5gtjWJ9a2BCUD51
 oyKSAlfQZQOvvky/yM+9xn4PSshc1PtVdE/el2P894q9N0FG35QN1r+/u0iOEDqDIOgU
 51BvrAq7kqGq0adDYv8TQeUTXnEvelg0gVg6u8eIVjhFshrCVVb3uuC9H3c92HHyUkgd
 RDt2V3J7masHMIP63oiiWpgqvrbQFQKoQ2E6mvSBqVMilM02xNga2XAKFpQ4BUfMsplT
 M9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n3kt4uhdwj+VggJPuiouyttfPZqI1r+JKBP+C+/n/4I=;
 b=Ot4D+oxJovPM0AyQhHB1SfNVMCly5smzRrW9vnAUeGcV2ms7mzB7/b9kYIsa63BoRD
 tvd4ANo3DIyHr37qg4xThuuBqcAixmTjwj6v0cf93HqwY/mUY9TDDLbvKbfSuMF1znFf
 xtQjmTTUocOQ6455S3lNrIFnKdkbPCttfLDlt80O4iqri03QstoBvULXp4+5Yw4ndGwm
 HdKVsjMnoIR6BMp1U69Xtczb4kngGJJOWxZZdfZGb2DQYmTRSQ6L1FEYK/OhH7QubGFh
 RHpDq8/8+SJUKv0aCWU25yWwiEjIsXwIkC5ez57SBWAUbwUg52HRU1vf+SM6sR4nC1Lc
 r+QQ==
X-Gm-Message-State: AGi0PubJLMu8sTDTWNSgCEg8Mnuf1YC1regsUjH3e3MWYg4rfcReRbaZ
 lr/rSgUsWmHKMmf4QOJwVuqcqi/LUOA=
X-Google-Smtp-Source: APiQypLGpTWRWauGDkkHL1RTZw+Opy9JCEn3liFldHJX49hfyJ44rF2yArT0z9MHw1LOUkdO4VTDPA==
X-Received: by 2002:a17:902:50d:: with SMTP id
 13mr25785715plf.170.1588039267734; 
 Mon, 27 Apr 2020 19:01:07 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id o68sm13666642pfb.206.2020.04.27.19.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:01:07 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 18/28] powerpc/xmon: Use a function for reading instructions
Date: Tue, 28 Apr 2020 11:58:04 +1000
Message-Id: <20200428015814.15380-19-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428015814.15380-1-jniethe5@gmail.com>
References: <20200428015814.15380-1-jniethe5@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently in xmon, mread() is used for reading instructions. In
preparation for prefixed instructions, create and use a new function,
mread_instr(), especially for reading instructions.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v5: New to series, seperated from "Add prefixed instructions to
    instruction data type"
v6: mread_instr(): correctly return error status
---
 arch/powerpc/xmon/xmon.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 65abae7a0103..716967f12063 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -121,6 +121,7 @@ static unsigned bpinstr = 0x7fe00008;	/* trap */
 static int cmds(struct pt_regs *);
 static int mread(unsigned long, void *, int);
 static int mwrite(unsigned long, void *, int);
+static int mread_instr(unsigned long, struct ppc_inst *);
 static int handle_fault(struct pt_regs *);
 static void byterev(unsigned char *, int);
 static void memex(void);
@@ -895,7 +896,7 @@ static void insert_bpts(void)
 	for (i = 0; i < NBPTS; ++i, ++bp) {
 		if ((bp->enabled & (BP_TRAP|BP_CIABR)) == 0)
 			continue;
-		if (mread(bp->address, &instr, 4) != 4) {
+		if (!mread_instr(bp->address, &instr)) {
 			printf("Couldn't read instruction at %lx, "
 			       "disabling breakpoint there\n", bp->address);
 			bp->enabled = 0;
@@ -945,7 +946,7 @@ static void remove_bpts(void)
 	for (i = 0; i < NBPTS; ++i, ++bp) {
 		if ((bp->enabled & (BP_TRAP|BP_CIABR)) != BP_TRAP)
 			continue;
-		if (mread(bp->address, &instr, 4) == 4
+		if (mread_instr(bp->address, &instr)
 		    && ppc_inst_equal(instr, ppc_inst(bpinstr))
 		    && patch_instruction(
 			(struct ppc_inst *)bp->address, ppc_inst_read(bp->instr)) != 0)
@@ -1161,7 +1162,7 @@ static int do_step(struct pt_regs *regs)
 	force_enable_xmon();
 	/* check we are in 64-bit kernel mode, translation enabled */
 	if ((regs->msr & (MSR_64BIT|MSR_PR|MSR_IR)) == (MSR_64BIT|MSR_IR)) {
-		if (mread(regs->nip, &instr, 4) == 4) {
+		if (mread_instr(regs->nip, &instr)) {
 			stepped = emulate_step(regs, instr);
 			if (stepped < 0) {
 				printf("Couldn't single-step %s instruction\n",
@@ -1328,7 +1329,7 @@ static long check_bp_loc(unsigned long addr)
 		printf("Breakpoints may only be placed at kernel addresses\n");
 		return 0;
 	}
-	if (!mread(addr, &instr, sizeof(instr))) {
+	if (!mread_instr(addr, &instr)) {
 		printf("Can't read instruction at address %lx\n", addr);
 		return 0;
 	}
@@ -2121,6 +2122,25 @@ mwrite(unsigned long adrs, void *buf, int size)
 	return n;
 }
 
+static int
+mread_instr(unsigned long adrs, struct ppc_inst *instr)
+{
+	volatile int n;
+
+	n = 0;
+	if (setjmp(bus_error_jmp) == 0) {
+		catch_memory_errors = 1;
+		sync();
+		*instr = ppc_inst_read((struct ppc_inst *)adrs);
+		sync();
+		/* wait a little while to see if we get a machine check */
+		__delay(200);
+		n = ppc_inst_len(*instr);
+	}
+	catch_memory_errors = 0;
+	return n;
+}
+
 static int fault_type;
 static int fault_except;
 static char *fault_chars[] = { "--", "**", "##" };
-- 
2.17.1

