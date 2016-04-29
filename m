Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxT0821BRzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 08:29:43 +1000 (AEST)
Date: Sat, 30 Apr 2016 08:29:27 +1000
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, felix@linux.vnet.ibm.com, Bill
 Schmidt <wschmidt@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: create_zero_mask() has bad inline assembly constraint
Message-ID: <20160430082927.2111f5ae@kryten>
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

In create_zero_mask() we have:

	addi	%1,%2,-1
	andc	%1,%1,%2
	popcntd	%0,%1

using the "r" constraint for %2. r0 is a valid register in the "r" set,
but addi X,r0,X turns it into an li:

	li	r7,-1
	andc	r7,r7,r0
	popcntd	r4,r7

Fix this by using the "b" constraint, for which r0 is not a valid
register.

This was found with a kernel build using gcc trunk, narrowed down to
when -frename-registers was enabled at -O2. It is just luck however
that we aren't seeing this on older toolchains.

Thanks to Segher for working with me to find this issue.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@vger.kernel.org>
Fixes: d0cebfa650a0 ("powerpc: word-at-a-time optimization for 64-bit Little Endian")
---

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index e4396a7..4afe66a 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -82,7 +82,7 @@ static inline unsigned long create_zero_mask(unsigned long bits)
 	    "andc	%1,%1,%2\n\t"
 	    "popcntd	%0,%1"
 		: "=r" (leading_zero_bits), "=&r" (trailing_zero_bit_mask)
-		: "r" (bits));
+		: "b" (bits));
 
 	return leading_zero_bits;
 }
