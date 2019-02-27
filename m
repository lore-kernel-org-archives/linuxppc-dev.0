Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97616C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD6A20643
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKUuUBDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD6A20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448WGv3Q4MzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 20:53:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=himadri18.07@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKUuUBDx"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448WF01t6hzDqJN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 20:52:20 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id b65so4729445plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 01:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yPXYOQmPNjUT9kROwbxf9Wi2pgbrB5L0DkDN2AYyq2E=;
 b=OKUuUBDxRFcoVMmExJovWiUOFfN+xH3K0XChqqzTVhdkClZhcM4HBit/PaPj0xZuvu
 c+uIY8a8/BYPQ3yRjtCUEsQfRU/x/6CwXp3LiYJL4pqbl/ONkTCC0msONNiTmvoMjaZV
 iU7d9vligZ3ueirg85MV9QJSPqdT8eobqxMujneSg73aj3kBGktPGnLih0jogzfza47G
 dXNVFQRw6D6id1yERYiXDp3aS7eIyXWPJhTwn77cqZyo44Yfvket5oUmdSSgVbIbn8WH
 mL/sjPplSUpTNExb3akIT5Ye1QPnKIxzL85J7Bngx98xCKpheHDfh1a/SQHlN0reJxdX
 uPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yPXYOQmPNjUT9kROwbxf9Wi2pgbrB5L0DkDN2AYyq2E=;
 b=qpjBUWa5zuRQH7hI+v5M79Gk29qJ7Zr5bGBeHU5nLU/qVnGohw5k9XD/oUkQcuqfke
 FVGsY1O92QYSeevTPcSCN2f5gklAXDy71XnJpvdpCQI1APYbW1fRV5z6MeDC6UeKJ8pT
 ctwF/hHnXVzzgRu732VklV7K/oY3CT+87tQtJwK+zviLzqYw8rjkFxIwac2YAVdv6hA/
 95ruLOE9CePS3V3d7GVI5JxlaGaGth9wGVPeOLNLnSviLn777xCzXL0dHYANX4NVTVLM
 1ub1AB+I/RemQdxKJaPh6H4Kdd7pgB7U1TUBF/La+Ip2xVaiYXLJCsNNzVRf8qzM7DXD
 G2Lw==
X-Gm-Message-State: AHQUAubBTzPn+FXoLA5u9VshM55eaD6s6HZ1mGbKY4aa4lmIC8fd5FEO
 C7ZE3m+m/JWgf3yalIibOog=
X-Google-Smtp-Source: AHgI3IYbPJBcU0HgFOwj+nyf+QE96G+oEXFLK7rTyM37xzGedJMR3euGe4G8+rsCRU6BTpiLv/98jw==
X-Received: by 2002:a17:902:f83:: with SMTP id 3mr1276273plz.125.1551261136896; 
 Wed, 27 Feb 2019 01:52:16 -0800 (PST)
Received: from localhost.localdomain ([157.32.131.196])
 by smtp.googlemail.com with ESMTPSA id m24sm15797303pgv.1.2019.02.27.01.52.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 01:52:16 -0800 (PST)
From: Himadri Pandya <himadri18.07@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tyreld@linux.vnet.ibm.com
Subject: [PATCH v3 1/2] arch: powerpc/kexec: Add missing of_node-put() in
 default_machine_kexec_prepare()
Date: Wed, 27 Feb 2019 15:21:37 +0530
Message-Id: <20190227095138.30263-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225090056.19055-1-himadri18.07@gmail.com>
References: <20190225090056.19055-1-himadri18.07@gmail.com>
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

Decrement the reference count on device_node "node" while breaking out
of the loop. Issue identified by Coccinelle.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
Changes in V2:
	- Change subject line
---
Changes in V3:
	- Add braces around the if block
---
 arch/powerpc/kernel/machine_kexec_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a0f6f45005bd..ef484a25fc50 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -64,8 +64,10 @@ int default_machine_kexec_prepare(struct kimage *image)
 			begin = image->segment[i].mem;
 			end = begin + image->segment[i].memsz;
 
-			if ((begin < high) && (end > low))
+			if ((begin < high) && (end > low)) {
+				of_node_put(node);
 				return -ETXTBSY;
+			}
 		}
 	}
 
-- 
2.17.1

