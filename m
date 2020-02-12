Return-Path: <SRS0=Z2Z0=4A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77BC2BA83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 10:28:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2052073C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 10:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2052073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48HbT60lm6zDqQK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 21:28:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux-m68k.org
 (client-ip=2a02:1800:110:4::f00:d; helo=leibniz.telenet-ops.be;
 envelope-from=geert@linux-m68k.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=glider.be
X-Greylist: delayed 548 seconds by postgrey-1.36 at bilbo;
 Wed, 12 Feb 2020 21:26:56 AEDT
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48HbRN3GwZzDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 21:26:55 +1100 (AEDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 48HbDg5CDQzMqjLn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 11:17:39 +0100 (CET)
Received: from ramsan ([84.195.182.253]) by xavier.telenet-ops.be with bizsmtp
 id 1mHd2200M5USYZQ01mHdrN; Wed, 12 Feb 2020 11:17:38 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1j1p5N-0001Nb-Hf; Wed, 12 Feb 2020 11:17:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1j1p5N-0002Nv-GF; Wed, 12 Feb 2020 11:17:37 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/time: Replace <linux/clk-provider.h> by
 <linux/of_clk.h>
Date: Wed, 12 Feb 2020 11:17:36 +0100
Message-Id: <20200212101736.9126-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The PowerPC time code is not a clock provider, and just needs to call
of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 1168e8b37e30696d..af0b6834f75c7007 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -50,7 +50,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 #include <linux/suspend.h>
 #include <linux/sched/cputime.h>
 #include <linux/processor.h>
-- 
2.17.1

