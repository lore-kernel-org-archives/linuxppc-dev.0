Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351BC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:53:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21605206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 02:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/DCv6VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21605206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VJZW1BCMzF325
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q/DCv6VI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="q/DCv6VI"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VJPR6ky7zF35g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 13:45:47 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id az3-v6so1764101plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 19:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/Mb1JKpF3Tt67fd3qErvQwrEj+oQ6WRhdtXnHt/hxMY=;
 b=q/DCv6VIEuxeDlrhbKcFXCZNGp+riKMlO8QxCTv+el/z+GuQd4+URRzJh26SVfeCVY
 vcespGUpObHS7fEo7uOTpudKRNGUrsg2sPhrtQQpTmrDMx7vtr/NSU+Br3VTP0tPnW3p
 GV9n8mQtqSSPvUu+7gIAwN7odZZgW64ztJlGppFNIqbkglzECggVeFGzyc39LVlGYEqu
 pqAYbA6/M7ghn7nkdWcalS1TeNNZ2euF18u/VxrOX0SlNjCNrCIx76Y8wUMmp0PKqKAV
 G59nzRizdj/p3aZSRPTnVouxS4HnG2KLDEm/k1zZKjiv1z7XU0Lh9pcL6FtwGmUk28Yq
 OuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=/Mb1JKpF3Tt67fd3qErvQwrEj+oQ6WRhdtXnHt/hxMY=;
 b=kc+n5y4XR13D4ULaL26GNgv0emr3NxvBr7ttkRSkfbSpNNJy/68eO/nJ8zSjvCn7FT
 XfOiwDjrcTqMiIzcyeiW3ai3R6xPhn5PuT5OQkBKpGlztj3Erc6r2o5q5iR+U9lieSin
 2mbX09Bptp2DYAztPdGydwyshkH8YEmZv4kumNtLTjfVkZh8Td9pgtt+HWhsdjmphOP5
 qgVygNTdmnbvuQdJ113UI46Mr4adnrDu6Ouka81oU3EwGW/J0+ZCrAPJCUEh2wKXU/+2
 OuqlklXCYUnT58yVLd7J+OWYkmEgpDLU0FzvNa/zb31LtRwwV8q1Ba91qk/xw20FDnRU
 lERA==
X-Gm-Message-State: ABuFfojv1Z6QInrEYxyTGZ9Y61ESdzq1JR11Ty1c9kVq48cLVvV8OcDs
 PjjsSsDg3A0+Rpy6L1ad6BzE5pmN
X-Google-Smtp-Source: ACcGV63M5AZVdHTSHjc6jw26jN/QlEJuVzZssW6QUpljimvolauvx1ev24lt6JYL7bD/fERyrCwEKA==
X-Received: by 2002:a17:902:e111:: with SMTP id
 cc17-v6mr31149806plb.175.1539139545808; 
 Tue, 09 Oct 2018 19:45:45 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id u65-v6sm33706829pfb.144.2018.10.09.19.45.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 19:45:45 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 10 Oct 2018 13:15:39 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/boot: Build boot wrapper with optimisations
Date: Wed, 10 Oct 2018 13:15:23 +1030
Message-Id: <20181010024523.4921-3-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010024523.4921-1-joel@jms.id.au>
References: <20181010024523.4921-1-joel@jms.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The boot wrapper is currently built with -Os. By building with O2 we
can meaningfully reduce the time decompressing the kernel.

I tested by comparing 10 runs of each option in Qemu and on hardware.
The kernel is compressed with KERNEL_XZ built with GCC 8.2.0-7ubuntu1.
The values are counts of the timebase.

Qemu TCG powernv Power8:

              Os            O2            O3
 median       10221123889   6201518438    6568186825
 stddev        1361267211    429090641     657930076
 improvement                    39.33%        35.74%

Palmetto Power8:

              Os            O2            O3
 median           50279         50599          35790
 stddev       992144533     627130655      623721078
 improvement                   36.79%         37.13%

Romulus Power9:

              Os            O2            O3
 median       670312391     454733720      448881398
 stddev          157569        107276         108760
 improvement                   32.16%         33.03%

TCG was quite noisy, with every few runs producing an outlier. Even so,
O2 is faster than O3. On hardware the numbers were less noisy and O3 is
slightly faster than O2.

The wrapper size increases when moving from Os. Comparing zImage.epapr
to the existing Os build using bloat-o-meter:

  Before=43401, After=56837 (13KB), chg +30.96%
  Before=43401, After=64305 (20KB), chg +48.16%

I chose O2 for a balance between Qemu and hardware speed up.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 739ef8d43b91..c6c5a1a6627d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -32,7 +32,7 @@ else
 endif
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-		 -fno-strict-aliasing -Os -msoft-float -mno-altivec -mno-vsx \
+		 -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
 		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -D$(compress-y)
 
-- 
2.17.1

