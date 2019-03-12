Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A263EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:26:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FAC2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0qZl6Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FAC2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jp235twvzDqCT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:26:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="K0qZl6Gc"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jnyd1CtfzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 08:23:37 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id t5so3112829wri.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H8NQNQuMFw0L9D+ZrDs+DwimCDz1lv4WmSbItCZ7xMg=;
 b=K0qZl6GcON/ccCqoRM6CUnD8DbdhQoqNUIw0YKmiprWKSoBOWUM0Q5T17+Rmql/3u1
 QslFLP0bgLCV0q1Jwk4m48bf5nmmwZeCR3Tq4E86de/eLm3rVj+8DqG1S+dhq/eJcl8v
 kc82nm/emKS7nlQuotUd+dlvEJgczzsSQup7nta9kslm/3a/fjG5y2o10w1lvmIRtYk0
 IAkP3wMHumema8VNS1ofEwiLkF4pORMd7vRp9aptTxHQYm7TtIqFmbTOlv67JMJ+Ip1e
 2GSPBgUQyuoAsl7vVGlKYogQdQ3L/NXqtzzIDpkw07R/rFvJ/hMj1IyEM9jXRaOQjLDp
 90jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=H8NQNQuMFw0L9D+ZrDs+DwimCDz1lv4WmSbItCZ7xMg=;
 b=G4tdIhgWf8MpAGXoB4VmNrgYqql39nEo151b3xSS41Xkp/nIGXkXsbBjty9yyTv2ys
 Nfb9yWw9hhhUUF7QdW7kl6vRptujEPAqKc8ICk2FmvpLE5eYoHZEo/y37TmzFIhsu+cE
 iuPNWYV5FRrobCc9+ozpO3CwbrBABXrhDy5lMLiqrb6Q4L5QwirBuNHTIikfrvYqLQ9O
 2UYbS/ErOV/JM14ax4nVIy7fmuA9ltAx8RmKXkXtKeMybIpp1mHBnQ6vcR4u1ekMVmKJ
 DG5sdMoRdCLOkQqEDK6ZbEDiGuahVkjU8uaF20rhY0Tkfu19J6BkgbLG2vd9aG8kIus5
 zRTg==
X-Gm-Message-State: APjAAAV5tdMrSE4kwye4vDu88rHeaRyLOlHCVEYhlduw0n7aU3xOzqtg
 wG7hCkEtABzR+V8zMDBOES0=
X-Google-Smtp-Source: APXvYqy2q7BWmTPZ/MJm9OMn6kgmtzkUVQkYRYNe4ohbpQuaG8hQuRtYD0RARooO6+Uoi/5sHyKUoA==
X-Received: by 2002:a05:6000:14d:: with SMTP id
 r13mr6833755wrx.231.1552425807833; 
 Tue, 12 Mar 2019 14:23:27 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
 by smtp.gmail.com with ESMTPSA id
 i62sm2200238wmg.17.2019.03.12.14.23.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Mar 2019 14:23:27 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 3BBAD1146D74; Tue, 12 Mar 2019 22:23:21 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/32: sstep: Move variable `rc` within CONFIG_PPC64
 sentinels
Date: Tue, 12 Mar 2019 22:23:17 +0100
Message-Id: <20190312212318.17822-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312202008.29681-1-malat@debian.org>
References: <20190312202008.29681-1-malat@debian.org>
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
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix warnings treated as errors with W=1:

  arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: as suggested prefer CONFIG_PPC64 sentinel instead of unused keyword

 arch/powerpc/lib/sstep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3d33fb509ef4..9996dc7a0b46 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1169,7 +1169,10 @@ static nokprobe_inline int trap_compare(long v1, long v2)
 int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		  unsigned int instr)
 {
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb, rd, spr, u;
+#ifdef CONFIG_PPC64
+	unsigned int rc;
+#endif
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
@@ -1292,7 +1295,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (instr >> 21) & 0x1f;
 	ra = (instr >> 16) & 0x1f;
 	rb = (instr >> 11) & 0x1f;
+#ifdef CONFIG_PPC64
 	rc = (instr >> 6) & 0x1f;
+#endif
 
 	switch (opcode) {
 #ifdef __powerpc64__
-- 
2.20.1

