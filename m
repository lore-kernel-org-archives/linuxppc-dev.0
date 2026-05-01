Return-Path: <linuxppc-dev+bounces-20355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D73FF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:12:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6Hgl6TtPz30B4;
	Fri, 01 May 2026 14:12:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608755;
	cv=none; b=Cpn0bh4FbzOUH5i2cYMeU/X6T0Oo+cimzMJRokCJWa3uy5Lpoh6PeoUDZSs22F5goa6wmNIYZ3PK78DRSa6thOh7VQnAvWPCArnQhQJMEYCOyLIQraufAs8QtpHIW6JYC/SErxEAAK161qKbAod0/SUa4yFJwq6A78Y+Y0HqH4fFakkrHVYY37d0n7UNg/su0qQKzh/z4rGyE9SxyFzZEcMEPIkGN+PKZiXZVDr/UHRnrrsRbxeUJC/JApDSMM3iy6atMpkqvHqYfXxaN7zdLhDtwsGqwiIaqsL4U+Ozi50Q4+LTJoxNh/ZAP174PMAnbwK1D7sPW56ynVwFZaIstg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608755; c=relaxed/relaxed;
	bh=FX+puozfKOk6l+f90pyqn7buO5CtmALr+6nyHUFvWvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVjXabg53D2CcK6a3TpDNV/twvN9s/9hmRmDCU3QwZuzLINuDGm9b3QFDH4RM71Om6/MQFAZt5ZWOKi1IYtZcTa0n41+/0+nnhAdp43ehJFsYzpU3syd+gtTlBeblXOUTGoPstX/GnacZDS2RfJFiBPU1D+nMHxROj3zv8/UB1Hs8XSwbfwhCHm1i9kxeOF8WIRVw8ewt3MI/aIgjL9llGrcXSsbZfaAEw0xj2EMyMhYqRbMC29BBcEkNLILcjTtMf5vviJDM7b4Wj5AnYBtbTltunByfuEGZNLRlggZeSElCGj8FK3E0dXwi2dEs39arFIi2/rsRFWwcOwcWxoqKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TkW+3t3s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TkW+3t3s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6Hgl2GCyz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:35 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso968574b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608753; x=1778213553; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX+puozfKOk6l+f90pyqn7buO5CtmALr+6nyHUFvWvA=;
        b=TkW+3t3sBawiPcCHts8z3UCGcQhlDWLciPJNgBpquH49vKZp+J0b6yq9wRxKZ7FKTm
         pS875XZ5pAvSaaskRIb14NWr1PVgyOkXD3F2hwgIAxeFZ9hWP4zzcQZhj0JLaiY+IbW7
         IPV5gZIinWoxEM0zeUO5HEkFyiLzt7y7KKFxaNF4/fwYLI4ij+YkGSWXVWtvP8bFPW9Q
         +N283YVinSZvtoaMNo0mDH0PwNMoaJr2CJGh+v178RVvwrexH6WFAaf7rd7JdjCvS8fK
         flxXC0sUg2VtrjWQx6Et0KBHjnjK/eUwE2gdph2skXDJLrPf6QChoWo+JGQdCRk6CfYM
         Z7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608753; x=1778213553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FX+puozfKOk6l+f90pyqn7buO5CtmALr+6nyHUFvWvA=;
        b=khQBzjHkqgE8rkHs1ILGTcjZLdpVjlv3woK+eg8v9NEUjRAwZjYYjsor8NETVwUmWv
         mhJmqXVOurs1Cm9nbgvD1z5jLYqdPtFHC3cHJwTNzS3NeXr+JCFdcaxytYQKsyXXWQmF
         3Fx81YtPJhHCrSHSaAA7syCoByFyEmJZ0hXGQn9Bd27VRoC6PL5EkKWhKlo+5ev6dciv
         YMHu8gLn7oJ4M8nFyD/3PJQXS6lA3rRgy02JoCnCuICOPy7hyeNiHNqCUQhN1rJW0xaj
         WmNg1WoWvE9Qxc+scz+x0tWsbx6F8k8SbsunFQLQ209giTJ6DW5JO52lgmvT3dlqNDGE
         nmDQ==
