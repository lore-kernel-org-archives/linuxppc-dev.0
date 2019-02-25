Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 09:50:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1922084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns0vYqSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1922084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447HHP0zgyzDqD5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 20:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=himadri18.07@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ns0vYqSo"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447GBy6m3nzDqDl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 20:01:11 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id r124so4197678pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 01:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PvYCnuVke77+JFr3v8AmDRAxbaZsaVVDdH592VB9bFY=;
 b=ns0vYqSoAno1BI7Uh/Zfnq6d14RQ8V1mBWsS+sonCErFMVFRcQ23oVoUQkgriEYiSr
 76VRXMXdkSxeEeOA0K7TcNabVP1JWlFxAzJnL2mIilZ1KvCYz7h78Hisla27NjCIxe4H
 nNyQhpql48ceChLBGc9QkRORse1Zs+yyPI57PnJzVdbjHqTh/wZ2eiCMOYjInQW0UNZy
 Qi7E1+H9THzKMNbojTRWczBUXX0WIVbzaKsImBjGLFTi7+awSv7Unk2h9fSDHycVuS4D
 b1tj+nDuXnxYm9T4keXSBdfKUxmuU3NozdDs8Y0/kLyHXUrLzBVTxy2Ga73Xl9cbv5eI
 98jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PvYCnuVke77+JFr3v8AmDRAxbaZsaVVDdH592VB9bFY=;
 b=YE7Hf6574jCCfnQrQvSUlS+EXRN1gN5n/7CmOEHu8xN+J6WL8zWb7o7mIfaUWepl5Y
 Rio8f6vcub88bfhvZz/I82yUWviSnD06eyBl1lpNW7ksUEL1Wb3EtPIAAD2xDhdkslfR
 jpdB9vcyy827iWh3j9O657MPU2rBXg3DHrxiGtf+KJ+PA4XtSBa8PX1ANwtEf3lud4Em
 2pKuNSI7LZXBia2ElnJmKZscB6ze8gc7dvbYANipYxDTczhGVwBLzZkBjb8QS4UlKD1Y
 gw9ZP5bv6yLwV9T7VZf863hJ9SimSPABgSnqPeTxLcyPPlSTcsld3Sskors6ZrlP9SMT
 VqYQ==
X-Gm-Message-State: AHQUAub8lXYrzETycWT1+1Xgv9bcfDCI0tyCgct321/AYGNSZa3D0TSO
 /nw+FX82Wpp1iPWlG4LgRfk=
X-Google-Smtp-Source: AHgI3IZ0FoVp5jiSzQYCmUlR/Y345f+zfNW+HWNZulIyLt8+Q47+iZ1MxLIOyKXAFHE8msPx7SqGCg==
X-Received: by 2002:a62:e11a:: with SMTP id q26mr19060240pfh.187.1551085267833; 
 Mon, 25 Feb 2019 01:01:07 -0800 (PST)
Received: from localhost.localdomain (mx.daiict.ac.in. [220.225.53.35])
 by smtp.googlemail.com with ESMTPSA id
 t185sm16308645pfd.165.2019.02.25.01.01.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 01:01:06 -0800 (PST)
From: Himadri Pandya <himadri18.07@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH v2 1/2] arch: powerpc/kexec: Add missing of_node-put() in
 default_machine_kexec_prepare()
Date: Mon, 25 Feb 2019 14:30:55 +0530
Message-Id: <20190225090056.19055-1-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190224080209.15969-1-himadri18.07@gmail.com>
References: <20190224080209.15969-1-himadri18.07@gmail.com>
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

Decrement the reference count on device_node "node" while breaking out
of the loop. Issue identified by Coccinelle.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
Changes in V2:
	- Change subject line
---
 arch/powerpc/kernel/machine_kexec_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a0f6f45005bd..46edde582984 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -65,6 +65,7 @@ int default_machine_kexec_prepare(struct kimage *image)
 			end = begin + image->segment[i].memsz;
 
 			if ((begin < high) && (end > low))
+				of_node_put(node);
 				return -ETXTBSY;
 		}
 	}
-- 
2.17.1

