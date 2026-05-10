Return-Path: <linuxppc-dev+bounces-20661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86343CD37B2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2026 21:49:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDGhr17nDz2xnK;
	Mon, 11 May 2026 07:49:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778433263;
	cv=none; b=edbzp+N0SbE2XUZGa3uSyWVHXb4Ch/QYY9T3oVIl8Z9XYmdz2F6QGL56yfcHohygN+wWEgkS77PExSwhY7bxzpxt226+VMMPJsq5z0larAnCw5ZzLGow7hI/zLOjXRcTGM32yk5CaAdAAB4jVoO2ra6zfDBfCZcQVKVap4i1vGAi0frl33tloHGxqDRCNJwUoxhj7DLeRB/71MBVF2+mnV5BB9EUXv58/bjvN/JcnqFkZQuHxtscU8fa9pi8BXG5ClSpTj2rRaXQYNEFH6/h62Q/CQndcNcgRqW+yjgN4K8fAcxJgrAZgyhSkxZXFGJJixIbWN4xvYn5Q0pyHk0Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778433263; c=relaxed/relaxed;
	bh=AdiKoqOYaOQxpnoifZq+HXTmHH4BYLymY6DfpNxMI/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZucGhb1h8DCDWSXHGT2j4x0vyszFF9ZVbkYCYRE/nz/QRYzzIV5BVQA3s/zwgVfEHqNdorbzGfjpBox+ydQRqGTVfHQiEhAJAPah/duZ+k3UTCpccAivGETqlrwd2jL/nM2ks5Fyh9FUW5UXsOPWMpRJ7lAITCgSytY1g05Qke9tuG0j8H5L1DPpvCncqXQ1vn8VNQzdL0xETVYBXWV2LynOa9wP1KNyoitYtuIFw/q/bAz06q0eMLSmQAj02cn7nwvQEgA5iaFJV2/SkeKK10kaNB5fdy5YLYVjVhuJO946F0+LpsUiuYyPs76/J5sls1/P4rZFAcZQku0EtyJdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N2mXUfpm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N2mXUfpm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gD8bf2N7cz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 03:14:22 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8354461da74so1633836b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778433260; x=1779038060; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdiKoqOYaOQxpnoifZq+HXTmHH4BYLymY6DfpNxMI/U=;
        b=N2mXUfpmuvy7mVuJuVJ4H+flHJwY2jACEhU3+JAILs1bP24uz2JHm49cRlFaxRx6JO
         yKYl0dzLRupdQs32ySyW6B6ox0BQq+dcVzJoiqmWhPdzQ2cuTsZnGLqNr3gqTfnA7+KS
         RDeDdL/4YmSSjVY8jH1R/r5EhTdoekBXF4xTu1H+FNZ6FAKxZc+AsKTleA1SREc8UV4a
         vaWxByAt3MC2RqMPF7nqpw32HwEJtNwotgh4RBRgo5ZP/dsfzawFqEnvsWIeIaOLlWaA
         IRDTUEp98eRgF7TqJu9UhT+R/F0vSMBm5B3DrkDnbLFfD1ucyVDyOKP0l062hYftPIry
         ogdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778433260; x=1779038060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdiKoqOYaOQxpnoifZq+HXTmHH4BYLymY6DfpNxMI/U=;
        b=SHlHQKX8xu5Hd0/V02qUBPgPJr3JnId5MWyr9rJy6sXOSnoFodFHaQH8Jvp08yJaC+
         x0f1+ltpGZxchrVd0YakGIx+9NamsqXpW9p257Usy3rh+GiWFopo8dwIG9eKq4kUNxza
         FvJR+/IYL6iXtL1mDTDJFYWtIWzzBGDNyYabrkZo1U7rdt0SL5I3rthVrXAp0swaHYMa
         Tm/Jg6aLeUi4ncuZL5GHGaUBy6z4PDcHeyr1WJAfJiJmQNr3/MsbV97hKgnt2H+KL3Hj
         t/AHeOE4FCwH3AWRlr+ZtGmdIeKoMUkESIjr1kUW4rMDlwfCElrVhdIDMaUmgjxREsij
         Wnig==
X-Gm-Message-State: AOJu0YwNmzKrV9cqjVlbYQfMXMjE30/8kUA02/FtS9/mP+fApf1bnleT
	dLb2mvntGYfA++LiLq7Yvngbe+HGgrGw33krSJ/uqc3E6nmhFFYDPEc7
