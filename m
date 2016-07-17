Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsV2y14WGzDqRQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:03:38 +1000 (AEST)
Received: by mail-pf0-f195.google.com with SMTP id g202so8983199pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 19:03:38 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v11 14/27] selftests/powerpc: Use the new SPRN_DSCR_PRIV
 definiton
Date: Sun, 17 Jul 2016 09:59:47 +0800
Message-Id: <1468720800-2950-15-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
References: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Now that the new DSCR register definitions (SPRN_DSCR_PRIV and
SPRN_DSCR) are defined outside this directory, use them instead.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/dscr/dscr.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr.h b/tools/testing/selftests/powerpc/dscr/dscr.h
index a36af1b..18ea223b 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr.h
+++ b/tools/testing/selftests/powerpc/dscr/dscr.h
@@ -28,8 +28,6 @@
 
 #include "utils.h"
 
-#define SPRN_DSCR	0x11	/* Privilege state SPR */
-#define SPRN_DSCR_USR	0x03	/* Problem state SPR */
 #define THREADS		100	/* Max threads */
 #define COUNT		100	/* Max iterations */
 #define DSCR_MAX	16	/* Max DSCR value */
@@ -48,14 +46,14 @@ inline unsigned long get_dscr(void)
 {
 	unsigned long ret;
 
-	asm volatile("mfspr %0,%1" : "=r" (ret): "i" (SPRN_DSCR));
+	asm volatile("mfspr %0,%1" : "=r" (ret) : "i" (SPRN_DSCR_PRIV));
 
 	return ret;
 }
 
 inline void set_dscr(unsigned long val)
 {
-	asm volatile("mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR));
+	asm volatile("mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR_PRIV));
 }
 
 /* Problem state DSCR access */
@@ -63,14 +61,14 @@ inline unsigned long get_dscr_usr(void)
 {
 	unsigned long ret;
 
-	asm volatile("mfspr %0,%1" : "=r" (ret): "i" (SPRN_DSCR_USR));
+	asm volatile("mfspr %0,%1" : "=r" (ret) : "i" (SPRN_DSCR));
 
 	return ret;
 }
 
 inline void set_dscr_usr(unsigned long val)
 {
-	asm volatile("mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR_USR));
+	asm volatile("mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR));
 }
 
 /* Default DSCR access */
-- 
1.8.3.1
