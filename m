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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A4CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 22:18:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7D020825
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 22:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPgnN6dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7D020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBqcG62VZzDr5d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 08:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::644;
 helo=mail-ej1-x644.google.com; envelope-from=olteanv@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JPgnN6dr; dkim-atps=neutral
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBj5F2zkTzDqTM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 03:24:46 +1000 (AEST)
Received: by mail-ej1-x644.google.com with SMTP id a21so3050269ejj.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DhWfch+PbL1rQUKAB1Yk9Mz5NfmZT5/0+GFbc58nQRA=;
 b=JPgnN6drMAWSqcalRvAHbi0jprbFBhTZt1Fn+Up3YHmEI9TXEVsbihS5m2v2jujTKi
 th+lqbLKWG8TJ9CK6MfNGiug1PEN44TkCOkoClPK/KoD1Cqe/ML8+pjQth/jdEGj+0s1
 AY0Mw4qCAXD87ReSQhInThTLddZMtBMGwtjqbnNeNy/GVDzQ4itqL74NXieTbN2AFm1C
 q+KKie38osW0q36ugZHVa8jtjoyRwyFmjoGPS564y8uHeU+WRIb+ARpMl2n/VqNZflml
 12WXUwRj/OS8cLeEaOhl4UdhyKWuDrMkX+VVl0WZavZNQle66LP+ClKDqvc2MEijcLrM
 7gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DhWfch+PbL1rQUKAB1Yk9Mz5NfmZT5/0+GFbc58nQRA=;
 b=aH0nz/HKJzRyOzxpdGW0EaBrPwx/4Gk/1fo8p06sUMhPd6hBiOqBsuJuyg2IJItXdg
 WiIBoB/odmaSvK1yPIMxjcXXuI5IZvK8ONI+Z0D050VwxVf7iDYeAbnLkfMvYCwTVggE
 rtLQbG5jUl4SWGvHipeXBj8wVG/qIRkcN54yP++W/dQ+XIpEYgtcdNCEd8cjmbSRYx51
 XTkDaqQMHQOcJYw+oXSasEz2I4/Bxsq7eJqv3jFiEHwgdO1ooQ2XyIe6fyqiIfEK6U6n
 2+CgnsfHlugVKDUYr5nighoyuygNKtOZiyrstd6ATP2731IhaJO7Af0EdyvwEK/Feor7
 w27Q==
X-Gm-Message-State: AOAM532dyFzQXT2p4sARN3/OGQNG2//b/6L7D/dZlkxKpG6n9H536E/p
 dJvpi/Z+2mcr7UT2SEPcF40=
X-Google-Smtp-Source: ABdhPJwYA3wRe1o4pTeacQVi3bgm1z+xiH580Qd8+l/C/geLfJNkokneg3yRCMBmAP0GNjMZ2wgNiw==
X-Received: by 2002:a17:906:a253:: with SMTP id
 bi19mr588879ejb.338.1595438682371; 
 Wed, 22 Jul 2020 10:24:42 -0700 (PDT)
Received: from localhost.localdomain ([188.25.219.134])
 by smtp.gmail.com with ESMTPSA id bt26sm311517edb.17.2020.07.22.10.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 10:24:41 -0700 (PDT)
From: Vladimir Oltean <olteanv@gmail.com>
To: robh+dt@kernel.org, shawnguo@kernel.org, mpe@ellerman.id.au,
 devicetree@vger.kernel.org
Subject: [PATCH devicetree 2/4] powerpc: dts: t1040: label the 2 MDIO
 controllers
Date: Wed, 22 Jul 2020 20:24:20 +0300
Message-Id: <20200722172422.2590489-3-olteanv@gmail.com>
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

In preparation of referencing the MDIO nodes from board DTS files (so
that we can add PHY nodes easier), add labels to mdio0 and mdio1.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 4af856dcc6a3..e1b138b3c714 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -620,11 +620,11 @@ enet3: ethernet@e6000 {
 		enet4: ethernet@e8000 {
 		};
 
-		mdio@fc000 {
+		mdio0: mdio@fc000 {
 			interrupts = <100 1 0 0>;
 		};
 
-		mdio@fd000 {
+		mdio1: mdio@fd000 {
 			status = "disabled";
 		};
 	};
-- 
2.25.1

