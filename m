Return-Path: <seth.forshee@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2wdL4SW4zDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 23:33:57 +1000 (AEST)
Received: from mail-qk0-f199.google.com ([209.85.220.199])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <seth.forshee@canonical.com>)
 id 1dxYws-000421-0q
 for linuxppc-dev@lists.ozlabs.org; Thu, 28 Sep 2017 13:33:54 +0000
Received: by mail-qk0-f199.google.com with SMTP id h13so550980qke.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 06:33:53 -0700 (PDT)
From: Seth Forshee <seth.forshee@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Seth Forshee <seth.forshee@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Always initialize input array when calling
 epapr_hypercall()
Date: Thu, 28 Sep 2017 09:33:39 -0400
Message-Id: <20170928133340.19312-1-seth.forshee@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several callers to epapr_hypercall() pass an uninitialized stack
allocated array for the input arguments, presumably because they
have no input arguments. However this can produce errors like
this one

 arch/powerpc/include/asm/epapr_hcalls.h:470:42: error: 'in' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  unsigned long register r3 asm("r3") = in[0];
                                        ~~^~~

Fix callers to this function to always zero-initialize the input
arguments array to prevent this.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 arch/powerpc/include/asm/epapr_hcalls.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index 334459ad145b..90863245df53 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -508,7 +508,7 @@ static unsigned long epapr_hypercall(unsigned long *in,
 
 static inline long epapr_hypercall0_1(unsigned int nr, unsigned long *r2)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 	unsigned long r;
 
@@ -520,7 +520,7 @@ static inline long epapr_hypercall0_1(unsigned int nr, unsigned long *r2)
 
 static inline long epapr_hypercall0(unsigned int nr)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	return epapr_hypercall(in, out, nr);
@@ -528,7 +528,7 @@ static inline long epapr_hypercall0(unsigned int nr)
 
 static inline long epapr_hypercall1(unsigned int nr, unsigned long p1)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
@@ -538,7 +538,7 @@ static inline long epapr_hypercall1(unsigned int nr, unsigned long p1)
 static inline long epapr_hypercall2(unsigned int nr, unsigned long p1,
 				    unsigned long p2)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
@@ -549,7 +549,7 @@ static inline long epapr_hypercall2(unsigned int nr, unsigned long p1,
 static inline long epapr_hypercall3(unsigned int nr, unsigned long p1,
 				    unsigned long p2, unsigned long p3)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
@@ -562,7 +562,7 @@ static inline long epapr_hypercall4(unsigned int nr, unsigned long p1,
 				    unsigned long p2, unsigned long p3,
 				    unsigned long p4)
 {
-	unsigned long in[8];
+	unsigned long in[8] = {0};
 	unsigned long out[8];
 
 	in[0] = p1;
-- 
2.14.1