X-Gm-Gg: Acq92OHgcouVMxfjEMIC6umH9JeDpJiE5LSidhKp+JQ0F5i+u4EiGM4rHph9bhNCSrK
	zNgbeGI4cTeVLjyzxPcJnrZYzfcs/I7upRHkNV7CoayxoJIIa2Tq2sECZnao55S2WftWTZ4qWMm
	FqPMejd2fXG4Z+6ST97gQudKO7cppFelS5OjVyq6Rx1grwEiQgiklbn3n0z6QK3KVNXuxEuT7UW
	GvyQUFnFEHKh1j+s8lqJQ10Ih4zSuc7HgsU6Cre7PzhqiRrlR1nYQKtz2coM/o+lGZpkEa8ftoa
	2Md7himh7xrVEk8xx4fzfdCtBtr2B2vBSFsR98/K4w9ssElxTPW4vjduO/NGy5XoRahi3/ZCWnm
	V3TkNPplc9lqo6KQiZyufWN0O7Evyuxq8Q2MvbTfe+v11ZMmJQ8oIkdmIYZEi4hMAgA13l7lGl6
	7I53JHG/ZTOqO43DjPFg==
X-Received: by 2002:a05:6a00:4389:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-83e3b2da632mr6556120b3a.24.1778433260105;
        Sun, 10 May 2026 10:14:20 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f381sm21799778b3a.6.2026.05.10.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:14:19 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 1/2] powerpc/prom: fix /chosen properties read from wrong node
Date: Mon, 11 May 2026 02:13:52 +0900
Message-ID: <20260510171353.1406018-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510171353.1406018-1-ekffu200098@gmail.com>
References: <20260510171353.1406018-1-ekffu200098@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 60f20d84dc81 ("of/fdt: Rework early_init_dt_scan_chosen() to
call directly") changed early_init_dt_scan_chosen() to be called
directly instead of via of_scan_flat_dt(). After this change,
early_init_dt_scan_chosen_ppc() does not behave as intended in either
case below:

- /chosen(or /chosen@0) exists: early_init_dt_scan_chosen() always 
  succeeds, so early_init_dt_scan_chosen_ppc() then reads properties
  from the root node (first iteration) instead of chosen node.

- /chosen does not exist:
  - Until commit 064e32dc5b03 ("of: fdt: Honor CONFIG_CMDLINE* even without
    /chosen node, take 2"), early_init_dt_scan_chosen() returns -ENOENT
    and early_init_dt_scan_chosen_ppc() returns 0. So of_scan_flat_dt()
    iterates over all remaining nodes. Not a bug but unnecessary.
  - After above commit, early_init_dt_scan_chosen() returns 0 and
    early_init_dt_scan_chosen_ppc() returns 1. So it reads properties
    from the root node (first iteration) instead of chosen node, same as
    the chosen node exist case above.

Instead of using of_scan_flat_dt() for chosen node handling, first call
early_init_dt_scan_chosen() directly to handle common chosen node
properties. Then call early_init_dt_scan_chosen_ppc(), which is updated
to handle powerpc-specific chosen node properties.

Both now look up chosen node directly to avoid reading from the wrong node.

Fixes: 60f20d84dc81 ("of/fdt: Rework early_init_dt_scan_chosen() to call directly")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
QEMU-based test results

$ fdtput -t bx chosen.dtb /chosen linux,crashkernel-base 00 00 00 10 00 00 00 00
$ fdtput -t bx chosen.dtb /chosen linux,crashkernel-size 00 00 00 02 00 00 00 00
$ qemu-system-ppc64 -M powernv9,dtb=chosen.dtb ...

1) AS-IS (before fix)
# cat /sys/kernel/kexec_crash_size
0

2) TO-BE (after fix)
# cat /sys/kernel/kexec_crash_size
33554432

---
 arch/powerpc/kernel/prom.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9ed9dde7d231..34318ddb4a73 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -450,15 +450,17 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	return 0;
 }
 
-static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
-						const char *uname,
-						int depth, void *data)
+static void __init early_init_dt_scan_chosen_ppc(void)
 {
+	const void *fdt = initial_boot_params;
 	const unsigned long *lprop; /* All these set by kernel, so no need to convert endian */
+	int node;
 
-	/* Use common scan routine to determine if this is the chosen node */
-	if (early_init_dt_scan_chosen(data) < 0)
-		return 0;
+	node = fdt_path_offset(fdt, "/chosen");
+	if (node < 0)
+		node = fdt_path_offset(fdt, "/chosen@0");
+	if (node < 0)
+		return;
 
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
@@ -491,9 +493,6 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 	if (lprop)
 		crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
-
-	/* break now */
-	return 1;
 }
 
 /*
@@ -818,7 +817,8 @@ void __init early_init_devtree(void *params)
 	 * device-tree, including the platform type, initrd location and
 	 * size, TCE reserve, and more ...
 	 */
-	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
+	early_init_dt_scan_chosen(boot_command_line);
+	early_init_dt_scan_chosen_ppc();
 
 	/* Append additional parameters passed for fadump capture kernel */
 	fadump_append_bootargs();
-- 
2.43.0


