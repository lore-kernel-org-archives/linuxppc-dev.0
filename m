Return-Path: <SRS0=n52k=JZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2DFC433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 18:50:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82666143D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 18:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82666143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVnkx2BXJz30G7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 04:50:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=NEa9FZMq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=youling257@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NEa9FZMq; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVnkR3sl5z2xgP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 04:50:05 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id z16so4477681pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Apr 2021 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oIRIEOVJimwmXciBNwHjV56oidjYB1LUygCarYNWZok=;
 b=NEa9FZMqA/a/HxerVeksfaslwYtBDsUdVZmQCspOgGu5bQ+RmByLk3b1OjsU819kBi
 DiVomnSK0SlTfXfTx8KzyYbUIVMt7WrW/hHfZoHyc3gKKtaOj1yoVUKE1UAdx/eneOh9
 dWui7YpDER5wM5wktdAoic0w33iy4U2/sytknod4URLZLGX+ICSvMu7VDYC88ilG7b5K
 lfk3w/GIa3g76CSGRs+tLqUk8YS8/eevKKI0fCXrfYYbL0/cJUcIBrHsY6ZxGdxNbcoN
 qKxClbq/WIFRMvVgX2MdcisukSdvU+zGc9TbYSg2Y0NMd+pmao5A1C8XFOdei9ix5gqC
 q7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oIRIEOVJimwmXciBNwHjV56oidjYB1LUygCarYNWZok=;
 b=ZBSH2Jl7VFZ3jOHgsOpyWMkRgr52fCZUjHfAvtAjL3eVb1j4VlaKVb1rZfz5wsPxmG
 3dt0ggiHcnIMK072vGcpJn/ACa3oZquNmZb6adfrlBPEC/SoBlXfRp+meVOGTH2ZwruK
 hB8v1ux8TcoMIC5KRLuip9IC3F9h7jLY2auarqXXZFR4ueSChlv7n2AowRL5Dld3e6Cs
 UlPPMoKrbAAXLB14OR6p+abe2Be3qjAyqBPyfggu1oCRF6CakTwkdLOU+7p452yOEaNq
 VjQZbn0tYgzNHkZqxnvLP287AfJ6cwYHjf64mpSR/DIQGM/WFQoT9d5Ou73Gw5rQ2Bky
 CGWw==
X-Gm-Message-State: AOAM532tuTj/wZ04UNdUtJevmzpxTYSwiv+x7uv9H9FasAISkuqxMDtA
 3wS3rOJ+2YOCbp4LCQuQ67g=
X-Google-Smtp-Source: ABdhPJyb1Ps1V/ROHrusZW90RzMS0bfqWGFsXWdlUBiDgNEj5EePAesHPrS2GlXB5ODKytPRpnlBxQ==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr28459766pgn.106.1619635800526; 
 Wed, 28 Apr 2021 11:50:00 -0700 (PDT)
Received: from localhost.localdomain ([198.148.102.224])
 by smtp.gmail.com with ESMTPSA id g14sm378239pfm.143.2021.04.28.11.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Apr 2021 11:49:59 -0700 (PDT)
From: youling257 <youling257@gmail.com>
To: alexandre.belloni@bootlin.com
Subject: Re: [PATCH 04/17] rtc: cmos: remove cmos_rtc_ops_no_alarm
Date: Thu, 29 Apr 2021 02:49:46 +0800
Message-Id: <20210428184946.23999-1-youling257@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210110231752.1418816-5-alexandre.belloni@bootlin.com>
References: <20210110231752.1418816-5-alexandre.belloni@bootlin.com>
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

this patch cause suspend failed on my Bay trail z3735f tablet.

[  162.038713] PM: dpm_run_callback(): platform_pm_suspend+0x0/0x40 returns -22
[  162.038760] alarmtimer alarmtimer.0.auto: PM: failed to suspend: error -22
