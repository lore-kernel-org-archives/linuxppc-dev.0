Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A28C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 22:20:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2182071A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0fnGmpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2182071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBqfF4fFJzDr3l
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 08:20:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::543;
 helo=mail-ed1-x543.google.com; envelope-from=olteanv@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=d0fnGmpq; dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBj5H2LlbzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 03:24:48 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id b15so2246649edy.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IwiK0U+Dhjv5R+D7L68/33/y00cq8SjNmUGfjDZfVnI=;
 b=d0fnGmpqyawQ6ZYxmbsWP6gl4hH8VZ6oUxfyea9jfSgAlL1mLymyW1fokoRJvAxg+H
 nlvajnhjmIzmBmnwyvX5fIjTcEWEPB4zIn0sYqns8vUqTWhFpX9fkQV21VFg7foAKeJm
 KLb48FjP3k9d5Q6Bq0GxgeCjC04cq0vnYj/KDJP94v7UEGtsQdSIaLDi3vOQlC5aVhEV
 qFj9sYBIjqlkHNfabEpR2Yp6ukw/GsWQfMrQHeUwKFlbmgdWiKpyQMmbC2CWDrSEVp+M
 zMyn/VPPsXBwVsmG+3TBI6HR3KTrdmUNyXEaSut29/0TdDxDrCyqwPa9oGLlBijDxvnA
 omsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IwiK0U+Dhjv5R+D7L68/33/y00cq8SjNmUGfjDZfVnI=;
 b=AT50+QB0I3sskakoa3tB+24tKsy7GdgKFTV4j8c0mJkMi42mgkuZwwaZLZiIdX7Btj
 9VQ7r4ywmQN6ECd1IFt8oI5hIfsYvGGfzFnxuBySD9YfeLmAP9n6ZoCZcK3RkKc65eNv
 r5ZRnA1sCmQoXE6rs4rccmU4y1lVUOy8ZlkhUVTyCF3gUgDQ6kGbo+E6JwlB5kgVR9KB
 7nqGBGAWS3PRRCxPskoaM/XJeYhj3V/0TVKlgGy3kTBVGuGbFkM9KsACFNIJa740gg5g
 bSAaWP4xdKu041wNFoS0uqj6vyZLIC5rID/UNj0ysb6i18HZ2vE4KDbQT1dKyxQYlgJI
 nf/g==
X-Gm-Message-State: AOAM531tuYkOroyb2UcXBzaPSDM5mQjZbzDPGG5jDYS5xEsZQXPe4y9H
 8s6E/V83aJZC7aSCvqqw2Dg=
X-Google-Smtp-Source: ABdhPJwN32en1tjwVds6TL6SW0e/xdD/1wt15akze77kDflk28RHrFyCzGDTRIFEKftNULw8jz/XBQ==
X-Received: by 2002:a50:d55b:: with SMTP id f27mr514751edj.312.1595438684854; 
 Wed, 22 Jul 2020 10:24:44 -0700 (PDT)
Received: from localhost.localdomain ([188.25.219.134])
 by smtp.gmail.com with ESMTPSA id bt26sm311517edb.17.2020.07.22.10.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 10:24:44 -0700 (PDT)
From: Vladimir Oltean <olteanv@gmail.com>
To: robh+dt@kernel.org, shawnguo@kernel.org, mpe@ellerman.id.au,
 devicetree@vger.kernel.org
Subject: [PATCH devicetree 4/4] powerpc: dts: t1040rdb: add ports for Seville
 Ethernet switch
Date: Wed, 22 Jul 2020 20:24:22 +0300
Message-Id: <20200722172422.2590489-5-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722172422.2590489-1-olteanv@gmail.com>
References: <20200722172422.2590489-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2020 08:08:50 +1000
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
Cc: madalin.bucur@oss.nxp.com, linux-kernel@vger.kernel.org,
 radu-andrei.bulie@nxp.com, fido_max@inbox.ru, paulus@samba.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Define the network interface names for the switch ports and hook them up
to the 2 QSGMII PHYs that are onboard.

A conscious decision was taken to go along with the numbers that are
written on the front panel of the board and not with the hardware
numbers of the switch chip ports. The 2 are shifted by 4.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 arch/powerpc/boot/dts/fsl/t1040rdb.dts | 111 +++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index 40d7126dbe90..28ee06a1706d 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -75,4 +75,115 @@ &mdio0 {
 	phy_sgmii_2: ethernet-phy@3 {
 		reg = <0x3>;
 	};
+
+	/* VSC8514 QSGMII PHY */
+	phy_qsgmii_0: ethernet-phy@4 {
+		reg = <0x4>;
+	};
+
+	phy_qsgmii_1: ethernet-phy@5 {
+		reg = <0x5>;
+	};
+
+	phy_qsgmii_2: ethernet-phy@6 {
+		reg = <0x6>;
+	};
+
+	phy_qsgmii_3: ethernet-phy@7 {
+		reg = <0x7>;
+	};
+
+	/* VSC8514 QSGMII PHY */
+	phy_qsgmii_4: ethernet-phy@8 {
+		reg = <0x8>;
+	};
+
+	phy_qsgmii_5: ethernet-phy@9 {
+		reg = <0x9>;
+	};
+
+	phy_qsgmii_6: ethernet-phy@a {
+		reg = <0xa>;
+	};
+
+	phy_qsgmii_7: ethernet-phy@b {
+		reg = <0xb>;
+	};
+};
+
+&seville_port0 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_0>;
+	phy-mode = "qsgmii";
+	/* ETH4 written on chassis */
+	label = "swp4";
+	status = "okay";
+};
+
+&seville_port1 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_1>;
+	phy-mode = "qsgmii";
+	/* ETH5 written on chassis */
+	label = "swp5";
+	status = "okay";
+};
+
+&seville_port2 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_2>;
+	phy-mode = "qsgmii";
+	/* ETH6 written on chassis */
+	label = "swp6";
+	status = "okay";
+};
+
+&seville_port3 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_3>;
+	phy-mode = "qsgmii";
+	/* ETH7 written on chassis */
+	label = "swp7";
+	status = "okay";
+};
+
+&seville_port4 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_4>;
+	phy-mode = "qsgmii";
+	/* ETH8 written on chassis */
+	label = "swp8";
+	status = "okay";
+};
+
+&seville_port5 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_5>;
+	phy-mode = "qsgmii";
+	/* ETH9 written on chassis */
+	label = "swp9";
+	status = "okay";
+};
+
+&seville_port6 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_6>;
+	phy-mode = "qsgmii";
+	/* ETH10 written on chassis */
+	label = "swp10";
+	status = "okay";
+};
+
+&seville_port7 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_7>;
+	phy-mode = "qsgmii";
+	/* ETH11 written on chassis */
+	label = "swp11";
+	status = "okay";
+};
+
+&seville_port8 {
+	ethernet = <&enet0>;
+	status = "okay";
 };
-- 
2.25.1

