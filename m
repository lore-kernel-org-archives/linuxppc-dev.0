Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FEEC4363A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 16:32:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F54A2224A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 16:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F54A2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFzfr3Dd1zDqWq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2020 03:32:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=vivier.eu
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=laurent@vivier.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivier.eu
X-Greylist: delayed 340 seconds by postgrey-1.36 at bilbo;
 Wed, 21 Oct 2020 03:29:13 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFzbY2pbmzDqf0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2020 03:29:13 +1100 (AEDT)
Received: from localhost.localdomain ([82.252.146.14]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvrRB-1kBaLT25Nn-00stxd; Tue, 20 Oct 2020 18:23:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serial: pmac_zilog: don't init if zilog is not available
Date: Tue, 20 Oct 2020 18:23:03 +0200
Message-Id: <20201020162303.1730562-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bKHy5QQSiE77OMXPCG5t3IA6kn0O8DJhl6MV+YUQP93v0wYpsUL
 coTYiKGAtOBLA3PVaVWj8x5zDK9kGX+W2jYNGYsoMOJ+HEuJCUxIACpOjZfKt0VmMqsTss8
 oVtH8p5n8HCTCqiQGfX6xdIAfG94PL2nv6jie7AOlG5rdMQJGKfXBCXpbqfcyprrUMeyXxf
 NqH1bsfQST/Ym95UPoE9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jLcdZxQQ/jk=:s20Da3hP6S9SPdnAfUuWLQ
 vJ/XDq5qM5R1XMLm29A5BPAZUPZa4wSLR1UWNXnwE3OnFMDkjy1zUaeN5USNDDCPx3mjvD2ev
 IR/Jk9x1ifbY9pBkLzqu16bF0sIJlqU6fryqBxqzWSSK3JxFXcyHcjxhkD2zJa95TYEnyw4ee
 GdpGZPzVtzDx6RX6shOqMRr2lRxdaklxRGFm/6iKJJBHJe+HEnep8jG0t8L0kulj/mt30woS5
 4RFfRTxMZLZqCU9daULLrw/AayyCmLEVdMLY8tZcYKLI0qIDvo3zsDHlVZGvuf3nNYOObdDxw
 qBx4JWJkW+/1VRX6CwkYi28jNOsdO/I9rSkuhmYF7v+zTRICeG4ItLiBtdPL4OsVvoYk7UXA3
 iysr4IosTI83elPB//JKbtpXIeidrgcaYkszR74oOfqjYHfGDEr2kmGGscSZS7JWfVUnEtOFR
 qoUI95A40g==
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
Cc: Laurent Vivier <laurent@vivier.eu>, linux-m68k@lists.linux-m68k.org,
 Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We can avoid to probe for the Zilog device (and generate ugly kernel warning)
if kernel is built for Mac but not on a Mac.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 drivers/tty/serial/pmac_zilog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 063484b22523..d1d2e55983c3 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1867,6 +1867,12 @@ static struct platform_driver pmz_driver = {
 static int __init init_pmz(void)
 {
 	int rc, i;
+
+#ifdef CONFIG_MAC
+	if (!MACH_IS_MAC)
+		return -ENODEV;
+#endif
+
 	printk(KERN_INFO "%s\n", version);
 
 	/* 
@@ -2034,6 +2040,11 @@ static int __init pmz_console_setup(struct console *co, char *options)
 
 static int __init pmz_console_init(void)
 {
+#ifdef CONFIG_MAC
+	if (!MACH_IS_MAC)
+		return -ENODEV;
+#endif
+
 	/* Probe ports */
 	pmz_probe();
 
-- 
2.26.2

