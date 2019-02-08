Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37435C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:13:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A631820869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+3gFJ1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A631820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgHK58gMzDqVl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q+3gFJ1K"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9g1LzFzDqVY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:22 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id g9so1001628plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p29IIJsFkSy/VtH97jDQ0kGu4yH81gkI6nxy4VVUxBE=;
 b=Q+3gFJ1KwMRZSoIxFi04JqDBmkEcfGOMjffIin60cp/+4JD0B4YuOsAooe0RwpsNWH
 f2UdmufY2otumiDcwt+VQmfdGpTntvXPk8cVw5gNhDnCKHWUujb1j3XnUw2NBQY7j3P/
 6DaH7LtPQAx0RezRSdeOuWQ/2DjjClsHRaM4OtuJdp5ggJ/1ABRbpvwApm5WEaJndn7U
 CS6i3JWppolDLLC7Dkgw2LWIQD2lufbrLNeptkiSWu/LkMMLXUJn/FOmQvDG8ur1k4PQ
 O9IDHfUacWRgz+2Q2RhoPOIYY/wD+sqdNeMeWrLgCMI8q+cIDSRuV8mkTPVyF3aWs99d
 mg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p29IIJsFkSy/VtH97jDQ0kGu4yH81gkI6nxy4VVUxBE=;
 b=MMMpczYqrYX0r+UA8rkBSnjC0yJJbgNxnEGz2C9ylsU0cjiKo45sVHHKIzyCW7MUFK
 YjSpiReiH9UGjHQvN2Y7xCpxcKDFYwLskt3pe3iw1JgPnZ/ZWVMJcPUJmw1V4Oou/DtC
 XWbFmP0p1XlA6qMl6jYcqR8jpOe5bCD+GTl/sFM6SY/TYVx1uKsfvR7dz1yWDrXly21/
 qMbdqhZ+g1Ak3idyqAwZzmdGPhBZp8US+XMFnWtx6wgwIxdUBtfrLCW77Te+4WFWmtRm
 MzgyuXJ9XoDJo+yjOPKcwOKQVRZhdzIokXy0zbf6E6b4ggfvqo/AR1HqBJotGF5OpmX+
 5c5A==
X-Gm-Message-State: AHQUAuZMPr9jODmDrKKAyRGZAiqmWNy481pnOejuY/Md5rmx3QMFOG9a
 PX3dQM4r1vTnvTv7638jd4vo4TLe
X-Google-Smtp-Source: AHgI3IbU6Q5ohL9cYWZ/EeC1PeY1FE6KzaUNRhqgORg+CQ5tZSc8Ee45SV82ynM/EWlUJAw7FwgtIQ==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr19674314pls.322.1549595301091; 
 Thu, 07 Feb 2019 19:08:21 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:20 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] powerpc/eeh_cache: Add a way to dump the EEH address cache
Date: Fri,  8 Feb 2019 14:07:58 +1100
Message-Id: <20190208030802.10805-3-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208030802.10805-1-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adds a debugfs file that can be read to view the contents of the EEH
address cache. This is pretty similar to the existing
eeh_addr_cache_print() function, but that function is intended to debug
issues inside of the kernel since it's #ifdef`ed out by default, and writes
into the kernel log.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh.h  |  3 +++
 arch/powerpc/kernel/eeh.c       |  2 +-
 arch/powerpc/kernel/eeh_cache.c | 34 +++++++++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index c003628441cc..fc21b6e78e91 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -460,6 +460,9 @@ static inline void eeh_readsl(const volatile void __iomem *addr, void * buf,
 		eeh_check_failure(addr);
 }
 
+
+void eeh_cache_debugfs_init(void);
+
 #endif /* CONFIG_PPC64 */
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_EEH_H */
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f6e65375a8de..d1f0bdf41fac 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1810,7 +1810,7 @@ static int __init eeh_init_proc(void)
 					   &eeh_enable_dbgfs_ops);
 		debugfs_create_u32("eeh_max_freezes", 0600,
 				powerpc_debugfs_root, &eeh_max_freezes);
-#endif
+		eeh_cache_debugfs_init();
 	}
 
 	return 0;
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index b2c320e0fcef..dba421a577e7 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <asm/pci-bridge.h>
+#include <asm/debugfs.h>
 #include <asm/ppc-pci.h>
 
 
@@ -298,9 +299,34 @@ void eeh_addr_cache_build(void)
 		eeh_addr_cache_insert_dev(dev);
 		eeh_sysfs_add_device(dev);
 	}
+}
 
-#ifdef DEBUG
-	/* Verify tree built up above, echo back the list of addrs. */
-	eeh_addr_cache_print(&pci_io_addr_cache_root);
-#endif
+static int eeh_addr_cache_show(struct seq_file *s, void *v)
+{
+	struct rb_node *n = rb_first(&pci_io_addr_cache_root.rb_root);
+	struct pci_io_addr_range *piar;
+	int cnt = 0;
+
+	spin_lock(&pci_io_addr_cache_root.piar_lock);
+	while (n) {
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+
+		seq_printf(s, "%s addr range %3d [%pap-%pap]: %s\n",
+		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
+		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
+
+		n = rb_next(n);
+		cnt++;
+	}
+	spin_unlock(&pci_io_addr_cache_root.piar_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(eeh_addr_cache);
+
+void eeh_cache_debugfs_init(void)
+{
+	debugfs_create_file_unsafe("eeh_address_cache", 0400,
+			powerpc_debugfs_root, NULL,
+			&eeh_addr_cache_fops);
 }
-- 
2.20.1

