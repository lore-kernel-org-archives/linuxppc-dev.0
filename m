Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D7DD2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 17:16:56 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] jump_label: also include linux/atomic.h when jump label
 is enabled
Date: Sun, 25 Aug 2013 15:15:49 +0800
Message-ID: <1377414952-15995-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1377414952-15995-1-git-send-email-haokexin@gmail.com>
References: <1377414952-15995-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The struct static_key will have a atomic_t type member no matter
whether jump label is enabled or not. We would include linux/atomic.h
when jump label is not enabled. But it also does make sense to include
this header file when jump label is enabled.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 include/linux/jump_label_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label_base.h b/include/linux/jump_label_base.h
index 20df08f..d5c8f4b 100644
--- a/include/linux/jump_label_base.h
+++ b/include/linux/jump_label_base.h
@@ -5,6 +5,8 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
+#include <linux/atomic.h>
+
 #if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
 
 struct static_key {
@@ -77,8 +79,6 @@ extern void jump_label_apply_nops(struct module *mod);
 
 #else  /* !HAVE_JUMP_LABEL */
 
-#include <linux/atomic.h>
-
 struct static_key {
 	atomic_t enabled;
 };
-- 
1.8.3.1
