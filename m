Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3CCC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E11220989
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 15:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU0KqAQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E11220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439fkS30GBzDqlV
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 02:33:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pU0KqAQd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pU0KqAQd"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439fNm0scbzDrL4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 02:17:44 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id c72so322178pfc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 07:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lzBd5ZYbLcRIJ/+mPtoYo7L9hb+UwndyxJFAHZSiy9U=;
 b=pU0KqAQdCppImSzuo/m3e90cf+kPGnD2pYWOHWCaZzYtriQyorfDhBnRxR/V40BJSt
 XbGoRJRi0fFLSrrY/dZYn7cJi/9v9gyRGBu6vICsevsqEW25jHfnOEfyAtLBxem5uFqH
 6ixOdOy/BJlj4c+ejaC3MBNs+pt8vzPtiL3COeEZdIHMnso6Y4B1jo/tW8xJF6/KzxaW
 vmXzF6bUfai/gtPxnVM3yx1v9MGtQJOEX0jQB/heH5MbEtAX+MDsubYMR8UGzvhx/Trs
 S6u9vKHZy2jC+cEOxGGTuDUeLHt/X5bAM5U+UHv+hr9V8ssYAkUDYWvLi+lgtNrS/1GD
 VwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lzBd5ZYbLcRIJ/+mPtoYo7L9hb+UwndyxJFAHZSiy9U=;
 b=a//2dbGg/l4IGtMktg0GNhSW0ISgZu20/oHm46171Wkr59hx2BcXwFvzKPePmHfZLx
 WIBklEF5DH/KSr6zPTGDOHFDZNecw85iFI8gbQ+ieJRdh7IThkyWTo626NOoIPi4YGFo
 wdT1HC/shBpXhlZAYKvMBAa4UkVDZcsstTPARfa+QVNb596q8hEct0wNd0WlMDaPAMrZ
 D1Z4KszrDcun5NDqOVHWwpwlct6YLlpGikuanTE6La1Hzfvlf9wfQ4PniXkqhKLYJD+c
 fskBF0h3VGCXFdjS/+4rBjf/AkMBd2PfddV1/7t9k1yhlaFY0UOIEjH0UJ+x3PnBFFP0
 GF8g==
X-Gm-Message-State: AA+aEWbJ2nez+39x0p9a9RAm62XxcbWy7EZGOvjfRVldp6aA2l71PAwz
 JxwsrvG/+/POFW6Q2Xy8gbDRJfv7
X-Google-Smtp-Source: AFSGD/Uk+RQLxjLXJyFhpKpC94nmpOYzRJwdMt6JyLVjchM7hDsv3cmyCKuX5SfiuDpipkpMx/KCOg==
X-Received: by 2002:a62:2044:: with SMTP id g65mr28694534pfg.127.1544109462183; 
 Thu, 06 Dec 2018 07:17:42 -0800 (PST)
Received: from 192-168-1-15.tpgi.com.au (60-240-78-224.static.tpgi.com.au.
 [60.240.78.224])
 by smtp.gmail.com with ESMTPSA id v12sm821546pgg.41.2018.12.06.07.17.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 07:17:41 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/7] powerpc/papr_scm: Fix DIMM device registration race
Date: Fri,  7 Dec 2018 02:17:12 +1100
Message-Id: <20181206151714.28494-6-oohall@gmail.com>
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

When a new nvdimm device is registered with libnvdimm via
nvdimm_create() it is added as a device on the nvdimm bus. The probe
function for the DIMM driver is potentially quite slow so actually
registering and probing the device is done in an async domain rather
than immediately after device creation. This can result in a race where
the region device (created 2nd) is probed first and fails to activate at
boot.

To fix this we use the same approach as the ACPI/NFIT driver which is to
check that all the DIMM devices registered successfully. LibNVDIMM
provides the nvdimm_bus_count_dimms() function which synchronises with
the async domain and verifies that the dimm was successfully registered
with the bus.

If either of these does not occur then we bail.

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 90203039dee8..871b386dd4b2 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -223,6 +223,9 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 		goto err;
 	}
 
+	if (nvdimm_bus_check_dimm_count(p->bus, 1))
+		goto err;
+
 	/* now add the region */
 
 	memset(&mapping, 0, sizeof(mapping));
-- 
2.17.2

