Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34019C282D7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:56:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B8720869
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M14PhSzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B8720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sDVy3NCkzDqjh
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 23:56:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M14PhSzv"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sDSt4H5KzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 23:54:38 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id f188so8813905wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Feb 2019 04:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LzRibTrepdgl7Xt0hOi6YoBdYALZ45jbA83RBWJYnEM=;
 b=M14PhSzvkCE0QtOPiYvmCq/2BEcrLyIyQ80miyFXr2iDquOKEI+eXj/jKhbaJRcj7u
 fpQNdDNcC4sG7D6nyGtNbpl8tah5in7sa+ssfztYlFL5j+ZJp/dHkD9LWsC+fQSwVzwI
 FOzlSK1pnbFkh5riPVdCdfYpYgL4eUxPlKI/5VwBZYzaqqadNxUqNNdV6PjRjsE682Lt
 UYCZM1iDy+f+ej0C5prJLn/6/pupcEH6RoKYspatPOyqh2eqOxU3TdVSz1UeLSJHL9Ep
 q1t3kzkLv7wVsiC0dK6/rrCETWHs6ritpf+n8M75HGCVXI98Z16dMty0sGih2b/Brq0q
 pAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=LzRibTrepdgl7Xt0hOi6YoBdYALZ45jbA83RBWJYnEM=;
 b=H4Dv6pjn2v/iCMMVQ8KbyOknKdtpJc5uTA6835xiHWu2mp5fbhf+7SiGs1LiGPq4FD
 7+BM+iEkr70gqXp4gCwN2IZHSAKvUXL5h/yPgSOewIuAK7fHcac8b49tzbku35P9I5Df
 q3s6Z2H66nuKtQy8GsQTSiDnknMnjUM4XA8xMAOm+6GFVDeoTVdH9TuBhz7TAZ9Nwyzr
 rd1730HfxdDIrDMvdSCR5+Ewrr4MUvTUws7WTU0uRigJ8MElVcJsEn16QiwPfrHBM/r9
 BNqJvmuAVPqVur256rwIsmpLuFo6Pub5Sz7Ngdk/MD7JsDG0Fjst9gjBrmquhxlhRUZA
 CLiQ==
X-Gm-Message-State: AHQUAubWTAREx+Hu3WvrhpUcQxyBIYA16+H46du0q714ju9cPV2fsKGi
 FtYSMi7CdRc1nkdFhtp/SgM=
X-Google-Smtp-Source: AHgI3IYgUBw1L5pAhe1XFSnXYBK2wmlmAe4NLvD8vNgjIvvDsDa3/8I0xQG3oCGCeYifuIpmWy8y1A==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr6763146wmf.144.1549112075725; 
 Sat, 02 Feb 2019 04:54:35 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id r200sm10973814wmb.36.2019.02.02.04.54.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 02 Feb 2019 04:54:34 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 816621146681; Sat,  2 Feb 2019 13:54:33 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Remove trailing semicolon after curly brace
Date: Sat,  2 Feb 2019 13:54:27 +0100
Message-Id: <20190202125427.2309-1-malat@debian.org>
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

There is not point in having a trailing semicolon after a closing curly
brace. Remove it.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/sysdev/tsi108_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 1fd0717ade02..1f1af12f23e2 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -51,7 +51,7 @@ phys_addr_t get_csrbase(void)
 		const void *prop = of_get_property(tsi, "reg", &size);
 		tsi108_csr_base = of_translate_address(tsi, prop);
 		of_node_put(tsi);
-	};
+	}
 	return tsi108_csr_base;
 }
 
-- 
2.19.2

