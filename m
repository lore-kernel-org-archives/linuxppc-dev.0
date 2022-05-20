Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A19C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 May 2022 12:37:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L4R856XSxz3bpQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 May 2022 22:37:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=T6IF6o4t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b;
 helo=mail-pl1-x62b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=T6IF6o4t; dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L4R7K2rhfz2yLJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2022 22:37:00 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d22so7232883plr.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2022 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pfgqFsTOUgXBDu5bDyAL2tx0ss8x2jsp1L7XsD88tdw=;
 b=T6IF6o4tHH9Gu44hBxaf50ZZBcUeVwAOcwZn1o9+d4JOAdCw1TySJ3sedAAMCHVdXc
 pctQeAF9JuDVdoxC5ojbPehyvDk9iusmY5boq7J05Dk8lyYwxwmfnVsZ3UwAKNEdcb5O
 xEvuc1sKes50BR49j32RbuzonkzaAFS8Q7Hdq//EJ/vLehSFA1UEnqTpLrqvk8MSE9UC
 QM9i2fMCQh5GieDAAbxtWvqY+QXF/gUOC8Odr0/8be3QX2eAfko3FtyMnjk7TUJt1ZP7
 1jF7yrjL3eSQWTRDgj1LpRsVwduCkzT+VTWg2DvvLDE1WWGQIE5Pb2NL5CN24QMPYlPS
 qdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pfgqFsTOUgXBDu5bDyAL2tx0ss8x2jsp1L7XsD88tdw=;
 b=BhEhDu1zHUP8Plxfh0fniXACeWULRWwfTAiqEJsK94ZL5GsyL3gldwaYu890uo7Nib
 mHZzIgep82pjCTUKKEXlatzTUaa22QpqQlkNSfm6Z5CIwlJT3HnqWffir/7cs9nFKRdy
 XnMkt2bjxmJ+R5mEnBqMX7AcX+X2oYfIf9dxKNyYntvysh1m7lu6dgLjVdR4HG0OuQUg
 UvicnVXeP5ctAGCwOLMzJNKUIYs/8jdqwbQ7TzhnVebzS4iF48BP8+H6fiMYEUIre6PQ
 mGNn3DJ7Yu7BqJ2C/cUi441QorvGPe09H2wCUGWTTHt3z1Pq3G9hmhkOBin+YaPLsulP
 oPuw==
X-Gm-Message-State: AOAM532sp05t7n1pdasX2nVKuIOuKKiZTaVJD+HAAtS8YjZf+6/iHkdE
 VED6ZM7c9GCr2fUAm7RFpU87j9GosxM=
X-Google-Smtp-Source: ABdhPJwOrk85B4xlVMD7ZMQqUD8vN+Ccy8JoFvpsOAxxWPiUGY86r4TeBO8vKWfqTvJbEMb7d89HOA==
X-Received: by 2002:a17:90a:6308:b0:1de:fb6c:5944 with SMTP id
 e8-20020a17090a630800b001defb6c5944mr10804569pjj.60.1653050217426; 
 Fri, 20 May 2022 05:36:57 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (124-171-74-249.tpgi.com.au.
 [124.171.74.249]) by smtp.gmail.com with ESMTPSA id
 y21-20020aa78555000000b0050dc76281fbsm1656211pfn.213.2022.05.20.05.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 05:36:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: Fix __kernel_sync_dicache sequence with
 coherent icache
Date: Fri, 20 May 2022 22:36:49 +1000
Message-Id: <20220520123649.258440-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Processors with coherent icache require the sequence sync ; icbi ; isync
to entire store->execute coherency. icbi (to any address) must be
executed to ensure isync flushes the pipeline. See "POWER9 Processor
User's Manual, 4.6.2.2 Instruction Cache Block Invalidate (icbi)" for
details.

__kernel_sync_dicache is missing icbi for the coherent icache path.
Add it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vdso/cacheflush.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
index d4e43ab2d5df..0085ae464dac 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -91,6 +91,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 3:
 	crclr	cr0*4+so
 	sync
+	icbi	0,r1
 	isync
 	li	r3,0
 	blr
-- 
2.35.1

