Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B68C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 14:01:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE7A2065C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bogrH/Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE7A2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsdtS5Pr9zDqBc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=tony.ambardar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=bogrH/Lc; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bsdkm2P2bzDqVL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 23:54:55 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id bd2so1161043plb.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z/K2/i+JXYfZZ5+5bldYLcF42Djb0mZAX58S+kRtJsc=;
 b=bogrH/LctRcjD61IXqaLFLgVpKP+15hGGQXFU1QPJO7NgISDGzRw5nzT8CIMhDNiTP
 ms0m5q0u9jD64WUXmiHzpxULDThbLR7ZBw7SiwFrFDib+wI8IQMLWXgD8Miyh8FicD2r
 Y/Ks2Fla9mIdyxJ2UPyzLc0SzOf26vVpk9FTZO8gAyrgEidVwpvl2G3H0LZOftwTdvx9
 doeY7DZD+4RaTROc4prYRIdRQ3eJx9ONJ9gf5GUo9W+LdGyEABBo/bwUYKg8R2cPGOuw
 Qzm9GIbZXexGEbmCGixOj79XM6bYXy4uCCPwqG1pJrnRJk/AWPCav3NWRVKLBm7RxNuP
 +SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z/K2/i+JXYfZZ5+5bldYLcF42Djb0mZAX58S+kRtJsc=;
 b=kfnYmkh97bsVZkFaJo918gI9lXJMPBCAkraDXEpdUuFpe5PJM7VPF0B5+UCMcUfis1
 23tDEkSkcAudvdYIxLl+s8z6fTPO5Ia414URXyyuhYUqdANA/eVo7cR4WL1gu1k3tzQv
 GHM+wuRLwWizpu82MFaAjPjavcFIIm8MCek4p2XI3N196UBeLMe12w7ItCDmUuFOTcWI
 S7v1ECgZWZOfJaYZg32w3zg1EalwbHO/ol/weDuuNakN6T67JWSbM63Fe9S5SfT6ABY3
 6hTSyAyqYlfO2c40m85yInZpxS3U8SJUVvg3W8rZQP46EO+b/3xbUvNb8cB4JwqEyMyL
 CH4A==
X-Gm-Message-State: AOAM531VOHSsgyrKm8KAdY9HdlAgWfQp+YOVy1Ml/YEKd/12hRlWUIok
 8YvOvYrpxZHmdB8sPHor6YE=
X-Google-Smtp-Source: ABdhPJxD4C2VPYadg84rIRzWLwt5+D0NW021aBQl3wpvrfSQ6SWd5wfgq05PgBpyp3lINoW2ttqL2w==
X-Received: by 2002:a17:90a:8c88:: with SMTP id
 b8mr8528564pjo.118.1600350891625; 
 Thu, 17 Sep 2020 06:54:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:e92d:10:6ca9:b613:f248:49fa])
 by smtp.gmail.com with ESMTPSA id
 a12sm17896994pgm.79.2020.09.17.06.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 06:54:51 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] powerpc: fix EDEADLOCK redefinition error in
 uapi/asm/errno.h
Date: Thu, 17 Sep 2020 06:54:37 -0700
Message-Id: <20200917135437.1238787-1-Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
References: <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Tony Ambardar <Tony.Ambardar@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Stable <stable@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Rosen Penev <rosenp@gmail.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A few archs like powerpc have different errno.h values for macros
EDEADLOCK and EDEADLK. In code including both libc and linux versions of
errno.h, this can result in multiple definitions of EDEADLOCK in the
include chain. Definitions to the same value (e.g. seen with mips) do
not raise warnings, but on powerpc there are redefinitions changing the
value, which raise warnings and errors (if using "-Werror").

Guard against these redefinitions to avoid build errors like the following,
first seen cross-compiling libbpf v5.8.9 for powerpc using GCC 8.4.0 with
musl 1.1.24:

  In file included from ../../arch/powerpc/include/uapi/asm/errno.h:5,
                   from ../../include/linux/err.h:8,
                   from libbpf.c:29:
  ../../include/uapi/asm-generic/errno.h:40: error: "EDEADLOCK" redefined [-Werror]
   #define EDEADLOCK EDEADLK

  In file included from toolchain-powerpc_8540_gcc-8.4.0_musl/include/errno.h:10,
                   from libbpf.c:26:
  toolchain-powerpc_8540_gcc-8.4.0_musl/include/bits/errno.h:58: note: this is the location of the previous definition
   #define EDEADLOCK       58

  cc1: all warnings being treated as errors

CC: Stable <stable@vger.kernel.org>
Reported-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
v1 -> v2:
 * clean up commit description formatting

v2 -> v3: (per Michael Ellerman)
 * drop indeterminate 'Fixes' tags, request stable backports instead 
---
 arch/powerpc/include/uapi/asm/errno.h       | 1 +
 tools/arch/powerpc/include/uapi/asm/errno.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/errno.h b/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/arch/powerpc/include/uapi/asm/errno.h
+++ b/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
diff --git a/tools/arch/powerpc/include/uapi/asm/errno.h b/tools/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/tools/arch/powerpc/include/uapi/asm/errno.h
+++ b/tools/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
-- 
2.25.1

