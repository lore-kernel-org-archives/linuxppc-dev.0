Return-Path: <SRS0=vA0f=6V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F9C38A2A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 21:42:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8E9208DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 21:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8E9208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49J6Pq6lQmzDr1Q
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 07:42:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=stevens-zone.net (client-ip=212.227.126.131;
 helo=mout.kundenserver.de; envelope-from=darren@stevens-zone.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49J6Bs17R1zDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 07:33:06 +1000 (AEST)
Received: from Cyrus.lan ([80.189.87.220]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.163]) with ESMTPA (Nemesis) id
 1MfHIZ-1iwLSb1P9H-00gs9G; Thu, 07 May 2020 23:32:58 +0200
Date: Thu, 7 May 2020 22:13:16 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org, oss@buserror.net
Subject: [PATCH 3/5] powerpc/mpc85xx: Add Cyrus Power-off and reset
Message-ID: <20200507221316.284e0d19@Cyrus.lan>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; powerpc-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:64McGM3Z+Dz/9QNgreqeG+BHsblXt1nCHUvA1sqw0Q1O8vjvKhe
 hGATtcmeY/Fa3oJxLVE/MyyL/fdgGTh6EKFtM7ASfd9c1r5IEVFC4/lPNGw95L60v1Yf5wm
 9yp8lO4z3FQiq2+4pUeMcbmk70bo3t/jwr/l9+pntdO86/B5cfjsyUvD+s10TZtMy2ThhDN
 SO6DW9ws2iFWLfKQB19BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:STImJKcutFk=:w6gIZ6Qn/B3h1bXZ5aws5X
 iTK9cjiflD3+4kxE5uwm0nz08BemywqBqrq7ylM7ePYJzWQWdZvZhta/tXDe/t/p5Z8Sohaos
 fxseEAjIhJPabV2a1Uqo+GYl3HQ+59LBOeCnvv18SeDc/2a9ZSFMJGh8sAs5k9qGTbisPlBdy
 6ari8GUOErhH8IOdy5BkbBwFSG8l6qSZ24FYJksz4n2CfvKcO76cY2QeJJcgircYyhhdIPPD8
 E4xGFzPbsArh6s26F5LC3ftmiuofxv0CI4Cv1i5NxGx/yiXTBCfXWXRjCQa1pYSh9Avx9KajT
 k9ot8qXSB2z2AeNF/D+k8n+ybRp9IXWwXVk0TY+VRN2gmmDluF0hS1XWVXwOOryZoKYDoGYcz
 3LpuMVQC3jdWXy5JVSuGGt3sYvzYtFT1H2y1EnsmjBVL9WOX8eHm9cufolHAjqv2NXGhIwWAY
 e7Shpdws1YC+BKakkGJADEiT+45Wlq0rHKGlYPrUiahULaULCuLd/jWCGjj4ixzCNbBz5ZeDi
 bjIbDGNDF33DF/Ujb9U6oyEKzdJo6+iRHMWvL92bEwAS3JKQgCfmC9H9e78N8bo/QasRL2hCW
 XlIF2wVN6/G055HlIqUSvKDSq3WuepceJkHhQC/ljZGGdW9xD6Vi5j6gahwnsB57bZdTCSCRX
 sEhp2whNZ1VBAZalSgkl+jFU3R4kX7jGLDpxXiIztcrShfOf08nNHwUldXc0eCP0E1TXPrYMc
 /EYRo76nnJmx62fKZwkiXulnINGuN9ouP5b8DLdZ1c4i2kbe4x4uSj8L0hKfTPpNe+8JyhBOa
 6c9vGIvxfNuJe5yjl6FaoU5baYTB3g3wiBoHd8X3xWVuqKczA1zXaTlPQTlTjzcBKXrLSWA
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
Cc: chzigotzky@xenosoft.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Cyrus board has GPIO connected power-off and reset, add device tree
nodes describing them.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts index bdf0405..f0548fe
100644 --- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
+++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
@@ -73,6 +73,16 @@
 			};
 		};
 
+		gpio-poweroff {
+			compatible = "gpio-poweroff";
+			gpios = <&gpio0 3 1>;
+		};
+
+		gpio-restart {
+			compatible = "gpio-restart";
+			gpios = <&gpio0 2 1>;
+		};
+
 		fman@400000 {
 			mdio@e1120 {
 				phy3: ethernet-phy@3 {
