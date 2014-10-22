Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D6D91A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 14:32:57 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powernv: Use _GLOBAL_TOC for opal wrappers
Message-Id: <1413948772.62479.492398078454.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 22 Oct 2014 11:32:52 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we can't call opal wrappers from modules when using the LE
ABIv2, which requires a TOC init.

This change uses the _GLOBAL_TOC() macro (rather than _GLOBAL) for the
opal wrappers, so that we can do non-local calls to them.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e9e2450..845a5c5 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -58,7 +58,7 @@ END_FTR_SECTION(0, 1);						\
  */
 
 #define OPAL_CALL(name, token)		\
- _GLOBAL(name);				\
+ _GLOBAL_TOC(name);				\
 	mflr	r0;			\
 	std	r0,16(r1);		\
 	li	r0,token;		\
