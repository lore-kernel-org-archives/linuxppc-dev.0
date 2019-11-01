Return-Path: <SRS0=PnYa=YZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2439FCA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 08:57:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A05204FD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 08:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCLqc/w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A05204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 474GL84wGkzF5Qr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Nov 2019 19:57:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rCLqc/w0"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474GHc0H80zF6bN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2019 19:55:39 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id e10so6063506pgd.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2019 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3+a+qBWAZsjwzvXaMRj6M3/WGWi2/Gc6GIleBXJ1TTc=;
 b=rCLqc/w0sHbUDuBnNQ/RX8czNCP2OOJn9HIh21yNDI0HQXZvqsudafEhFgCdQFzWMS
 NSGqma/ugQm4RjQ2n6fd4JNT3pyJqQH0YWLxXT3SOLXp5aj8PKbUiEIu/9Vt+NAhBTFz
 y+5feFpCsQAEjobeM24rEGQgM3wZE9hOGvmfnMWuPLNYYtYw40LHnYIgRNUHTQpUR7mg
 ESk6w9wO95r6TCGQ8mZI8lS53RJA1POxBgQtV6ASgL7Anp0krmXbZl/VbFJ7EvIwNdzF
 z+IL4Zdr6bLcWbkdWFHgdnOjIA9V9YWBKU41eZTMQ5AzrcVDtAJ857ReoYoD7yz1Yw1u
 4mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3+a+qBWAZsjwzvXaMRj6M3/WGWi2/Gc6GIleBXJ1TTc=;
 b=JDc9Ucl8ZYNu8q0HlMruR8HwaQ835MHaFTlv9+WiLPoIc+GeCGxeefjVj7sGIIWKXt
 68tVo0OyYqsntjWol2HSPEJvWQF8lWOXXS9wX2GdcnYUFrT1J1G0VlrMF8gIXzwtEwMA
 mBjrYCjSbFxYaE7ffBEneOBICqtQU4NMwoezqlHptAPlMnq9DmPNht42TP8G8zGrv6HM
 bIcZb5FhwcD4kmj90AljodTsyJt1+QUX3CDv0MUf2u7nFUoBJ8ir3GX8AVMMLBatBpBm
 gHbetPELQB75HtgnoV4iVcU4+FxVx2ftys0MBLrSQFZtK83De7WMSY67GSYBUJ7jhcDn
 TNww==
X-Gm-Message-State: APjAAAVzNSbcCoUNZOiw6h+ofTW5QWrip+DTYtjS3YI+vu2UfMDrQ2Z/
 pm35S2PeHUju0RqOrBpqWZyBbj9zeWs=
X-Google-Smtp-Source: APXvYqzS6WmQHZDKeuG9WO6s1ktScQj+4xUJ/oKQghwisunajB6N8eEKiHgiBgenj77fHS+XzqrXwQ==
X-Received: by 2002:a17:90a:ba89:: with SMTP id
 t9mr3945639pjr.29.1572598535470; 
 Fri, 01 Nov 2019 01:55:35 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id q15sm5596078pff.155.2019.11.01.01.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:55:34 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/xmon: Allow passing an argument to
 ppc_md.restart()
Date: Fri,  1 Nov 2019 19:55:21 +1100
Message-Id: <20191101085522.3055-1-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On PowerNV a few different kinds of reboot are supported. We'd like to be
able to exercise these from xmon so allow 'zr' to take an argument, and
pass that to the ppc_md.restart() function.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d83364e..6a6f675 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1147,16 +1147,19 @@ static int do_step(struct pt_regs *regs)
 
 static void bootcmds(void)
 {
+	char tmp[64];
 	int cmd;
 
 	cmd = inchar();
-	if (cmd == 'r')
-		ppc_md.restart(NULL);
-	else if (cmd == 'h')
+	if (cmd == 'r') {
+		getstring(tmp, 64);
+		ppc_md.restart(tmp);
+	} else if (cmd == 'h') {
 		ppc_md.halt();
-	else if (cmd == 'p')
+	} else if (cmd == 'p') {
 		if (pm_power_off)
 			pm_power_off();
+	}
 }
 
 static int cpu_cmd(void)
-- 
2.9.5

