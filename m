Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A0C43219
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:53:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEC72087F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEC72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rsng21F3zDqNg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:53:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.134; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrZx71mTzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:58:49 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPooN-1h7uVt3Uzj-00MrCK; Sat, 27 Apr 2019 14:52:51 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 20/41] drivers: tty: serial: cpm_uart: use
 dev_err()/dev_warn() instead of printk()
Date: Sat, 27 Apr 2019 14:52:01 +0200
Message-Id: <1556369542-13247-21-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:gPxg0pvaNEeq5x+UwAsDbHdgypnsGOsK9o3j3foMhaID5KFRvEv
 8AvtdT3OHQsnwoPSUVUVgaG7uGVOSNulOF2BUp5euWPO4xOffryfhmOQh75bfkqTrattPsp
 QFI8+vQMDSRQJ10o81AgQsbvofwXHCA01N/KdcAMGoHFdvQFXnI8JYKNCiQeBe0EpQIxX+K
 rRBN+WvzZqwD0ZWGZ/IRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fa+84OpXGhY=:4yn01I4vKQ0aCgY4ksDwI4
 G0JA0IAVabPW6RGTRTauCM3iqEtZLwNgJxkGiBIJlDcIeNv6p30jQRAxJUysIHvkysK+7tap9
 Nm6u9UbpEl6EnBBlJaNiT7/E5ORm/MdBhdjuG9UGMd47X7hb5eWxqjL5I8T5vkLwDMDM/X0GI
 X98HAEoUGHTYim2IeuvDUDSSzHA8NnN05BfXroK4T4/QTWWaSooIgP7Stlt07jeNHetDWQc+G
 +Y9Kt4tFG3A9IGvJDhmrcN56kKL2ECfIQKKPGd1PObvArUInQFakLwmPtpaJnOG2ve1h41y8n
 /Ekby6O1GVuMo39+WzSi2l9lfrjFCoEsDz3y4coWjq08FlaBLRXFLHrSy0P+RauEq9dkOWj1/
 Kv9tdJq7e/S2Xd09hAp2CncWc1C/zF2Ji3+mmCqGWdoEHyNl2iegBTRJd44bqIXSxtrFAsW5q
 2xmWSHRIdX8RSCQ3B+i3G3baoSmxTADKN4Fzt8doLqzY6UStaCid2FX2hmxcg8wnYt0o2gM7c
 nczXNBuFFeVk/++Z6wihBy6rv+O5B46MWLtYW0Rhb+wM5tJPj0bJKjwKx+0dc2M25IQHiS2iC
 2iKXjlLfO+U0AwiJI+u0fifrHiLcweJl3otJjNeV7s8ojXwLf+A2Ksdipiw4fmA/4tRHi1uAX
 vI6T5loGpSe8M6uOfrt2q8lialx82+ZiXfTgwcN0G7Cl5kRUqyvvW0HT/6UAgIvoVCe8Zc2PK
 smS+NWB2UHUTe/FIvJ85gEtCTMkCGdAZjtoZhw==
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

Using dev_err()/dev_warn() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 6 +++---
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index b929c7a..374b8bb 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -265,7 +265,7 @@ static void cpm_uart_int_rx(struct uart_port *port)
 		 * later, which will be the next rx-interrupt or a timeout
 		 */
 		if (tty_buffer_request_room(tport, i) < i) {
-			printk(KERN_WARNING "No room in flip buffer\n");
+			dev_warn(port->dev, "No room in flip buffer\n");
 			return;
 		}
 
@@ -1155,7 +1155,7 @@ static int cpm_uart_init_port(struct device_node *np,
 	if (!pinfo->clk) {
 		data = of_get_property(np, "fsl,cpm-brg", &len);
 		if (!data || len != 4) {
-			printk(KERN_ERR "CPM UART %pOFn has no/invalid "
+			dev_err(port->dev, "CPM UART %pOFn has no/invalid "
 			                "fsl,cpm-brg property.\n", np);
 			return -EINVAL;
 		}
@@ -1164,7 +1164,7 @@ static int cpm_uart_init_port(struct device_node *np,
 
 	data = of_get_property(np, "fsl,cpm-command", &len);
 	if (!data || len != 4) {
-		printk(KERN_ERR "CPM UART %pOFn has no/invalid "
+		dev_err(port->dev, "CPM UART %pOFn has no/invalid "
 		                "fsl,cpm-command property.\n", np);
 		return -EINVAL;
 	}
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index 6a1cd03..ef1ae08 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -67,7 +67,7 @@ void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
 		return pram;
 
 	if (len != 2) {
-		printk(KERN_WARNING "cpm_uart[%d]: device tree references "
+		dev_warn(port->dev, "cpm_uart[%d]: device tree references "
 			"SMC pram, using boot loader/wrapper pram mapping. "
 			"Please fix your device tree to reference the pram "
 			"base register instead.\n",
-- 
1.9.1

