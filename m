Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6CEC61CE8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 16:20:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A002084F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 16:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLiTw/CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A002084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hjhf2fg8zDr1R
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 03:20:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLiTw/CX"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hjg04H9jzDqtr
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 03:18:52 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id z9so8114367pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p2JF6kCxDVwm8ztbo8DbVkB8buCPaFSdA3+ZOMTjwkM=;
 b=ZLiTw/CXvBtjwyP+b3HA/yOdrHasdukHyaN6/wZirWWGx9OG3v+a30Py2h9jHoJ7Ry
 /rSnbzrzDwQuD94mhLoVlk7PrhHb+uzYi8BtA4exDWbI+2RKHspc8EQAP8iYaz8dVJ1d
 YZutH9PtQd0wDltZuooF6B83Oz7EYRFMxbTQdLhaj2MvnC7sy4p+N7cUz384f3mlYg8X
 JT4FmSyt1YIjy1Gled6wthM43OhU8JggppJnBQ+xLEaSoFdiHFkFh0EMYJxJSlcPulNo
 EpAOqActKeYTd8IAR7r/hECfF2YhBgJw00kYBjpgJedOQIKgHSOA/zYTNviXA/UknD79
 qJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=p2JF6kCxDVwm8ztbo8DbVkB8buCPaFSdA3+ZOMTjwkM=;
 b=SVs/WGU8Amad8VwhzBxrFzK2JI1mJNChSrM4GsgbDK6RTZfynSG1YZbZSOns1KHLZt
 ruywocKyPdS7u206f5Bte5PbrWzbP5jQc64KZPknxoS0An5jSuCXN6Q9DBgIDzW5BC+f
 2Fm3QlwSdwKoK7R14IjIrc/6TF64BaEmZS1ApzBucsq9XjUw/dF2heLQduMtBveKvgyT
 Y/gerkKUMdnlDy9U4pTrwn+OZuBV37OSY2cMr5z41lIquX6xsG+XUBtsDuuQ4h8FTuvy
 uf2+FsarISq/XyfBigU/uHB3espvv6g+8amMoxMatCDPrnTDhznpA1VPDHqASP9MVSQm
 Kexw==
X-Gm-Message-State: AJcUukf0NxRU/HZHYY99VUo9HPiCH3QAhPD5G5yCDjCdZExHnDi8zflS
 31imCJbRHlOsccAKk9y/kac=
X-Google-Smtp-Source: ALg8bN4HtuFQjUdq0KEw4xzV43Dbambc7GeLtCaeSodr71/pe2oY5aBPk6qJM9PbTzbp1CLLaMQCSw==
X-Received: by 2002:a62:2cf:: with SMTP id 198mr23792285pfc.67.1547914730497; 
 Sat, 19 Jan 2019 08:18:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d16sm8748888pgj.21.2019.01.19.08.18.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 08:18:49 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc: chrp: Use device_type helpers to access the node
 type
Date: Sat, 19 Jan 2019 08:18:45 -0800
Message-Id: <1547914725-12125-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
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
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The node type can no longer be accessed directly, resulting in the
following build error. Use accessor function instead.

arch/powerpc/platforms/chrp/setup.c: In function ‘chrp_init_IRQ’:
arch/powerpc/platforms/chrp/setup.c:541:33: error:
	‘struct device_node’ has no member named ‘type’

Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: of_node_is_type() checks if the node pointer is NULL, so there is
    no need to check it before calling the function.

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
2.7.4