X-Gm-Message-State: AOJu0YybKuK0vfkIAAxbd4Y8lv1uX9CFYZOMYBbgyJqHAxbVNWdG3PcH
	Bxul9X/lAhDGdOLt/PfMPiIbOjo76Om0I0HveP+0HMre13cQIvx57xF7hHoCgu63
X-Gm-Gg: AeBDievexT9ZMFmyuj0wXberg+fZ53mneTLw4M6uhe3vI4zGbwb9BMeErT4oeU6nrJw
	7mtYe/nq98/BQyoVC51JTYUIYbPooHjV1m94IPOw++ZdWB7cnrYC/8Lo1gLClStI3gIsz3NaJ0T
	IUHA6mGi7S1di3TjdCilEG7FsQ6tXi78j9k+BXSZkcGPMJPR5TPQvJRHF+4lAcGJqUHNolFMKa0
	KvlL1nHw1HDa9UW30fufM6bZZnI3zFfEV2TS8QMWRUbWY+jbm/oLdYHkeiDJhRHTy2d3P9MN9cp
	v4yaL40s0bcM3cCkyc9sUnEH7wN0zapDxv4A9vJ/y8NAFXTiX69kvmpXuMiDrdjwCYXeB9AhUS/
	G7nQqcLpcpcCwtRaGBm0BiSSIwgKnj+TXZsibE51TaZeGe9To2Ii18HbZdpHCDLH5/Q6cyBp7WW
	GJLC0+72iPCAi0Nb63caSj22ZjfvijH3mDEqWQPPG7P/peTu8PASQv7c0i4usOvotKExFOn/SKU
	g==
X-Received: by 2002:a05:6a00:3e27:b0:82f:3774:4fdc with SMTP id d2e1a72fcca58-834fff78b31mr5164676b3a.1.1777608752763;
        Thu, 30 Apr 2026 21:12:32 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:32 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/9] pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_init()
Date: Fri,  1 May 2026 09:41:43 +0530
Message-ID: <f2141eafb80e7780395e03aa9a22e8a37be80513.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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

Remove such 3 levels of nesting patterns to check success return values
from function calls.

ret = enable_hvpipe_IRQ()
    if (!ret)
	    ret = set_hvpipe_sys_param(1)
	        if (!ret)
		    ret = misc_register()

Instead just bail out to "out*:" labels, in case of any error. This
simplifies the init flow.

While at it let's also fix the following error handling logic:
We have already enabled interrupt sources and enabled hvpipe to received
interrupts, if misc_register() fails, we will destroy the workqueue, but
the HMC might send us a msg via hvpipe which will call, queue work on
the workqueue which might be destroyed.

So instead, let's reverse the order of enabling set_hvpipe_sys_param(1)
and in case of an error let's remove the misc dev by calling
misc_deregister().

Cc: stable@vger.kernel.org
Fixes: 39a08a4f94980 ("powerpc/pseries: Enable hvpipe with ibm,set-system-parameter RTAS")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 28 ++++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 402781299497..800649f309a5 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -780,23 +780,29 @@ static int __init papr_hvpipe_init(void)
 	}
 
 	ret = enable_hvpipe_IRQ();
-	if (!ret) {
-		ret = set_hvpipe_sys_param(1);
-		if (!ret)
-			ret = misc_register(&papr_hvpipe_dev);
-	}
+	if (ret)
+		goto out_wq;
 
-	if (!ret) {
-		pr_info("hvpipe feature is enabled\n");
-		hvpipe_feature = true;
-		return 0;
-	}
+	ret = misc_register(&papr_hvpipe_dev);
+	if (ret)
+		goto out_wq;
 
-	pr_err("hvpipe feature is not enabled %d\n", ret);
+	ret = set_hvpipe_sys_param(1);
+	if (ret)
+		goto out_misc;
+
+	pr_info("hvpipe feature is enabled\n");
+	hvpipe_feature = true;
+	return 0;
+
+out_misc:
+	misc_deregister(&papr_hvpipe_dev);
+out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
 	kfree(papr_hvpipe_work);
 	papr_hvpipe_work = NULL;
+	pr_err("hvpipe feature is not enabled %d\n", ret);
 	return ret;
 }
 machine_device_initcall(pseries, papr_hvpipe_init);
-- 
2.39.5


