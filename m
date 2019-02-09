Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D16C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 23:18:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7320521919
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 23:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7320521919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xnzG54qjzDqSy
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 10:18:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xnxR201szDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 10:16:42 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.237]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.179]) with ESMTPA (Nemesis) id
 1MMXcP-1gZ0dw0ly3-00JYQn; Sun, 10 Feb 2019 00:16:35 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org,
	oss@buserror.net
Date: Sat, 09 Feb 2019 23:14:41 +0000 (GMT)
Message-ID: <4d531fb8828.51b92386@auth.smtp.1and1.co.uk>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: [PATCH] powerpc/85xx: Activate Cyrus disk-activity LED
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:5oPvqf/wPwCBTyjg/77R1a1P0Y76v7cGy/t88Jq0yqqALo5CLV4
 2I7fz3Il73mV+J4cZ5JNxSL30CNosB6B4UbM/IGg5z/iWRIqJ2jrfpheh2WeyOFirxxw+FY
 GAnmCYZvREgKKN29Nw/2sKbpYWHajtImwBlw5bopB5WbLZ5aKcVsVDAaroDb1z3K87JiMUR
 ikYUjlPxm1+IYlcpxQdCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X9T/B51Hm4w=:m9Rtaf7eLWL4q8pbJQWPuv
 uNEavUTDehntwzPsrle9nz6H8Sq39n+ZTLqbMiS4bY7h2MbE45xh/ZZKl2FFpBCfSYyLRCLWB
 1K3/p1cqThenzYn4ZkGaoYclPIMr8mqKzU7Yy0yFYlzn+RJvq3rai90GL+oImQYTtu3HdTHWT
 MXxkRIYDBxll59eMyv9hIWZc2VZ4tDkqnWUSIwNKsuwJVcy+i6eEna2s03FU+0gSqsgOIlwJf
 grLKO6fxIBALeqYlu6xo/+0LlWWWAtENzqXwUjYDsizDNaZ7Ui35+pBU6odhqQYucKdWzs7xa
 pBn9rKV31phF0eiwg3Rh1pQgBLEG/W8T/wa2T+YgIaARiTlroOzvgbr3yLnYJF8RJiOpwPMVh
 U8EnoGJmLb/7pop2PO94ycNP5MMVo/d31j5iO8vw8mjv5lmPKqZVlrxkzH9XvAp745qzrVIGu
 TO6l4Aam+Csg0asVYiYxbF4TGntRRlgpfV2GHdJZALrZRxmsJw4KOUgZvXTcu1G08rD+geI+F
 YEltH4InihAzJhZUgy9zKzFdIWFhOCwKHEdL5Fp8/oph2Z1oawcbe0ZJ1fEYa1YU+eSKnt7mI
 MIn8zVtvnMmKErl73KOHhW11VSjN2zka59hp7sfRsJ6ozVDbYgQQ2Q2UTC4kTC93j9mpayy0x
 3ZQ7KoMOW1ntXSptmBYuom31AS6iSu1E9gfQcoIFIotwV2Lpa/UyVlt4P5zNUOa6RjXpAFbH1
 VvWpBdrMGWxDjU05V+h35WgVf92syDa50Ist2cGO+Eu+VpWCpwEb4qDjRF8=
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

The disk activity LED on the Cyrus board is attached to a gpio pin,
add the required device-tree node for the kernel driver to use.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

diff --git a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
index 15e8440..348cfdb 100644
--- a/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
+++ b/arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
@@ -82,6 +82,15 @@
            gpios = <&gpio0 2 1>;
        };
 
+       leds {
+           compatible = "gpio-leds";
+
+           hdd {
+               label = "Disk Activity";
+               gpios = <&gpio0 5 0>;
+               linux,default-trigger = "disk-activity";
+           };
+       };
    };
 
    rio: rapidio@ffe0c0000 {

