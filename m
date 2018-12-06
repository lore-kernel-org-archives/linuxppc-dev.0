Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92310C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:22:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093B620868
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxMCU5Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093B620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fVH66gpzDrPB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:22:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxMCU5Zj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxMCU5Zj"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNY680WzDrJf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:33 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id g9so312376plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1Tqps1caDm6LnBcfACof6EXbBukiLDkZzP348o6r5kY=;
 b=DxMCU5ZjtKIdCjAzA96jsOcbmOP4vjL5w4Qq6bb8dg5HDOrNrb52VLcNE0CnmMdi5Z
 pgmVcRBtaJpkKOclXhZ6rg2C2gWjvwLz/NhXZN2xLAgMzX68bRlUOPAPQTD1ScOXihzY
 4Rh5uv/1ScQaeJL0onm8vhVmieBgri/G8cM8ZAFe6CEGSRA+Lwjw7gR970a3JZ4P0/Lb
 GYr3Q1Gk0H4HHw9ow5k0zWTMQE8NSoqIEINDQvrFRjOYxYINOoVW5Qk3DzpKmvjE4aJ0
 sQGRNKoBMwksXta0uH2DtoM70rpQF1ehOqpvJfIrvR+f0RL87P66y2SVmRNa3Af0nXud
 yP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1Tqps1caDm6LnBcfACof6EXbBukiLDkZzP348o6r5kY=;
 b=sa7DwzoZtBtNh9ESvdy5t1wBPNTnYUOwKcPH+qWd3HEHa7CbFNBEwRXAT+1+HFJ4BR
 rG/CtgGnHMZNy3HMpZiOjxeyfl2rGNhVybeb3KksiIB088V9hGJxPe101LFEh5spVWYz
 SB0tM5bx73aS+QOn+gLdX8FP1kghHGlGnIhcNOH6ujI2MUSWQZZP5borykzTbyNlCfHW
 tVw9tzOEi54RPLYNjvWsTC6fmhX6LzRS3l8kWWqRfyYZq77fply1W7fRbnS6FPSMGqVK
 vmTKfKqdCYh4cusukJJcyofO/0dR1/qzu/B+FPOJxP6cG8G/yrNze3G35isJ/ZvhrO3i
 pQBQ==
X-Gm-Message-State: AA+aEWYpcbk+RoCuLYnVamgkZN5Yde0BbZDWSslNmGczf0Uw+KbD9VU7
 EUZ5gt8Lch6ODBBf/toLKa43eTvA
X-Google-Smtp-Source: AFSGD/X3quP8QL6hmQbG1NztRkTAglCf0+0eDy8hkRPiOn9mmvfrBXkE7Uese96erCTLN0HWznxlRw==
X-Received: by 2002:a17:902:b112:: with SMTP id
 q18mr28616271plr.255.1544109451741; 
 Thu, 06 Dec 2018 07:17:31 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:31 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/7] powerpc/papr_scm: Use depend instead of select
Date: Fri,  7 Dec 2018 02:17:08 +1100
Message-Id: <20181206151714.28494-2-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181206151714.28494-1-oohall@gmail.com>
References: <20181206151714.28494-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Making PAPR_SCM select LIBNVDIMM results in circular dependencies in
Kconfig when another symbol depends on it. Fix this by replacing the
select with a depends.

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Reported-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index ed91c9aea78e..e31e397003b3 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -141,8 +141,7 @@ config IBMEBUS
 	  Bus device driver for GX bus based adapters.
 
 config PAPR_SCM
-	depends on PPC_PSERIES && MEMORY_HOTPLUG
-	select LIBNVDIMM
+	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
 	tristate "Support for the PAPR Storage Class Memory interface"
 	help
 	  Enable access to hypervisor provided storage class memory.
-- 
2.17.2

