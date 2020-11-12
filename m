Return-Path: <SRS0=rG8u=ES=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952C4C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 11:02:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73422053B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 11:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMDgKOJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73422053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWzG20wyJzDqyY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 22:02:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PMDgKOJW; dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWzB35ZpczDqll
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 21:59:06 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id 33so5513898wrl.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRCHYBSKer/DhncW1LEqcraDTStImfNIgO1yubNFQNU=;
 b=PMDgKOJWARNDQAWKNjRWYyoUhnMr4/vfaysnBsAvVrYhOuX0ypHnP4JUPS4NhD7PXc
 hQsqSt+b46W0Xpoq0cOZxSaAuu20SdmNs9imxHtYqpbpZ1NXvUFwkTQxfL5JLpSAVQjF
 569qusdZm7VtmkYdzj5mcQqnwm76DJU+02N4QdLb0fUcHPAQrmTUjy+irar9ChsRs6du
 E7xJ+fUHg63fDmQeSl/W3BWW2WK++L3Txca+rIuBSchDbjosc8FwRvVStmqtmULmr5Pa
 BejSG1IJQIweIMaelH78uIkLz9CRa1zFuvsGcKyIHgAnt1QesDmtsDOKedzeBgYFIm8W
 vDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NRCHYBSKer/DhncW1LEqcraDTStImfNIgO1yubNFQNU=;
 b=st2Jgs4qb6avJGdSmB2rXkzYVG8CXcKeLsdLtuG2vuzB45ZsjrVsh3GJl6DjX6O1iB
 7YF/rYLwP8DMn+wdhankjWvg9hP3YAlI/sMaK+//ko+RZg5yHK0tEPQuous3E0t8jlMU
 WUnpz1GS7VrO86DflhYpgd05ZaR4wsuJGVz849d/edxPyqoHcjA5rxn/9+InNfR7RZc1
 ZY0lcU4V6fg7NIM1iuNrgylG3myvBs5jUlM5ouqe8+GsHMT/YTEY6d4HiVy8EChtsyfd
 cxURvUR0um7dbtREkMFDffprFjujl5BS3L4u+IMMO8kGofkprFrayb/OB8xZiVnapXT2
 dorQ==
X-Gm-Message-State: AOAM531AVpp5Ud8JCIvzJe6i78vgX2xK/1Ng/9bR7lfhjAD/SUXNa2se
 AZhWciFwy6/QxsSL8IBEh3jCYA==
X-Google-Smtp-Source: ABdhPJyXxqSXwVkg2Ox5pxokrrElCxJ+dBD6xraCAU1vuEAqBAeCpJrjRyun+5dKCvYm5QU1CHa0JQ==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr34746566wru.405.1605178743922; 
 Thu, 12 Nov 2020 02:59:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 02:59:03 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH v2 3/4] powerpc: asm: hvconsole: Move 'hvc_vio_init_early's
 prototype to shared location
Date: Thu, 12 Nov 2020 10:58:56 +0000
Message-Id: <20201112105857.2078977-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112105857.2078977-1-lee.jones@linaro.org>
References: <20201112105857.2078977-1-lee.jones@linaro.org>
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
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hvconsole.h     | 3 +++
 arch/powerpc/platforms/pseries/pseries.h | 3 ---
 arch/powerpc/platforms/pseries/setup.c   | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/asm/hvconsole.h
index 999ed5ac90531..ccb2034506f0f 100644
--- a/arch/powerpc/include/asm/hvconsole.h
+++ b/arch/powerpc/include/asm/hvconsole.h
@@ -24,5 +24,8 @@
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
 extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
 
+/* Provided by HVC VIO */
+void hvc_vio_init_early(void);
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

