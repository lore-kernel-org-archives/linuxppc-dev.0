Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C0AC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:49:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71412087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLtFnYna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71412087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TNXP2DQlzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 07:49:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JLtFnYna"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TNVS48FFzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 07:47:28 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id o25so14079111wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ouBPg+ImuhkElC1A5gmZvHBCT5kkBeXVc/HxCuxh1Ho=;
 b=JLtFnYnaI5m9A1TbNOlBa+13UOpbcz14XGNsbBjl3Qxg9w5JhgYnsoPd3V3ccmYwEQ
 5PHOF4gN2MXrw60EgOl9aLW1XFAmhAe6ZrmwnlzNj+S7uKFFHUembq3taRAROiwgHyKX
 RG2/TN72+1BU661kPcW0K8N7kADddKmryAoCU9aL8/ZWIWE3/xPolLudUbEJEI7GXqFo
 nZqQo8OFzpjV5TGDe3mfkHwRDP16Nc+0K6+PvIm1FIe7jPl7Bm+eC4cIGv+8crO+GQt2
 GkIndCFYinHvHyjcw2RTBRlkMseMveC8nXtDWYIwZtm6HFn/p+reIhF7hNj938EcwA24
 CQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ouBPg+ImuhkElC1A5gmZvHBCT5kkBeXVc/HxCuxh1Ho=;
 b=AN4ktvVDoZT6nhnoQMToxvHvwzoOeGV77uGL+hSjKUgTM6vdmxlgg0z5xwTw9MTZt+
 foq+b88evfoj1teMPtGfyZoTFMMkTCnwDoj1qClejnmr3wR37byJB+63S3YC6+O75vAU
 CQJQIcXRko/hpeM/P8Fehk7Evd1f4ARgZg2RCG6uyKoR54zezvz0SA9GIlczpyhe1Vmq
 QfooQiCyvhFTqxEeFvAubeCOr3zQ9KDpqSgZCAbSuLambYQGfDoIVkp+s3FL+ZSSBezn
 9JacFSOValQfM2eNDZCxXWtsbUxuEl5/whfKGNaBVxKw9N2hM0nJZ069iLbzzBh05412
 wEZg==
X-Gm-Message-State: APjAAAU7K5Q/TszxQB+mDnBMP//Vqo17F2WcJaLdt59CHcSNjrFrDOm0
 kge7OWjZsika9bdnOAlbpgo=
X-Google-Smtp-Source: APXvYqzpGUcZhdQ2s6T/pGJASsG8ikg8UoWZcbHoPfm7Wf0mxIoCkypvVdFsZMtZCODSObZTyUtdIg==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr16549013wmj.120.1553633244165; 
 Tue, 26 Mar 2019 13:47:24 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
 by smtp.gmail.com with ESMTPSA id
 y66sm13837211wmd.37.2019.03.26.13.47.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 13:47:23 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 3C440114237E; Tue, 26 Mar 2019 21:47:22 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 2/2] Remove functions holly_power_off and holly_halt since
 unused
Date: Tue, 26 Mar 2019 21:47:19 +0100
Message-Id: <20190326204720.18882-2-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326204720.18882-1-malat@debian.org>
References: <20190312203140.31785-1-malat@debian.org>
 <20190326204720.18882-1-malat@debian.org>
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Silence the following warnings triggered using W=1:

  arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous prototype for 'holly_power_off' [-Werror=missing-prototypes]
  arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous prototype for 'holly_halt' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/holly.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 9d2eefef7b7b..829bf3697dc9 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -234,18 +234,6 @@ static void __noreturn holly_restart(char *cmd)
 	for (;;) ;
 }
 
-void holly_power_off(void)
-{
-	local_irq_disable();
-	/* No way to shut power off with software */
-	for (;;) ;
-}
-
-void holly_halt(void)
-{
-	holly_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
-- 
2.20.1

