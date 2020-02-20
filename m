Return-Path: <SRS0=DuU+=4I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B91C11D04
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F4020722
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JVaN2k6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F4020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NY2v5rhkzDqHG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 22:56:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NXxb4hM1zDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2020 22:51:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JVaN2k6D; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48NXxb3YDCz9sR4; Thu, 20 Feb 2020 22:51:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48NXxb1b7Xz9sRs; Thu, 20 Feb 2020 22:51:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582199507;
 bh=86l/kbZLVUpuHg6YbEexdjNFc6my3ik18yJ0IXjuWIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JVaN2k6DCLwkFfDt7B7KIrcPRcCjqBa+gfe33jQc+SyklS2aghhfXuIOxjx6E6RLk
 /Thz9VuG7E6PwONQShNIDdGN32dO47dTqPR8H6T80gvsCwhBZ/qEWLuXknBshd2tjA
 ouJ3RXM4m3cATZMl5FRuP8uL8jbX1T5KyIQXTXzRIbHsbQwkKTvZHdRpmNZGUj3jeP
 3J9dc3VNOWMpXJOsc5zT7FMFytoV0Xnpe1FEuW2Gri0xoICHZ+CIpFL8rEUm0fsUqa
 DGF/bY5vePlYuluc6dBB5aeX9qbg8eS1ja0CX91RlyVqWBP6srtLUjK846Kf1HFsSU
 7dhLVJOgnPEHg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/5] powerpc: Add current_stack_pointer as a register global
Date: Thu, 20 Feb 2020 22:51:38 +1100
Message-Id: <20200220115141.2707-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220115141.2707-1-mpe@ellerman.id.au>
References: <20200220115141.2707-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

current_stack_frame() doesn't return the stack pointer, but the
caller's stack frame. See commit bfe9a2cfe91a ("powerpc: Reimplement
__get_SP() as a function not a define") and commit
acf620ecf56c ("powerpc: Rename __get_SP() to current_stack_pointer()")
for details.

In some cases this is overkill or incorrect, as it doesn't return the
current value of r1.

So add a current_stack_pointer register global to get the value of r1
directly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Split out of other patch, tweak change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/435e0030e942507766cbef5bc95f906262d2ccf2.1579849665.git.christophe.leroy@c-s.fr
---
 arch/powerpc/include/asm/reg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1b1ffdba6097..da5cab038e25 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1450,6 +1450,8 @@ static inline void mtsrin(u32 val, u32 idx)
 
 extern unsigned long current_stack_frame(void);
 
+register unsigned long current_stack_pointer asm("r1");
+
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
 
-- 
2.21.1

v3: Split out, and use current_stack_pointer not get_sp()
