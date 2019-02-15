Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25099C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:03:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9761821934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkEB7amK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9761821934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440w3l40WWzDqbx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 12:02:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkEB7amK"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vl736S9zDqYq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:35 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id y10so4072075plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XeoTmhYLPp8tjhT8rF+9QvptO7KsQbcTvhlh4PdpM8w=;
 b=AkEB7amKqM3ggfc0r7zWMX874g2uHqQyaHObd/bTOlxBLSUSeD3NCbW/5cIHCmLalq
 sJigDhxlYiGHp1VreS4GL19LSqPzV+hNt9O89S+Owwt/TRDceg3MK871pgetrF9A2Ezk
 Z6U9oxw4R1xZnsWM37zZCXXwfUaiYamn2sCHBRNri9xlS9jWFRU0dr0/2A/kYtFC6JlY
 L+GDHTx3e+mtLyqW4syiTRDChrYNFB9s41+mGdcfsFFYRisselSAo7yuZOvAeOuhPrt+
 DczwgnORA8U/lFWrfHfGPwg1Tlgix4W3i+2T4eXYxDDhcAzVGKHmi0Kq1BC2ETsjBJHZ
 wwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XeoTmhYLPp8tjhT8rF+9QvptO7KsQbcTvhlh4PdpM8w=;
 b=bJn++5Z4ZKm/8+eWWnSjc+ZVrGaNUmJBbRnT851axLjyjCMxGbV/Kkzspatk4S+zyl
 FN5col3EtfICE3PwG1R8EEacg4O2O6s+6B7j2tVGZF8IBCVP+ksUpWL0pud2/hWoNNtA
 dyhJ0vAlTiqmC+c/1zC0notHdku0H2xQ6hyf/DZYN7ahfcLOb1QrF0MegED22tlAPvhz
 4+vnc4T68uDKi9P0Ciyui1u32WjcaaRy4mQIfjdvu7K9/DMTwEaN49nMASHQPcTNsbb7
 aV4IY/P+pgfnNKT6sDmrwXLO4YX2BTer6hweWbOBV9Uvn1iog/Vj6ai/QekQ8RkO4Grf
 QVTA==
X-Gm-Message-State: AHQUAuYYNWwdhK+eKeleIHcvv8MczLiuYX9k8H4nrlPdsRqzXMdTHjpK
 7p6/88WwF2q5o/col+FZAGCqh4Wb
X-Google-Smtp-Source: AHgI3IapROeXXjhXpKJlhXIczouY6Top7HqODOBTg5BMjnWAOB1UrkFO79FUgE3XcN5uELw94ZFu7Q==
X-Received: by 2002:a17:902:7608:: with SMTP id
 k8mr7052132pll.245.1550191713259; 
 Thu, 14 Feb 2019 16:48:33 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:32 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/7] powerpc/eeh_cache: Add a way to dump the EEH address
 cache
Date: Fri, 15 Feb 2019 11:48:13 +1100
Message-Id: <20190215004817.19961-3-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
References: <20190215004817.19961-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
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
v2: Added missing #endif
    Replaced while loop with a for
---
 arch/powerpc/include/asm/eeh.h  |  3 +++
 arch/powerpc/kernel/eeh.c       |  1 +
 arch/powerpc/kernel/eeh_cache.c | 30 ++++++++++++++++++++++++++----
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2daecd677855..478f199d5663 100644
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
index d021f5abeec5..82d22c671c0e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1810,6 +1810,7 @@ static int __init eeh_init_proc(void)
 					   &eeh_enable_dbgfs_ops);
 		debugfs_create_u32("eeh_max_freezes", 0600,
 				powerpc_debugfs_root, &eeh_max_freezes);
+		eeh_cache_debugfs_init();
 #endif
 	}
 
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index b2c320e0fcef..5c5697cced41 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <asm/pci-bridge.h>
+#include <asm/debugfs.h>
 #include <asm/ppc-pci.h>
 
 
@@ -298,9 +299,30 @@ void eeh_addr_cache_build(void)
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
+	struct pci_io_addr_range *piar;
+	struct rb_node *n;
+
+	spin_lock(&pci_io_addr_cache_root.piar_lock);
+	for (n = rb_first(&pci_io_addr_cache_root.rb_root); n; n = rb_next(n)) {
+		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
+
+		seq_printf(s, "%s addr range [%pap-%pap]: %s\n",
+		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem",
+		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
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

