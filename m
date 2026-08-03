Return-Path: <linuxppc-dev+bounces-25267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756BDC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 13:31:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDHcn3cR3z30F0;
	Mon, 03 Aug 2026 23:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785763865;
	cv=none; b=myPx/Yl55Wm55F8qyyuDKGxC58Y26aD1cxkrfwu9F/dpoi3ZY6lsOSZ17zhAYOAz+k9q0wja2BCyV2IOpzNC9LFI6OOA1FXlgMQKneaUs0zeF4splRwrcJNX4Q4VrrdLdolTOU1DxUyzLWSBaJHMaesaVbpnS4m5j878L3b3ak6O8TluiOAlAJLAIrA16EQrMAvtuJHPMO2sxSjxAXE2GSodXY0Cq12c+B89E59o+Xnj4YNy0mhgo96bD9tPhDGaUd4tRqida6f2SEShaUEoekwNghk/ndipfVhI3G2AlNBNbNP8K/g3ZwkSXWmCEaLpELtctypNb3IINeCu+wTvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785763865; c=relaxed/relaxed;
	bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2qm9tkakhImXe/nmJJ9KAhiLgK4t1NjDyY11aErpeHcrqY9Zd1jL70UzmDiwIni5SldFbYYAn2ruUO/MWlw0cnprnUZEmAiYahfYwZGsve6Mw2iWNdhRuCDck0JsP4+iXyS2UagFb1E/JpiSHlvt12K5NpMcCB6TfW+lrJwJm3nPp2Yh1kemQtNoZYVTbYO2uA+/Phu6x5nvsiml/wZh0LfRo8GxPsDMsqiVse+EqwzZBI+PTjWbOiTnDMFF5yp5zMnmRQ6VSao91h8d8k9DlnofMxadRSZn+3ORGp2WOMAV40lZrQsCXLiL3B8xwQv5qiDnas0oqAGVZsQBmMtnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pf/ThEF3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pf/ThEF3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDHcm0M6Wz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 23:31:03 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2500537a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763861; x=1786368661; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
        b=Pf/ThEF3gfcJtC8ideHkpndzo3OOEvYc22sFq+PgnyXNVkYSF7WEYyEWwn9bSgB0Ba
         WIl9EKBBfhYNRQb7k2gnHranQOnEIJQ1xyiR7OCAGT2lOS4JOgqz8qx1Pfq+hioDDK9B
         ZZlzWbZeKOQZMgoruivnqQ6fnbLrtYZvcWKdCCGrRSZ4aacgyrCMJSX6noeB2yGR2427
         A4EP0rVJd8kMF2/NCjz1tESKyAYKebtvUWX0G1pHylm0pqKTiWDmuVMbtxn0TKVGFvQS
         oqqo+qeLWsgXzi3nnvnMtFir7tEjKiFfcNVuZUPhODKUC1kBrABY0fjRRPRj+dw53jBc
         0FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763861; x=1786368661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
        b=SehmnqdafxnR6coVOeMpWh5qzFNtka7LJFcL29+zsUUnLkuHJScxgzaR2ymHFsy/dT
         //B+lLfqcZf1s/DLbnPLJq220lhx1P7DZMbJYfr97e7JrM9O+VZeDHi6ElHAxgdYPmTk
         id01YYs6S2OnkqwQwsafZIMQfvadfFX4n8fvMESqHukGxv/V/0d+jf6WLMSb+GEd0vRM
         eyUREoBZ5whNfAAyCZmD+weHl4S0YmZTzGm98ZdTtkusVq7OWlj+b+MljgXvDJ2LTC7D
         AA1c1+u62qGFpk8MnEMJwHP4UP/4OOkqI9kearUvNbaYojHdNai4VJtzhWAnFcbDDuX8
         109Q==
X-Forwarded-Encrypted: i=1; AHgh+RqsHMrl5veZzkepsgl4J+SRn4K2Tm0Utgb7yGVqk6hQ+kf76sYLq4TZQwW6eWgVy+KdZvRYiL3pjhyh6B0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycLDM8Ie9Zc0WnduU4X0KRAx1PjsbCuTwlcL6yKmrycmPumEce
	s8CZBsEaFE9bUhj0frQH6fE3o+Vnkkg67MUfnd2B6d3UJo5QUYrFn/4=
X-Gm-Gg: AR+sD12Pr8Ft59BSpo5CFtVa128fD9XzasgSJ3hXc/Nz/KzwCiFUNdtzYTcCbXEAKoi
	H3CSsanpv1HnNbWgVIdMdN15i4xyobe6ZKn0OMi465b18PdMKOMi3zOF3G9kC56WbYxp6Xq8kb/
	a0oqPzwDpArQh8c0pPw2JLUfSaoaiMaOagMtajuUacyYIIS14A+CdXE+hxFB7Dh63BdIFfwKhfx
	FZxpFW2zM5xtbmYakpDbCN9KagCwM2sl4UxA+PG7CWMsVMxdh4Myx1h9dQV8JDgTXwyhuzVLz1b
	HxCM1T47CX+3nThG19dq2L6Nu6id4+pvNbdWxk5vJhYWPmiVKmJHDM4nlTEy1l6JO9W36He2YCn
	I01zqwoL2rWNukB67Q9sZ7lzDDE6hLsDmfgb+L9LgMKE/73z0lR885xtDM0tXsvprQzfZWHIuB4
	mzmS9i9KzyoRSxjQXaOobniKWMXoaieFdto8rUmcCluVXciMbsWD/83RfHUF0JJqeZeczP0RHjB
	4a9qWSDHy2bG3wtnXk3Y3ynf4ZJgEYalApy6zRm5VmNcgKeBqOGDiKKfTn4Hy87i7al4U/SU5Qu
	MguV0lW/TCPqNG+yCcDTYNdzPSgEpZ7uDw==
X-Received: by 2002:a17:90b:3947:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38fbc3f246fmr8665430a91.1.1785763860528;
        Mon, 03 Aug 2026 06:31:00 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb259000bsm2531459a91.0.2026.08.03.06.30.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 06:30:59 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Mon,  3 Aug 2026 22:30:48 +0900
Message-ID: <20260803133048.42650-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that private object without unregistering or freeing the netdev, leaving
a registered device with a dangling private pointer.

Unregister and free the HDLC device before releasing its private object.
An active device must be closed before detach_hdlc_protocol(), because
the detach path resets dev->flags and clears IFF_UP. Otherwise the later
unregister_netdevice() skips ndo_stop, leaving NAPI, the UCC and its IRQ
active while their backing resources are freed.

Close the device inside unregister_hdlc_device() while RTNL is held and
the HDLC protocol is still attached. This lets uhdlc_close() disable NAPI,
stop the UCC and free the IRQ before the remove path releases the DMA and
private resources.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Close an active HDLC device before detaching its protocol so ndo_stop
  performs the NAPI, UCC and IRQ teardown noted by Simon Horman's review.
- Link to v1: https://lore.kernel.org/netdev/20260728171545.49247-1-mhun512@gmail.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 drivers/net/wan/hdlc.c         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93..4c843c94cf 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index cbed10b1d8..a38f90d300 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
+	dev_close(dev);
 	detach_hdlc_protocol(dev);
 	unregister_netdevice(dev);
 	rtnl_unlock();
-- 
2.47.1

