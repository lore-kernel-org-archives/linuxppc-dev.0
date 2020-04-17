Return-Path: <SRS0=SBso=6B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6983C2BB1D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 07:45:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64176208E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8MSu1rW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64176208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 493Sn311DHzDrfJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 17:45:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Z8MSu1rW; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 493SYY75bZzDrbd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 17:35:29 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id w65so659898pfc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l5WOXNxTGJUVLKilP79WYKGu1MbUuu0FUcEnhDUyO7U=;
 b=Z8MSu1rWgLZFLMfmDuFsOwHLlPVvIT2z+Y6ZTsFVQFqq33GGvOl98Nr7KMjOXdsfN6
 dSyGk7INAApr6dn89rObKOd56T9lBroNoT5kTrVDPURBJBoT6kzFdMVmVtZtmAFCEaf7
 0TsaccNkw7/VrHg6We2O/p1sqyAp0maf1hp1kycX4MCZFPn4x05OWg+jPdpqZAS4TA8n
 UT3ifIpmivM4GngXm7Mi2vQaftMxnqDxPCDMNTPM45Zq9B/ccrHVAXM1PKwyBSvHQDrx
 aNnmLfkEpHNA8dJ7X7W2Q/1vHNajvob/TlC0KvCznM8LZcahsq4ppPRYidLx3OaNI6g6
 +20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l5WOXNxTGJUVLKilP79WYKGu1MbUuu0FUcEnhDUyO7U=;
 b=qHUmNwNb9LJUc9grZAhb4UMrnHQtSMdj98u7qregnjVhQnqamnThz3feh+bPS5+zib
 Q1c71B7f/JXMLjOpndieb5jFtavtwBmFzywUtGIIOFNnMwB6CDagTZSZM/LoKefIlGMe
 QLd30p3Ki+X+2S/jpcobz//n1+kVqyTc5yliNQxjUsx9ReXt0lEMF3f3sV+WnYfu6BAn
 6mSIMzPWK1m95BGbUxdfqhelV2sWh3Lzzm7nsZ8scHsTwQnDgSBCySVzgStBsUGWv9+U
 hKRYmKvYs5xxNyGACts7DmpvpM/jOurv7IKhvbp225k+hoARRQckY1/kCUJXx6wXOeE/
 f41A==
X-Gm-Message-State: AGi0PubOEC8ksDopJ7E7F2jrr82Py0Vf69gAqrD5rwQvM+dmbJ84mzVp
 ylECa7JpktwMQQEWD3Uvkr0gx4Hw
X-Google-Smtp-Source: APiQypLlgTdMTdO2fiNrxJbEPW6xDzrZMntoq0tp0GDNfozIy9JFhO18Z18BTg79q2YtKQ4k8umR8w==
X-Received: by 2002:a63:5d5b:: with SMTP id o27mr1789270pgm.104.1587108927122; 
 Fri, 17 Apr 2020 00:35:27 -0700 (PDT)
Received: from 192-168-1-13.tpgi.com.au (115-64-37-247.static.tpgi.com.au.
 [115.64.37.247])
 by smtp.gmail.com with ESMTPSA id mq18sm5272438pjb.6.2020.04.17.00.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 00:35:26 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/powernv/pci: Sprinkle around some WARN_ON()s
Date: Fri, 17 Apr 2020 17:35:08 +1000
Message-Id: <20200417073508.30356-5-oohall@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200417073508.30356-1-oohall@gmail.com>
References: <20200417073508.30356-1-oohall@gmail.com>
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

pnv_pci_ioda_configure_bus() should now only ever be called when a device is
added to the bus so add a WARN_ON() to the empty bus check. Similarly,
pnv_pci_ioda_setup_bus_PE() should only ever be called for an unconfigured PE,
so add a WARN_ON() for that case too.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 05436a9..627420c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1139,7 +1139,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	 * We should reuse it instead of allocating a new one.
 	 */
 	pe_num = phb->ioda.pe_rmap[bus->number << 8];
-	if (pe_num != IODA_INVALID_PE) {
+	if (WARN_ON(pe_num != IODA_INVALID_PE)) {
 		pe = &phb->ioda.pe_array[pe_num];
 		return NULL;
 	}
@@ -3224,7 +3224,7 @@ static void pnv_pci_configure_bus(struct pci_bus *bus)
 	dev_info(&bus->dev, "Configuring PE for bus\n");
 
 	/* Don't assign PE to PCI bus, which doesn't have subordinate devices */
-	if (list_empty(&bus->devices))
+	if (WARN_ON(list_empty(&bus->devices)))
 		return;
 
 	/* Reserve PEs according to used M64 resources */
-- 
2.9.5

