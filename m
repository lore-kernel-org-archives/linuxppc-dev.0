Return-Path: <SRS0=Qvps=ZS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AA5C432C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Nov 2019 05:24:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF0620637
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Nov 2019 05:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+6aTw0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF0620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47MXQK4ldwzDqc3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Nov 2019 16:24:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+6aTw0a"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47MXN95nv6zDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2019 16:22:33 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so3395828plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2019 21:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7ISG4mLSmSSVy+VO7Y6xAojx6lHfG66ZOcv81yzph2o=;
 b=Q+6aTw0aO2S3f4y/NH6RUi4oJ/2oit1DbtZUWwkEC7MhcOvrgYE86EnwqdvKVvSmXv
 3vOdm7rtylhV+uGJiW5fMLH0U+hz9R1Er2CKu3eE3s3+fvm9Gqly8XQOJNvI0XgaCnte
 pw1/3ug/cJWwkvatysXtOilA3I7DvjmIL1NCUkO4q5q7SAiXnXxxBbo7I2s6NTK5lsD5
 yxnvs6TFw6XRVOeArw3+YPrHTxbi7LxoWliBLnpWyKigwJ52EHXfvMfjKzJRsBpJ6BVE
 RkR4tmfDMBofv3bnqPUR2Y1wFybDnHZyfn63K2+Yw/hJkFMp6C4ry/KmoJ9EjDe1zhtM
 Ac4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ISG4mLSmSSVy+VO7Y6xAojx6lHfG66ZOcv81yzph2o=;
 b=bsQC/LoIoWSXaRCunCPMBMXXzSZu48rIkg578XO//atkNBChsMMeJkhLT1UoRE30TH
 Sl4xm6OMQHQV/oUv8Le23jgfJLycrl0QOj2ERD8fqFiHqqlpY+CSUZ5MrZUUopXctFr3
 Xbi+cnGJlkDswp7/6qauDnhnFnLAJXH9u3PLPG8Mqbgq0sLg9xgchGQG/yWYb8ZGEGg7
 tIPLsexA5S8FstaEEjba089bk2868Z/wOt2v0nfCNRev/yovk/A6eMTMybvb7zaKstmJ
 G/3V6PNbZrtRKgr8fExCm2ltxisFSDXQ4INUwmR1yykwKV8nBWvrrB/Vh3idsbR7xVGG
 XjmA==
X-Gm-Message-State: APjAAAUK2q/YDtYKQylO2yixFg0zN1PRoNmov3E6EvjdgYrK1HTUHJnQ
 lAckp8VhEJn2NgdJ5v8Ql9GJlvHp
X-Google-Smtp-Source: APXvYqxeIhTnJSw+peRGoR1e7uQ82PA2TNwV9Dn3pHs1qGujgNITFbI98luASesryHQ2AL0GDGrV2g==
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr763056plj.3.1574745750839; 
 Mon, 25 Nov 2019 21:22:30 -0800 (PST)
Received: from sol.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id t27sm10657920pfq.169.2019.11.25.21.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 21:22:30 -0800 (PST)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/18] powerpc: Add BOUNDARY SRR1 bit for future ISA version
Date: Tue, 26 Nov 2019 16:21:25 +1100
Message-Id: <20191126052141.28009-3-jniethe5@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126052141.28009-1-jniethe5@gmail.com>
References: <20191126052141.28009-1-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: alistair@popple.id.au, Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the bit definition for when the cause of an alignment exception is a
prefixed instruction that crosses a 64-byte boundary.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 521ecbe35507..6f9fcc3d4c82 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -777,6 +777,7 @@
 #define   SRR1_PROGADDR		0x00010000 /* SRR0 contains subsequent addr */
 
 #define   SRR1_MCE_MCP		0x00080000 /* Machine check signal caused interrupt */
+#define   SRR1_BOUNDARY		0x10000000 /* Prefixed instruction crosses 64-byte boundary */
 
 #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
 #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
-- 
2.20.1

