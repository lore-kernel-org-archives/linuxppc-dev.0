Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP8sK2MJgzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 00:47:16 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Russell Currey <ruscur@russell.cc>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] powerpc/eeh: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <0a35cb55-9f6b-21ca-565f-cab26237c962@users.sourceforge.net>
Date: Fri, 4 Aug 2017 16:46:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 4 Aug 2017 16:37:56 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/eeh_dev.c   | 5 +----
 arch/powerpc/kernel/eeh_event.c | 5 ++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index d6b2ca70d14d..2742ecbadf18 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -55,11 +55,8 @@ struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 
 	/* Allocate EEH device */
 	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
-	if (!edev) {
-		pr_warn("%s: out of memory\n",
-			__func__);
+	if (!edev)
 		return NULL;
-	}
 
 	/* Associate EEH device with OF node */
 	pdn->edev = edev;
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index accbf8b5fd46..c62bd90e038f 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -132,10 +132,9 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	struct eeh_event *event;
 
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
-	if (!event) {
-		pr_err("EEH: out of memory, event not handled\n");
+	if (!event)
 		return -ENOMEM;
-	}
+
 	event->pe = pe;
 
 	/* We may or may not be called in an interrupt context */
-- 
2.13.4
