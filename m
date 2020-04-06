Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D14C2BA18
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 08:25:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D385820672
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 08:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msXrOgUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D385820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wkBB3hPGzDr45
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=msXrOgUh; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wjrv3q8wzDqtN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 18:10:23 +1000 (AEST)
Received: by mail-pj1-x1042.google.com with SMTP id m15so6125391pje.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EMy+RJTIvJPN81adG7t5m7zmtGlbp8slYvwlBwci/7E=;
 b=msXrOgUhZrSf6DfCozCA+M1dlgwqPBEc0l1IYMIsf5gUoxBrznezxSOvx6a3WU6F1C
 I7+n7sngArVCs6p7SKK6ddWXTQNY2tsdz2xTauzszJHOOjlWuIzhq1SG3iZ79IeNRhNw
 0arPxFAHPiFd3oUueVzH/Ke3OW9i867JgLqlp6MfuiBoHdYkqawWHZQJhCXzzH8wBzVm
 qw/OGU/FqSyLHqxmVjNS9NVr6StT49xCV0C6M7hlRFfIweloBTfKJDsHzsb0T+FGV+5j
 MctpaTnMnyw3hutXKKgFQSf3CrkOGr/M8y1lwp3+/npogqvhDNXCZ4snS0B0lGwDvGna
 Jycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EMy+RJTIvJPN81adG7t5m7zmtGlbp8slYvwlBwci/7E=;
 b=SY0gwOTbfONa+zMsWSTOf/zUivJpDMK4nvg4ZGpZIQxwW7qlueodoir9Xph9g3yOQa
 r9WcGcfayTufh+oraBQa/YGDUfWT06E3fTTMCAZAR6I9t8JjcmUREexHpZKUx+mo8tMY
 GheY2GANs+IiUO2ZBgBI8XGd3kuJjMOGWcS7oCxh6kt3J+KmU7QyUOqob0N8j3khlnD1
 g2nLcGGmDBRmrmtQWLfctrZmyk3a46A7iS+JngzkahvX7NGvW9nopdCqjv58y0/slwU+
 8n/TxT4uKULuJVA6qWtex+SyXg+D6iOHcXol67LCxcIdRkgvMI8EfqAiYcmgWfP7006s
 OLAA==
X-Gm-Message-State: AGi0PuaacnlNvFVjLzlvmyrVPWdbGpEphdsWJ+z5cgXICVIp4Gjei4ZN
 msNtcZ7eDMrT2lttQsp4wcP8gExeBmg=
X-Google-Smtp-Source: APiQypKHzNc3UMzl0KcL3lOB+fgAbWrUeFnHI0i1Znj/jed8d3x5xgeReUBdpBrZcmbGft1sivowEg==
X-Received: by 2002:a17:90a:e7c5:: with SMTP id
 kb5mr15998554pjb.187.1586160619851; 
 Mon, 06 Apr 2020 01:10:19 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id m2sm11460406pjk.4.2020.04.06.01.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 01:10:19 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 07/21] powerpc: Use a function for byte swapping
 instructions
Date: Mon,  6 Apr 2020 18:09:22 +1000
Message-Id: <20200406080936.7180-8-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406080936.7180-1-jniethe5@gmail.com>
References: <20200406080936.7180-1-jniethe5@gmail.com>
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

Use a function for byte swapping instructions in preparation of a more
complicated instruction type.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/include/asm/inst.h | 5 +++++
 arch/powerpc/kernel/align.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 15f570bef936..78eb1481f1f6 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -18,4 +18,9 @@ static inline int ppc_inst_opcode(u32 x)
 	return x >> 26;
 }
 
+static inline u32 ppc_inst_swab(u32 x)
+{
+	return ppc_inst(swab32(ppc_inst_val(x)));
+}
+
 #endif /* _ASM_INST_H */
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index a83d32c6513d..46870cf6a6dc 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -310,7 +310,7 @@ int fix_alignment(struct pt_regs *regs)
 		/* We don't handle PPC little-endian any more... */
 		if (cpu_has_feature(CPU_FTR_PPC_LE))
 			return -EIO;
-		instr = swab32(instr);
+		instr = ppc_inst_swab(instr);
 	}
 
 #ifdef CONFIG_SPE
-- 
2.17.1

