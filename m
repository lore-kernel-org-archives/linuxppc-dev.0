Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EFC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 03:46:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3193D21927
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 03:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3193D21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MBHm4wQZzDqcQ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 14:46:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MBFW5xdGzDqXR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 14:44:30 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 (helo=home.buserror.net)
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>) id 1gaYB7-0000Rn-7f
 for linuxppc-dev@lists.ozlabs.org; Fri, 21 Dec 2018 21:42:17 -0600
Date: Fri, 21 Dec 2018 21:42:15 -0600
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <20181222034215.GA11704@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: [PATCH] powerpc/dts/fsl: Fix dtc-flagged interrupt errors
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

mpc8641_hpcn was updated to 4-cell interrupt specifiers, but
PCI interrupt-map was not updated.  It was also missing #interrupt-cells
on the outer PCI buses.

p1020rdb-pc was updated to 4-cell interrupt specifiers, but
the ethernet-phy nodes weren't updated.

mpc832x_rdb had an invalid "interrupts = <0>" on the ethernet-phy nodes.
Besides being the wrong number of cells, 0 is not a valid IPIC interrupt
according to ipic.c.  Presumably it was meant to indicate that these
PHYs are not connected to an interrupt.

Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts    | 128 +++++++++---------
 .../powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 128 +++++++++---------
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi |   2 +
 arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi    |   4 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts         |   4 -
 5 files changed, 132 insertions(+), 134 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
