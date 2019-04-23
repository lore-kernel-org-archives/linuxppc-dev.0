Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176EDC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:29:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8496B21773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4pAnp44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8496B21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZmw2ZnpzDqG6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:29:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4pAnp44"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTYX129rzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:34:23 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id w25so7755892pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YLehLOE1ABgy8jWFXPTFYcRWdLlFEjSaDVUOmHPoCTo=;
 b=U4pAnp44P0PSsqJ98jbweSjiy67o17Pd9PsGiJzfQCnzcNqMnueTSBofSe3eHuJU9b
 TCzZEp1720OAfACQnAfygosHxbzrQT/XrNS5CP/gIEwNq7Q+8kSigXvYCvre1DgFlGub
 ehGR8zmyYp2r+BStZbVGvWicy5PaLfRexCF0xJqOpuxxYJjlCUv+0znoY4VHUIrEMfZa
 xsBVpsYsTS7Vhta5FqBjgc7O+4W3GDsGJhpPpXSBpH7m1SXeAiFtOoWcyscTnL5AB7vC
 l1RST2gQTU/CZyk97kB6T1Q1dxugH7NTA5WkvHQq2gcezxvwAyCKN+OeSbMNhGV1Z5f4
 dqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YLehLOE1ABgy8jWFXPTFYcRWdLlFEjSaDVUOmHPoCTo=;
 b=VPeGmjTm55IGqUMq52Hd6uuSYCg2i6V/IDCLyB5/9wLhydALNRe8etybU84WpGXW+J
 VwRANb6H6Ujq5+GTUxzoZe7Pcd+vgxNUEMsnJ/Lbg/jC934dZbTZys/CsqMQqjR5/oZq
 bQjVreyRIojlI9C4c5vrGTA8F/g9pyL3woF8fub35jKCygDUUr8W8//miFsY2k5EkMLI
 rTvRmjOtG81DmZL+TyCF/v1iqn8WTcMbCmVbTfhB7KelHDuaxhmb9nwtoEaYx4EOhWdQ
 vQjwtZ9BPqIpZpvIqplEirTNhreLLfNCee2mNb/+TwCjOpjcFVUBD9LPckQXg7WAH7l8
 BCAg==
X-Gm-Message-State: APjAAAVjfkEmIFJ32PFRN9ArwZBd+EZknDsHoG5+zXd2jjwhXENtJyAG
 OoppM9OarX7j3PJJnaBlRrY=
X-Google-Smtp-Source: APXvYqwOnaUZCTkR7Hrbrv1qaIAVW1d7EU8d1K7h/wsG99DVbwKx3P6IvbLyZuV/vvVQ9mgc8M/mJg==
X-Received: by 2002:a62:7089:: with SMTP id
 l131mr28640994pfc.158.1556037261922; 
 Tue, 23 Apr 2019 09:34:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.34.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:34:21 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC tree
Date: Wed, 24 Apr 2019 00:28:54 +0800
Message-Id: <20190423162932.21428-26-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:30 +1000
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

Add a index.rst for PCI subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst | 9 +++++++++
 Documentation/index.rst     | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/PCI/index.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
new file mode 100644
index 000000000000..c2f8728d11cf
--- /dev/null
+++ b/Documentation/PCI/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Linux PCI Bus Subsystem
+=======================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
diff --git a/Documentation/index.rst b/Documentation/index.rst
index fdfa85c56a50..d80138284e0f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -100,6 +100,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   PCI/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

