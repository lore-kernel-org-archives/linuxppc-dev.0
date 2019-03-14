Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420E9C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:07:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C6721874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C6721874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L49h1QcYzDqMy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:07:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Sl4kYgzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:35:34 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mnqfc-1gfhVq0cXa-00pPMk; Thu, 14 Mar 2019 23:35:12 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 42/45] drivers: tty: serial: sa1100: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:12 +0100
Message-Id: <1552602855-26086-43-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RVGNTqK71uxCFzYiMccKjuCKa9laF5X8HCcGcmlmO1usX3YVlzQ
 2l0E32dh0GukR5EdVh1DhZcBWg83jqWN/ogke08s8INXpCOetgNpLOEYrY4HjVW1zWMcNn7
 ZAGjvmK1JQukDRJBUS+PeG45zVtJkXpp8YR5j+irWM4N0MykiP3+jBroEQKX36PN9uq6ZJR
 O4t/cOcbKDvRBRmsjuuxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9eK6LDs34VM=:oAkZK4RcLFbn0YB72xpPgd
 PUpVRJzzsZsyyADxwqdbDiE1xNQ3aX7TtXLOzmT5+kX+ulnfG2eVdVR+SNmx3IiSF0aumaBHx
 +bUSgOvqmYtJlpbXtJ+lnVA1YKEs3HZSGUtETtyriWahIHBct4+hStxilF+Cw0dO6nQ+gHhkW
 p7h8WD+HLLwldAHMY9YJHlvGVgj0FyaweK/D6crfTOJAjcmKALoU1kxgTViUXbrMX8exg79xj
 xxx5AsvSkiQ1de1QzhR2JKLrCIeHL+K2lRrNyc0xw0+s0vKWu5ZvhZQMtGTmzDW7G4tujyFAC
 oGBYGyi8RrmKwz0Y0p2RoKIBxutEzu9ShdIWFLMilKSuoV4L79C5LHvBcnpn6VOc5dnZMaHKL
 3J3aC8F/7YNJzEB8Dmm+12tt6MOkLkYtxswm/PWRwXJO/izSvBazj63tYVZxdbh21Bjy38FWU
 bAKpukglONH9XWQVnOOFJ9BcuXjQXsjJIu6H+8LHzI95cgsZLNUNJNrBMZ2QmkZuGvzpkej9R
 KOhOGFU6DeFtQE53HIGizdIQ1rH9aNUN910nsbH9bXTYJoUyVx+j6e6BilSWwTq9P1aLYeOS9
 qEvYEVNoLOrXDduIHdnwTPGliEvKAhvlkG+DkrSe0wmR52L0iprcJu2ynHLYcpz9LVSKa4pfi
 yeH6q0l2W5wiy3dEfUVOvqB7fnYtODJSjd4VQG/onh0Vw5GD4Hm1EZcdKnPRqf450bjxBERlD
 ETDaSJybMySEjDj2vrH/rnloHnSUDALInx72kw==
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
 drivers/tty/serial/sa1100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index a399772b..3aa20a2 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -522,7 +522,7 @@ static void sa1100_release_port(struct uart_port *port)
 	struct sa1100_port *sport =
 		container_of(port, struct sa1100_port, port);
 
-	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, sport->port.mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -533,7 +533,7 @@ static int sa1100_request_port(struct uart_port *port)
 	struct sa1100_port *sport =
 		container_of(port, struct sa1100_port, port);
 
-	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev, port->mapbase, UART_PORT_SIZE,
 			"sa11x0-uart") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

