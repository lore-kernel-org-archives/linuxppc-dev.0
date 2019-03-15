Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F7C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 02:10:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4446F2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 02:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="MYzwGELu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4446F2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L8Dz33GxzDqQl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:10:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="MYzwGELu"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L8CC5JmJzDqQS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:09:09 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id n22so5164458pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 19:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y3kqJQ5xsOjs4aV1pFM0MeGV8X4Abqf24LZEIyvcPnE=;
 b=MYzwGELu/d1daXHH5m38Tz2y+m+vS0t/i7J7G1Tba0K6lEAE1PBJZrOKdMR1yR4H/y
 mdkh1NivJ7Ank2bMvpzjQrDN/Mhv0A2QHmxk6EdoM02KQIh6Wr44rBzDsevU2xTExpnb
 2uaERrNyy/xu+lragW9+cvIOaTuD2/XDPYSCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y3kqJQ5xsOjs4aV1pFM0MeGV8X4Abqf24LZEIyvcPnE=;
 b=BgQ/WS7bvE/c/Wb5fXcOMtL6wGcXRpJteEyEfW2bhSBbRHOcIME5TGhiqcRBVGxXLw
 eCUpntB7PkafvoAcRSAEDRSsfOIbXxlbI2s9YfqG5mjLPxYQX4BWWttHsewieSbEYiOH
 Cfb3Viw11w8LqZEZhFKcLzhihxUs5+KoXFJmoKETLqDEFPsU6dfx1TRfUT9DMXY1/Giu
 25ZmxHfk0fVeV8dqw8WlVng8kQEhU6t/JiMAoT5b7rfxUlJhOiOYnkuZR0hSWUWTnI5q
 PbP+20Bh3dDUqo08ZyvD85BOI8edy++aDtmNfRkBRaeChaHNIx5U+W65ZC2uySC/keXK
 l6xw==
X-Gm-Message-State: APjAAAWYTw1Wi3Kh8//R7Rs+mlvPPRTn0AvQ+pJKCCIZjAc9pe7KoRV+
 cecj9K4g7jqbNyRsD+xUwATY8w==
X-Google-Smtp-Source: APXvYqz4OAteB7F0UWElJ5HD5WmtiImAfV0WL0obe2SGPZSKJk4sI0S2qI7wlcwxjHcOlARBq8cw2w==
X-Received: by 2002:a65:534d:: with SMTP id w13mr1025397pgr.186.1552615745775; 
 Thu, 14 Mar 2019 19:09:05 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
 by smtp.gmail.com with ESMTPSA id j20sm472815pfh.141.2019.03.14.19.09.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Mar 2019 19:09:04 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: omosnacek@gmail.com, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
Date: Fri, 15 Mar 2019 13:09:01 +1100
Message-Id: <20190315020901.16509-1-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
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
Cc: leo.barbosa@canonical.com, Stephan Mueller <smueller@chronox.de>,
 nayna@linux.ibm.com, leitao@debian.org, pfsmorigo@gmail.com,
 marcelo.cerri@canonical.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The original assembly imported from OpenSSL has two copy-paste
errors in handling CTR mode. When dealing with a 2 or 3 block tail,
the code branches to the CBC decryption exit path, rather than to
the CTR exit path.

This leads to corruption of the IV, which leads to subsequent blocks
being corrupted.

This can be detected with libkcapi test suite, which is available at
https://github.com/smuellerDD/libkcapi

Reported-by: Ondrej Mosnáček <omosnacek@gmail.com>
Fixes: 5c380d623ed3 ("crypto: vmx - Add support for VMS instructions by ASM")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/crypto/vmx/aesp8-ppc.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
index d6a9f63d65ba..de78282b8f44 100644
--- a/drivers/crypto/vmx/aesp8-ppc.pl
+++ b/drivers/crypto/vmx/aesp8-ppc.pl
@@ -1854,7 +1854,7 @@ Lctr32_enc8x_three:
 	stvx_u		$out1,$x10,$out
 	stvx_u		$out2,$x20,$out
 	addi		$out,$out,0x30
-	b		Lcbc_dec8x_done
+	b		Lctr32_enc8x_done
 
 .align	5
 Lctr32_enc8x_two:
@@ -1866,7 +1866,7 @@ Lctr32_enc8x_two:
 	stvx_u		$out0,$x00,$out
 	stvx_u		$out1,$x10,$out
 	addi		$out,$out,0x20
-	b		Lcbc_dec8x_done
+	b		Lctr32_enc8x_done
 
 .align	5
 Lctr32_enc8x_one:
-- 
2.19.1

