Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x22d.google.com (mail-pl0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPjx4KkTzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:17 +1000 (AEST)
Received: by mail-pl0-x22d.google.com with SMTP id n10-v6so12518486plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:17 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 01/29] powerpc: export symbol msr_check_and_set().
Date: Wed, 23 May 2018 15:01:44 +0800
Message-Id: <1527058932-7434-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

PR KVM will need to reuse msr_check_and_set().
This patch exports this API for reuse.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13..25db000 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -154,6 +154,7 @@ unsigned long msr_check_and_set(unsigned long bits)
 
 	return newmsr;
 }
+EXPORT_SYMBOL_GPL(msr_check_and_set);
 
 void __msr_check_and_clear(unsigned long bits)
 {
-- 
1.8.3.1
