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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE1C83000
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 13:52:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E70206B9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 13:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK6t9DDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E70206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BNPP0Yb2zDqCl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 23:52:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=hjl.tools@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TK6t9DDh; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49BMjL1YP7zDqVQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 23:21:09 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id x15so10685944pfa.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PSEugyT8Lo+1ZhrlvgQjxW4x141gV7dlNRE0LVKLu4g=;
 b=TK6t9DDhO7O5M8Wkv5d/JVPmoc86hlNKkMZflDwy1HMUs7qkqJloY5awfna3htZE9W
 FrNXue6aRyf9fIgeJoKbEztwoj9XjpjTcndnwtk3dYDNblnGIbiT9BdlqVzM233YH7TU
 wIVXo/gwIiYgst4VoWyQRblZ6DQRM2bj3JNiHI1zdzbJK+ykaYA4HSV3Ms5EM1bmwewp
 WCckB7DM+LYKDgeZPpNxTkIK8TAm1aqhbC9K52YMpua9jHspcbdtv8XIYhtU7tMWSqfV
 RBWf0cdfZEXQyQxXL8bJFRHI3BuUEz27vcAQI03rhEeUWZYlpdMaLqeXJ9TgblUUa8iH
 FPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PSEugyT8Lo+1ZhrlvgQjxW4x141gV7dlNRE0LVKLu4g=;
 b=pkhZ8ccOt0QszhTwlSZgmO1kufqgN7hFrXrijgVe7vIHDxfQ6BFLYI8vpA4M00AZ8i
 iRmWcAsITQnNBBmjXn0uC1Qv3MQHJgDuHNHi9emyvOYCyyV/6JxgAeDkuMlNkmi4Kcip
 quHgcm3hW9pFPDUS8R3v2n+2nPRdj+vo0Grrl+ZQhax2hQMOiUuAUn2rN0Ojo3jvt+/e
 PolWfBvv8D5YQtEUw57Pt7P/zLyGvyDp406r9ah52/xtY3tsMPzYR7HP6ws07+KZG7hf
 W74IHaPDtDnBByIA+kCIQQHWH3K3HIyTNHQ8RgX7CdNC9PZ5TyQSc63URSN65ds7tlIF
 UuMw==
X-Gm-Message-State: AGi0PuaUBqEGIXDmqgpcsqJW73jVHdtf7QQu3NpTeXm/MipMXSa1Vi3e
 3S1T5/ZrLnkT8x0Dq/1j+Ww=
X-Google-Smtp-Source: APiQypL+ws/Dz3L/EhqNygye/RUl8b5l213WFumblEyR9F4+FV4dhOzjSRUH8xgJH1SS2n/3TsqjVA==
X-Received: by 2002:a63:48a:: with SMTP id 132mr18429238pge.380.1588080067621; 
 Tue, 28 Apr 2020 06:21:07 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net.
 [69.181.90.243])
 by smtp.gmail.com with ESMTPSA id j5sm3587925pgi.5.2020.04.28.06.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 06:21:07 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
 by gnu-cfl-2.localdomain (Postfix) with ESMTP id 43EA4C0326;
 Tue, 28 Apr 2020 06:21:06 -0700 (PDT)
From: "H.J. Lu" <hjl.tools@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: Keep .rela* sections when CONFIG_RELOCATABLE is
 defined
Date: Tue, 28 Apr 2020 06:21:04 -0700
Message-Id: <20200428132105.170886-1-hjl.tools@gmail.com>
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

 #ifdef CONFIG_RELOCATABLE
 ...
        .rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
        {
                __rela_dyn_start = .;
                *(.rela*)
        }
 #endif
 ...
        DISCARDS
        /DISCARD/ : {
                *(*.EMB.apuinfo)
                *(.glink .iplt .plt .rela* .comment)
                *(.gnu.version*)
                *(.gnu.attributes)
                *(.eh_frame)
        }

Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
don't discard .rela* sections if CONFIG_RELOCATABLE is defined.

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

