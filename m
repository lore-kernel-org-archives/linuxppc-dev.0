Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB03C004D2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 06:25:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68452075E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 06:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvcN/Kkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68452075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NFky5QMxzDr2j
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 16:24:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvcN/Kkb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvcN/Kkb"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NFdq0gdnzF0wf
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 16:20:27 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id k21-v6so6957438pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=+4Y8rKFVycyB4LOx/E7jIuOA4dM5bIwCu7gvQ3wtYEE=;
 b=NvcN/KkbMRBZxVmmUcv7TnDTK0IEjS9DIyWLqk3piEE/mQjhENyGBsb4NmENoOEhhL
 nvoDq/ICHVKh+vdpmdAz+vgNadjUSEWIcVk/fLQ4e/Wr+/InMKlcl8EkuXBkG2PuCDoU
 wy/P+V7MF+W6DexYarYigIO0cSl6Z9y2mU3Y71kOkrB8Ppu3JUq01WCjG9eok55zz3fF
 fdfaoKOvv9sdkERag919zB9dHPQ9e74lR8fmj+4DwJSuVuvf5i3uYRi9tl/Tng0axVqY
 JYNveRyFLtWCzui3y3AL5rQVLiV4TmWthdedR9bNDrUdEZGaz3vJJhI8M3p5L9ptTtux
 ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=+4Y8rKFVycyB4LOx/E7jIuOA4dM5bIwCu7gvQ3wtYEE=;
 b=R6mBPtS4SsAeraqbxXlrWPSvqkUhj4yWZaTmC+tliAuTgnxhSdp4hpI/BgAoyacoyI
 cRy+w/PdQt1XmfPO0sX8qFHzbAMUQPTQxRXOwnv3tpXefCDheAc1tmJgoK2eXHKexkF1
 f2bq5/T2ZVlAEKy6fWVM3lyD/D3t+0p6YGDPILsAFT6oFjyzs0QdtEgQyWem7ViiLhK6
 jNWiVtTEH8l3jsg3ZBEIC4WudIn0cN/xoalqGalEdX/TxbvflxP0/br/62XYQcoF9tFC
 pjlGdYvLfGzsqIA8HXyF2cUKSXJqTPFfRH+8iCmITtAWwHJS4AyNp2mnYOPcs3wC1pm7
 OyBw==
X-Gm-Message-State: ABuFfoiEGwKhMiMVQq4av8uam3Uig5geyiHvcpTWp8baikVA+zZjvAAg
 OmatyKnyWWlv79QgZTOzqm42nKkR
X-Google-Smtp-Source: ACcGV62vUdqvErlSAyJrWaTESGW90TynFe1DULBJ1DPAXCz+Gbqu5oOPeu8JT8MZPYHKKBXbI+DSsQ==
X-Received: by 2002:a63:fa09:: with SMTP id
 y9-v6mr5399015pgh.177.1538288425804; 
 Sat, 29 Sep 2018 23:20:25 -0700 (PDT)
Received: from ala-d2121-lx1.wrs.com (unknown-156-139.windriver.com.
 [147.11.156.139])
 by smtp.gmail.com with ESMTPSA id v8-v6sm12899237pfl.6.2018.09.29.23.20.24
 (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 29 Sep 2018 23:20:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/64: Remove duplicated -mabi=elfv2 for little
 endian targets
Date: Sat, 29 Sep 2018 23:25:19 -0700
Message-Id: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The -mabi=elfv2 is currently specified twice in the makefile. Remove
the one that does not test compiler.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 arch/powerpc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acb..16b0695 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -93,7 +93,6 @@ ifdef CONFIG_PPC64
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
 aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
-aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
 
 ifneq ($(cc-name),clang)
-- 
2.7.4

