Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B6EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:22:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0552184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0552184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4Vt5jlyzDq9B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:22:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.10; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zh5XmfzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:44 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7AEs-1gysYv2WhY-017UBE; Thu, 14 Mar 2019 23:34:57 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/45] drivers: tty: serial: dz: use devm_* functions
Date: Thu, 14 Mar 2019 23:33:57 +0100
Message-Id: <1552602855-26086-28-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ttxJh5/xAJalSpvfPzcSPkK1u0tHzU5oEa0OJSDkUB5+9mbyZ93
 GfixrGgZLuEqOktG1VWublpF48aVXf47MLO4J1+kmnjK0SbYIgmiGKY3LLYP6rgFBaKHlqd
 P7mjlfvaVnAntwbTAk1Xih6HJ1iqeZvlH+VjdFH6i1YQ8qq1Xvmq0Lfc1Wi5itpO5dELCuf
 KAZi81lWjiID8vIbWtbsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jx7wB1WY8SU=:mypYpIxuS7u3lhFJmJlpr/
 pYg2XXWBfoWfj3tC/KTTX5KOQVMThq/S1idT1ULQCt6SizTl2NCJs+V4MqD5Rpf6wc8YDi9zb
 nblu1Sl5Vf+fE3aiY28m0+Wm1JKiSXXr1jIqYDsb0VeE+jVXY8hcmDzEuG1Y/Vsv/RF+Lb/yB
 KFPqFzhMaam2S7HS28cJHI8hw8b1AMecnqQgR/2lvOrm8mBg3/zjIJsSz9JKeFBQ+LXbqLeGL
 rRMeMheZN9gXtj1U9rxQj4MucEI+Aft60Y7XbuRhigzU+s/3pycscOZtGZRBrzBIL0JCC2nih
 4TrbTe7Ax0KFS7/i1hGP0/IIqh1bJzVDN7wqfz6KxftaqPi4Whq+tGN5g9jnppeR/HJ37MMuv
 +K/rBdvtgp4kdxGtyG8thMZDoesZBmOjE4fGHJbH9eYrTxggh3gASSAO10DffvlnAV8hcdt7d
 +EbQccaYlR3PMxMb0sxQSyNUmBQhTbKNN7bKa64Lec6irEPaW8WU+4tSsCys0hSilgaM6ih1j
 UQxKx+Id8sN63+643XUMtYNENBAIv7LLQOVUELMlsn2yCc9qquiQs4FAiAcAkTll6huL1tmY5
 gMXkvf90kz4jYj8twN0OW/vpdr7F2X6o6jd1sKoCFkoJroFUT6V6Ilc11iqJinnPcdaOjwJLU
 YqlzSzSHwJ2/QpDEP4V1ZXgF4S+i5aH9mrQyNyQAqjup8VMR+R6dUxidKZU/rUPMMh2HegEEv
 IJwfsCe4HVGEzxvW0rdaLdIJs9s6wRciIoghng==
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 andy.gross@linaro.org, tklauser@distanz.ch, david.brown@linaro.org,
 rjui@broadcom.com, s.hauer@pengutronix.de, slemieux.tyco@gmail.com,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, gregkh@linuxfoundation.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/dz.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 96e35af..10a75e3 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -666,19 +666,22 @@ static void dz_release_port(struct uart_port *uport)
 	struct dz_mux *mux = to_dport(uport)->mux;
 	int map_guard;
 
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = NULL;
 
 	map_guard = atomic_add_return(-1, &mux->map_guard);
 	if (!map_guard)
-		release_mem_region(uport->mapbase, dec_kn_slot_size);
+		devm_release_mem_region(uport->dev,
+					uport->mapbase,
+					dec_kn_slot_size);
 }
 
 static int dz_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 dec_kn_slot_size);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      dec_kn_slot_size);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO\n");
 		return -ENOMEM;
@@ -694,8 +697,10 @@ static int dz_request_port(struct uart_port *uport)
 
 	map_guard = atomic_add_return(1, &mux->map_guard);
 	if (map_guard == 1) {
-		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
-					"dz")) {
+		if (!devm_request_mem_region(uport->dev,
+					     uport->mapbase,
+					     dec_kn_slot_size,
+					     "dz")) {
 			atomic_add(-1, &mux->map_guard);
 			dev_err(uport->dev,
 				"Unable to reserve MMIO resource\n");
@@ -706,7 +711,9 @@ static int dz_request_port(struct uart_port *uport)
 	if (ret) {
 		map_guard = atomic_add_return(-1, &mux->map_guard);
 		if (!map_guard)
-			release_mem_region(uport->mapbase, dec_kn_slot_size);
+			devm_release_mem_region(uport->dev,
+						uport->mapbase,
+						dec_kn_slot_size);
 		return ret;
 	}
 	return 0;
-- 
1.9.1

