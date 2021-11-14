Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F608C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Nov 2021 12:00:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3581D60F21
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Nov 2021 12:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3581D60F21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cdjrlc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HsW9k1273z30J3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Nov 2021 23:00:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cdjrlc.com (client-ip=109.244.180.96; helo=smtpbg.qq.com;
 envelope-from=wangborong@cdjrlc.com; receiver=<UNKNOWN>)
X-Greylist: delayed 143 seconds by postgrey-1.36 at boromir;
 Sun, 14 Nov 2021 23:00:13 AEDT
Received: from smtpbg.qq.com (smtpbg127.qq.com [109.244.180.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HsW994lXGz2xXC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Nov 2021 23:00:10 +1100 (AEDT)
X-QQ-mid: bizesmtp32t1636890979tkys33yj
Received: from localhost.localdomain (unknown [125.69.41.88])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sun, 14 Nov 2021 19:56:18 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: pqOtrSRu7rhj+T4F55rzH6VfybqVBt8tt8daMQz9+Hpq1RJ0+Py0JX5El+rFn
 GIWCaeb+x8+Wc4n7bOgXAPVbZbtH59jkWSftn+CZVFIP0DYSWoOD2n3U+pH57K2B7s1WDms
 6fLshoSSlQCvUxwPmw7sfoLB30tR+r+D8ZD65FRmoIAkyY5Nwgar97OftRb9qRxTI0w/AUn
 H4+zYTUyauebGhsQU/n5hIvGR0r7HvrUhZScSQBwV+YhcErfcOeRUTfTZBtoKWRb2R9uLkH
 3uhwKNE9oBSwEoT0Mj0tp8owdTa3cOZMDoT2I4XJ/gQOkwr+yYRYAh7LEzuMuCOhDU5bUnK
 6lEPi0znQDaNg2s2BA6YidAxsqJ0tNa0ebxwA98
X-QQ-GoodBg: 0
From: Jason Wang <wangborong@cdjrlc.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc: tsi108: make EXPORT_SYMBOL follow its function
 immediately
Date: Sun, 14 Nov 2021 19:56:16 +0800
Message-Id: <20211114115616.493815-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
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
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, wangborong@cdjrlc.com,
 michael@walle.cc, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

EXPORT_SYMBOL(foo); should immediately follow its function/variable.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/sysdev/tsi108_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 4c4a6efd5e5f..9e13fb35ed5c 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -51,13 +51,12 @@ phys_addr_t get_csrbase(void)
 	}
 	return tsi108_csr_base;
 }
+EXPORT_SYMBOL(get_csrbase);
 
 u32 get_vir_csrbase(void)
 {
 	return (u32) (ioremap(get_csrbase(), 0x10000));
 }
-
-EXPORT_SYMBOL(get_csrbase);
 EXPORT_SYMBOL(get_vir_csrbase);
 
 static int __init tsi108_eth_of_init(void)
-- 
2.33.0


