Return-Path: <SRS0=IsZE=EK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA0C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 19:41:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF5B206F9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 19:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQEUFgF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF5B206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRH8Z4BXGzDqP6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 06:41:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wQEUFgF4; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRH352xYHzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 06:36:49 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id c18so3512906wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2020 11:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sW45qqqQ6addDuh9wJMdphmMJUrhr2wEdPzjio8U9Vc=;
 b=wQEUFgF4ft5oi40ft9oy0bhvwfOdzDGjDBQ2fN+SdQlJfJkX4r7TwxYmkN+KP3GKDd
 LsgCPgefHaUlqOeA/qv4qxZDrkGs5AiQ0cWMRRVNnjniTVbXT62KAywGPD5My9rthOSm
 Wrixjs4a/HrBE+15gf2Y1suPR4vriY31mY8VmG4H4PLLx9rD4L7b+F9R4CbJaVbOXru0
 uRPRENrjej+ej4wW8TpmeUl6Ux3P3uRoJzL3kIeasmK0vn/SO0n47mgK9Ck3ed8n4bSo
 JgtLWi13TuJIt4UfgUH6hOkpEPoycwlNj0hjAKUL1eHeBEHdo0lIovfcLeONIUAllXhT
 LBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sW45qqqQ6addDuh9wJMdphmMJUrhr2wEdPzjio8U9Vc=;
 b=hejkekDDscFSj4oRC0RgjY4i24JajQDedzkqVm2Fkl7LSc7cPcIm2qw5nMo01G0Vne
 ihVvUVs6YFw7MG0hLq5IL8kIV9QGx3glIt43yX4t04058pYozNvOeN1cYSNIAiut5mlt
 44c019FJgc3BiThHRZy6kfyy/JYCiiTxEV3YVgQ9UeWXLk/YMxKWmUv9B6qT8O/vsasQ
 APNZmPQJ+qcp0NPCBT96ukp/X6AAF34BJQRbkxD4pFwDU4cdVTU0NkSSVCv15xu0sZ2J
 aDE87ZJNmbC+IbF1f5X8ETp4OJFBMG2ZJr0jS1B9E0StHaBOKJaF4BqO6MSVFaGOtb22
 /8xA==
X-Gm-Message-State: AOAM531z/vjHrmei5+1aXMsTt/LM5HG273CqmN19y+ZMCDcnHvKUb9QT
 gamHzdogG38cIhNCj5jNkFH7/g==
X-Google-Smtp-Source: ABdhPJzS1GNCL1q4lGL4YRttHLZ6psOrCrvvSmz+bUeyN+dq8yTpxhmAygyPOyuFG9pbUEAALMHMXw==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr6094659wmh.72.1604518604614; 
 Wed, 04 Nov 2020 11:36:44 -0800 (PST)
Received: from dell.default ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 11:36:44 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/36] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's
 prototype to shared location
Date: Wed,  4 Nov 2020 19:35:44 +0000
Message-Id: <20201104193549.4026187-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_vio.c:385:13: warning: no previous prototype for ‘hvc_vio_init_early’ [-Wmissing-prototypes]
 385 | void __init hvc_vio_init_early(void)
 | ^~~~~~~~~~~~~~~~~~

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/powerpc/include/asm/hvconsole.h     | 3 +++
 arch/powerpc/platforms/pseries/pseries.h | 3 ---
 arch/powerpc/platforms/pseries/setup.c   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
index 999ed5ac90531..936a1ee1ac786 100644
--- a/arch/powerpc/include/asm/hvconsole.h
+++ b/arch/powerpc/include/asm/hvconsole.h
@@ -24,5 +24,8 @@
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
 extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
 
+/* Provided by HVC VIO */
+extern void hvc_vio_init_early(void);
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_HVCONSOLE_H */
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 13fa370a87e4e..7be5b054dfc36 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -43,9 +43,6 @@ extern void pSeries_final_fixup(void);
 /* Poweron flag used for enabling auto ups restart */
 extern unsigned long rtas_poweron_auto;
 
-/* Provided by HVC VIO */
-extern void hvc_vio_init_early(void);
-
 /* Dynamic logical Partitioning/Mobility */
 extern void dlpar_free_cc_nodes(struct device_node *);
 extern void dlpar_free_cc_property(struct property *);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 633c45ec406da..6999b83f06612 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -71,6 +71,7 @@
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
 #include <asm/dtl.h>
+#include <asm/hvconsole.h>
 
 #include "pseries.h"
 #include "../../../../drivers/pci/pci.h"
-- 
2.25.1

