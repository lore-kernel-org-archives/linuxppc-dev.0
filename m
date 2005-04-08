Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id 0FB3D67B25
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 00:08:28 +1000 (EST)
Message-ID: <4256904C.6080703@xiphos.ca>
Date: Fri, 08 Apr 2005 10:08:12 -0400
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: Joshua Lamorie <jpl@xiphos.ca>
References: <42545228.9060003@xiphos.ca> <4254FB38.9040202@bluewin.ch>
	<425541C8.6060408@xiphos.ca>
In-Reply-To: <425541C8.6060408@xiphos.ca>
Content-Type: multipart/mixed; boundary="------------070000080509030006030405"
Cc: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>, rtai@rtai.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: Unhandled relocation of type 11
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070000080509030006030405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yes, this fix appeared to work.  It looks like there are just four 
14-bit references:

ppc_ftoui.S:56:     blt     __fixsfsi               /* return directly 
from there */     
ppc_ftoui.S:61:     blt     __fixsfsi               /* return directly 
form there */
ppc_dtoui.S:63:     blt     __fixdfsi
ppc_dtoui.S:73:     blt     __fixdfsi

I've sent an email to the sourceforge maintainer, but I haven't heard 
anything yet.  It's a great library, it greatly improves FP 
performance.  Anyone else been using it?  Any problems?

My fix is attached.

Joshua

-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.


--------------070000080509030006030405
Content-Type: text/plain;
 name="fptoui_module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fptoui_module.patch"

--- perflibs.orig/fpopt/ppc_dtoui.S	2003-12-12 15:38:02.000000000 -0500
+++ perflibs/fpopt/ppc_dtoui.S	2005-04-08 10:03:19.629210784 -0400
@@ -53,14 +53,26 @@ function_prolog(__fixunsdfsi)
 
 /* For negative numbers, just convert to signed integer */
      or.     r3,r3,r3      
-     blt     __fixdfsi               /* return directly from there */      
+#if defined(__KERNEL__) && defined(MODULE)
+     bge     positive
+     bl     __fixdfsi               /* return directly from there */      
+#else
+     blt     __fixdfsi
+#endif
      
+positive:	     
      rlwinm  r8,r3,12,0x000007FF      /* extract exponent */
 /* For numbers less than maximum positive signed integer, convert normally */     
      cmpwi   r8, 0x041e     
-     blt     __fixdfsi               /* return directly form there */
+#if defined(__KERNEL__) && defined(MODULE)
+     bge     overmax 
+     bl     __fixdfsi               /* return directly form there */
+#else
+     blt     __fixdfsi
+#endif
      
 /* Create stack frame, just to save link register! */
+overmax:
      mflr    r0                      /* save link register in caller's stack */
      stw     r0,4(r1)               
      stwu    r1,-STACKSIZE(r1)       /* set up stack frame to hold saved regs */
--- perflibs.orig/fpopt/ppc_ftoui.S	2003-12-12 15:38:02.000000000 -0500
+++ perflibs/fpopt/ppc_ftoui.S	2005-04-08 10:06:46.155813968 -0400
@@ -53,14 +53,26 @@ function_prolog(__fixunssfsi)
 
 /* For negative numbers, just convert to signed integer */
      or.     r3,r3,r3      
-     blt     __fixsfsi               /* return directly from there */      
+#if defined(__KERNEL__) && defined(MODULE)
+     bge     positive
+     bl      __fixsfsi               /* return directly from there */      
+#else
+     blt     __fixsfsi
+#endif	
      
+positive:
      rlwinm  r8,r3,9,0x000000FF      /* extract exponent */
 /* For numbers less than maximum positive signed integer, convert normally */     
      cmpwi   r8, 0x009e     
-     blt     __fixsfsi               /* return directly form there */
+#if defined(__KERNEL__) && defined(MODULE)
+     bge     overmax 
+     bl      __fixsfsi               /* return directly form there */
+#else
+     blt     __fixsfsi
+#endif
      
 /* Create stack frame, just to save link register! */
+overmax:
      mflr    r0                      /* save link register in caller's stack */
      stw     r0,4(r1)               
      stwu    r1,-STACKSIZE(r1)       /* set up stack frame to hold saved regs */

--------------070000080509030006030405--
