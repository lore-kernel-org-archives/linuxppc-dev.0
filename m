Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3127BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 09:51:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3922084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 09:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iykYtNKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447HKF0g4BzDqKS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 20:51:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=himadri18.07@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iykYtNKn"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447GC96y97zDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 20:01:25 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id i130so4207018pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0gtoIvKIgHOe3EmIZdTicjZMhayQYnHwgQwtxSB9MOY=;
 b=iykYtNKnsE++S9nssXz14vp65wsvPWnokH3msPz2CudhbAMoUs8ktHqgEODBdzz7UI
 vTTSfTIIke84gxJdY/zHZMVXWkVbxnCoKn3mjMNA5m+lh0gJc/a+yPsHzID4Gpan3wj0
 JuMVFmX6Q6M1z5gOFkXI9xAMrRJAARhoEwe7dQmc7eG/M4o6D7RPlkA4jV+MrxFeC6bH
 N8sjAnjG/a9jRSPNXSx+BzQkYXdLNbdmICZqVAYAY24y1Lr+rhLNkjflZXtp0dyLnMYV
 poqcyjnmxD8eUvs0eDRzKgmvKXgqgrMvDEiYCUVbLkBPohXl5BLu3uDdDYsOFuAe/aaE
 dp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0gtoIvKIgHOe3EmIZdTicjZMhayQYnHwgQwtxSB9MOY=;
 b=RyrLzFSYNhDPT582WTHU/cQbwBByyhr6fC83ZkSlWz/zEAacOxU9hfAm2clGPiRShR
 VdhKnzIhE6KVnXRS9xvUdyGkO5IzYFrKQeVHVre6ubeaOaeUERhwpU5ieR/rDNfw0emx
 iHwpO+IIZVHc4tBL1d9++Q2LvZJa3e7y+a0zZg35ftCS1btTUnj4ya5NpH5V5XubDcl2
 ZvzIv3NvsrXN1C7VXsV6oxsJSjm80jvWNfQ+jJMyeNbYwgBx9zaCtnoHbt5wLWPB+T8E
 oXs8c9xSaJ7aLuI/g0DNv5O81Hwcx0Pf+gNQodiGnrPHHV/hMCI7htQqCiVXtMW/3ogF
 PrzA==
X-Gm-Message-State: AHQUAuY+0ImW+EESsy6BjZJFhuoIFcKXIt+To1cNUXbZKA38TVJy1dU+
 6I89aW3VRuxAaqvTKvnxu44=
X-Google-Smtp-Source: AHgI3IZWggVp93GmEtGEyKifpd0lcnwtH/mtC32QQNMH18YFessRnCSJZxAM2ftYEvKKsLVrbJ9sWA==
X-Received: by 2002:a63:4542:: with SMTP id u2mr17786527pgk.291.1551085284210; 
 Mon, 25 Feb 2019 01:01:24 -0800 (PST)
Received: from localhost.localdomain (mx.daiict.ac.in. [220.225.53.35])
 by smtp.googlemail.com with ESMTPSA id
 t185sm16308645pfd.165.2019.02.25.01.01.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 01:01:23 -0800 (PST)
From: Himadri Pandya <himadri18.07@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH v2 2/2] arch: powerpc/hlwd-pic: Add missing of_node-put() in
 hlwd_pic_probe()
Date: Mon, 25 Feb 2019 14:30:56 +0530
Message-Id: <20190225090056.19055-2-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225090056.19055-1-himadri18.07@gmail.com>
References: <20190224080209.15969-1-himadri18.07@gmail.com>
 <20190225090056.19055-1-himadri18.07@gmail.com>
X-Mailman-Approved-At: Mon, 25 Feb 2019 20:48:32 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, Himadri Pandya <himadri18.07@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Decrement the reference count on device_node "np" while breaking out of
the loop. Issue identified by Coccinelle.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
Changes in V2:
	- Change subject line
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 8112b39879d6..3ee1404ceef4 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -220,6 +220,7 @@ void hlwd_pic_probe(void)
 			irq_set_chained_handler(cascade_virq,
 						hlwd_pic_irq_cascade);
 			hlwd_irq_host = host;
+			of_node_put(np);
 			break;
 		}
 	}
@@ -237,4 +238,3 @@ void hlwd_quiesce(void)
 
 	__hlwd_quiesce(io_base);
 }
-
-- 
2.17.1

