Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F96C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jan 2022 21:52:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JdjD16w5Kz3bVZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jan 2022 08:52:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=waldekranz-com.20210112.gappssmtp.com header.i=@waldekranz-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=dxSQq+S4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=waldekranz.com (client-ip=2a00:1450:4864:20::132;
 helo=mail-lf1-x132.google.com; envelope-from=tobias@waldekranz.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=waldekranz-com.20210112.gappssmtp.com
 header.i=@waldekranz-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=dxSQq+S4; dkim-atps=neutral
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JdjCD31q1z2yMj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jan 2022 08:51:17 +1100 (AEDT)
Received: by mail-lf1-x132.google.com with SMTP id x7so884965lfu.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jan 2022 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=Fh88UieW6M3tWsjtjC/VnGD/KSjEuK5OFMLJWUnuCow=;
 b=dxSQq+S4FDQSUQHu6og87yfSFEKZ7VwwgvfVP0ypGeLxAWpyg6p84iP92YGMNP3PbB
 RNtvkOFn5BYHTjAGLoLMBYk3RTL+qJSWtnEHNQFeXnwQvKFk86F8Opbk9G0UQLy2fIoA
 bPUCNja0E7VUKDij25LC6ZaxL0oEZKhq5AkQMaCB6pXwv3kh8bza+q+EDV1auYPY+8Uk
 VL5RtYkp7L5SYJrr6pwHvIvdBw/07aMvd7pCLyyaWHJMCTh/qLr0qOhedf+tiPx3gral
 TdFIMrs4KzEVqcvsiEIZSzoXnG0CV/TzKz/DAiI7a/BzxLMe2xBtxfjsva++gKE0GiQT
 aWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=Fh88UieW6M3tWsjtjC/VnGD/KSjEuK5OFMLJWUnuCow=;
 b=NGjp4+KCjrYErX8HiCp2OdST6B9+Byr95Avz/1CkoDl0jCz01m7vYA9t5IGIxCFpe3
 68EwNVzsS+QBtbNOioEhhraXEKsoUSMRTug01WxsDBz3DEARS7vjwHpxJURY27Iy4h5F
 904cZK697EA3RjB1eq4Wc6CHIuDV4ZGEVqlei2YEhsZCGzDi1n/OsUgI3Ko63tdC41ET
 pACsV4PGCdqqzQZq3Xe5kbLDpph6qx+Xhz8d5vvvrinEy2lfd+/8fubz4ccDcYlQMfxv
 NguNG2BU9pl74V+fipo1JwrrTESoZ6jPGnbI+zAlhJzTAEpgIN+/KylgNKReGlIaV0ip
 jQyA==
X-Gm-Message-State: AOAM531LJJgXiAH/3vdzFEIZeqNlAptmLKsVgHCFXZ8Yy6wh+91eHCwx
 r864DCy0t2KjsC8cqjSkvSjm0Q==
X-Google-Smtp-Source: ABdhPJxYJU4hIMsPmX47okJRLdOdBxNXXO11G7oGsTPSSdPTN2zTc/EXE0bTmhvpGf1opGlzns8huA==
X-Received: by 2002:a2e:144f:: with SMTP id 15mr21537821lju.326.1642542670287; 
 Tue, 18 Jan 2022 13:51:10 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se.
 [193.12.47.89])
 by smtp.gmail.com with ESMTPSA id w5sm1704808ljm.55.2022.01.18.13.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 13:51:09 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH v2 net 3/4] powerpc/fsl/dts: Enable WA for erratum A-009885 on
 fman3l MDIO buses
Date: Tue, 18 Jan 2022 22:50:52 +0100
Message-Id: <20220118215054.2629314-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118215054.2629314-1-tobias@waldekranz.com>
References: <20220118215054.2629314-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Shruti Kanetkar <Shruti@freescale.com>, linux-kernel@vger.kernel.org,
 Emil Medve <Emilian.Medve@Freescale.com>,
 Igal Liberman <Igal.Liberman@freescale.com>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This block is used in (at least) T1024 and T1040, including their
variants like T1023 etc.

Fixes: d55ad2967d89 ("powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA FMan")
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index c90702b04a53..48e5cd61599c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -79,6 +79,7 @@ mdio0: mdio@fc000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfc000 0x1000>;
+		fsl,erratum-a009885;
 	};
 
 	xmdio0: mdio@fd000 {
@@ -86,6 +87,7 @@ xmdio0: mdio@fd000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
+		fsl,erratum-a009885;
 	};
 };
 
-- 
2.25.1

