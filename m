Return-Path: <SRS0=fKfC=FW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE442C4361B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 14:56:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6457423B01
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 14:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6457423B01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CyBl23X24zDqkX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 01:56:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=metux.net
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CyBH40DDczDqWh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2020 01:35:27 +1100 (AEDT)
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MD9Kj-1kzJDr1AGX-0099IA; Fri, 18 Dec 2020 15:31:58 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/23] arch: s390: drop misleading warning on spurious IRQ
Date: Fri, 18 Dec 2020 15:31:08 +0100
Message-Id: <20201218143122.19459-10-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:+Fk5XG1M51DsDMqllxhuk9QMdwKM8nFiYzagO2Q/2cSgAuejovr
 dtmISK1c/qztd4178uEaymF5uh/0I6XlA2Tqnyx7Bfb0v6ONN47Yqppdl3VTdau8eLZW2Uv
 /pHid2mGQ+3dMXHd9bKt92Duo1y1rPLeQr5rGle5B4uBkwH7iz9s0bsnzCRdN3jFBUhSf/r
 +0OdIMQ80t8v/+o43h3+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2f4lndISjI=:zHUd/iqf0O3qag8NkEcoBz
 x4x9TA7Ovp04jopysG/BlFtt1L5oIEmvskqof0AHt9vQMAKkztiscW5ztKv8l1IPCHM4FRUK7
 ob3aoPzcMvd0E5ijhnPp1qaioD3QFkMaBe+oev+iwsti2I965xNEIIOKQakRqrgwN7V2zYzBB
 8XgP9bUY+3Tiv6CMn8DT42WJvWvHPiqPqpw8bGh8YBe9MMOekLpBZz6OTOzdFxDgJdyVlkxMc
 Woo6ULY0pjIcEj/2+3mzbmDNZrNjx4xo4WB6FTNIsI5UvulnLwvmYxAQR8juEJf6ShH7cGcxY
 kk6tE44rK5SWHHMaqfK5sZEBFToA3VUjtPeCZxjWMfyLWLVp6UOq4BJ74AXDFlPs57qLm8Xbb
 uH6PiWBNvirOZkAb5kUMzlHPjSXYR1xgbCzp2pBMri5zdtt3HN0eVFGqhHnrw
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
Cc: mark.rutland@arm.com, dalias@libc.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, alexander.shishkin@linux.intel.com,
 linus.walleij@linaro.org, James.Bottomley@HansenPartnership.com,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, will@kernel.org,
 gerg@linux-m68k.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, ysato@users.sourceforge.jp, jolsa@redhat.com,
 deller@gmx.de, x86@kernel.org, bgolaszewski@baylibre.com, tony@atomide.com,
 geert@linux-m68k.org, catalin.marinas@arm.com, linux-alpha@vger.kernel.org,
 arnd@arndb.de, msalter@redhat.com, jacquiot.aurelien@gmail.com,
 linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, bp@alien8.de,
 namhyung@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 linux-mips@vger.kernel.org, maz@kernel.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The warning in ack_bad_irq() is misleading in several ways:
* the term "vector" isn't quite correct
* the printing format isn't consistent across the archs: some print decimal,
  some hex, some hex w/o 0x prefix.
* the printed linux irq isn't meaningful in all cases - we actually would
  want it to print the hw irq.

Since all call sites already print out more detailed and correct information,
we just don't need to duplicate this in each single arch. So just drop it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/s390/include/asm/hardirq.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6c0674..56d95fcb310a 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -21,9 +21,6 @@
 #define __ARCH_HAS_DO_SOFTIRQ
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
+#define ack_bad_irq(irq)
 
 #endif /* __ASM_HARDIRQ_H */
-- 
2.11.0

