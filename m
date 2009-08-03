Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0040BB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 22:38:33 +1000 (EST)
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225]) by ozlabs.org (Postfix) with ESMTP id 3400ADDD1B
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Aug 2009 22:38:30 +1000 (EST)
Received: by ewy25 with SMTP id 25so967563ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Aug 2009 05:38:27 -0700 (PDT)
Message-ID: <4A76DB06.7090405@gmail.com>
Date: Mon, 03 Aug 2009 14:41:42 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc: Read buffer overflow
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check whether index is within bounds before grabbing the element.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index a0f6838..588a5b0 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -294,10 +294,11 @@ static void macio_setup_interrupts(struct macio_dev *dev)
 	int i = 0, j = 0;
 
 	for (;;) {
-		struct resource *res = &dev->interrupt[j];
+		struct resource *res;
 
 		if (j >= MACIO_DEV_COUNT_IRQS)
 			break;
+		res = &dev->interrupt[j];
 		irq = irq_of_parse_and_map(np, i++);
 		if (irq == NO_IRQ)
 			break;
@@ -321,9 +322,10 @@ static void macio_setup_resources(struct macio_dev *dev,
 	int index;
 
 	for (index = 0; of_address_to_resource(np, index, &r) == 0; index++) {
-		struct resource *res = &dev->resource[index];
+		struct resource *res;
 		if (index >= MACIO_DEV_COUNT_RESOURCES)
 			break;
+		res = &dev->resource[index];
 		*res = r;
 		res->name = dev_name(&dev->ofdev.dev);
 
