Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrQsF1G8SzF1V5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 04:38:21 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id c11-v6so8376579plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:38:21 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 01/30] powerpc: export symbol msr_check_and_set().
Date: Wed, 28 Feb 2018 01:37:08 +0800
Message-Id: <1519753057-11059-2-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753057-11059-1-git-send-email-wei.guo.simon@gmail.com>
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
index 72be0c3..8f430e6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -152,6 +152,7 @@ unsigned long msr_check_and_set(unsigned long bits)
 
 	return newmsr;
 }
+EXPORT_SYMBOL_GPL(msr_check_and_set);
 
 void __msr_check_and_clear(unsigned long bits)
 {
-- 
1.8.3.1
