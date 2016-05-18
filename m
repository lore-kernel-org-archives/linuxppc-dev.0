Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8bsm1fYfzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 11:17:48 +1000 (AEST)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r8bsl3gXHz9vK1
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 11:17:47 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gh9so3301531pac.0
 for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2016 18:17:47 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4/4] powerpc/sparse: Use LE definition of REG_BYTE
Date: Wed, 18 May 2016 11:16:52 +1000
Message-Id: <1463534212-4879-4-git-send-email-dja@axtens.net>
In-Reply-To: <1463534212-4879-1-git-send-email-dja@axtens.net>
References: <1463534212-4879-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sparse complains that it doesn't know what REG_BYTE is:

arch/powerpc/kernel/align.c:313:29: error: undefined identifier 'REG_BYTE'
arch/powerpc/kernel/align.c:320:37: error: undefined identifier 'REG_BYTE'
arch/powerpc/kernel/align.c:328:29: error: cast from unknown type
arch/powerpc/kernel/align.c:328:29: error: cast from unknown type

REG_BYTE is defined differently based on whether we're compiling for
LE, BE32 or BE64. Sparse apparently doesn't provide __BIG_ENDIAN__
or __LITTLE_ENDIAN__, so add an explicit __CHECKER__ to the LE
definition.

The choice of LE is arbitrary.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/align.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 8e7cb8e2b21a..43f745f2cea9 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -230,7 +230,7 @@ static int emulate_dcbz(struct pt_regs *regs, unsigned char __user *addr)
 #endif
 #endif
 
-#ifdef __LITTLE_ENDIAN__
+#if defined(__LITTLE_ENDIAN__) || defined(__CHECKER__)
 #define REG_BYTE(rp, i)		(*(((u8 *)((rp) + ((i)>>2)) + ((i)&3))))
 #endif
 
-- 
2.5.0
