Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 547142C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 03:32:09 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH 2/4] powerpc: book3s kvm can be modular so it should use
 module.h
Date: Mon, 13 Jan 2014 11:21:51 -0500
Message-ID: <1389630113-7919-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389630113-7919-1-git-send-email-paul.gortmaker@windriver.com>
References: <1389630113-7919-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM support is tristate, so this file should be including
module.h instead of export.h -- it only works currently because
module_init is currently (mis)placed in init.h -- but we are
intending to clean that up and relocate it to module.h

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kvm/book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 8912608b7e1b..279459e8a072 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -16,7 +16,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/err.h>
-#include <linux/export.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include <asm/reg.h>
-- 
1.8.5.2