index 11bea3e6a43f..58ac17496c89 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -169,100 +169,100 @@
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0 0 1 &mpic 2 1
-			0x8800 0 0 2 &mpic 3 1
-			0x8800 0 0 3 &mpic 4 1
-			0x8800 0 0 4 &mpic 1 1
+			0x8800 0 0 1 &mpic 2 1 0 0
+			0x8800 0 0 2 &mpic 3 1 0 0
+			0x8800 0 0 3 &mpic 4 1 0 0
+			0x8800 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0 0 1 &mpic 2 1
-			0x8900 0 0 2 &mpic 3 1
-			0x8900 0 0 3 &mpic 4 1
-			0x8900 0 0 4 &mpic 1 1
+			0x8900 0 0 1 &mpic 2 1 0 0
+			0x8900 0 0 2 &mpic 3 1 0 0
+			0x8900 0 0 3 &mpic 4 1 0 0
+			0x8900 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0 0 1 &mpic 2 1
-			0x8a00 0 0 2 &mpic 3 1
-			0x8a00 0 0 3 &mpic 4 1
-			0x8a00 0 0 4 &mpic 1 1
+			0x8a00 0 0 1 &mpic 2 1 0 0
+			0x8a00 0 0 2 &mpic 3 1 0 0
+			0x8a00 0 0 3 &mpic 4 1 0 0
+			0x8a00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0 0 1 &mpic 2 1
-			0x8b00 0 0 2 &mpic 3 1
-			0x8b00 0 0 3 &mpic 4 1
-			0x8b00 0 0 4 &mpic 1 1
+			0x8b00 0 0 1 &mpic 2 1 0 0
+			0x8b00 0 0 2 &mpic 3 1 0 0
+			0x8b00 0 0 3 &mpic 4 1 0 0
+			0x8b00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0 0 1 &mpic 2 1
-			0x8c00 0 0 2 &mpic 3 1
-			0x8c00 0 0 3 &mpic 4 1
-			0x8c00 0 0 4 &mpic 1 1
+			0x8c00 0 0 1 &mpic 2 1 0 0
+			0x8c00 0 0 2 &mpic 3 1 0 0
+			0x8c00 0 0 3 &mpic 4 1 0 0
+			0x8c00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0 0 1 &mpic 2 1
-			0x8d00 0 0 2 &mpic 3 1
-			0x8d00 0 0 3 &mpic 4 1
-			0x8d00 0 0 4 &mpic 1 1
+			0x8d00 0 0 1 &mpic 2 1 0 0
+			0x8d00 0 0 2 &mpic 3 1 0 0
+			0x8d00 0 0 3 &mpic 4 1 0 0
+			0x8d00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0 0 1 &mpic 2 1
-			0x8e00 0 0 2 &mpic 3 1
-			0x8e00 0 0 3 &mpic 4 1
-			0x8e00 0 0 4 &mpic 1 1
+			0x8e00 0 0 1 &mpic 2 1 0 0
+			0x8e00 0 0 2 &mpic 3 1 0 0
+			0x8e00 0 0 3 &mpic 4 1 0 0
+			0x8e00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0 0 1 &mpic 2 1
-			0x8f00 0 0 2 &mpic 3 1
-			0x8f00 0 0 3 &mpic 4 1
-			0x8f00 0 0 4 &mpic 1 1
+			0x8f00 0 0 1 &mpic 2 1 0 0
+			0x8f00 0 0 2 &mpic 3 1 0 0
+			0x8f00 0 0 3 &mpic 4 1 0 0
+			0x8f00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0 0 1 &mpic 3 1
-			0x9000 0 0 2 &mpic 4 1
-			0x9000 0 0 3 &mpic 1 1
-			0x9000 0 0 4 &mpic 2 1
+			0x9000 0 0 1 &mpic 3 1 0 0
+			0x9000 0 0 2 &mpic 4 1 0 0
+			0x9000 0 0 3 &mpic 1 1 0 0
+			0x9000 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0 0 1 &mpic 3 1
-			0x9100 0 0 2 &mpic 4 1
-			0x9100 0 0 3 &mpic 1 1
-			0x9100 0 0 4 &mpic 2 1
+			0x9100 0 0 1 &mpic 3 1 0 0
+			0x9100 0 0 2 &mpic 4 1 0 0
+			0x9100 0 0 3 &mpic 1 1 0 0
+			0x9100 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0 0 1 &mpic 3 1
-			0x9200 0 0 2 &mpic 4 1
-			0x9200 0 0 3 &mpic 1 1
-			0x9200 0 0 4 &mpic 2 1
+			0x9200 0 0 1 &mpic 3 1 0 0
+			0x9200 0 0 2 &mpic 4 1 0 0
+			0x9200 0 0 3 &mpic 1 1 0 0
+			0x9200 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0 0 1 &mpic 3 1
-			0x9300 0 0 2 &mpic 4 1
-			0x9300 0 0 3 &mpic 1 1
-			0x9300 0 0 4 &mpic 2 1
+			0x9300 0 0 1 &mpic 3 1 0 0
+			0x9300 0 0 2 &mpic 4 1 0 0
+			0x9300 0 0 3 &mpic 1 1 0 0
+			0x9300 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0 0 1 &mpic 3 1
-			0x9400 0 0 2 &mpic 4 1
-			0x9400 0 0 3 &mpic 1 1
-			0x9400 0 0 4 &mpic 2 1
+			0x9400 0 0 1 &mpic 3 1 0 0
+			0x9400 0 0 2 &mpic 4 1 0 0
+			0x9400 0 0 3 &mpic 1 1 0 0
+			0x9400 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0 0 1 &mpic 3 1
-			0x9500 0 0 2 &mpic 4 1
-			0x9500 0 0 3 &mpic 1 1
-			0x9500 0 0 4 &mpic 2 1
+			0x9500 0 0 1 &mpic 3 1 0 0
+			0x9500 0 0 2 &mpic 4 1 0 0
+			0x9500 0 0 3 &mpic 1 1 0 0
+			0x9500 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0 0 1 &mpic 3 1
-			0x9600 0 0 2 &mpic 4 1
-			0x9600 0 0 3 &mpic 1 1
-			0x9600 0 0 4 &mpic 2 1
+			0x9600 0 0 1 &mpic 3 1 0 0
+			0x9600 0 0 2 &mpic 4 1 0 0
+			0x9600 0 0 3 &mpic 1 1 0 0
+			0x9600 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0 0 1 &mpic 3 1
-			0x9700 0 0 2 &mpic 4 1
-			0x9700 0 0 3 &mpic 1 1
-			0x9700 0 0 4 &mpic 2 1
+			0x9700 0 0 1 &mpic 3 1 0 0
+			0x9700 0 0 2 &mpic 4 1 0 0
+			0x9700 0 0 3 &mpic 1 1 0 0
+			0x9700 0 0 4 &mpic 2 1 0 0
 
 			// IDSEL 0x1c  USB
 			0xe000 0 0 1 &i8259 12 2
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
index 7ff62046a9ea..e64b91e321f6 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -136,100 +136,100 @@
 		interrupt-map-mask = <0xff00 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0 0 1 &mpic 2 1
