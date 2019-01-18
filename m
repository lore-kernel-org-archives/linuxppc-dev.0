Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C8C43444
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 14:37:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51C02063F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 14:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51C02063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h3SL4PkYzDr2k
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 01:37:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h3QG5jqQzDr1K
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 01:35:34 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id 32so14490252ota.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 06:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVGhT6BU39gUhAH6M0jr+uNLemL95swoAvyl8eRJ6FI=;
 b=Z0e+Uqtxg0L96MnZLcn41fPlv5zzCzOmmYfG2XfTL3Qi6aZsFdbsEyc773/Dm7GBHe
 QfKdoFXspLOHHYfSKeP8qF3ySQ5R4bXtB6eKWJKeVVV6m5HxdJzZ03bSlzFBIamgO4+k
 myzbVLCT9fvIMPwA4hQQDmZk2rpDYwmjJK6FOdp4gOc+U+tc4uyKBinJq9TtwSRmmVAK
 pULX1x6d+Wl8IWVttCou9krHI+TwgYr8U6FfoT0cJDF5HhMwxhEWD36Sh42Rt6yFRVtz
 E/eOFOjRpEpzTOlrylCLB6PiGHVvCmftqQc58cdG4IECA02/qnKkPBZ0cgG4l3SAiCMt
 574g==
X-Gm-Message-State: AJcUukdjy6ULztzJ6Xn3IphpEluKivK4B7j10XaIpChsixsOkpnhQZKQ
 ffxVYMa6SCb4HzaNmPCAIA==
X-Google-Smtp-Source: ALg8bN5Ptq+PNy/kuvFbCq58AbfrygjnpbikMXrpb1CD1H1RjCNXP08oP04eJ0y5V7mwGBr3yAaLhQ==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr12418915otn.172.1547822130556; 
 Fri, 18 Jan 2019 06:35:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm2101711otj.19.2019.01.18.06.35.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 06:35:30 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: chrp: Use of_node_is_type to access device_type
Date: Fri, 18 Jan 2019 08:35:29 -0600
Message-Id: <20190118143529.13347-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 8ce5f8415753 ("of: Remove struct device_node.type pointer")
removed struct device_node.type pointer, but the conversion to use
of_node_is_type() accessor was missed in chrp_init_IRQ().

Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Michael, I see you just sent a PR of fixes. I can send this to Linus if 
you prefer.

 arch/powerpc/platforms/chrp/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index e66644e0fb40..9438fa0fc355 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -538,8 +538,7 @@ static void __init chrp_init_IRQ(void)
 	/* see if there is a keyboard in the device tree
 	   with a parent of type "adb" */
 	for_each_node_by_name(kbd, "keyboard")
-		if (kbd->parent && kbd->parent->type
-		    && strcmp(kbd->parent->type, "adb") == 0)
+		if (of_node_is_type(kbd->parent, "adb"))
 			break;
 	of_node_put(kbd);
 	if (kbd)
-- 
2.19.1

