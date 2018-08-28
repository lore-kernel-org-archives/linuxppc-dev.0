Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420FLN5325zF0BV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 02:57:48 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id k19-v6so993900pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 09:57:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] powerpc/64s/hash: avoid the POWER5 < DD2.1 slb invalidate
 workaround on POWER8/9
Date: Wed, 29 Aug 2018 02:57:31 +1000
Message-Id: <20180828165731.24320-4-npiggin@gmail.com>
In-Reply-To: <20180828165731.24320-1-npiggin@gmail.com>
References: <20180828165731.24320-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I only have POWER8/9 to test, so just remove it for those.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2206912ea4f0..77a888bfcb53 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -672,7 +672,9 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 
 	isync
 	slbie	r6
+BEGIN_FTR_SECTION
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 	slbmte	r7,r0
 	isync
 2:
-- 
2.18.0
