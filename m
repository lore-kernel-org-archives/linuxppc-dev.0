Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3EC4725B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:33:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7805206D5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 04:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LodVkAyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7805206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H3d548xZzDsFc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 14:33:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LodVkAyh; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H2dd4kR7zDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 13:49:09 +1000 (AEST)
Received: by mail-pj1-x1043.google.com with SMTP id t40so213439pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2020 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BWBFARQnHPSfB1o3vQSMUY+XpzGeZixhVVIQQb0+p/U=;
 b=LodVkAyhWvD54tXhRbz6fDvlRtsj43IBaJoA5GvMrrgaz6FGshSaDKauKNIIvyj+By
 ej2A5T5d1J1stOTBqXj96RYXQi3Yr5G646KiL6NZAAJM8H0kk1sLA0BrKu8yYJXy7nz5
 aelPtm0KiYh1yFWwkDCHbvNNQ1hHZbV1hPQJ72arC+i1DJTof1FgKMiMw9KJI/iNBjF1
 KJdJTYwXy+Xg1mssabxjEVK8uci7zDypF/GGWImq3kcGg/HduhDkNleWgX/R6qTA+dbc
 3ywfG7sfvzYSttf1zUzoxmF3x/eVIi4t/RCReq2KZZXDR+96udrJR9VcD5gF9P0GxZ29
 HL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BWBFARQnHPSfB1o3vQSMUY+XpzGeZixhVVIQQb0+p/U=;
 b=bKnTN9xryPw58clPSMJDM6YUmXjp29W5tbQhlHqLbfOojMjYJMRUXMDtUbED3YW6qQ
 2BuUx5SYML2BZQLIkg0IJaz7ADMtB2xwXAoRJ4sgaW5RG0hvVJ289Wda/JdiKtwC/RDH
 uesHr7hdZp2kgZKQKxjWoYOwocXMV7EpkqD9aAfZjD6cnkNQPNWJJgjkzRZpXq0BbV5G
 zU/h9w4nhweGE22++HUtK4X8BSp2pPWrHE7XdIJQcGO1DkO9/+yOhtDoukYaSJ7hAyOb
 XEeSKvWus2XexCTjuIzS9Oxn22wZ4R65qdhlGxVXjENXZ4GahMRmFy/5mY5zJULAHUTu
 qwXA==
X-Gm-Message-State: AGi0PubwiZIJDeXYVzGslbFqXlh6vHyaItEZVC3hJk/6D/TNdaZFngd8
 Fc5RAMpC5jW/T1pW8wNfb1o/wHOqzHdjpQ==
X-Google-Smtp-Source: APiQypL1TWTeNQwAj8V+wKnd/1Kh0aM9/9Oj6p0r8Tooz2vISJmZwI4tlIvTlVUU3SHn8vS13T0Gsg==
X-Received: by 2002:a17:902:9049:: with SMTP id w9mr613822plz.27.1588736947390; 
 Tue, 05 May 2020 20:49:07 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id k4sm465676pgg.88.2020.05.05.20.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 20:49:07 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 27/30] powerpc/kprobes: Don't allow breakpoints on suffixes
Date: Wed,  6 May 2020 13:40:47 +1000
Message-Id: <20200506034050.24806-28-jniethe5@gmail.com>
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

Do not allow inserting breakpoints on the suffix of a prefix instruction
in kprobes.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
v8: Add this back from v3
---
 arch/powerpc/kernel/kprobes.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 33d54b091c70..227510df8c55 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -106,7 +106,9 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
+	struct kprobe *prev;
 	struct ppc_inst insn = ppc_inst_read((struct ppc_inst *)p->addr);
+	struct ppc_inst prefix = ppc_inst_read((struct ppc_inst *)(p->addr - 1));
 
 	if ((unsigned long)p->addr & 0x03) {
 		printk("Attempt to register kprobe at an unaligned address\n");
@@ -114,6 +116,17 @@ int arch_prepare_kprobe(struct kprobe *p)
 	} else if (IS_MTMSRD(insn) || IS_RFID(insn) || IS_RFI(insn)) {
 		printk("Cannot register a kprobe on rfi/rfid or mtmsr[d]\n");
 		ret = -EINVAL;
+	} else if (ppc_inst_prefixed(prefix)) {
+		printk("Cannot register a kprobe on the second word of prefixed instruction\n");
+		ret = -EINVAL;
+	}
+	preempt_disable();
+	prev = get_kprobe(p->addr - 1);
+	preempt_enable_no_resched();
+	if (prev &&
+	    ppc_inst_prefixed(ppc_inst_read((struct ppc_inst *)prev->ainsn.insn))) {
+		printk("Cannot register a kprobe on the second word of prefixed instruction\n");
+		ret = -EINVAL;
 	}
 
 	/* insn must be on a special executable page on ppc64.  This is
-- 
2.17.1