-			0x8800 0 0 2 &mpic 3 1
-			0x8800 0 0 3 &mpic 4 1
-			0x8800 0 0 4 &mpic 1 1
+			0x8800 0 0 1 &mpic 2 1 0 0
+			0x8800 0 0 2 &mpic 3 1 0 0
+			0x8800 0 0 3 &mpic 4 1 0 0
+			0x8800 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0 0 1 &mpic 2 1
-			0x8900 0 0 2 &mpic 3 1
-			0x8900 0 0 3 &mpic 4 1
-			0x8900 0 0 4 &mpic 1 1
+			0x8900 0 0 1 &mpic 2 1 0 0
+			0x8900 0 0 2 &mpic 3 1 0 0
+			0x8900 0 0 3 &mpic 4 1 0 0
+			0x8900 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0 0 1 &mpic 2 1
-			0x8a00 0 0 2 &mpic 3 1
-			0x8a00 0 0 3 &mpic 4 1
-			0x8a00 0 0 4 &mpic 1 1
+			0x8a00 0 0 1 &mpic 2 1 0 0
+			0x8a00 0 0 2 &mpic 3 1 0 0
+			0x8a00 0 0 3 &mpic 4 1 0 0
+			0x8a00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0 0 1 &mpic 2 1
-			0x8b00 0 0 2 &mpic 3 1
-			0x8b00 0 0 3 &mpic 4 1
-			0x8b00 0 0 4 &mpic 1 1
+			0x8b00 0 0 1 &mpic 2 1 0 0
+			0x8b00 0 0 2 &mpic 3 1 0 0
+			0x8b00 0 0 3 &mpic 4 1 0 0
+			0x8b00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0 0 1 &mpic 2 1
-			0x8c00 0 0 2 &mpic 3 1
-			0x8c00 0 0 3 &mpic 4 1
-			0x8c00 0 0 4 &mpic 1 1
+			0x8c00 0 0 1 &mpic 2 1 0 0
+			0x8c00 0 0 2 &mpic 3 1 0 0
+			0x8c00 0 0 3 &mpic 4 1 0 0
+			0x8c00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0 0 1 &mpic 2 1
-			0x8d00 0 0 2 &mpic 3 1
-			0x8d00 0 0 3 &mpic 4 1
-			0x8d00 0 0 4 &mpic 1 1
+			0x8d00 0 0 1 &mpic 2 1 0 0
+			0x8d00 0 0 2 &mpic 3 1 0 0
+			0x8d00 0 0 3 &mpic 4 1 0 0
+			0x8d00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0 0 1 &mpic 2 1
-			0x8e00 0 0 2 &mpic 3 1
-			0x8e00 0 0 3 &mpic 4 1
-			0x8e00 0 0 4 &mpic 1 1
+			0x8e00 0 0 1 &mpic 2 1 0 0
+			0x8e00 0 0 2 &mpic 3 1 0 0
+			0x8e00 0 0 3 &mpic 4 1 0 0
+			0x8e00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0 0 1 &mpic 2 1
-			0x8f00 0 0 2 &mpic 3 1
-			0x8f00 0 0 3 &mpic 4 1
-			0x8f00 0 0 4 &mpic 1 1
+			0x8f00 0 0 1 &mpic 2 1 0 0
+			0x8f00 0 0 2 &mpic 3 1 0 0
+			0x8f00 0 0 3 &mpic 4 1 0 0
+			0x8f00 0 0 4 &mpic 1 1 0 0
 
 			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0 0 1 &mpic 3 1
