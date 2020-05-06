Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227BFC4725F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:17:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EBA206D5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEj1rdID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EBA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H3G15SJ8zDqf5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 14:17:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LEj1rdID; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H2b71gnGzDqTF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 13:46:58 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id t11so510845pgg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2020 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4FVca1M8aaYnG5CZFXD6rsEwXd+GPeG9BqpUrjG5r6M=;
 b=LEj1rdIDcYyTVVp0Hn7G4vVCp9b9NOWo3SbohAmUnScCst34lqOgn6y6t0ho3JsDtY
 Y6+83+KO/eVt5l61ifgzKKd+axZoTRQwExW6F3F0wVuY9AmssUv1gGrqPa2d20mxW1B/
 Q70oxBeybs/tQeHXKwNsLf2isOw96PbvUSxj819ncmPD4ORSOmxCL91OQVY1rV4yMA4D
 sRHj5KzCzG8zJgVlnQtPQgB0mGBok6kUctvcLNCXKhsnaXtIccIW3SFboTdRYHYFqtdM
 J5hYH8mr+6bSJTHrpfPTF9JmQRwTjCldXnrhG+cHFdCwnWuuGrHT0gjqls90l/Z0xw2f
 h3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4FVca1M8aaYnG5CZFXD6rsEwXd+GPeG9BqpUrjG5r6M=;
 b=a1S7BL7Ei6YCVSsQHgBQ+2LFdrBBSfmQPociuRY176PmSMKAJb3Uzyq9OFBRUmQ3B8
 /deQ38nvSGQCeJ+xBSzpqeUh7RAyRpxscsTQs8W5MW//3niiY8CX6IrrGlPgIFx1pgOq
 4kjqvBYAByfF4OVxGasQDFzba9OddiRTB6wMuZiaQHmSKBF7OGHRISGZPCFhsiFJqf6t
 RtTucUzQ7/6smoVEI/qbOrmPJ5zVQySUoMRaDsJSUUUYz6F3/vQxYylM5CQJz9mfaSX8
 lVyLSgW6pGsW23pra+84YuOJnZ5xxTVZPCFtasUGQGJjWd9FtIMiFmcgC4f4pymWcZfh
 V5kg==
X-Gm-Message-State: AGi0PuZyaEFgelI/D9KyRq/zrrnULgV0+f0aWSLre17ErtHPiZeWJkv4
 9w9852uMdBbl4Wn7GUQY063ZsfN1YXix/A==
X-Google-Smtp-Source: APiQypKtvJP8DziZrDI9nEMbH7C3+TJDp2GAWImWVPUahkmLhDcbfPdGa4G+2PmlnQN7aidW8aN9KA==
X-Received: by 2002:a62:780b:: with SMTP id t11mr6178700pfc.196.1588736813948; 
 Tue, 05 May 2020 20:46:53 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id k4sm465676pgg.88.2020.05.05.20.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 20:46:53 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 18/30] powerpc/xmon: Use a function for reading instructions
Date: Wed,  6 May 2020 13:40:38 +1000
Message-Id: <20200506034050.24806-19-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506034050.24806-1-jniethe5@gmail.com>
References: <20200506034050.24806-1-jniethe5@gmail.com>
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
 naveen.n.rao@linux.vnet.ibm.com, Jordan Niethe <jniethe5@gmail.com>,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently in xmon, mread() is used for reading instructions. In
preparation for prefixed instructions, create and use a new function,
mread_instr(), especially for reading instructions.

Reviewed-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v5: New to series, seperated from "Add prefixed instructions to
    instruction data type"
v6: mread_instr(): correctly return error status
v8: style
---
 arch/powerpc/xmon/xmon.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 68e0b05d9226..7a9cbc6d9b21 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -122,6 +122,7 @@ static unsigned bpinstr = 0x7fe00008;	/* trap */
 static int cmds(struct pt_regs *);
 static int mread(unsigned long, void *, int);
 static int mwrite(unsigned long, void *, int);
+static int mread_instr(unsigned long, struct ppc_inst *);
 static int handle_fault(struct pt_regs *);
 static void byterev(unsigned char *, int);
 static void memex(void);
@@ -896,7 +897,7 @@ static void insert_bpts(void)
 	for (i = 0; i < NBPTS; ++i, ++bp) {
 		if ((bp->enabled & (BP_TRAP|BP_CIABR)) == 0)
 			continue;
-		if (mread(bp->address, &instr, 4) != 4) {
+		if (!mread_instr(bp->address, &instr)) {
 			printf("Couldn't read instruction at %lx, "
 			       "disabling breakpoint there\n", bp->address);
 			bp->enabled = 0;
@@ -946,7 +947,7 @@ static void remove_bpts(void)
 	for (i = 0; i < NBPTS; ++i, ++bp) {
 		if ((bp->enabled & (BP_TRAP|BP_CIABR)) != BP_TRAP)
 			continue;
-		if (mread(bp->address, &instr, 4) == 4
+		if (mread_instr(bp->address, &instr)
 		    && ppc_inst_equal(instr, ppc_inst(bpinstr))
 		    && patch_instruction(
 			(struct ppc_inst *)bp->address, ppc_inst_read(bp->instr)) != 0)
@@ -1162,7 +1163,7 @@ static int do_step(struct pt_regs *regs)
 	force_enable_xmon();
 	/* check we are in 64-bit kernel mode, translation enabled */
 	if ((regs->msr & (MSR_64BIT|MSR_PR|MSR_IR)) == (MSR_64BIT|MSR_IR)) {
-		if (mread(regs->nip, &instr, 4) == 4) {
+		if (mread_instr(regs->nip, &instr)) {
 			stepped = emulate_step(regs, instr);
 			if (stepped < 0) {
 				printf("Couldn't single-step %s instruction\n",
@@ -1329,7 +1330,7 @@ static long check_bp_loc(unsigned long addr)
 		printf("Breakpoints may only be placed at kernel addresses\n");
 		return 0;
 	}
-	if (!mread(addr, &instr, sizeof(instr))) {
+	if (!mread_instr(addr, &instr)) {
 		printf("Can't read instruction at address %lx\n", addr);
 		return 0;
 	}
@@ -2122,6 +2123,25 @@ mwrite(unsigned long adrs, void *buf, int size)
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

