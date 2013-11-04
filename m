Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1C" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A9202C05F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 03:54:22 +1100 (EST)
Date: Mon, 4 Nov 2013 16:54:15 +0000
From: "Joseph S. Myers" <joseph@codesourcery.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/6] math-emu: fix floating-point to integer overflow detection
In-Reply-To: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
Message-ID: <Pine.LNX.4.64.1311041653550.4290@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: Joseph Myers <joseph@codesourcery.com>
Cc: Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
 Shan Hai <shan.hai@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joseph Myers <joseph@codesourcery.com>

On overflow, the math-emu macro _FP_TO_INT_ROUND tries to saturate its
result (subject to the value of rsigned specifying the desired
overflow semantics).  However, if the rounding step has the effect of
increasing the exponent so as to cause overflow (if the rounded result
is 1 larger than the largest positive value with the given number of
bits, allowing for signedness), the overflow does not get detected,
meaning that for unsigned results 0 is produced instead of the maximum
unsigned integer with the give number of bits, without an exception
being raised for overflow, and that for signed results the minimum
(negative) value is produced instead of the maximum (positive) value,
again without an exception.  This patch makes the code check for
rounding increasing the exponent and adjusts the exponent value as
needed for the overflow check.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

Previous submission: <http://lkml.org/lkml/2013/10/8/700>.

This macro is not present in the glibc/libgcc version of the code.  It
remains the case both before and after this patch that the conversions
wrongly treat a signed result of the most negative integer as an
overflow, when actually only that integer minus 1 or smaller should be
an overflow, although this only means an incorrect exception rather
than affecting the value returned; that was one of the bugs I fixed in
the glibc/libgcc version of this code in 2006 (as part of a major
overhaul of the code including various interface changes, so not
trivially backportable to the kernel version).

diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index 70fe5e9..6bdf8c6 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -743,12 +743,17 @@ do {									\
 	  }									\
 	else									\
 	  {									\
+	    int _lz0, _lz1;							\
 	    if (X##_e <= -_FP_WORKBITS - 1)					\
 	      _FP_FRAC_SET_##wc(X, _FP_MINFRAC_##wc);				\
 	    else								\
 	      _FP_FRAC_SRS_##wc(X, _FP_FRACBITS_##fs - 1 - X##_e,		\
 				_FP_WFRACBITS_##fs);				\
+	    _FP_FRAC_CLZ_##wc(_lz0, X);						\
 	    _FP_ROUND(wc, X);							\
+	    _FP_FRAC_CLZ_##wc(_lz1, X);						\
+	    if (_lz1 < _lz0)							\
+	      X##_e++; /* For overflow detection.  */				\
 	    _FP_FRAC_SRL_##wc(X, _FP_WORKBITS);					\
 	    _FP_FRAC_ASSEMBLE_##wc(r, X, rsize);				\
 	  }									\

-- 
Joseph S. Myers
joseph@codesourcery.com
