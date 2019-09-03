Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A4C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 10:19:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E145230F2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 10:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAhuhITd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E145230F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46N2x70KYLzDqNj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 20:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAhuhITd"; 
 dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46N2t71dGSzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2019 20:16:30 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id q5so2627014pfg.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2019 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2QXNODmxd3WZugElMuIhRUvu6c2H4Kin9tIlAVM8VL0=;
 b=aAhuhITdb1BhQt1g6LJiU4W7ce9X3dlelm7yR8niWjpqBe0sDwyECg+Z5gRLJz0tUE
 RgH4nRNVGMyENKXVfHa3RnRad2VR99lnOZu5mo2Upaqxtpf1kXYM2jGoeL9Q2UtHjfUQ
 CF2zgA5FhXIaUYNX2rnlTnv/fq+vMLH8VplZOQShIMBstXHvC1NZ3c0vVK3j0AxTzpEM
 9erO40efg0mdEB3OWRFPDxbgVsfsdkmggno10W6afI5LmUTK3qC5vlc87Lu05ZUWMHew
 GQ0PqbP7/1caDqrlLtTOXGUtJPd8LV/NgSLsfB2iu5ENJcQRe41bARH0I7AhDZsh6h0y
 UVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2QXNODmxd3WZugElMuIhRUvu6c2H4Kin9tIlAVM8VL0=;
 b=pPvobSQ9SuASlkRtlxigO6UWdwH8XxplWTwhX9CZuNkX81enWM4MiSxmbsdRd1RxGS
 HR3dm3hb7zLVwws3F5yjUWvIdwkwSLC+gbhGO0ccEfPOTh+eyUBj2epi2SXQ0u8gCogy
 g8sigBpyT92CU8nJfdSsom0Oq3Y5dwJYG3AnPAxGHEj0RrnpeNUIC0Ug+ubevNiFXroV
 i7hFdne3wfnQAGfPhnKYDsg2o0xJEiT6IfzrcRa0Y35P0TA743vglnFR4oiVkV8mXnl+
 cRkN1ho7BXgIy/jpwW3k7swEPn55E4Eiq/mXEBDGR7nr1WE2ZcJxmYmI5BQwV3svdN7r
 6g1Q==
X-Gm-Message-State: APjAAAWsq0hAqfH+74gY3gD8qU+EQPy0VYL7T2aJZnzNDwzgDCPQ/iUT
 nemw4KLqD/gKkv9DLgA8yif+CXjf
X-Google-Smtp-Source: APXvYqyqFXyr0iFIDZd0HdknTxhL43jYRJIvby8Vluf7gu4ppEWOwOBqk0lq2C2Dl2y8qgi5jBy3Iw==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr636828pfo.122.1567505787053; 
 Tue, 03 Sep 2019 03:16:27 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e24sm19676701pgk.21.2019.09.03.03.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 03:16:21 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: EEH + hotplug fixes
Date: Tue,  3 Sep 2019 20:15:51 +1000
Message-Id: <20190903101605.2890-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes various random crashes and other bad behaviour when hot
pluggable slots are used with EEH, namely:

1) Random crashes due to eeh_pe and pci_dn lifecycle mis-management
2) Hotplug slots tearing down devices you are trying to recover due
   to the reset that occurs while recovering a PE / bus.
3) Hot-remove causing spurious EEH events.

And some others. This series also enables pnv_php on Power9
since various people were carrying around hacks to make it
work and with the above fixes it seems to be fairly stable
now.

The series also adds the beginnings of a platform-independent test
infrastructure for EEH and a selftest script that exercises the
basic recovery path.

Oliver


