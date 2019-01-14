Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD7C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 20:15:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0629F2064C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 20:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJeLztXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0629F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dl7z5X2wzDqXm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 07:15:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LJeLztXb"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dl685B14zDqVZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 07:13:36 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id 96so392155wrb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wWmKbA5d1oGoKuQguYAEN7zBM2H2HtNTPi7BgyT+znE=;
 b=LJeLztXb9zgZvHzDWbseGTWidNnpW/yFUY8r0TRpnoVtSGfyr+9cFKpMGTtbygxsgK
 EgXfYwfB9M8h/ktpa3VziHuaHkuqqWAwPJOXZ4D++YHxdi6zcf94D0CUTVRQhrnN9P4K
 tFMJLetWqC7sNybYyHUclTfS/A5oCIyzb6JmWOs4eVlNErNMvNDNXkGvX0KleqXd64yB
 YzNlZyMJyPhu6mRBEF79jK9+qMe9VWrx1V4Q8ZJpIyE7jnY6wFRBu4N6dx3+Fy370gw3
 HMyQT9VDw9ehIpGJE1J0Gk7SPI0k4st4NyUmWqRMnvx9TXibRhjw8uuj+PM5cNFFsxfV
 Uc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wWmKbA5d1oGoKuQguYAEN7zBM2H2HtNTPi7BgyT+znE=;
 b=ihjvmV7ZkuKmcJy+g9sNF3PWlZxQrPAW2ePOzAHt1PoUlJUEzPEcbD+7CQvNqOctcU
 JMyPD5KdjYBpV/pDh3gzAouFfHjW4A2H8YZWxs7+QoXV1AYLGV+BzkRf9wzxDp+WaC9f
 /9ZdUOe7l5VxNIj8XPGpvCW5eSKLYPHi8sWsFnEZXB2mJYSimV7HPQM3vypXUQiTe0kq
 NasUNlNquCcPT7GZb44AORmR0P/+iSlu5+zpvmwi+KHpi/1AMMJ9LCYgSfMP8fwukuAc
 BuXhRAQmB9QJ/O6OQQOpL4GJkJ0fyqRaeeLB+xuMDl1wGB6Mc1DR2/ikqGFePmpy7pwN
 5ltA==
X-Gm-Message-State: AJcUukfvuipLHMWokhOkMV+Ygh4elbUw8CRShWMRR//d3YJPH+QwWO66
 3Jrnkk7BE8bZiYHbjnQ8Fr4=
X-Google-Smtp-Source: ALg8bN7bqye7llULIjL7t/Z3TLbFTkFMfki7ki2Lrd+nu5U0G8/6XBBCi0iF7q74/cXWuqyYK4jwqg==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr176312wrv.88.1547496813706;
 Mon, 14 Jan 2019 12:13:33 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id c15sm24265536wml.27.2019.01.14.12.13.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 12:13:31 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id ADE5D11422AD; Mon, 14 Jan 2019 21:13:30 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Allow CPU selection of G4/74xx variant
Date: Mon, 14 Jan 2019 21:13:04 +0100
Message-Id: <20190114201304.10783-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

GCC supports -mcpu=G4

This patch gives the opportunity to select ALTIVEC for this variant.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/Kconfig.cputype | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 8c7464c3f27f..7c544607ba32 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -153,6 +153,11 @@ config E300C3_CPU
 	bool "e300c3 (831x)"
 	depends on PPC_BOOK3S_32
 
+config G4_CPU
+	bool "G4 (74xx)"
+	depends on PPC_BOOK3S_32
+	select ALTIVEC
+
 endchoice
 
 config TARGET_CPU_BOOL
@@ -171,6 +176,7 @@ config TARGET_CPU
 	default "860" if 860_CPU
 	default "e300c2" if E300C2_CPU
 	default "e300c3" if E300C3_CPU
+	default "G4" if G4_CPU
 
 config PPC_BOOK3S
 	def_bool y
-- 
2.19.2

