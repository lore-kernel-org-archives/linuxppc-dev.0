Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1C" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0BBC2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:12:34 +1100 (EST)
Date: Tue, 8 Oct 2013 23:12:27 +0000
From: "Joseph S. Myers" <joseph@codesourcery.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] math-emu: fix floating-point to integer unsigned saturation
Message-ID: <Pine.LNX.4.64.1310082310120.23637@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: Joseph Myers <joseph@codesourcery.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joseph Myers <joseph@codesourcery.com>

The math-emu macros _FP_TO_INT and _FP_TO_INT_ROUND are supposed to
saturate their results for out-of-range arguments, except in the case
rsigned == 2 (when instead the low bits of the result are taken).
However, in the case rsigned == 0 (converting to unsigned integers),
they mistakenly produce 0 for positive results and the maximum
unsigned integer for negative results, the opposite of correct
unsigned saturation.  This patch fixes the logic.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

I intend to make the corresponding changes to the glibc/libgcc copy of
this code, given that it would be desirable to resync the Linux and
glibc/libgcc copies (the latter has had many enhancements and bug
fixes since it was copied into Linux), although strictly this
incorrect saturation is only a bug when trying to emulate particular
instruction semantics, not when used in userspace to implement C
operations where the results of out-of-range conversions are
unspecified or undefined.

diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 9696a5e..70fe5e9 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -685,7 +685,7 @@ do {									\
 	    else								\
 	      {									\
 		r = 0;								\
-		if (X##_s)							\
+		if (!X##_s)							\
 		  r = ~r;							\
 	      }									\
 	    FP_SET_EXCEPTION(FP_EX_INVALID);					\
@@ -762,7 +762,7 @@ do {									\
 	    if (!rsigned)							\
 	      {									\
 		r = 0;								\
-		if (X##_s)							\
+		if (!X##_s)							\
 		  r = ~r;							\
 	      }									\
 	    else if (rsigned != 2)						\

-- 
Joseph S. Myers
joseph@codesourcery.com
