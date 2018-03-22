Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNT6NLvzF20D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:13 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id d10so9993544wrf.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:13 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 18/19] powerpc: Add a missing include header
Date: Thu, 22 Mar 2018 21:20:04 +0100
Message-Id: <20180322202007.23088-19-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
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

The header file <asm/switch_to.h> was missing from the includes. Fix the
following warning, treated as error with W=1:

  arch/powerpc/kernel/vecemu.c:260:5: error: no previous prototype for ‘emulate_altivec’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/vecemu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vecemu.c b/arch/powerpc/kernel/vecemu.c
index 8812085883fd..4acd3fb2b38e 100644
--- a/arch/powerpc/kernel/vecemu.c
+++ b/arch/powerpc/kernel/vecemu.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+#include <asm/switch_to.h>
 #include <linux/uaccess.h>
 
 /* Functions in vector.S */
-- 
2.11.0
