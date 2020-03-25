Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4029BC1975A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 05:21:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3AF20719
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 05:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RtZS2Njn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3AF20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nGfw5kWKzDqDt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 16:20:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--maskray.bounces.google.com
 (client-ip=2607:f8b0:4864:20::94a; helo=mail-ua1-x94a.google.com;
 envelope-from=3wul6xgckdhslzrjqzxfnnfkd.bnlkhmtwoob-cdukhrsr.nykzar.nqf@flex--maskray.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=RtZS2Njn; dkim-atps=neutral
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com
 [IPv6:2607:f8b0:4864:20::94a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nGcq2dhmzDqDt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 16:19:02 +1100 (AEDT)
Received: by mail-ua1-x94a.google.com with SMTP id t26so490559ual.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 22:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=kyc8Lz803rkHQahNF6Vh9SygFIqhcJEwIAPW6vgmG6U=;
 b=RtZS2Njn/KzVpX/FvHUXmFMOmQPo8H16AFZliE42BfKH8LSIsG4TaaPr3k4baWg7oN
 FAwzI36r9IH/URI8WTZzHZvQlQV3BFjtMMeK5AZTxkyP7siRG9sz+14mixhW3wqIcRSw
 DYTrk8q4HCb0osNiXSb27aJOM31JxjRvNSxufu3tAsuwB2BiprBlMza7OHcS9XK7CCUV
 gb9VUj7kpHI4ZftJGm33tX8s0/cHtlcKV/jKy7idlUNkkGCpwKPbt3hpiVmXRLXVBC38
 /ixZuHthHaNi+E2yDDw706dm67XM4gzbQvixwUlVhlq3NXRtmgDR0ccxTyKMwrGVG+Cw
 /5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=kyc8Lz803rkHQahNF6Vh9SygFIqhcJEwIAPW6vgmG6U=;
 b=W2ErDLO9xCwz7i3MkvD2nVDyDQP4qo1LxbbLzEP8SGKqZ4TBuF9cXIjr0NoCn01PqN
 DLuVwDlPu+9SVMBGnDSPYEwktoVNS2L+QNzUkmHuFWLvJ6lC1CxbFcvAtaPhB0xIVqPa
 HXlMFidXv03fVLY6p9nv6t6wde5r9OzYGY0jvy/7Wapp5ZWojFfwxjnkIEkSzqqlMY9Q
 1da3fPjYqo49ixkyLou06gYI1dIfD7KzFkcumd9hXjXZtN2jrALnkCCYVlNPuy2vpVyU
 ETXAKUyibCuvetUu++BKV0IlM634BXss19yS7O4tmCYoJr2fwx1WiDLFTqH5eKPmeGRJ
 hB+Q==
X-Gm-Message-State: ANhLgQ1nNA/PP1LG0SR3pLg3kicLzYrE5UsZstPZZLgPhKjuwK9oi7J6
 6zvgzIOd55KluoqEzE9hhaSF9LU8vxE3X16jqoHO8HcUmbtXDkVaokk9WhmVbGixsqLjWNT/Psy
 Z0vEpkBr23vwx2yDjqzw4PhcEYSSlPMbtXo/CJScWbbLgN0gEBeBOM83hLc1sSbTue9OW65Aypg
 ==
X-Google-Smtp-Source: ADFU+vso17kpYZYmje+XnuoKKyCDzunYk+z3xnIdzaLGiaSGQl0pdP4gn4zznjG3W9c4mw3VNenOVGNhjj8o
X-Received: by 2002:a67:69d8:: with SMTP id e207mr1292649vsc.141.1585113538881; 
 Tue, 24 Mar 2020 22:18:58 -0700 (PDT)
Date: Tue, 24 Mar 2020 22:18:20 -0700
Message-Id: <20200325051820.163253-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] powerpc/boot: Delete unneeded .globl _zimage_start
From: Fangrui Song <maskray@google.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, Joel Stanley <joel@jms.id.au>,
 Fangrui Song <maskray@google.com>, clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

.globl sets the symbol binding to STB_GLOBAL while .weak sets the
binding to STB_WEAK. They should not be used together. It is accidetal
rather then intentional that GNU as let .weak override .globl while
clang integrated assembler let the last win.

Fixes: cd197ffcf10b "[POWERPC] zImage: Cleanup and improve zImage entry point"
Fixes: ee9d21b3b358 "powerpc/boot: Ensure _zimage_start is a weak symbol"
Link: https://github.com/ClangBuiltLinux/linux/issues/937
Signed-off-by: Fangrui Song <maskray@google.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: clang-built-linux@googlegroups.com
---
 arch/powerpc/boot/crt0.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 92608f34d312..1d83966f5ef6 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -44,9 +44,6 @@ p_end:		.long	_end
 p_pstack:	.long	_platform_stack_top
 #endif
 
-	.globl	_zimage_start
-	/* Clang appears to require the .weak directive to be after the symbol
-	 * is defined. See https://bugs.llvm.org/show_bug.cgi?id=38921  */
 	.weak	_zimage_start
 _zimage_start:
 	.globl	_zimage_start_lib
-- 
2.25.1.696.g5e7596f4ac-goog

