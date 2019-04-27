Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D28C43218
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27562087F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27562087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rsqp2kr1zDqV9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:55:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.135; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrZy28ZPzDqMw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:58:49 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVNF1-1hBGZC1Cwp-00SLNE; Sat, 27 Apr 2019 14:52:41 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/41] drivers: tty: serial: sb1250-duart: fill mapsize and
 use it
Date: Sat, 27 Apr 2019 14:51:50 +0200
Message-Id: <1556369542-13247-10-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ZaCk4lb7tsU+VMSXb76laO+FYz7IB7DvruPd8DW8Z5VN86cLAXx
 XoTjgpy1D4cW0l6Dtk8ovOsbJ8N9Wa/Bbip0AWVSYaXLx73ljAgB+eT7NLTxRv9yXwxk0n6
 HH2/FDKHKTK7DJe3OrFZeO4xRkkEqT/D7RK5KNlvmu7PNcsk+uX5W9PhxlgNSIsAXElPf5S
 ey1fWSh+9w6GIdr1VGyZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RtxnkcS4BNw=:W1X4jBRlBVWuJD4Pv6ByqF
 uzEI8ecJpCWed3KCre2mLXW0OXV5A1OENmZaS058fCcGLtY/MMyJk+3j/FIE64fyPp6Mf1QNf
 aHI+BXIFLgyXi8UWEs7I7dkNTUzS1hd1Y+tVx2kiPwebsxB/XUlrxaR7Fd+F1i430VFQ0lSPO
 zSE9MVSXtx3rkP7LVIC2YS72tpsG3/731cMYzZEP7TddPWMBZbiYH9zO7cZTzd2MNiiTn7gKK
 hL0UsISQtmQIYESfFp9BFNeBK5uNoWKVjQc/7YFpnrQdlzWxKNceujqFxbVb5puKYKdvXqjKn
 z86W63uetedU7jZV89p57IdEVW50fhVwtsq/1k62INBnzcGtu9HFtpvtB1HcvQmiooA4rwVvS
 0BZ+xEx9lAH3SG3mbmfItGYnZ5cRjYfSIQghjdQqIpjmqIwpwXwDqILuPsriyG22f4TRyKS94
 lHaIV8x4nkWZmMTQptjrpfGBagay9++hR/f76Q2bocX+TYmsHkI1DGJ6erhO34vQq3s0okRk9
 TE0oDSgCtr4m9lwBGxUMVcPXpTxEcRTF53n02LZQq3FeWLotqFA0dysl3/8hYVuYTMh8IdYQm
 /CQD2IWCzXYDtoh7t0cqt+i4178a5QRyQzlkeXcgbEU6JPbsQLGHTKIiy/t1N9MPvU2iSapEE
 Crhd85EZKZrNEXL+/T18e96NxkLVjar2G6zwr2dxfT7zIrQE6jllrRgUBUQsGpCvy5NVL+gB8
 lhEo+qVJmxmGmT6o0g1nqWttNWpKWOXBo1THCA==
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

Fill the struct uart_port->mapsize field and use it, insteaf of
hardcoded values in many places. This makes the code layout a bit
more consistent and easily allows using generic helpers for the
io memory handling.

Candidates for such helpers could be eg. the request+ioremap and
iounmap+release combinations.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 227af87..1184226 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -658,7 +658,7 @@ static void sbd_release_port(struct uart_port *uport)
 
 	if(refcount_dec_and_test(&duart->map_guard))
 		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
-	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+	release_mem_region(uport->mapbase, uport->mapsize);
 }
 
 static int sbd_map_port(struct uart_port *uport)
@@ -668,7 +668,7 @@ static int sbd_map_port(struct uart_port *uport)
 
 	if (!uport->membase)
 		uport->membase = ioremap_nocache(uport->mapbase,
-						 DUART_CHANREG_SPACING);
+						 uport->mapsize);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
@@ -693,7 +693,7 @@ static int sbd_request_port(struct uart_port *uport)
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int ret = 0;
 
-	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
+	if (!request_mem_region(uport->mapbase, uport->mapsize,
 				"sb1250-duart")) {
 		pr_err(err);
 		return -EBUSY;
@@ -716,7 +716,7 @@ static int sbd_request_port(struct uart_port *uport)
 		}
 	}
 	if (ret) {
-		release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		release_mem_region(uport->mapbase, uport->mapsize);
 		return ret;
 	}
 	return 0;
@@ -812,6 +812,7 @@ static void __init sbd_probe_duarts(void)
 			uport->ops	= &sbd_ops;
 			uport->line	= line;
 			uport->mapbase	= SBD_CHANREGS(line);
+			uport->mapsize	= DUART_CHANREG_SPACING;
 		}
 	}
 }
-- 
1.9.1

