Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF89C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:19:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B9A218B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC1WPwmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B9A218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbt823GVzDqQh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HC1WPwmI"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTfW5JqHzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:38:43 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id ck15so7805411plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9skjzp96cygvVz+1JSKV6lvwc3vgk2hHizbPglWd7s=;
 b=HC1WPwmIlG+hlyxRIZOH4CnRvVGwgWVa8brKz231nxL34WdA7oIv1fV5i09oVTPQZf
 HGb7skRKqQOEDwz7Nvih8QFEy8wtKy8dT/lu8CJ+eSB/mCx/vsNdhZQ2eHhSD6QHo2YG
 TuxotwAoJX08deAs0U38LEGdW6TiWo/Jj7iSaEcRvY0nmp38CIEY4/H5B890tE45wqyF
 HsZfKjucwW1hqfafZ6YstpPJ0y6Xkfaf/2btpDk3ncRlqLjR57n6TQR8GhbrVGm1cAKR
 +jB4LseocMLJWC88f3+dQQ1dTw4PG93BGi+/ScqkZy+AW2l/SYsh6i6jGWQXmL68+cHS
 nokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9skjzp96cygvVz+1JSKV6lvwc3vgk2hHizbPglWd7s=;
 b=jt2Yd6qX5Bzi4isEC37worvD834qk0z4b3nR1/tbM16LTrsmgu0sLqnot0PvVY4hR2
 eEuNbBI/Awz+lyvkUUuEtOE/HYX54CIC2oFDJNUPXTm0Ak1AaepTD+p3JRMzW0t2e4ad
 MWXQTLlMJ+Blt9Ji7pMlvi/haJDR44esUzC3Gvh1/bCIuiv3yqyxoMXBGKLPIqrnsuQG
 +jvNPkQTy8DyliAK8BOyMniOsYzweqA3DB0tkihNOcw0ghOeutj2ukDojaWImqHKrSbC
 6+7ZNd3cKLhrVoLHTiSBa7DzLeniP0sKhzwYDkN35VE5Iu3EtT20eFikpGXcLAa1rIR8
 aHcA==
X-Gm-Message-State: APjAAAX7+7dA+Ua7SIwDq4pR/jhvb3UtY37XliLBOSz7wOpLZfiN6VAg
 vplOX1owjHAKVwOESjGoCXk=
X-Google-Smtp-Source: APXvYqxW4QBYEj4LOBC2F/7Xh+EtfVt86Gw4890OAPE41pEAwNvEos7lM78G5yOaeekXq29BA133cQ==
X-Received: by 2002:a17:902:6949:: with SMTP id
 k9mr26582784plt.59.1556037521465; 
 Tue, 23 Apr 2019 09:38:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:38:40 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 55/63] Documentation: x86: convert usb-legacy-support.txt
 to reST
Date: Wed, 24 Apr 2019 00:29:24 +0800
Message-Id: <20190423162932.21428-56-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:33 +1000
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
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst                               | 1 +
 .../{usb-legacy-support.txt => usb-legacy-support.rst}    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c41c17906b6d..526f7a008b8e 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -25,3 +25,4 @@ Linux x86 Support
    pti
    microcode
    resctrl_ui
+   usb-legacy-support
diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.rst
similarity index 92%
rename from Documentation/x86/usb-legacy-support.txt
rename to Documentation/x86/usb-legacy-support.rst
index 1894cdfc69d9..19abead7f1a8 100644
--- a/Documentation/x86/usb-legacy-support.txt
+++ b/Documentation/x86/usb-legacy-support.rst
@@ -1,7 +1,11 @@
+
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
 USB Legacy support
-~~~~~~~~~~~~~~~~~~
+==================
 
-Vojtech Pavlik <vojtech@suse.cz>, January 2004
+:Author: Vojtech Pavlik <vojtech@suse.cz>, January 2004
 
 
 Also known as "USB Keyboard" or "USB Mouse support" in the BIOS Setup is a
-- 
2.20.1