-			0x9000 0 0 2 &mpic 4 1
-			0x9000 0 0 3 &mpic 1 1
-			0x9000 0 0 4 &mpic 2 1
+			0x9000 0 0 1 &mpic 3 1 0 0
+			0x9000 0 0 2 &mpic 4 1 0 0
+			0x9000 0 0 3 &mpic 1 1 0 0
+			0x9000 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0 0 1 &mpic 3 1
-			0x9100 0 0 2 &mpic 4 1
-			0x9100 0 0 3 &mpic 1 1
-			0x9100 0 0 4 &mpic 2 1
+			0x9100 0 0 1 &mpic 3 1 0 0
+			0x9100 0 0 2 &mpic 4 1 0 0
+			0x9100 0 0 3 &mpic 1 1 0 0
+			0x9100 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0 0 1 &mpic 3 1
-			0x9200 0 0 2 &mpic 4 1
-			0x9200 0 0 3 &mpic 1 1
-			0x9200 0 0 4 &mpic 2 1
+			0x9200 0 0 1 &mpic 3 1 0 0
+			0x9200 0 0 2 &mpic 4 1 0 0
+			0x9200 0 0 3 &mpic 1 1 0 0
+			0x9200 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0 0 1 &mpic 3 1
-			0x9300 0 0 2 &mpic 4 1
-			0x9300 0 0 3 &mpic 1 1
-			0x9300 0 0 4 &mpic 2 1
+			0x9300 0 0 1 &mpic 3 1 0 0
+			0x9300 0 0 2 &mpic 4 1 0 0
+			0x9300 0 0 3 &mpic 1 1 0 0
+			0x9300 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0 0 1 &mpic 3 1
-			0x9400 0 0 2 &mpic 4 1
-			0x9400 0 0 3 &mpic 1 1
-			0x9400 0 0 4 &mpic 2 1
+			0x9400 0 0 1 &mpic 3 1 0 0
+			0x9400 0 0 2 &mpic 4 1 0 0
+			0x9400 0 0 3 &mpic 1 1 0 0
+			0x9400 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0 0 1 &mpic 3 1
-			0x9500 0 0 2 &mpic 4 1
-			0x9500 0 0 3 &mpic 1 1
-			0x9500 0 0 4 &mpic 2 1
+			0x9500 0 0 1 &mpic 3 1 0 0
+			0x9500 0 0 2 &mpic 4 1 0 0
+			0x9500 0 0 3 &mpic 1 1 0 0
+			0x9500 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0 0 1 &mpic 3 1
-			0x9600 0 0 2 &mpic 4 1
-			0x9600 0 0 3 &mpic 1 1
-			0x9600 0 0 4 &mpic 2 1
+			0x9600 0 0 1 &mpic 3 1 0 0
+			0x9600 0 0 2 &mpic 4 1 0 0
+			0x9600 0 0 3 &mpic 1 1 0 0
+			0x9600 0 0 4 &mpic 2 1 0 0
 
 			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0 0 1 &mpic 3 1
-			0x9700 0 0 2 &mpic 4 1
-			0x9700 0 0 3 &mpic 1 1
-			0x9700 0 0 4 &mpic 2 1
+			0x9700 0 0 1 &mpic 3 1 0 0
+			0x9700 0 0 2 &mpic 4 1 0 0
+			0x9700 0 0 3 &mpic 1 1 0 0
+			0x9700 0 0 4 &mpic 2 1 0 0
 
 			// IDSEL 0x1c  USB
 			0xe000 0 0 1 &i8259 12 2
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
index eeb7c65d5f22..50039d4fa278 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
@@ -97,6 +97,7 @@
 &pci0 {
 	compatible = "fsl,mpc8641-pcie";
 	device_type = "pci";
+	#interrupt-cells = <1>;
 	#size-cells = <2>;
 	#address-cells = <3>;
 	bus-range = <0x0 0xff>;
@@ -123,6 +124,7 @@
 &pci1 {
 	compatible = "fsl,mpc8641-pcie";
 	device_type = "pci";
+	#interrupt-cells = <1>;
 	#size-cells = <2>;
 	#address-cells = <3>;
 	bus-range = <0x0 0xff>;
diff --git a/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
index 25f81eea60e0..a13876c05c1e 100644
--- a/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
@@ -205,13 +205,13 @@
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
 			interrupt-parent = <&mpic>;
-			interrupts = <3 1>;
+			interrupts = <3 1 0 0>;
 			reg = <0x0>;
 		};
 
 		phy1: ethernet-phy@1 {
 			interrupt-parent = <&mpic>;
-			interrupts = <2 1>;
+			interrupts = <2 1 0 0>;
 			reg = <0x1>;
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 647cae14c16d..be6ef3531b28 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -311,13 +311,9 @@
 			compatible = "fsl,ucc-mdio";
 
 			phy00:ethernet-phy@0 {
-				interrupt-parent = <&ipic>;
-				interrupts = <0>;
 				reg = <0x0>;
 			};
 			phy04:ethernet-phy@4 {
-				interrupt-parent = <&ipic>;
-				interrupts = <0>;
 				reg = <0x4>;
 			};
 		};
-- 
2.17.1
