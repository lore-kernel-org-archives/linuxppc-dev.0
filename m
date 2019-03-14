Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:33:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFE72070D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFE72070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L4lY56wNzDq5j
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:33:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3Zt3WNVzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:40:54 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZk1p-1ha7vI0XKR-00WmeJ; Thu, 14 Mar 2019 23:35:07 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/45] drivers: tty: serial: apbuart: use devm_* functions
Date: Thu, 14 Mar 2019 23:34:07 +0100
Message-Id: <1552602855-26086-38-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2dk2jESpJv/HEfcNhm6LprNXtUCqzVx1Rvdfnjmt87/bGDbVsf/
 n6IJXGpfOh+ytlsw3dFBHYudgyuS1XDPdOT3eQYpN7QrEUJ5zFh4jnOO9OqQ2oHIhZfyLL4
 qnqLTDRTXuIfKvf0gzGuMPkPi3Z4BrPcuHcKwYjrIS+IbAxFB1cehvHku5NKfqbqPZdYaSb
 GBkxJfegQWU/hAuuGRPaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6IL+xuev150=:H4fER6STo8ZVxjpNp19Frk
 /kIZ8ps9dXY0LQB1WY1bLfaanSR2HrMztwn7txpv2hRpQes8ABU7DxA10fZ6b0mhLCGJPwjYO
 NN1AOl3x/4P08F+zQ9MJEsWpWErOOJqPZzltezxAmWwCIckaGIS2Wi+bKab6/GL8Arb1CcfYJ
 iZDNWg2VBh2EIXxDEJhFZvyR5fG4rwbXxsaOTCCficEeIjNvIDvmxKvqRp5IidiIzarjuyHkM
 12a0ouNxtu5yjI9GwiheAQf8BeaOsTZ5+/mR1G04Bz2W6NV4DBoepi9xeHeCdAqjchnRd08Qt
 t2LZ1P9oYPmXREISnBH0TdR/pD2+vgRAUeUbWTv2OVAfDEd0AnnWeepQXN2zi6fnPGbseIB2O
 dxFMmG04mkIxXXyr5aw8DSH5ITouSPKgRFS5gvgAcyS1/IyU0sgbvBX0XHln9AWnjW56gV1/7
 Olg/GoI6PL/tfFGraF49ZG0pB/uQe7whwpLwjUuqwJ70IHmTmB97fljtWRaMLPtN03A8yFN5J
 z0VCJ/AVt7cr4EVst++NopamXzxRus2En1SwI29qxzw2u/nWwXfEWX6p3ICcLT2t3dTKD/FI6
 XUx+798jYRjlZnXOxCdmz+w1ZUkyrZ7N+lMHC6EZist1vOGn/ck7IedL9WOAlbYBRm5RpvoYT
 QpKjm+TL7w2MvymxtMlIk4UGChW47GiNaDO2uKlCykiX67q0jQwc/kVUECVy0Xh8KtUS8f+I4
 Z6NmBuf/Xb/zibUEc3HF+/bzuZZ+Ox9M4RV26A==
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
 drivers/tty/serial/apbuart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133..5eaaee9 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -293,12 +293,15 @@ static const char *apbuart_type(struct uart_port *port)
 
 static void apbuart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, 0x100);
+	devm_release_mem_region(port->dev, port->mapbase, 0x100);
 }
 
 static int apbuart_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, 0x100, "grlib-apbuart")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       0x100,
+				       "grlib-apbuart")
 	    != NULL ? 0 : -EBUSY;
 	return 0;
 }
@@ -622,7 +625,9 @@ static int __init grlib_apbuart_configure(void)
 		port = &grlib_apbuart_ports[line];
 
 		port->mapbase = addr;
-		port->membase = ioremap(addr, sizeof(struct grlib_apbuart_regs_map));
+		port->membase = devm_ioremap(port->dev,
+					     addr,
+					     sizeof(struct grlib_apbuart_regs_map));
 		port->irq = 0;
 		port->iotype = UPIO_MEM;
 		port->ops = &grlib_apbuart_ops;
-- 
1.9.1

