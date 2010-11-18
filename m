Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A284B71E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 11:10:31 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: <grant.likely@secretlab.ca>, <dirk.brandewie@gmail.com>,
	<devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>,
	<microblaze-uclinux@itee.uq.edu.au>
Subject: [PATCH 2/7] arch/x86: Add support for device tree code.
Date: Thu, 18 Nov 2010 15:54:57 -0800
In-Reply-To: <1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <98608b2e-d138-4dc0-808d-3662ab2c9938@VA3EHSMHS025.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few support device-tree related support functions that x86 didn't
have before.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

----

Looks like just some irq related junk left!
---
 arch/x86/include/asm/irq.h |    2 ++
 arch/x86/kernel/irq.c      |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 5458380..af4e630 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -10,6 +10,8 @@
 #include <asm/apicdef.h>
 #include <asm/irq_vectors.h>
 
+#define irq_dispose_mapping(...)
+
 static inline int irq_canonicalize(int irq)
 {
 	return ((irq == 2) ? 9 : irq);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 91fd0c7..a3aaed4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -364,3 +364,14 @@ void fixup_irqs(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_OF
+#include <linux/of_irq.h>
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   const u32 *intspec, unsigned int intsize)
+{
+	return intspec[0] + 1;
+}
+EXPORT_SYMBOL_GPL(irq_create_of_mapping);
+
+#endif
-- 
1.5.6.6



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
