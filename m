Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F5C282DA
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 01:57:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4A320B1F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 01:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sBV/YYyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4A320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cGrT3hHFzDqS8
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 11:56:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="sBV/YYyb"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cGpl02GNzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 11:55:24 +1000 (AEST)
Received: by mail-qk1-x742.google.com with SMTP id z76so6009989qkb.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Apr 2019 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=TmYQ7hFkjaBeCconcL7FY5cmVjdiG0ObsQxHd0Hzpm8=;
 b=sBV/YYybBMJg+IbMv0Bn3eyugsTpwOASRjvjBmcgA92WeTbWT5ZlMEJh3TM2auXwGU
 ear4C1AA2SPKcgpL7dA396DQkXirIUXS67wlmW89++4iu+6H4OBsiCTvWawNwD0FB7ZM
 AxhPXHIaE1viUkIvlvaULhtzm059uOuhFu0JCK4zA8mHzpVtOb5LM1bu7S3xY3HdiU2h
 sgLSQAqZU6pLTARXFoMtnLs3CmmLLSBakDy/DPiIFbjyy3AsMxd/1sxVCm47wRq6zQDu
 VeSsZOlDt/JRbdmrLahXvsy2S11LMiP5w54kttZ3qFFjUlyiAANDbhKI4iaOFegGad/L
 G6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TmYQ7hFkjaBeCconcL7FY5cmVjdiG0ObsQxHd0Hzpm8=;
 b=sHaF3uRoEYCnFWTgL9Eqar74c5dwa0u0yr6lOYaPeX47K4vgwck1WDqAxF0O24ozPt
 ih7Yheev9aGmvTLOmc10yy5VXmRjC7JFn31K6gU457qV5uitXg/mArDc57VQeJHKEKNz
 HGUs2pGOwZPQwtHhpJXxwGDYJVRTDST42QhaZcPkZpGV/ZEO+44e12TYhw9LZvLEhH5a
 SAVbtl/WJeRGfuVi0iI06YRL7NrpiqESHLTr8L7zGjDGredLBaNkzoE9b42QO7HsyJTR
 YX+Rd9QJuFP+GMDF5zpwF/phIUCmu+3FYencISFq8DPTivsvbc0dqFtQ+STkYzIf8nvp
 4N7Q==
X-Gm-Message-State: APjAAAXOThqNyF9x9tzqtub7GXdkA1Ipj8/z+gtRUANFWh3yxWwfCOIk
 iGw2xrGDT6KfEwJg3m4ZEzRUxA==
X-Google-Smtp-Source: APXvYqyeMwDlrefLZK6tvhMZ1SBBDwrIQ/U3yZLm87VAJniwapXmOCBm8dtIoJwMHKjnFME3z/o0XQ==
X-Received: by 2002:a05:620a:1646:: with SMTP id
 c6mr17645924qko.69.1554602121104; 
 Sat, 06 Apr 2019 18:55:21 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id 11sm18748299qtu.5.2019.04.06.18.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 06 Apr 2019 18:55:20 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org
Subject: [PATCH] powerpc/pseries/pmem: fix a set but not used value
Date: Sat,  6 Apr 2019 21:54:47 -0400
Message-Id: <20190407015447.39292-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
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
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, oohall@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The commit 4c5d87db4978 ("powerpc/pseries: PAPR persistent memory
support") set a local variable "count" in dlpar_hp_pmem() but never
use it.

arch/powerpc/platforms/pseries/pmem.c: In function 'dlpar_hp_pmem':
arch/powerpc/platforms/pseries/pmem.c:109:6: warning: variable 'count'
set but not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/pseries/pmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index 27f0a915c8a9..f860a897a9e0 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -106,7 +106,7 @@ static ssize_t pmem_drc_remove_node(u32 drc_index)
 
 int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 {
-	u32 count, drc_index;
+	u32 drc_index;
 	int rc;
 
 	/* slim chance, but we might get a hotplug event while booting */
@@ -123,7 +123,6 @@ int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 		return -EINVAL;
 	}
 
-	count = hp_elog->_drc_u.drc_count;
 	drc_index = hp_elog->_drc_u.drc_index;
 
 	lock_device_hotplug();
-- 
2.17.2 (Apple Git-113)

