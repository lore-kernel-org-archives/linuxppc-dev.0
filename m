Return-Path: <SRS0=fKfC=FW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA761C4361B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 15:16:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286ED23B09
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 15:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286ED23B09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CyC9z3rjZzDr74
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Dec 2020 02:16:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=metux.net
 (client-ip=212.227.126.135; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CyBs50lyyzDr0D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2020 02:01:28 +1100 (AEDT)
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mo77T-1kK1VW1xBj-00pdXc; Fri, 18 Dec 2020 15:58:05 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/23] arch: alpha: drop misleading warning on spurious IRQ
Date: Fri, 18 Dec 2020 15:57:25 +0100
Message-Id: <20201218145746.24205-3-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:PqfaMTt25KQVxSXJTsfozmpBAeruFGG1jC3nsUehROhD0z4rSWE
 IaehytI/o5f6AoCsRTbYyuxgmId5X0qoSvyCMuRnkNj7LNq5/UmiaBRQ00TZS8ksxE8tlTK
 Z9+ACa+Zo53iDchZquHqWbo9V4ZzVTjuuoRD+GatwY7YnsMFfYTqB2Hjg0NnSpL67XfIodJ
 9BxvEx894cQB3s69Eu2JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cohc8wk3vdI=:mzsvjvsWiiIwFiETSEotKA
 VmihfaVOaUQkByRjx7upE0UZT9zku+CzaTER2s+0cjRSYZ+F8ERiobaxCWYZbhD/zpbJAQ6BO
 Jxo98tjMSAykS3PAHuIs+mxtSplM92YWW8TseGJyHkOYQ3QZdyBpza4/hxXYN4Ebc95vJxs7w
 Wa3Fc2C+/6ZRKWZVYMWHF0FBNgUrG8cXl7VxhNWwC2H88W112L8bfPGLfl8vkZEZqPvuxHxHg
 qcIRWC53JqO9xuu8oj92R32XrMwvVUAg9/uYE9F/vUOV2HsU/JKe11720K5SEjUesaIUGHRzN
 2mba0rBnOH42YIy00q/nB8X2aw6OJqinSdqwaFlRTPK2+24XwcR4uomPWxEmPCYlwQQi10QC0
 rs5ksIwNEmKimqOI4pxpTTh9yzKt9scYRBbflDEdABGUepE9fNlb8iHrjRZDgIi2VbdVmqvA3
 2uNlI59NRmXmKPW0jDnIUVD59WP8M72uBTTY8d1uA/l8d0Ld50snZ/ksflXjV6BMsN+t38hj/
 ogRH9PXkj6nrxUFRuWUZWM=
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
 arch/alpha/kernel/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index f6d2946edbd2..c1980eea75a6 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -35,7 +35,6 @@ DEFINE_PER_CPU(unsigned long, irq_pmi_count);
 void ack_bad_irq(unsigned int irq)
 {
 	irq_err_count++;
-	printk(KERN_CRIT "Unexpected IRQ trap at vector %u\n", irq);
 }
 
 #ifdef CONFIG_SMP 
-- 
2.11.0

