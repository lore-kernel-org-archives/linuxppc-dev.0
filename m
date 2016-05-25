Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFS0s0FbpzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 08:40:45 +1000 (AEST)
Date: Thu, 26 May 2016 08:39:55 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Align hot loops of some string functions
Message-ID: <20160526083955.3f7deda4@kryten>
In-Reply-To: <20160526083813.0f96a454@kryten>
References: <20160526083813.0f96a454@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Align the hot loops in our assembly implementation of strncpy(),
strncmp() and memchr().

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.junk/arch/powerpc/lib/string.S
===================================================================
--- linux.junk.orig/arch/powerpc/lib/string.S
+++ linux.junk/arch/powerpc/lib/string.S
@@ -24,6 +24,7 @@ _GLOBAL(strncpy)
 	mtctr	r5
 	addi	r6,r3,-1
 	addi	r4,r4,-1
+	.balign 16
 1:	lbzu	r0,1(r4)
 	cmpwi	0,r0,0
 	stbu	r0,1(r6)
@@ -42,6 +43,7 @@ _GLOBAL(strncmp)
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
+	.balign 16
 1:	lbzu	r3,1(r5)
 	cmpwi	1,r3,0
 	lbzu	r0,1(r4)
@@ -73,6 +75,7 @@ _GLOBAL(memchr)
 	beq-	2f
 	mtctr	r5
 	addi	r3,r3,-1
+	.balign 16
 1:	lbzu	r0,1(r3)
 	cmpw	0,r0,r4
 	bdnzf	2,1b
