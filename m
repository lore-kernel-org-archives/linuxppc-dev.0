Return-Path: <SRS0=3PPi=MM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE16C004D2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 06:22:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48652075E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 06:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z34G+4vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48652075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NFhR1vn1zF3Bw
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Sep 2018 16:22:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z34G+4vl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z34G+4vl"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NFdq5GCTzF3BW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 16:20:28 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id d4-v6so7001881pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 23:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=bOEO3uF3LSVduBWR6WI8whfikIvJtWy/IcEoDORz6TA=;
 b=Z34G+4vls88WGoKBuWupf0Q0Y8czE6Eaj7qFwaXozQf5Wsv9ejvh7Li10TDEqDFRiC
 j/c7owbdtmc3Hzqqm+2v15mB/BWQD4jiGUnAgY0+gXKzXgEfGQPr7qZfneiTrcMMEmfg
 IrLx8u0qNFIxY+Ky6kUuMw6CgU0Vi6aYS2ufe7dpTAX8X4qp0QdejYTl6kPXjQryx3UT
 5y1OpHmlbMcgoaxmT13mHgleJTpNway+EnfGtLNPvAYQlEspo1UWv+TtON4uP0fjhmWI
 aDx5TryTFOGX0NTsnLLwUGftf+01EoA71E2GbotSx8orIavAWByiuoc1qOPOa+PK3WXF
 CLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=bOEO3uF3LSVduBWR6WI8whfikIvJtWy/IcEoDORz6TA=;
 b=EwQj2IJO1KZuFAyYJDHyC80ZnHrlZcTAEfl7gY93MiKy4fXeueIW53cTRwvDU2S8mT
 S4MVeRinUEXOFdMelWo6S2kFfjy4LzKeb+j8Lzv0kr/yjz6mfTiD+2s38xplmGMpZIhD
 R+UO0dFwZMb4nL7GbMMrk0ga+dP3cS6UhwFFApIvvIHO2tyOttP3GusWTo0PRrPEgiOd
 Xh2kM57xFk3ArHswFlLsDlmhcFyG1HCxRVbZmZT9YJE+nKO99tXmj0jODbvGAbOgev1C
 LVjCB/NlukH806Hvr6LeARiKuZLRCwTP9MDrDSocCTYSOuyh9YsL9ApOtpXL10x3pOWN
 3AUw==
X-Gm-Message-State: ABuFfoi7BypohxJvmCQyuLH7zbmxReIjUvJA6w72sPGLKGPiA9Ru0/1l
 Ibr8qa17cL6bQMAfLxj4aF10hvB3
X-Google-Smtp-Source: ACcGV63dpD4+zuI1D+oq/PxKmTh0CfX/3bUflotgjMLlRV5juVdb4XY6lPL0RkZUq9bp+f0+odW+WA==
X-Received: by 2002:a62:9f11:: with SMTP id
 g17-v6mr5819162pfe.144.1538288426949; 
 Sat, 29 Sep 2018 23:20:26 -0700 (PDT)
Received: from ala-d2121-lx1.wrs.com (unknown-156-139.windriver.com.
 [147.11.156.139])
 by smtp.gmail.com with ESMTPSA id v8-v6sm12899237pfl.6.2018.09.29.23.20.25
 (version=TLS1_1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 29 Sep 2018 23:20:26 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit kernel to
 512 bytes
Date: Sat, 29 Sep 2018 23:25:20 -0700
Message-Id: <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
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

commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
userspace to 512 bytes") only changes stack userspace redzone size.
We need increase the kernel one to 512 bytes too per ABIv2 spec.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 arch/powerpc/include/asm/ptrace.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 447cbd1..817be3f 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -30,16 +30,12 @@
 #ifdef __powerpc64__
 
 /*
- * Size of redzone that userspace is allowed to use below the stack
+ * Size of redzone that kernel/userspace is allowed to use below the stack
  * pointer.  This is 288 in the 64-bit big-endian ELF ABI, and 512 in
  * the new ELFv2 little-endian ABI, so we allow the larger amount.
- *
- * For kernel code we allow a 288-byte redzone, in order to conserve
- * kernel stack space; gcc currently only uses 288 bytes, and will
- * hopefully allow explicit control of the redzone size in future.
  */
 #define USER_REDZONE_SIZE	512
-#define KERNEL_REDZONE_SIZE	288
+#define KERNEL_REDZONE_SIZE	512
 
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
 #define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
-- 
2.7.4

