Return-Path: <SRS0=vA0f=6V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50AAC35280
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 21:37:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B751208DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 21:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B751208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49J6Hk0vbXzDqv5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 07:37:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=stevens-zone.net (client-ip=212.227.126.130;
 helo=mout.kundenserver.de; envelope-from=darren@stevens-zone.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49J6Bs1XlszDqjZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 07:33:07 +1000 (AEST)
Received: from Cyrus.lan ([80.189.87.220]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.163]) with ESMTPA (Nemesis) id
 1MLi4W-1joL1O30xE-00HeSz; Thu, 07 May 2020 23:32:58 +0200
Date: Thu, 7 May 2020 22:15:50 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org, oss@buserror.net
Subject: [PATCH 4/5] powerpc/mpc85xx: Add Cyrus HDD LED
Message-ID: <20200507221550.6b02a290@Cyrus.lan>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; powerpc-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eu1dSSV+zkmibQANbadquMydJV16qkeRQh8wTyhLZu2VWUO0suK
 /lV6lSM9ZAqrRz8olDWEYnxbwNjU/bsxXrQOpx9+AiCp4SGvvKfKgpKMQcd3nSmMTONDDX6
 a4IMWbdm9r3nk8A/Oc6BMxg6rmMQsZ6ay3a6394kJsgMQxeIpF2RgkR7Auo4Ksk+O0lVtEV
 uuYNZZJaJrb394ql6e6Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAi2k/2P3BQ=:l+/GVb0SKesni5RytrC/e3
 JgY+p2mYa/yKpJ9eNvDepSzjdT7/3aIt4STxAwKn/zBIpS930axU+Oj2WKIoaqynISFE9rcMJ
 ckRB5R5BeeGR9Xx2X+kXldjN+3tU6O8Saytn5yJQnFUtg4kPn6LZym/CreX96VzeXm1licUPv
 1CWoNwjKlMTOm9JQVZs1uJPsa/bqbp1awlDTp4xXnoTQ2IIvay+baqQgbgxojwXf29YzKZxIJ
 DUXPNjTzwB0rc7vBNkumRyT8hfSTc9DQE2Hu2wEoVzGhfmRDr7k+NvQdQcyJ5BmYXRiPklyR2
 zHyBvbUmPqxqLJq6FMBhuGSDKm3xxy7Z4meWSoZNh8bfeCQFDkZSesUTE9zsQAzdXj7uxqzKy
 kTf4rhSxvn4mppPNeJyoIowoyD4cVKm32CGoRGQxR4RU7ZsWDPOu84xtVG5ZNWHRy/2lZiKP5
 MS3VzlKAtU4ZelWeLgRbWojG1k6YhU11sUNqXInrSDp5SDbVYPcJsD9zeljjapHj/xFiYwYvb
 Q4hGrEsfmlawdBxpxioHpHyQZmy80zRFLVJAra6IcqeRHxiP1qjV+QXYBeHcw6HqgE2dGy4Z8
 bjPcnJgFuLW57gKIM9JPJESuGwC9s/Xihnv9Xuv+DzpbRr9nEMTrdXQMg2wgUkpboThboA4WO
 cdt5TkUgkTd3OfB8B2FdJKfSwgTOlgjbVNIE1/m3e+mW2sUherVthsrf1hhfP3fCb030tvZQ+
 YAf6Kj7HsE12X3wZ6phkWtC5Kt8422O9ODD84MQ82SblRiGX/msHA+3jyzPzaEk6GmwJzsNaQ
 p0GHbJQ7u1MbApnzuqqfphQ8fP6qPh3QnXCeC/vD1FyI1mSX+uQ9S2ZclTxJxjq97FiI30I
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

The Cyrus board has its HDD LED connected to a GPIO pin. Add a device
tree entry for this.

Signed-off-By: Darren Stevens <darren@stevens-zone.net>

---
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts index f0548fe..74c100f
100644 --- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
+++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
@@ -83,6 +83,16 @@
 			gpios = <&gpio0 2 1>;
 		};
 
+		leds {
+			compatible = "gpio-leds";
+
+			hdd {
+				label = "Disk Activity";
+				gpios = <&gpio0 5 0>;
+				linux,default-trigger =
"disk-activity";
+			};
+		};
+
 		fman@400000 {
 			mdio@e1120 {
 				phy3: ethernet-phy@3 {
