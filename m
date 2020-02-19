Return-Path: <SRS0=ebxO=4H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20398C34047
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 14:22:29 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4082176D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ4DvGep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4082176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48N0Kr5MVDzDqTJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 01:22:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=iZ4DvGep; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48N0Hs0rsSzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 01:20:38 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 70so181275pgf.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2020 06:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=LTIXxTsKamaQgBnqjDJXhWOodA2nfbhxlXJcQS82fT4=;
 b=iZ4DvGepQpSHSzRsc9fl7ek4ISJotj8QK1wY8rFLNz3aSWCqYLX7WPVaxi1SR+6MCD
 XLNUbJ6/uArQfEEY09UdgRAL4tkKDyJNHDUSN2AIgRSKEKz9uMS5p7vOimcfQ7k5JUIc
 OxwlDgf4TP99PL48EdL6LVSsRngWcaUUu8tnBAtbhPe+sEwESvILEVMx1ec+fx6iP4P8
 MHlywMlMWdEjyOyfUHfnxpwJ7TDtuuFZmvyNc7liN/2zWWNL0YjovZ7Uyz8ZyROgTgbh
 FjciU9D76QpW1sMOj7tmSLaG7uMnl+i+sWBg49fYl/I4z+UrgA9mmFS3ZqqxyatEDVwu
 H1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LTIXxTsKamaQgBnqjDJXhWOodA2nfbhxlXJcQS82fT4=;
 b=kY0nL9Tr8fJUIJEe7VAf+dyPkhPe50XjhN3B4d+4YejXJu7iT/fW2LrfHqpgP8ciVr
 OoAv0QmNKS/kI+yAyDy/Xd6/n94fOcJhukkywLBjNMiqoSSj9/ggtGqtGzpnMakGnvd9
 HbTPn4nBNnmCnbSaXwtVx6jJBD3Cau1UUxrTZuY+ugwddgykEokCZIoFydGYBzmKYRb7
 gWQ64654TsYoFynh0uYhurr7GtMTaFZZaFMcQL/mhbY/xjvz6/z0WHpISLbJlsM5UMsn
 1G9+23/cAWmB7CIuX+oEF7V21qX/qn0nKeQJmXYfqhlBlVvJobua718URi7ybJ9RygPk
 pZSg==
X-Gm-Message-State: APjAAAVx48czfJa659cPJ5DELD713MvUnMs5Xw/PdmrwD0GAP3gsoziO
 hBUTQfq/6Yrh1lnS8kJhqcsgGC8=
X-Google-Smtp-Source: APXvYqzeE8k7yP0uggA9cy/SjKGBoYni1Ecfw5qfPE+SB5znERpqq9fj4Vk4TcjMmuk+ekayFY+5Jw==
X-Received: by 2002:a63:1e5e:: with SMTP id p30mr29954146pgm.112.1582122035716; 
 Wed, 19 Feb 2020 06:20:35 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t15sm2993316pgr.60.2020.02.19.06.20.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:20:34 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3] powerpc/crashkernel: take "mem=" option into account
Date: Wed, 19 Feb 2020 22:18:17 +0800
Message-Id: <1582121897-24336-1-git-send-email-kernelfans@gmail.com>
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
Cc: kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
 Pingfan Liu <kernelfans@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'mem=" option is an easy way to put high pressure on memory during some
test. Hence after applying the memory limit, instead of total mem, the
actual usable memory should be considered when reserving mem for
crashkernel. Otherwise the boot up may experience OOM issue.

E.g. it would reserve 4G prior to the change and 512M afterward, if passing
crashkernel="2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G", and
mem=5G on a 256G machine.

This issue is powerpc specific because it puts higher priority on fadump
and kdump reservation than on "mem=". Referring the following code:
	if (fadump_reserve_mem() == 0)
		reserve_crashkernel();
	...
	/* Ensure that total memory size is page-aligned. */
	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
	memblock_enforce_memory_limit(limit);

While on other arches, the effect of "mem=" takes a higher priority and pass
through memblock_phys_mem_size() before calling reserve_crashkernel().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
---
v2 -> v3: improve commit log
 arch/powerpc/kernel/machine_kexec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index c4ed328..eec96dc 100644
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
@@ -185,7 +186,7 @@ void __init reserve_crashkernel(void)
 			"for crashkernel (System RAM: %ldMB)\n",
 			(unsigned long)(crash_size >> 20),
 			(unsigned long)(crashk_res.start >> 20),
-			(unsigned long)(memblock_phys_mem_size() >> 20));
+			(unsigned long)(total_mem_sz >> 20));
 
 	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
 	    memblock_reserve(crashk_res.start, crash_size)) {
-- 
2.7.5

