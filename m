Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40K3rq1M6gzDqwW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 05:48:27 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id p53so6597465wrc.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 12:48:26 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/32: Make some functions static
Date: Sun,  8 Apr 2018 21:48:20 +0200
Message-Id: <20180408194821.19682-1-malat@debian.org>
In-Reply-To: <20180408194318.8062-1-malat@debian.org>
References: <20180408194318.8062-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
prototypes for

- ppc_setup_l2cr
- ppc_setup_l3cr
- ppc_init

were added but at the same time in commit d15a261d876d ("powerpc/32: Make
some functions static") those same functions were made static. Fix
conflicting changes by removing the prototypes and leave the function as
static. Fix the following warnings, treated as errors with W=1:

  arch/powerpc/kernel/setup_32.c:127:19: error: static declaration of ‘ppc_setup_l2cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:140:19: error: static declaration of ‘ppc_setup_l3cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:186:19: error: static declaration of ‘ppc_init’ follows non-static declaration

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Previous version contained the reverted patch, correct that.

 arch/powerpc/kernel/setup.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 35ca309848d7..829ed66f0a40 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -19,9 +19,6 @@ void irqstack_early_init(void);
 void setup_power_save(void);
 unsigned long __init early_init(unsigned long dt_ptr);
 void __init machine_init(u64 dt_ptr);
-int __init ppc_setup_l2cr(char *str);
-int __init ppc_setup_l3cr(char *str);
-int __init ppc_init(void);
 #else
 static inline void setup_power_save(void) { };
 #endif
-- 
2.11.0
