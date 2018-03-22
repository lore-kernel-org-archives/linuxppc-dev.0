Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNR6ZJrzF20G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:11 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id s10so9986369wra.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:11 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 17/19] powerpc/32: Add a missing include header
Date: Thu, 22 Mar 2018 21:20:03 +0100
Message-Id: <20180322202007.23088-18-malat@debian.org>
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

The header file <linux/syscalls.h> was missing from the includes. Fix the
following warning, treated as error with W=1:

  arch/powerpc/kernel/pci_32.c:286:6: error: no previous prototype for ‘sys_pciconfig_iobase’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/pci_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 85ad2f78b889..51cba7d7a4fd 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/bootmem.h>
+#include <linux/syscalls.h>
 #include <linux/irq.h>
 #include <linux/list.h>
 #include <linux/of.h>
-- 
2.11.0
