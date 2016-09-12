Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXfh32Pp8zDsPv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 17:34:11 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 128so7708285pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:34:11 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v14 02/15] selftests/powerpc: Use the new SPRN_DSCR_PRIV
 definiton
Date: Mon, 12 Sep 2016 15:33:12 +0800
Message-Id: <1473665605-11890-3-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
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
