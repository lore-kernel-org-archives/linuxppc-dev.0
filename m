Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325AC64EB0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 06:22:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00840213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 06:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No/VBDP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00840213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TnGR3yJ7zF3N3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 17:22:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="No/VBDP8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="No/VBDP8"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TnD13hCJzDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 17:20:48 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id j23-v6so299946pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=lr4ZNpYGUyLLmEYKOa7aZQeyWbw48cLDUir6fDmqkcI=;
 b=No/VBDP8Vy69NYms7QxROItEn9gq+w6lRv/22Kp99jaPiZeXrKtBSls3c/u4M69uKI
 1CouawrXsN5J/XvS9BhwQjkoHRXe6nQvpiWoCDv+x28dHE+gF52Dz2IB8JwJMZFkyZz/
 21PyAEwbmgbEEaw2s/v5nQIov4jIPLKer/LQKCftadTZn5SpE4G5bKZOtAapfO4Bjrva
 59S2QrbPX/GghcurMogN4vRRv9ZppTHecbdSaLVH+EK/pquEv0BfeeTnuRTaRTUEW4Wd
 U8hv/VzyUJHOGpuqQqfDgPjtXkrL6sklhYaJO4tslbRtRo2PxHckDKCNRZpQjhIknXOV
 jiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=lr4ZNpYGUyLLmEYKOa7aZQeyWbw48cLDUir6fDmqkcI=;
 b=Ja+k00DwrnhXbmHSDrYyHkAJYUBE0XH1d2jKh8w0koontxQuQ8PuzedVes1V9jMSus
 p1U3XyR7vG8Q/VzrR7zZtpIr+NLL0YtWXD0Sgl7IyMIS4nX2Y/L5dP8q7nUhBH8FG34y
 tGNc/8xUqAHD93pAOqlipl//pxZ4BHSnoq6COSjhhuFNN+ltF3R2gYvvAzDBnqtw/4jK
 T2VUFMOVvbq5N0E1RF5tH9mYsoAJ8uCsSJX+Xlc0YG3av6LDl6G0fj+WRRUshxwmbYg3
 vQQ+z9Wmq4Pkv9ji7Qm5dJcCAvMubBIVzOmX4bryZ8dtYzeh8VXxXEvWF03Q3LyvIN/K
 NtIQ==
X-Gm-Message-State: ABuFfojv0HM+OEtJtH0QL2YutGjoAXgc8zkalylB3R0nwk5e9e//drGh
 rappXMjFzvpHkjeyjmVZkkddSejK
X-Google-Smtp-Source: ACcGV60/VvpBmT1W7Bps7zfricB+a63Bzhy+RLyeoBQfQINXm37LHUp+/l63uyrGBO/e/oQ02yyw3Q==
X-Received: by 2002:a62:fc13:: with SMTP id
 e19-v6mr28659311pfh.101.1539066046084; 
 Mon, 08 Oct 2018 23:20:46 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id y10-v6sm29037790pgi.85.2018.10.08.23.20.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Oct 2018 23:20:45 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 09 Oct 2018 16:50:39 +1030
From: Joel Stanley <joel@jms.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/perf: Quiet IMC PMU registration message
Date: Tue,  9 Oct 2018 16:50:38 +1030
Message-Id: <20181009062038.29695-1-joel@jms.id.au>
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
v2: patch the correct file, update commit title

 arch/powerpc/perf/imc-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1fafc32b12a0..6954636b16d1 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1392,7 +1392,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 	if (ret)
 		goto err_free_cpuhp_mem;
 
-	pr_info("%s performance monitor hardware support registered\n",
+	pr_debug("%s performance monitor hardware support registered\n",
 							pmu_ptr->pmu.name);
 
 	return 0;
-- 
2.17.1

