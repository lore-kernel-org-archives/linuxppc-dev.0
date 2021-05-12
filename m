Return-Path: <SRS0=OS5J=KH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D0C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 20:28:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1D5613C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 20:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1D5613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgRFs650Qz30Gt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 06:28:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=oKzYDYCk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82b;
 helo=mail-qt1-x82b.google.com; envelope-from=danielhb413@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=oKzYDYCk; dkim-atps=neutral
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgRFP0ksnz2yYv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2021 06:28:24 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id h21so14470539qtu.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 May 2021 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LZlefKr1lV7bmtdSSoz8XhCmkGKvesGkL6F37B8vsmM=;
 b=oKzYDYCk/jEDeyJZmbBl/FAcgQau5/B/XgiIxxqXoqbKyaAdTWeBOm0+CW6GmBDWJB
 +9M8l9TL7p39DjpzleAQcWGgZduUsRwbsvklF3FUkvIZ+sDnDjqfKCjWPIS4FlEtNu5i
 xSNjqr3mtE+0IpBh21yL3Y1s5wQGx876HjnPWfH7tv/sLUmS8d2PZSqlD8fNvhLtJMIu
 T4hqjGYms1+cDmoLa7hjsOIK2tB8xc9DKWeKXpv9dLimdzDPjAepRsl48RDnSgLKM6ce
 Nvg2IaTX04fF8khv9JMUALf5rXY8mdtX/wvrJfLI8SNjBwc13f/sSvUX0MowoAAuuWYu
 eAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LZlefKr1lV7bmtdSSoz8XhCmkGKvesGkL6F37B8vsmM=;
 b=Xmwm2t0jPTFlC1bJtWdH7oF1VHHuKODwRlmWFEL+Cz8vE19t2wCXUAxNJMkdOE/1DT
 HnP1CcslQCaAOKNx1jWwcAvCKM7Gt0w/VHKH5jfkkT8lC11clhx4VrMeBhHwvMy2ufKD
 jEeafV4qUl9DdcXFZ77UZWf9aIkF/N5I8jVrNOtKTK4w51YoWnePRYDVn2UShA2mKAiS
 KaRIhWX4w1/ufMsWh6zfKpn17dPV5+mYXmwNM5yMNd/7PR1uDpkD9y6TFSDcxQGEZx2W
 OIoT1q7Wovrk9kuXW24JqlJkmI0yGZIH5ZVl/AxAA0J0xveB0lwjh4djw3e0DPRJ5iQ7
 YTYg==
X-Gm-Message-State: AOAM533yJrCsDt11cDn1W+o4TucxijmLbDlhn64/v/B9EXpaWal7hmuu
 6tbCxWdrElwgtEI5lfzrQ2SuWvyuBFExMw==
X-Google-Smtp-Source: ABdhPJwyadHXplc1aglxlsfLXCGWgQqhORS9s7IBjThCOr21yeheVAH7WIc+6FFgH+Bd9YJTm15hCg==
X-Received: by 2002:a05:622a:1756:: with SMTP id
 l22mr21902768qtk.367.1620851301952; 
 Wed, 12 May 2021 13:28:21 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:fb9a:a1c9:c5a3:1e98:bc69])
 by smtp.gmail.com with ESMTPSA id j29sm778317qtv.6.2021.05.12.13.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 May 2021 13:28:21 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] powerpc/pseries: check DRCONF_MEM_RESERVED in
 lmb_is_removable()
Date: Wed, 12 May 2021 17:28:07 -0300
Message-Id: <20210512202809.95363-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512202809.95363-1-danielhb413@gmail.com>
References: <20210512202809.95363-1-danielhb413@gmail.com>
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DRCONF_MEM_RESERVED is a flag that represents the "Reserved Memory"
status in LOPAR v2.10, section 4.2.8. If a LMB is marked as reserved,
quoting LOPAR, "is not to be used or altered by the base OS". This flag
is read only in the kernel, being set by the firmware/hypervisor in the
DT. As an example, QEMU will set this flag in hw/ppc/spapr.c,
spapr_dt_dynamic_memory().

lmb_is_removable() does not check for DRCONF_MEM_RESERVED. This function
is used in dlpar_remove_lmb() as a guard before the removal logic. Since
it is failing to check for !RESERVED, dlpar_remove_lmb() will fail in a
later stage instead of failing in the validation when receiving a
reserved LMB as input.

lmb_is_removable() is also used in dlpar_memory_remove_by_count() to
evaluate if we have enough LMBs to complete the request. The missing
!RESERVED check in this case is causing dlpar_memory_remove_by_count()
to miscalculate the number of elegible LMBs for the removal, and can
make it error out later on instead of failing in the validation with the
'not enough LMBs to satisfy request' message.

Making a DRCONF_MEM_RESERVED check in lmb_is_removable() fixes all these
issues.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index bb98574a84a2..c21d9278c1ce 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -348,7 +348,8 @@ static int pseries_remove_mem_node(struct device_node *np)
 
 static bool lmb_is_removable(struct drmem_lmb *lmb)
 {
-	if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
+	if ((lmb->flags & DRCONF_MEM_RESERVED) ||
+		!(lmb->flags & DRCONF_MEM_ASSIGNED))
 		return false;
 
 #ifdef CONFIG_FA_DUMP
-- 
2.31.1

