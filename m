Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74206C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 04:52:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAE52133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 04:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdsT6kda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAE52133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fpYR5ZWMzDqQH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 14:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=lukas.bulwahn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LdsT6kda"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fp1N0jDmzDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 14:28:18 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id h4so5361746wre.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 21:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=txS5K0t/babaX0UQdaUfV/KGVtvAv9X5zQGn/++TGrg=;
 b=LdsT6kdaBTy2aZHxulrRPGENURohhTDEn5wKVqlS8HIqq00zyT9lC4vx5tfVWIKDbq
 WbhYZcyVIkxcFicA7F8+WJonkXACTnVHAkrwu4jj2pZzfqu6c+Ani6w30XGCevJLxRku
 XjZfuyZiRVuK3tDEzphD+Cmx78LOBu/id7XSKggI+exjXi3aYBmhbw/gP/8kjKLYYyzN
 71dH1v8qol/xb/FLU22ZAnsdZ/BjcjYzJXl9iFB/dDxQG2EY3AFrhnmGz1Gcs4TTjZ2a
 QWGpHcHJzDBrXO+wRR5m3FXqxLBMWMJ4Vhw2M922tr2B3Nh0oJllTquvxXxrZEViCO/W
 B8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=txS5K0t/babaX0UQdaUfV/KGVtvAv9X5zQGn/++TGrg=;
 b=FlzNB18bsOSNpSTAHJmRqbhpNNcRe6Oyd1ZIFbkj7y5kecpYgqchUS+TqY7V7ju9Vw
 jtXHblEZzPostAdE4KiJplPChE8DHhwHB36zurxiPjszwlF7IVjq74EL2BoVmlGI4dPK
 JssuytnCPfLoD+ZMNpddfKiiomxeyJLxFmrTcE9SafwWAWzHlHEHcaOEFw9LGmUMqBPg
 BVlkP7bgFGTs3IqFVNfOSUxFfsAWBFzSHzh9row2kkEVKJBg5YEy/79P//aNOgGgM6tj
 7/POIXBzqKNhwARoo9l++BtpOYKhZHlkfqrCjIQieIDuIijvDTfm2DcV1AAaq1GecMV3
 wJwQ==
X-Gm-Message-State: APjAAAWmRkMzTq8tVitTrT1u8mNWu9OuXKYepUUO4RPty0PCIb5MwfjR
 EXR9l6BPM5C8/qpE3ik7INE=
X-Google-Smtp-Source: APXvYqx3xvbhrM2S93Nr5TbEahE4hspgM2cJxcCwnO1V1Q0oLSVQVl8o9wriOtqqeqr23tjvO6L7VQ==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr30217032wrm.225.1554956889461; 
 Wed, 10 Apr 2019 21:28:09 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da5:5700:805e:d3ab:f95:5de])
 by smtp.gmail.com with ESMTPSA id 204sm6376153wmc.1.2019.04.10.21.28.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 21:28:08 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com addresses
Date: Thu, 11 Apr 2019 06:27:52 +0200
Message-Id: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 11 Apr 2019 14:51:11 +1000
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
Cc: linux-pci@vger.kernel.org, "Paul E . McKenney" <paulmck@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
to @linux.ibm.com in commit 1dfddcdb95c4
("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
some still remained.

We update the remaining email addresses in MAINTAINERS, hopefully finally
catching all cases for good.

Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

Tyrel, please take this patch. Thanks.

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..454b3cf36aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7439,14 +7439,14 @@ F:	drivers/crypto/vmx/ghash*
 F:	drivers/crypto/vmx/ppc-xlate.pl
 
 IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
-M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-pci@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	drivers/pci/hotplug/rpaphp*
 
 IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
-M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-pci@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
@@ -10388,7 +10388,7 @@ F:	arch/arm/mach-mmp/
 
 MMU GATHER AND TLB INVALIDATION
 M:	Will Deacon <will.deacon@arm.com>
-M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
+M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Nick Piggin <npiggin@gmail.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.17.1

