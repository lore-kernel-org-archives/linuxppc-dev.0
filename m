Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5245CC43218
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:01:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4582087C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4582087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rrf45894zDqZR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:01:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.187; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrSf0jYwzDqYS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:53:21 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHoZS-1hX2X90am6-00EvFl; Sat, 27 Apr 2019 14:52:49 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 18/41] drivers: tty: serial: apbuart: use dev_info() instead
 of printk()
Date: Sat, 27 Apr 2019 14:51:59 +0200
Message-Id: <1556369542-13247-19-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:OVKGRVf0aXMWmtc1PHtqfEjiYENJhZU3hpSHmEA0npVSmInw18W
 peVVZAyjlFJAio3YAZ7zsEC8Fe2VQ89wyDlbJaIzUmZGMMp3iII6gzrN822v79B5j0vvLsh
 71zzSbmGgmkHHfJu8peOu878gwp/4AQZkem15Rl7F+pbbfe+1IRXXc3iTGk/vbwXXy8feJ1
 A4wTh5WhUYxm3/nJIj4hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJPYxrqUW4Q=:IX4zfaBz7w6xvHD6+zvUEx
 9lgTvdeuV59hcukEVZymu+p6tcoSHdR0K1YyNeMpb8uyuppx99cFXsn6a/2c3QwCqdTtaOI7b
 NM555G1mdTA4tx9beSLOpohIzVc1IAh0aF9aqOMLarv10YlFJVBypKsS7eozOr8YjLPwNCA7y
 xLNnSL9nvqoyuR6pmZ9cvRyyyP6/eYw4Fc/aHOZVjluv6XaHH1kDZqcwruoEvA55uYtvnSHac
 9MjLs8ftcbsYmjTSWf1ukKC9wrnPzPU62l5wd6argIoQ2M9shIoE9+TB45W0N7bfJyq0mDbaX
 TJHKhxyRPW+/7p9yUNV10hZ7DQE+aMsD5fm2A2ANmTrYm1EOuOJrwHBgNOvOC8EJ4+jTkk6/W
 BwDYOySXQ80cH6wqZIg+DXq1/w/mFQHSkmwtbd0oqKoJWF1i+ZJF+Ic9yETZqxb/VKtT1JjId
 aY7KauvC1h+u+2i6Ia65kuNV1gsqfMmGLLZjy0AiXOjEvc13FOU1AbsdYNOJA5WSEPHUqWLHT
 SoAIo9fOAKbG2KsIwCu7Zo2mryl45CvXBMMMbNQ9jt5fV9nD8v7BkFwLkMucoFwqTowZs8u5T
 g8EDSIiimu5RjbwcGKHM6HD5X5/g/5FrZKGvHbfpY29hrmOad8MLWYtKwnASbuVRUr6XWpvrq
 WJJr4n5/Cu72gbTk0oEBe4AhzNbI9tMroHYK2nYqhfZrYtIznaI/92IoE9ZcqFvyCxwmiSEKp
 6Y0UpIDYj+h2G2Yvy0Vj7nMLmkVAnbhBJyzm0A==
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
 drivers/tty/serial/apbuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index d2b86f7..89e19b6 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -568,7 +568,7 @@ static int apbuart_probe(struct platform_device *op)
 
 	apbuart_flush_fifo((struct uart_port *) port);
 
-	printk(KERN_INFO "grlib-apbuart at 0x%llx, irq %d\n",
+	dev_info(&pdev->pdev, "grlib-apbuart at 0x%llx, irq %d\n",
 	       (unsigned long long) port->mapbase, port->irq);
 	return 0;
 }
-- 
1.9.1

