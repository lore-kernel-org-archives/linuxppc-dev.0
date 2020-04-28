Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBEDC83002
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 01:54:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0DE206D6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 01:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMYpTRpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0DE206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49B4Sy67w5zDqkJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 11:54:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=hjl.tools@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TMYpTRpZ; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B4Lq3QRzzDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 11:49:07 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id k18so7709857pll.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2020 18:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VjlmInaD+CunQni2gwfodUVCdw5wBkcVV++SAKGDNm8=;
 b=TMYpTRpZpgzQQDLuoRXsivuHFnJ3XWrpG2C4ZITMWd/5oh0i2Znf5NqQ7fqOkDgDpF
 yN2ifB8qy33yYemkK1J0Obs96WwYHPwRXwCGRReufe6J67kiKKQIiqjYvzPw5YyPIgg7
 j9RmdRt39k3xuue47Pm2I8drGtaFUblkQF4ukd9PS+36BU3hZxxKBIxt1hlFpm3Cf8xA
 38QpgdLaGab8FnQVjsUc9I7ShA731CpqWUnzD/9W7FivUdiKRV6pA96Hl5DRWOm/SffF
 EeK4hIUOFv2IOIUxZdn1RyJjYTFEn/aK7i95uwKD2BNMweQKRf1CGLBjavDulW9HzbWu
 gQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VjlmInaD+CunQni2gwfodUVCdw5wBkcVV++SAKGDNm8=;
 b=DtesVGMyr+L2CgWI0CB469gp98lJ53upUKZbqxo3sZX1QtweuBJBpvZn8gDC6qUAn7
 YUJ9OVm63rrAq7m5YF3uV1Oeob9U5q6TEjPDLiFlVela9qd+2uFs8B6rG7cVMh7cKLvg
 LQDLs105h2IOvWwLSr4sK/rFuRLNipw56oI+VGWdx3UPArNeTOLnp2Dh3hHDtjwJBmVR
 PoILmiOYkoND+bWgyCAE8CBBnMjuNMJ9LNKYo9LzgsG2Pe0c748D+/K0oycbKQBIvoyp
 uVk7svJVQqXS+fMyTgqHX9RRGqsV89SbLQXCeQVx47FUG29oAw5Jw97jLjAMHTTXhly1
 uqVg==
X-Gm-Message-State: AGi0Pub/Mh7wCyLba9LbJwf5aZdjMq2yfpd3913UGsOrBUAGnQil0G1v
 ZtqloxiE6FAgkLK3PB8pGD8=
X-Google-Smtp-Source: APiQypKW1jBhkcPIj1dIcDXG+vS4AuDRosNuBrsHzNoEKEhSnJE2syPk/CzYimYRQy8CXCNfjwstvg==
X-Received: by 2002:a17:90a:690b:: with SMTP id
 r11mr1983059pjj.119.1588038542547; 
 Mon, 27 Apr 2020 18:49:02 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net.
 [69.181.90.243])
 by smtp.gmail.com with ESMTPSA id 4sm14173285pff.18.2020.04.27.18.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 18:49:01 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
 by gnu-cfl-2.localdomain (Postfix) with ESMTP id 9054BC02BB;
 Mon, 27 Apr 2020 18:49:00 -0700 (PDT)
From: "H.J. Lu" <hjl.tools@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: Discard .rela* sections if CONFIG_RELOCATABLE is
 undefined
Date: Mon, 27 Apr 2020 18:48:59 -0700
Message-Id: <20200428014900.407098-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.25.4
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
Cc: linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Paul Mackerras <paulus@samba.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Borislav Petkov <bp@suse.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

arch/powerpc/kernel/vmlinux.lds.S has

        DISCARDS
        /DISCARD/ : {
                *(*.EMB.apuinfo)
                *(.glink .iplt .plt .rela* .comment)
                *(.gnu.version*)
                *(.gnu.attributes)
                *(.eh_frame)
        }

Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
change to discard .rela* sections if CONFIG_RELOCATABLE is undefined.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
 arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 31a0f201fb6f..4ba07734a210 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -366,9 +366,12 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .rela* .comment)
+		*(.glink .iplt .plt .comment)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+#ifndef CONFIG_RELOCATABLE
+		*(.rela*)
+#endif
 	}
 }
-- 
2.25.4

