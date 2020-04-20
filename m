Return-Path: <SRS0=UNki=6E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69106C3815B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 18:44:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0A22074F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="L8rOOqcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0A22074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495bFm1mJhzDqsR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 04:44:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=L8rOOqcK; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495b571ZJWzDql6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 04:36:43 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 495b5348S3z9v1wG;
 Mon, 20 Apr 2020 20:36:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=L8rOOqcK; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id gxDbs_nGq2rw; Mon, 20 Apr 2020 20:36:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 495b5330mBz9v1wB;
 Mon, 20 Apr 2020 20:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1587407799; bh=Z+DTGzvTxqsqWxp7dVXacfp4jVlr8OqLRFto6Y4sZ9Y=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=L8rOOqcKaI8PRNtGUjmExVCXN2aNm7M4ITgfNvfHi0vm9iF2SxG5McgWPHCMxgUbd
 w/JDEn0iV9AaIW7Vzc24QlW0oeJaxOLqj46CJOvh0FF6TnMgOHUKbZsqSl/TrIc7UF
 SHD9VypxTA063u8DemWf1+5fC8tvjnIJQpKRC/iU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 55A558B78A;
 Mon, 20 Apr 2020 20:36:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rAhfwyKCRVLE; Mon, 20 Apr 2020 20:36:39 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A2B98B77E;
 Mon, 20 Apr 2020 20:36:39 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D48DB657AE; Mon, 20 Apr 2020 18:36:38 +0000 (UTC)
Message-Id: <bb0a6081f7b95ee64ca20f92483e5b9661cbacb2.1587407777.git.christophe.leroy@c-s.fr>
In-Reply-To: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
References: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/5] powerpc: Remove _ALIGN_UP(), _ALIGN_DOWN() and _ALIGN()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 20 Apr 2020 18:36:38 +0000 (UTC)
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
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These three powerpc macros have been replaced by
equivalent generic macros and are not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/page.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 3ee8df0f66e0..a63fe6f3a0ff 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -249,13 +249,6 @@ static inline bool pfn_valid(unsigned long pfn)
 #include <asm/page_32.h>
 #endif
 
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr, size)   __ALIGN_KERNEL(addr, size)
-#define _ALIGN_DOWN(addr, size)	((addr)&(~((typeof(addr))(size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
-
 /*
  * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
  * "kernelness", use is_kernel_addr() - it should do what you want.
-- 
2.25.0

