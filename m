Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61506C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:47:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0EC60EFF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 21:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E0EC60EFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDZlL5Jzjz3f8x
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 07:47:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:828:c7c0:49:5ff:fe41:d261;
 helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr;
 receiver=<UNKNOWN>)
Received: from luna.linkmauve.fr (unknown
 [IPv6:2a01:e0a:828:c7c0:49:5ff:fe41:d261])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDZZz0NHxz3cBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 07:39:50 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id 88C64F40B68; Tue, 21 Sep 2021 23:39:43 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: linux-crypto@vger.kernel.org
Subject: [PATCH 0/4] crypto: nintendo-aes - add a new AES driver
Date: Tue, 21 Sep 2021 23:39:26 +0200
Message-Id: <20210921213930.10366-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: devicetree@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Ash Logan <ash@heyquark.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This engine implements AES in CBC mode, using 128-bit keys only.  It is
present on both the Wii and the Wii U, and is apparently identical in
both consoles.

The hardware is capable of firing an interrupt when the operation is
done, but this driver currently uses a busy loop, I’m not too sure
whether it would be preferable to switch, nor how to achieve that.

It also supports a mode where no operation is done, and thus could be
used as a DMA copy engine, but I don’t know how to expose that to the
kernel or whether it would even be useful.

In my testing, on a Wii U, this driver reaches 80.7 MiB/s, while the
aes-generic driver only reaches 30.9 MiB/s, so it is a quite welcome
speedup.

This driver was written based on reversed documentation, see:
https://wiibrew.org/wiki/Hardware/AES

Emmanuel Gil Peyrot (4):
  crypto: nintendo-aes - add a new AES driver
  dt-bindings: nintendo-aes: Document the Wii and Wii U AES support
  powerpc: wii.dts: Expose the AES engine on this platform
  powerpc: wii_defconfig: Enable AES by default

 .../bindings/crypto/nintendo-aes.yaml         |  34 +++
 arch/powerpc/boot/dts/wii.dts                 |   7 +
 arch/powerpc/configs/wii_defconfig            |   4 +-
 drivers/crypto/Kconfig                        |  11 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/nintendo-aes.c                 | 273 ++++++++++++++++++
 6 files changed, 329 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/nintendo-aes.yaml
 create mode 100644 drivers/crypto/nintendo-aes.c

-- 
2.33.0

