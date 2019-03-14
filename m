Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65FDC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:44:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240E5217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240E5217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L50N4xbyzDqR7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 10:44:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L3b1573DzDq9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 09:41:01 +1100 (AEDT)
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMFdY-1hMdWN1TK2-00JG0A; Thu, 14 Mar 2019 23:35:01 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/45] drivers: tty: serial: amba-pl011: use devm_*
 functions
Date: Thu, 14 Mar 2019 23:34:01 +0100
Message-Id: <1552602855-26086-32-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RrhaH1V2yhApRvvvaZtoxAX7c0npCjW9x7ofTbyAp4JJexoeDXu
 VgCgkfPxOnd4RyjxsmSHh88smR49ypo/XC23MVHNWOgQ6N1w2CcXMoNpydlWWCrvQMRLPQi
 2IZTIUfDuFnD0iaBupDlWJtMF54wZ5A5zDWEuAgj5MrP659Kcr013u/1RtS0CwnlTYOWZr0
 WKH6/xjoUg4ACtBgMxuBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Uofs7Koo0w=:bR5IrdVdddl8dfbE6zQbik
 pEToLTTZk+8jjcP4Nx/V/Dw6R8RhkjmHrcI7w02ZvU+l5iNRLhYRHrWhNYrrowZmwbVKYkoMg
 VQypDLh/gjMeXFXOcvdZfBj6gKUL1lUqhW//GBePCn6hK18Fxy0XlNQ+7r5Qy9Tlf9UcQcAme
 Ax/V6p52tRiitMtjIVFII1WHiQDAd95SNTlEM2kRCXyq4HexcOKqFv2+U59ZcES3ADgTR53Uw
 elu5qLhq0n9u++pJuAbVPWOf94itYFMi5UpoFGTkT6saQI4V6YZYwVfV7Aj1Pgmgier+7qTiH
 /kMC+af6SKR0PL84fcTSLivrc6dLkP+fOSBOZvWfhz1JAUGlE7EMRX4y1hi65L7jpFGZ6L4nG
 Y1UTOhwgxgxNGxTBfYoMqTAXMg9dC+rJ2I/siIfj59dJUZIywbZm2eG4wLZvZdwCAPbW0ZgLl
 Ga7QXWr/wdY6eaExxC1jPDtH2ZG83knVCnSoaSOSw/M63Suy3eR2QfkP2vzdJtlu/w/x5Tudv
 zjn0td5cxRP8lldHLFUMwNbB932nJ62ssfFOSWMePT7dRdpvr2bklE21u2PQ6C+j4Jt5+THaM
 StG4OfSElRa20XnuWxxUwCo5z6iH8L04uSpjrZqTMSD5yygwo4u2pfl/jauey91otDkwYsS0O
 Iyz1p4HeiyxqKwRN+o3lQ8yk9qo4dylf93NGsu0DrWiS7pU1d2Slr7nQPPxqzPeaH0wnnXcy4
 EsgPAY57kx9Hdez/1skzA+vnqprjnmeRUa1aqLd43/nNUDriO15Fd6wfC0HsTcBMCZaDWGYua
 gWPP4J8RzKKU4RtWtq4jXPVnBkxY+fkHSSftxugEC8wAyoFpJFFfen5tmQW212H1Kpn72kV1L
 SU0+GGDyaVXFYPV6BlOpu/InVuqBuRToYEFocc5GPlmxDyu/lBG6x4JnPW/ZBwZYVpvWhZx7G
 8AtFPVwkyEw==
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
 drivers/tty/serial/amba-pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade21..2a968b2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2098,7 +2098,7 @@ static const char *pl011_type(struct uart_port *port)
  */
 static void pl011_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, SZ_4K);
+	devm_release_mem_region(port->dev, port->mapbase, SZ_4K);
 }
 
 /*
@@ -2106,7 +2106,10 @@ static void pl011_release_port(struct uart_port *port)
  */
 static int pl011_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       SZ_4K,
+				       "uart-pl011")
 			!= NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

