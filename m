Return-Path: <SRS0=84HA=XE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6547C00307
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Sep 2019 04:07:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E75218AC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Sep 2019 04:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZzA3A78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E75218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46RZPB183ZzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Sep 2019 14:07:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZzA3A78"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46RZMH5cqnzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Sep 2019 14:05:28 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id d3so5973695plr.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Sep 2019 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ArKS3KDUZ4lnp20uJakf6XS86Pf1t8mXZvQKLitLAos=;
 b=PZzA3A78EMRLw6OO8y/ZW/oLlIrAaiFwJHleoonpCDbY4Ab6RiVapEdFf7VIu5pcdT
 3s6e9sAAQxP+Rz2sV4YdkPdfalwpe/rs6vUepfVbAvHcnkpAsCm7JohzmsRE56Hna2Vv
 SRJaoxWXBxXfPmSCQpbR97nwqjREkc5BAGRJomeeNR5+CuOKGKjwQlULPJSYODHINmaY
 NXLxy/qdAnA4Wq0yww2E0sdJacqwmdc7qRuTR/geVlHFwT1E8W3L7wRwkZHtIxPjZOmW
 Y6cqb1D3QWOBABNnxaLBZ4LRjNHFB0bQa0Di/LCte6XLwqtuSPrv568M4CI7Aj96fcmu
 uJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ArKS3KDUZ4lnp20uJakf6XS86Pf1t8mXZvQKLitLAos=;
 b=Vy9tIEPjrzlzD7DtiwUpyGayGpERAgTFrOiPoS+YGTCfhS/fUXQ3YJioluPLJu1Wcd
 OuYtoVAYkBxGEnE67p7YKNOaYWbtJsdV/l982CvayS36tHU8y0SbgBogVZ6xl4e8qbWJ
 abcWiwIdNyJL9PtoFHKcOw+uwDMf/PW8Rw0HkwLYij4/Ua8UniJaUyynx4zDMwqdznm7
 5tQmEJqwFV5+yKoyg+y0drUi00J3CuJNyH8ldO8DFe32AllAfDaFhY6ikNqjiqJZuPjs
 4fUY8/rx3Z54u/QnMFCTpaGf/c5ORo5b6QAeDpdXKzmsX0DJzbzNlDzvnAQRsEOPBO3/
 g3VQ==
X-Gm-Message-State: APjAAAUpYa0snuoI4Zwudn2lclqZft606CFvheuZ/dw6rGPzVopSsYnv
 qO/eMdZvUI2T2MAG4FSLAUIm9oY=
X-Google-Smtp-Source: APXvYqwXqfqvooDg/N4B0R1zkLjnGZfLdtJDjC4XV5NxXcglkyZj4X9adL0BkrqIOpbpWHfIgXFL3w==
X-Received: by 2002:a17:902:854a:: with SMTP id
 d10mr22390671plo.222.1568001925127; 
 Sun, 08 Sep 2019 21:05:25 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b20sm15690100pff.158.2019.09.08.21.05.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Sep 2019 21:05:23 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/crashkernel: take mem option into account
Date: Mon,  9 Sep 2019 12:05:06 +0800
Message-Id: <1568001906-5750-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
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
Cc: Hari Bathini <hbathini@linux.ibm.com>, Pingfan Liu <kernelfans@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'mem=" option is an easy way to put high pressure on memory during some
test. Hence in stead of total mem, the effective usable memory size should
be considered when reserving mem for crashkernel. Otherwise the boot up may
experience oom issue.

E.g passing
crashkernel="2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G", and
mem=5G.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/machine_kexec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index c4ed328..714b733 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -114,11 +114,12 @@ void machine_kexec(struct kimage *image)
 
 void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base;
+	unsigned long long crash_size, crash_base, total_mem_sz;
 	int ret;
 
+	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
 	/* use common parsing */
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+	ret = parse_crashkernel(boot_command_line, total_mem_sz,
 			&crash_size, &crash_base);
 	if (ret == 0 && crash_size > 0) {
 		crashk_res.start = crash_base;
-- 
2.7.5

