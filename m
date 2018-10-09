Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF0C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:57:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5FB20C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhCeto5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5FB20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tmhf2yR4zF3Nb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qhCeto5G";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qhCeto5G"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tmf70b3CzF3DG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 16:54:54 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id i4-v6so245099pgq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 22:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=7O2LsVWyoBpCdlGR06mw0gBTtPpY0TZyV1YjI0/huSQ=;
 b=qhCeto5Gg/f3Q1FCkGMVAHSvYNMPK/o65eVcNQmKSlGqvR0jwivZd4v3bMQFq504RW
 GrABOZcQnoDKM8+l7yct9XQguEholEf2Mm7b4l+MpHxe/QGtjns+8YDe3Cnc3fRpvFrW
 y0xIRn56fvW4YX3Ta6UcXpQ/VLLvJYmVqowoQosT0KXVBTXoSGSnlq+XoP4sqDzk67YN
 FGB/V0S9lXAE8p7jJGwBOyOZ8ctvfherSGcKsiNL+8PhE1oWaT0+ou6f5HQQ8QK1DCps
 DxDM6Mwbhkd+r+HI48FSBEuw59jZ97dlIiHxvXEzlOoJatS0aWwV8jC2gHyuEzxuljm9
 6IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=7O2LsVWyoBpCdlGR06mw0gBTtPpY0TZyV1YjI0/huSQ=;
 b=j+b/XAHGpCVCeW0vec/GwagaUCPJQ2M51nlAKuKqjS/lPeIOs3/aMCnwr3gtivJshR
 5X4kF+ixHRmw7wAVfDPrbHjfZeH7l4GEF2gs/x3j1uBiNMQsACLJkGLs8Ui1xf8GvMlz
 Ddx/AywMAqzzdntJTjkZvm5o/kngLrMhWqiPpkcWYntiu8AmiVBxYvbln/zv3pP6V/xM
 iwnU9NlNsUGYhnxBjg6+nuF7sA1LDgt7qR9A592GK430nENx+Z6tQXBHWWiVrGh6o2QQ
 14OegeXMIxw4CbzMVuT9RR6LXMUpfjUHGT6W0pZ2sjhWQB0f8vRiR63JGKgYrdkAsPp9
 dX1A==
X-Gm-Message-State: ABuFfogj/lsBX+m0wCc86jqAhjv6lW1+uY6FQGAiiAj5/XSDeg1pJ2JL
 KC2FzjGbsrpAv6SR6TGGIuo=
X-Google-Smtp-Source: ACcGV618brXvxtBfCAqzZbsYEoVpL3A/Y+6xNU6cw1CkSiaKJu5PjF4YuJSvzRtX8JPEAQXwXqH7nw==
X-Received: by 2002:a62:1906:: with SMTP id 6-v6mr29166708pfz.9.1539064491809; 
 Mon, 08 Oct 2018 22:54:51 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id m27-v6sm27660699pff.187.2018.10.08.22.54.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Oct 2018 22:54:50 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 09 Oct 2018 16:24:44 +1030
From: Joel Stanley <joel@jms.id.au>
To: Paul Mackerras <paulus@samba.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Quiet PMU registration message
Date: Tue,  9 Oct 2018 16:24:44 +1030
Message-Id: <20181009055444.20317-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On a Power9 box we get a few screens full of these on boot. Drop
them to pr_debug.

[    5.993645] nest_centaur6_imc performance monitor hardware support registered
[    5.993728] nest_centaur7_imc performance monitor hardware support registered
[    5.996510] core_imc performance monitor hardware support registered
[    5.996569] nest_mba0_imc performance monitor hardware support registered
[    5.996631] nest_mba1_imc performance monitor hardware support registered
[    5.996685] nest_mba2_imc performance monitor hardware support registered

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/perf/core-book3s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 81f8a0c838ae..a01c521694e8 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2249,8 +2249,8 @@ int register_power_pmu(struct power_pmu *pmu)
 		return -EBUSY;		/* something's already registered */
 
 	ppmu = pmu;
-	pr_info("%s performance monitor hardware support registered\n",
-		pmu->name);
+	pr_debug("%s performance monitor hardware support registered\n",
+		 pmu->name);
 
 	power_pmu.attr_groups = ppmu->attr_groups;
 
-- 
2.17.1

