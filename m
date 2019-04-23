Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A60FC282E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:50:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8046217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwlfpBPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8046217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbDx62mwzDqSD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:50:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kwlfpBPF"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTby092XzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:36:29 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id ck15so7802627plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=64xazSolKvbAkmeK33oc5VYzPUgesF2xpW5xUbGcjt0=;
 b=kwlfpBPFGUAMOA3hImN/0Fr1fvXoRwFhICv0Lsn0HuDvPp0B9eYoqyrJPbnCBxyzJz
 skXSdkDtMK0LSKBEtS7cA4Fls6NeXTdb/VHGZeBPVmcCdaY5bWjDtEKYAo+srZ5sYWhO
 57xtC68acrC+6aLOLoWZynxTbf/93Ox7WVGKWSbb7JRZ0eXxHJOoT1YTDa6HB/+6BUDP
 QJD2VpOsawF6WWU3HnGy7nZkhr7lAOHwW9B3Rp+bKkWbhgOWSzmugM5RKK7U0ipwcWay
 MLHp6zpxWJIUEFzCQPZkBE0NWduoPyQYaBF94y5uSdLlNOvBHSOvw4NrH7zs8i0FPPRq
 DlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=64xazSolKvbAkmeK33oc5VYzPUgesF2xpW5xUbGcjt0=;
 b=dlF0aeFeZCPfbtML6XskuK1cJd29RTCP+YobmCYiWizsxUgKJoqN5XXK5d510KBwem
 tEyZutrUPoQFKiBqcGCRky8C1AkLc9XejN05RZD6QP89QlITS1EpDj3wGzePM3ai5ncc
 6SnzsJqygIy29Qb5DUa/WULr+Xnx5RJ/CA26BFxg/0uLpBbzibv3Z7GW2YuhpEuWskkL
 OhS1jB4qlffThgceI5tvrmV1O3Sq8VPv9VcU7iwo1WBv7uZNu3caVQMlSt9wU1t3ImEu
 T9zRbhNrAV+C9c36kGZacTmre7a7NArMUiGsx7i+JjwsiAg6Bvn9IoVv9m0M1Sy/I/yc
 eLZg==
X-Gm-Message-State: APjAAAW0r0Z+moL3bUApPiNT6SHh//bsanm5sZ2h4+EV/vWrVsQPvzP7
 8TBykp0yJ8W3pHHr7TDEyp0=
X-Google-Smtp-Source: APXvYqwbiOQ4Eh7U2IuTyJKPYYO1VwIcE2waf/RHXY5SnGUuxOhD94nb3bmdijZZMnK9sDeGZdyHyg==
X-Received: by 2002:a17:902:9004:: with SMTP id
 a4mr17769704plp.223.1556037388040; 
 Tue, 23 Apr 2019 09:36:28 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.36.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:36:27 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 37/63] Documentation: add Linux x86 docs to Sphinx TOC tree
Date: Wed, 24 Apr 2019 00:29:06 +0800
Message-Id: <20190423162932.21428-38-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:32 +1000
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

Add a index.rst for x86 support. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/index.rst     | 1 +
 Documentation/x86/index.rst | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/x86/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index d80138284e0f..f185c8040fa9 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -112,6 +112,7 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
+   x86/index
    sh/index
 
 Filesystem Documentation
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
new file mode 100644
index 000000000000..7612d3142b2a
--- /dev/null
+++ b/Documentation/x86/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Linux x86 Support
+=================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
-- 
2.20.1

