Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B39C433FF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 10:20:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C532070D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 10:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C532070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45xwgD33S3zDqJY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 20:20:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.65; helo=mail-lf1-f65.google.com;
 envelope-from=yefremov.denis@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45xwXf1mPqzDqJR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 20:14:42 +1000 (AEST)
Received: by mail-lf1-f65.google.com with SMTP id u10so2887842lfm.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 03:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BsIPSvfzLwnhnLKtcEHLG5y6k186GA8GW/6JbbfPnA4=;
 b=ZzAut6bTrqjv/wLDFPeOHJzOlvS1sG7zNAiw0jZcGGOS4DZMRAap93nPqspc2cnFbg
 KCefp02dyMiieRPPYcD0J9YOJvtw6bctyRXWQJaoReYYR3VA77sE8cqP7VUNhhEenxON
 4AHK1YJViGIUoAyIDFCYxs9FTbSPXasXBA8X4zDzd+o4l/bsZ/gbETKb2Bn9pYnNbZpd
 ilXcjtAkLQ0IrD5zoXHctaSe6SrNidM+8YQD0Gi4XPod6ytxtANTg02iTwOdjyVShjJu
 Poxxez/ByG62igConzEe0NSdJ+IJ/cRflhnQ/KFFcCmKVr4JCa3s17+yLeg8Ip0ThE7M
 AbQA==
X-Gm-Message-State: APjAAAXJsf1ijkp9ZWjBVXTaV/rmfQNeyDwqdMycC7JBhzwJJkaWM0c6
 wut2hwpeIDsNIuGdwC9N+tY=
X-Google-Smtp-Source: APXvYqxAitsCCS/HFPR7uHO4tOhzGp6jjCagTQ9NCr3/Ull+T3hU8+UpiyoxWae7OFM9Qe0aQhN3uA==
X-Received: by 2002:ac2:5492:: with SMTP id t18mr53096046lfk.41.1564395278677; 
 Mon, 29 Jul 2019 03:14:38 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 03:14:38 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/5] powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date: Mon, 29 Jul 2019 13:14:00 +0300
Message-Id: <20190729101401.28068-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729101401.28068-1-efremov@linux.com>
References: <20190729101401.28068-1-efremov@linux.com>
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Denis Efremov <efremov@linux.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The function pci_resource_to_user() was turned to a weak one. Thus,
powerpc-specific version will automatically override the generic one
and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/powerpc/include/asm/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 2372d35533ad..327567b8f7d6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -112,8 +112,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long size,
 					 pgprot_t prot);
 
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
-- 
2.21.0

