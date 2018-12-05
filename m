Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C663C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:11:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C91208E7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C91208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398yZ3ZP1zDqLw
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:11:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398Vz3XWfzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:23 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id s5so19788564oth.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sl5w3TVJ+wE3vPiBwLh392ShItBJGNo7vWury6PkKf8=;
 b=gMCgK0YWp9KJ68xJ2qQLvexnFL4aYzGztt3XnrG9WUYo9X3+dzSfhT4IZqcXu3fo1R
 H21lkqy6VU+m/K1HGcq/jk2XgwCnyY/4OsdAL5YyLNlSfM9x5W+f7hvRw96nB9S5mpee
 HvgrKHVbLgZwWY5q/655rox9uvZL85FRdCi46V2SrNpBXjnBxnDOWTrPlUtr6wTmdU9J
 0pQL3dSkf7sQTwxWw2l/fZvjc0VYKUxBp1B63fVkcO/ocOxckyTU14IbIxi9hQJUIGnW
 3Wxq5Ttiv1fFNT80lG27Z16iyMaSggWWRlYUirgD7zN4bFDytP9jSfIQCKnKvMVYCpfx
 5Fbw==
X-Gm-Message-State: AA+aEWZ4CXy+0OA7R8/hsSHlXchGw8zegmPH7dsDMLqbqtmEJ/hYO5iZ
 d6v2+jaz5V1gFnXEmecidw==
X-Google-Smtp-Source: AFSGD/XJEhm0daE9rARarhesB/fYxVEV3Dg1SVhUur15fRBEWdS9UsL72dAXg1SJBm6p51u3D3E/NA==
X-Received: by 2002:a9d:4201:: with SMTP id q1mr14968194ote.126.1544039481659; 
 Wed, 05 Dec 2018 11:51:21 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:51:21 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: Use of_node_name_{eq,prefix} for node name comparisons
Date: Wed,  5 Dec 2018 13:50:43 -0600
Message-Id: <20181205195050.4759-27-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For hvc, the code can also be simplified by using of_stdout pointer
instead of searching again for the stdout node.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/hvc/hvc_opal.c      |  2 +-
 drivers/tty/hvc/hvc_vio.c       | 11 +----------
 drivers/tty/serial/pmac_zilog.c |  4 ++--
 drivers/tty/serial/suncore.c    |  8 ++++----
 drivers/tty/serial/sunsu.c      |  4 ++--
 5 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 77baf895108f..c66412566efc 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -353,7 +353,7 @@ void __init hvc_opal_init_early(void)
 		if (!opal)
 			return;
 		for_each_child_of_node(opal, np) {
-			if (!strcmp(np->name, "serial")) {
+			if (of_node_name_eq(np, "serial")) {
 				stdout_node = np;
 				break;
 			}
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 59eaa620bf13..6de6d4a1a221 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -371,20 +371,11 @@ device_initcall(hvc_vio_init); /* after drivers/tty/hvc/hvc_console.c */
 void __init hvc_vio_init_early(void)
 {
 	const __be32 *termno;
-	const char *name;
 	const struct hv_ops *ops;
 
 	/* find the boot console from /chosen/stdout */
-	if (!of_stdout)
-		return;
-	name = of_get_property(of_stdout, "name", NULL);
-	if (!name) {
-		printk(KERN_WARNING "stdout node missing 'name' property!\n");
-		return;
-	}
-
 	/* Check if it's a virtual terminal */
-	if (strncmp(name, "vty", 3) != 0)
+	if (!of_node_name_prefix(of_stdout, "vty"))
 		return;
 	termno = of_get_property(of_stdout, "reg", NULL);
 	if (termno == NULL)
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index a9d40988e1c8..bcb5bf70534e 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1648,9 +1648,9 @@ static int __init pmz_probe(void)
 		 */
 		node_a = node_b = NULL;
 		for (np = NULL; (np = of_get_next_child(node_p, np)) != NULL;) {
-			if (strncmp(np->name, "ch-a", 4) == 0)
+			if (of_node_name_prefix(np, "ch-a"))
 				node_a = of_node_get(np);
-			else if (strncmp(np->name, "ch-b", 4) == 0)
+			else if (of_node_name_prefix(np, "ch-b"))
 				node_b = of_node_get(np);
 		}
 		if (!node_a && !node_b) {
diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 70a4ea4eaa6e..661e8b151366 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -89,14 +89,14 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 	int baud, bits, stop, cflag;
 	char parity;
 
-	if (!strcmp(uart_dp->name, "rsc") ||
-	    !strcmp(uart_dp->name, "rsc-console") ||
-	    !strcmp(uart_dp->name, "rsc-control")) {
+	if (of_node_name_eq(uart_dp, "rsc") ||
+	    of_node_name_eq(uart_dp, "rsc-console") ||
+	    of_node_name_eq(uart_dp, "rsc-control")) {
 		mode = of_get_property(uart_dp,
 				       "ssp-console-modes", NULL);
 		if (!mode)
 			mode = "115200,8,n,1,-";
-	} else if (!strcmp(uart_dp->name, "lom-console")) {
+	} else if (of_node_name_eq(uart_dp, "lom-console")) {
 		mode = "9600,8,n,1,-";
 	} else {
 		struct device_node *dp;
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..8ed60ccd45fb 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1482,8 +1482,8 @@ static int su_probe(struct platform_device *op)
 	up->port.ops = &sunsu_pops;
 
 	ignore_line = false;
-	if (!strcmp(dp->name, "rsc-console") ||
-	    !strcmp(dp->name, "lom-console"))
+	if (of_node_name_eq(dp, "rsc-console") ||
+	    of_node_name_eq(dp, "lom-console"))
 		ignore_line = true;
 
 	sunserial_console_match(SUNSU_CONSOLE(), dp,
-- 
2.19.1

