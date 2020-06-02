Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45909C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:38:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CFB206C3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2vC+Z5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CFB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bgnG4fZbzDqby
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:38:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bgY43lb0zDqLY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 15:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=U2vC+Z5w; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 49bgY31yFyz8tRw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 15:27:51 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 49bgY270Byz9sSy; Tue,  2 Jun 2020 15:27:50 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::344;
 helo=mail-wm1-x344.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=U2vC+Z5w; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 49bgY25Tqsz9sSn
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2020 15:27:50 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id l26so1582701wme.3
 for <linuxppc-dev@ozlabs.org>; Mon, 01 Jun 2020 22:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VvZkYrE/ElD8+bLPqa0flL0yq6OinHZAHyvZH+R7fXo=;
 b=U2vC+Z5w9Dg5miJQ+cwMHr47yPjI5Z5S63UHzPgk0KgIycWdGMFbm2cFXiN0b/cvBT
 upj4run3EdUnFFHyYTwy++0wfXEFAq6KhFquk0Yl81F0MugryrKqKa9KhD9m1yf9BGWi
 lOSs9rrp0nS0GuNMlhUmsxDtmjoQMzQFhZfVpth6yQZc4LaNXHpsof+UagHSyjufrLYJ
 S+67awGwmS6lxamZkrEAjpES1dvvwBPiVTtVMLwlJomvUjV8ZkZiww4dlDAwigHdBnFS
 cmp/tYklBdCs91YMISiFnm5sg/KOyMivuwbJOqptdG5VYJK2WJxDR0dBq7Tu5nkTTppr
 AtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VvZkYrE/ElD8+bLPqa0flL0yq6OinHZAHyvZH+R7fXo=;
 b=ekd1aIbMzn+fQGM8VlfYZtTOYA6A345HUpX8DyUnuZK4GsvbulEQuewvYkwhDFOj1q
 HSv+JSC0TSi+UxRYZTPMx8g/lieGVcrNSjAYqHhYb1W2ZlkaEp8LUiwoy9Kgn+p8HQhn
 ZQ9UvLrVboRE8n4nXA2URQfO/g+IffJz8Sp8Cm9tX6EuP/NfyEt5XqFi/DapqKlkNLK8
 Feff2WY492roZmjeSfahtEdhKfsmI4qcOxIXtPIBo+UdNzksu6r8a+4YBaA3/DBDqoRU
 TkiZ4tswgI0uW/ryAKze2IKCtTqsEKbI1qPq18Zh38NsC6AmvBrCFJrPjT3aRU0UYsht
 i4Pw==
X-Gm-Message-State: AOAM532DkRHdT+MgDCv6jh/VzTKjiVLatTk8jyGQPCAEWPQgPQJ+/DMb
 HFCAgwPusUE3VQVOgsee9G4DLQLm
X-Google-Smtp-Source: ABdhPJxIgaAyfRrECNEy7BrJ9dai6lBFekiJGpQ7Gyvt/wbuBCbATFp5zyBLylcNReaGV5WnYWYBNw==
X-Received: by 2002:a1c:bc42:: with SMTP id m63mr2420084wmf.11.1591075667793; 
 Mon, 01 Jun 2020 22:27:47 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id a124sm1831336wmh.4.2020.06.01.22.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 22:27:47 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] powerpc: Handle prefixed instructions in
 show_instructions()
Date: Tue,  2 Jun 2020 15:27:28 +1000
Message-Id: <20200602052728.18227-4-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602052728.18227-1-jniethe5@gmail.com>
References: <20200602052728.18227-1-jniethe5@gmail.com>
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
Cc: Jordan Niethe <jniethe5@gmail.com>, alistair@popple.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently show_instructions() treats prefixed instructions as two
separate word instructions. '<' and '>' are placed around the
instruction at the NIP, but as a result they only wrap around the
prefix. Make '<' and '>' straddle the whole prefixed instruction.

Currently showing a prefixed instruction looks like:

Instruction dump:
60000000 60000000 60000000 60000000 60000000 60000000 60000000 60000000
60000000 60000000 60000000 60000000 <04000000> 00000000 60000000 60000000

Make it look like:
Instruction dump:
0x60000000 0x60000000 0x60000000 0x60000000 0x60000000 0x60000000 0x60000000 0x60000000
0x60000000 0x60000000 0x60000000 0x60000000 <0x04000000 0x00000000> 0x60000000 0x60000000 0x60000000

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/kernel/process.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b3f73e398d00..bcd7277a9395 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1258,7 +1258,7 @@ static void show_instructions(struct pt_regs *regs)
 	printk("Instruction dump:");
 
 	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
-		int instr;
+		struct ppc_inst instr;
 
 		if (!(i % 8))
 			pr_cont("\n");
@@ -1272,16 +1272,17 @@ static void show_instructions(struct pt_regs *regs)
 #endif
 
 		if (!__kernel_text_address(pc) ||
-		    probe_kernel_address((const void *)pc, instr)) {
+		    probe_kernel_read_inst(&instr, (struct ppc_inst *)pc)) {
+			instr = ppc_inst(PPC_INST_NOP);
 			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-				pr_cont("<%08x> ", instr);
+				pr_cont("<%s> ", ppc_inst_as_str(instr));
 			else
-				pr_cont("%08x ", instr);
+				pr_cont("%s ", ppc_inst_as_str(instr));
 		}
 
-		pc += sizeof(int);
+		pc += ppc_inst_len(instr);
 	}
 
 	pr_cont("\n");
-- 
2.17.1

