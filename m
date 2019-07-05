Return-Path: <SRS0=Ef5B=VC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E9AC46499
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 21:31:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6A4216E3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 21:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="jfQEjTnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6A4216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45gShs65rnzDqft
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2019 07:31:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=fossix.org
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=santosh@fossix.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fossix.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=fossix-org.20150623.gappssmtp.com
 header.i=@fossix-org.20150623.gappssmtp.com header.b="jfQEjTnk"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45gSbV1MM9zDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2019 07:27:02 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id i189so4786309pfg.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jul 2019 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fossix-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BcXNj0V5J0vzNKvRmRBKPvDo98GIk5DFm0hE0qX8TyY=;
 b=jfQEjTnkV6wdrek1BzaZzxHfG44DALpfRjaRTDHQ7lbR6n2gTrvyR9TAP4mtbeU4D0
 XU7d5rGuxp34NWs4aEimwbQ7jfYA9LaUsvRRfarVdfSl8t60/G3sKVlJNMHIO5Lo+X24
 ImNwudQAOS9jSVcTMzr4BTTOlXpvY+H2bO7UuliHvUJOiMPGmhhI5TEJ8dTFQkoNPodU
 gZweZfIxusi5lVtEJ4SIHALy770CUHuXdVaxA/KHOa5dos6+XGeHKB7ToszIoYz/QJjy
 +gXYMYWUuR2n0lnwCUwVza1tYGtPR8huv1x1MIEow/80Rn/SFqoz5q4PdwYnJvHXTamB
 QlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BcXNj0V5J0vzNKvRmRBKPvDo98GIk5DFm0hE0qX8TyY=;
 b=ZUGnZ3HcuDVLhp2WSlZFCc71zP12RjxFmmncJsbM3xss6u3bLhnB/PSpO0TQ/l5NZa
 /hZNoA8qlowjQP7K8GgZ3vZYBqNih0ZtzGzUix6rmoOCgnII8rFMWyS2+1m9VMxK/UdE
 gto72Ao/n3dYuREOQQ9S+KEPI/YasW6Ylf1xucU/QD2ueP9+s/m3Zio154v+hH+UYAr4
 E+LID77dR+8cMWV8Ig/Jx57HBiqirHs1vFlz/g/P9Vs5Sr7N6leaCkI5PyTyUgMfUOzP
 QE5xFphsuxWbscENH1FXx0PA+IStvXRSIVr8NCkvoMY5Mg31rORsLXmjguRQqn+QaI1e
 jXYg==
X-Gm-Message-State: APjAAAWlQyPv9Af9HK/R9/fSQ7Bhe23JEMDZVq9WN0hkVcKC2oA5Btdi
 Q5UJgZ57ZRnDasJx7KcEe/mZcK+B8LC8pQ==
X-Google-Smtp-Source: APXvYqwojXpxAEStqHeqax4ld1xKz8Ycfa6SmWTApC5kF8rnB4KXIEDQIC7A/5PO1mwmAuviZ30aSA==
X-Received: by 2002:a63:56:: with SMTP id 83mr7770381pga.145.1562362019689;
 Fri, 05 Jul 2019 14:26:59 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.217.222])
 by smtp.gmail.com with ESMTPSA id o13sm9321389pje.28.2019.07.05.14.26.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 14:26:59 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [v3 1/7] powerpc/mce: Make machine_check_ue_event() static
Date: Sat,  6 Jul 2019 02:56:41 +0530
Message-Id: <20190705212647.21750-2-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705212647.21750-1-santosh@fossix.org>
References: <20190705212647.21750-1-santosh@fossix.org>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Reza Arbab <arbab@linux.ibm.com>

The function doesn't get used outside this file, so make it static.

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b18df633eae9..e78c4f18ea0a 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -33,7 +33,7 @@ static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT],
 					mce_ue_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-void machine_check_ue_event(struct machine_check_event *evt);
+static void machine_check_ue_event(struct machine_check_event *evt);
 static void machine_process_ue_event(struct work_struct *work);
 
 static struct irq_work mce_event_process_work = {
@@ -203,7 +203,7 @@ void release_mce_event(void)
 /*
  * Queue up the MCE event which then can be handled later.
  */
-void machine_check_ue_event(struct machine_check_event *evt)
+static void machine_check_ue_event(struct machine_check_event *evt)
 {
 	int index;
 
-- 
2.20.1

