Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3BC2BB84
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 00:54:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1894C206CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 00:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmJlwLrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1894C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsJQZ1sTgzDrNF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 10:54:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.194;
 helo=mail-il1-f194.google.com; envelope-from=tony.ambardar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=RmJlwLrT; dkim-atps=neutral
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsHz83lswzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 10:34:27 +1000 (AEST)
Received: by mail-il1-f194.google.com with SMTP id a19so570776ilq.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 17:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Na9A930XnJjifMT8ZHNAvuKYoJPnmdw7X5EjcY4GoqM=;
 b=RmJlwLrTYhvd51TSGpjqRixx9s+/rFs3rOKnJtMPoG5DNNUh6Z++hIYiRWVMqrHsU0
 ZlYBR/I4v8f6JQsGCMyLg/tZ98oiVf3aMVGYNIO/XqlrVmbUvPGyeO5YHCnpY7BDZkiJ
 SBhG7dB+7Ogp5Bf7JyvOK6gRPB78H28J35zqfJYVHsbT4NrJ9Jq4syr+Pw28i2bonZkj
 nDEKRKolvVvPOjTkZFstsLB4uNumBC+Hjy0jRnnZPMDDxWrSBFtH02UvlNeb2sgNo42Y
 my+AKtRpfgMx52z5VfePbVNCQga2wAy2jq/TLJarcmwTh66Mx4EvF5I7f67yG2QKnqHa
 JIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Na9A930XnJjifMT8ZHNAvuKYoJPnmdw7X5EjcY4GoqM=;
 b=i8KJeIn/TNK2cgB1LQts+6cvw+lBuQ7Yq1EM9nEYJQtGXDryidaPod9Iv5dmr5Lirs
 feOBejoNayVjzaDlLbMAElXa3pBVascr2NITMC8K1uyUAOBXOySTDtsMqKs0eU11P3GD
 Y938hq8oXXm+ES2NhDP1h7tqBt3CPK7MhzKFD74lhCJ8+8ty8x+26F7eOedtd+rs7q40
 s8owDXlr9+jCyVRdY9MrdNfSRlRYZ7vWJTMRTfD5vNUtHrP7Pthyoo7un5IGo4AuUt8y
 gx8AOy53h8rDqzOTPDlfJc1c847fd8KezEWacNLLdSbVzGn678pycQO+guWu5kX/HW7Q
 Ansg==
X-Gm-Message-State: AOAM533eRNafqIa+0x+gwQUF8CWD+q6QZFt7GLwWrZPbp91+giAjIunX
 mM/WT7P0kkMi7UXmEs1akdE05rPTlk4jIU2M
X-Google-Smtp-Source: ABdhPJz1qpB9CoFcw5mzJ0L2g1fQqPftTDPav38YlicRSdcMy4AS+soddUEEi9bBAkBrY8QxF8Cq8w==
X-Received: by 2002:a65:6888:: with SMTP id e8mr3241834pgt.375.1600301298990; 
 Wed, 16 Sep 2020 17:08:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:e92d:10:68d8:fab6:907:5cf6])
 by smtp.gmail.com with ESMTPSA id a13sm14300343pfl.184.2020.09.16.17.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 17:08:18 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc: fix EDEADLOCK redefinition error in
 uapi/asm/errno.h
Date: Wed, 16 Sep 2020 17:07:57 -0700
Message-Id: <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
References: <20200916074214.995128-1-Tony.Ambardar@gmail.com>
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
Cc: Tony Ambardar <Tony.Ambardar@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Rosen Penev <rosenp@gmail.com>,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A few archs like powerpc have different errno.h values for macros
EDEADLOCK and EDEADLK. In code including both libc and linux versions of
errno.h, this can result in multiple definitions of EDEADLOCK in the
include chain. Definitions to the same value (e.g. seen with mips) do
not raise warnings, but on powerpc there are redefinitions changing the
value, which raise warnings and errors (if using "-Werror").

Guard against these redefinitions to avoid build errors like the following,
first seen cross-compiling libbpf v5.8.9 for powerpc using GCC 8.4.0 with
musl 1.1.24:

  In file included from ../../arch/powerpc/include/uapi/asm/errno.h:5,
                   from ../../include/linux/err.h:8,
                   from libbpf.c:29:
  ../../include/uapi/asm-generic/errno.h:40: error: "EDEADLOCK" redefined [-Werror]
   #define EDEADLOCK EDEADLK

  In file included from toolchain-powerpc_8540_gcc-8.4.0_musl/include/errno.h:10,
                   from libbpf.c:26:
  toolchain-powerpc_8540_gcc-8.4.0_musl/include/bits/errno.h:58: note: this is the location of the previous definition
   #define EDEADLOCK       58

  cc1: all warnings being treated as errors

Fixes: 95f28190aa01 ("tools include arch: Grab a copy of errno.h for arch's supported by perf")
Fixes: c3617f72036c ("UAPI: (Scripted) Disintegrate arch/powerpc/include/asm")
Reported-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
v1 -> v2:
 * clean up commit description formatting
---
 arch/powerpc/include/uapi/asm/errno.h       | 1 +
 tools/arch/powerpc/include/uapi/asm/errno.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/errno.h b/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/arch/powerpc/include/uapi/asm/errno.h
+++ b/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
diff --git a/tools/arch/powerpc/include/uapi/asm/errno.h b/tools/arch/powerpc/include/uapi/asm/errno.h
index cc79856896a1..4ba87de32be0 100644
--- a/tools/arch/powerpc/include/uapi/asm/errno.h
+++ b/tools/arch/powerpc/include/uapi/asm/errno.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_POWERPC_ERRNO_H
 #define _ASM_POWERPC_ERRNO_H
 
+#undef	EDEADLOCK
 #include <asm-generic/errno.h>
 
 #undef	EDEADLOCK
-- 
2.25.1

