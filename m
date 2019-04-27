Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA60C43219
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 14:10:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1AA2064A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 14:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1AA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rt9z5w4CzDqG6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Apr 2019 00:10:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.134; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrbK0TtwzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:59:08 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2wCi-1hLTog0PAy-003R4p; Sat, 27 Apr 2019 14:53:02 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 33/41] drivers: tty: serial: zs: use dev_err() instead of
 printk()
Date: Sat, 27 Apr 2019 14:52:14 +0200
Message-Id: <1556369542-13247-34-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:QF40RLIzjg39yF+kkJLwWE6eyJO2lDQl6Yzy88yH5771K+U+/wt
 1Wjl3D+kIur6TBPIOh4jOyMYXzSox/0XX1Hcf4zFuPQmKc9TKSN1fBoJRYlf+0M/kOR3PC/
 l9Y251gM1AKpBxtXImahYkduMkU7yDZeVYsF1N1b7uZfo2UV2TlEEwBb0bCY34hAZbZneXk
 NbA8aA4/MktrW0coiKTyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PUEIAZHq084=:kxQMrXXEM11XkaImEQol+w
 YRDcBRFVIfJV/kZpoTtR3bHPPNubpwQ7L9FlRGCd1xACbBhX2X9/DK4LUw8062FZnQswsMCpZ
 aAxvH2fDWo0piTBjlBhh5WKxTMf/2NdY0bGl8KvANiJmVr8N3btRCf4twxtWgoaM2yQlvx9Dh
 XX1W2DVx7AW/84N/b1/Qp40K+Uov6Mtc+JCnVHuehXjvoeVbL94pxRcRVNaHLnmJoN67b8R9T
 Z2DQh6rRomE0Xn0QWOVfzQeux5PT7vOu7PNyRhmElwC7KOOfG9OZ4RlBtgu8MyY1+px0473p8
 7BoepyA+XJmpF6bm7lpsbwAkIyB01RMOyARkYp0B7XYHb8m5MNrOdJFPQQdpVAYUpjMVwAeOA
 3AnSE3gnazF3GghmURzxARDymYGOK2OG92ix0oQ/Mn9CAFRiTdP5vLKjuU5zx/53PAMbktFVQ
 Ofi9MttGWE1lXfXQ2Js+qs2VnA80M6YnjSefpWu4gLeQ9hrverj6UipU00xRtpJcND/HLgwB8
 86FKuRfg6ZIdG8hkJ36pYeLp+cA+qeNsaNvhZ/vxTHE8HxNB12/lqkIyDz9/C4OsNRYgcSvhz
 rhY4Axk21INx26qURBJm+xTpHFrpsEDdYuBLmR7fqp/mCOMItkRRJoWGX9rxsu/FP3r8E5gBH
 +GjN8e2uue3oQZyfU+v0B9LgPNRv5q5NX7cxHgX9eBzVe7u0l+I+giY5mmQxqMTLmDhHME0V6
 xOUf5VJvIC5tXkV9iOU1J3YxRZ2V8igq50uU7A==
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
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org,
 linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org,
 vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org,
 khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com,
 matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/zs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e4..adbfe79 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -767,7 +767,7 @@ static int zs_startup(struct uart_port *uport)
 				  IRQF_SHARED, "scc", scc);
 		if (ret) {
 			atomic_add(-1, &scc->irq_guard);
-			printk(KERN_ERR "zs: can't get irq %d\n",
+			dev_err(uport->dev, "zs: can't get irq %d\n",
 			       zport->port.irq);
 			return ret;
 		}
@@ -995,7 +995,7 @@ static int zs_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 ZS_CHAN_IO_SIZE);
 	if (!uport->membase) {
-		printk(KERN_ERR "zs: Cannot map MMIO\n");
+		dev_err(port->dev, "zs: Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -1006,7 +1006,7 @@ static int zs_request_port(struct uart_port *uport)
 	int ret;
 
 	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
-		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
+		dev_err(uport->dev, "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
-- 
1.9.1

