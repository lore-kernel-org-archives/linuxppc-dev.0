Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FF1D1A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 05:40:42 +1100 (AEDT)
Date: Thu, 19 Feb 2015 18:40:34 +0000
From: Joseph Myers <joseph@codesourcery.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH RFC] Update kernel math-emu code from current glibc soft-fp
In-Reply-To: <20150219.132122.204795202277130266.davem@davemloft.net>
Message-ID: <alpine.DEB.2.10.1502191835490.22905@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1502061719210.27832@digraph.polyomino.org.uk>
 <20150219.132122.204795202277130266.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-273902004-1424371234=:22905"
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kkojima@rr.iij4u.or.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---1152306461-273902004-1424371234=:22905
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: 8BIT

On Thu, 19 Feb 2015, David Miller wrote:

> From: Joseph Myers <joseph@codesourcery.com>
> Date: Fri, 6 Feb 2015 17:25:29 +0000
> 
> > * On SPARC, comparisons now use raw unpacking (this should not in fact
> >   change how the emulation behaves, just make it more efficient).
> 
> I did a sparc64 test build and it failed like so:
> 
> arch/sparc/math-emu/math_64.c: In function ¡do_mathemu¢:
> arch/sparc/math-emu/math_64.c:487:1: error: expected expression before ¡return¢
> arch/sparc/math-emu/math_64.c:488:1: error: expected expression before ¡return¢
> arch/sparc/math-emu/math_64.c:490:1: error: expected expression before ¡return¢
> arch/sparc/math-emu/math_64.c:491:1: error: expected expression before ¡return¢
> arch/sparc/math-emu/math_64.c:495:1: error: expected expression before ¡return¢
> 
> I'm attaching a CPP processed math_64.c for your convenience:

Please try this patch on top of the previous one.  The way abort is 
redefined in the kernel code doesn't work for one place using it in an 
expression; this patch changes a comma expression to a statement 
expression.  This didn't appear in my powerpc testing because the powerpc 
emulation never uses FP_FROM_INT; I'm not sure how Kaz's sh testing 
avoided the problem appearing there.

diff --git a/include/math-emu/op-common.h b/include/math-emu/op-common.h
index b9f5e1a..8c059c3 100644
--- a/include/math-emu/op-common.h
+++ b/include/math-emu/op-common.h
@@ -1818,7 +1818,7 @@
 			 X##_e = (_FP_EXPBIAS_##fs + 2 * _FP_W_TYPE_SIZE - 1 \
 				  - _FP_FROM_INT_lz);			\
 		       })						\
-		     : (abort (), 0)));					\
+		     : ({ abort (); 0; })));				\
 									\
 	  if ((rsize) - 1 + _FP_EXPBIAS_##fs >= _FP_EXPMAX_##fs		\
 	      && X##_e >= _FP_EXPMAX_##fs)				\

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-273902004-1424371234=:22905--
