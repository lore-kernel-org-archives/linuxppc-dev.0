Return-Path: <B21284@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0583B7589
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 21:46:18 +1100 (EST)
Received: from mail65-am1 (localhost.localdomain [127.0.0.1])	by
	mail65-am1-R.bigfish.com (Postfix) with ESMTP id B81A69702C7	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 10:46:14 +0000 (UTC)
Received: from am1ehsmhs005.bigfish.com (unknown [10.3.201.254])	by
	mail65-am1.bigfish.com (Postfix) with ESMTP id BA4865F806A	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 10:45:56 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9CAjsPp003030	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 03:45:54 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9CB0plj021132	for <linuxppc-dev@ozlabs.org>;
	Tue, 12 Oct 2010 06:01:00 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>,
	<linux-mtd@lists.infradead.org>
Subject: [PATCH v4 5/5] mtd: m25p80: add support to parse the partitions by OF
	node
Date: Tue, 12 Oct 2010 18:18:34 +0800
Message-ID: <1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: david-b@pacbell.net, kumar.gala@freescale.com,
	Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
v4:
 - Updated to latest kernel base(Linux 2.6.36-rc7).
 - Made changes according to Grant's comments.

 drivers/mtd/devices/m25p80.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 6f512b5..9d20738 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -924,6 +924,11 @@ static int __devinit m25p_probe(struct spi_device *spi)
 			nr_parts = data->nr_parts;
 		}
 
+		if (nr_parts <= 0 && spi->dev.of_node) {
+			nr_parts = of_mtd_parse_partitions(&spi->dev,
+					spi->dev.of_node, &parts);
+		}
+
 		if (nr_parts > 0) {
 			for (i = 0; i < nr_parts; i++) {
 				DEBUG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
-- 
1.6.4
