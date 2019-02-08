Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7910C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:11:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3560E21907
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK3tcaVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3560E21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgF837f1zDqVl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:11:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tK3tcaVz"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9d0rLLzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:21 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id s198so940569pgs.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e/bZztgTuRc6b6QMzo/bQ5CptpgZV2rogpTll22dfes=;
 b=tK3tcaVzEsOMiB7rMRxe/fDwJlL3s4eEGGVWV6BB9Rf7q5dLr5vkpjWJS0GMp5hbIL
 5TMEv9I+e3qlh2WgZTbuuyQrhBE8sH6YpYgqSti2Ra906zo/K7KUz58SDx5X8x6hUb7V
 lWS+OqctoPAtr1ymS6sJaYPvJ7MxbQrDRYAVlhhSIOcmQPp8ynnhjT/sAui+OaXpGOI2
 d0JVQu20xUp5/sqILPma5s30RdtbVIMENw2IXCXpnUJWO5iA+uTJs4z1hfPcARYEJUBL
 eZ0R3+SBHXcBkR6iCDsncLi8XXUw7fa0RjZEVOnK7bk7vyCBs7g+58rqtYQK+LcY7mG3
 LtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e/bZztgTuRc6b6QMzo/bQ5CptpgZV2rogpTll22dfes=;
 b=cMQcGUtWdI26ds/CHDk6fRITuHJQJTkbFB1OnGJaAq0Mr9tvNBtiU+4APu4xegHAPT
 EbzPnKqkQe17PdXosa+ZIeX3V1qWqKtOvZNKbqv9I2cZmrzwIR6hD7KE6vKc7Qrfs0U3
 JWnhux56m/Uy5YfJlWik+cen0K29jpjsSTMzAk7xvpdZFQc3A7e9UCBxixoz6NUadY9e
 BKUjx5MVkHUJ/4MbsN/yWqdzhjeiZiAVncYHp6dozY6/7OfEyU+fxS7DgC6EZ+Afem48
 E3CpQ43Ce+RQ8biF3pQfD7UelXvCD0P9gR2ghXF2scRrOWgeIWycG6lGI9UELKdpwIYQ
 OHOA==
X-Gm-Message-State: AHQUAuYe6zMLk6CuBOxbDD80HzwXArWqKxeP7VFjB7za6Qb+JNcqSQoZ
 5HknVCpk9N1Ih7dO8ReJRYCVEVVW
X-Google-Smtp-Source: AHgI3IZp3lzrkYAZb1Eeb5FE3XzTlsbxmY+ARQgvhnL6lTfJ1rShkodxyFT0Y9kPkfFDUiVwwPxEsg==
X-Received: by 2002:a65:60c5:: with SMTP id r5mr3019396pgv.427.1549595299136; 
 Thu, 07 Feb 2019 19:08:19 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:18 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/7] powerpc/eeh_cache: Add pr_debug() prints for insert/remove
Date: Fri,  8 Feb 2019 14:07:57 +1100
Message-Id: <20190208030802.10805-2-oohall@gmail.com>
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

The EEH address cache is used to map a physical MMIO address back to a PCI
device. It's useful to know when it's being manipulated, but currently this
requires recompiling with #define DEBUG set. This is pointless since we
have dynamic_debug nowdays, so remove the #ifdef guard and add a pr_debug()
for the remove case too.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 201943d54a6e..b2c320e0fcef 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -157,10 +157,8 @@ eeh_addr_cache_insert(struct pci_dev *dev, resource_size_t alo,
 	piar->pcidev = dev;
 	piar->flags = flags;
 
-#ifdef DEBUG
 	pr_debug("PIAR: insert range=[%pap:%pap] dev=%s\n",
 		 &alo, &ahi, pci_name(dev));
-#endif
 
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
@@ -240,6 +238,8 @@ static inline void __eeh_addr_cache_rmv_dev(struct pci_dev *dev)
 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
 
 		if (piar->pcidev == dev) {
+			pr_debug("PIAR: remove range=[%pap:%pap] dev=%s\n",
+				 &piar->addr_lo, &piar->addr_hi, pci_name(dev));
 			rb_erase(n, &pci_io_addr_cache_root.rb_root);
 			kfree(piar);
 			goto restart;
-- 
2.20.1

