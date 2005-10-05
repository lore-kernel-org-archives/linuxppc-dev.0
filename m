Return-Path: <paubert@iram.es>
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 5 Oct 2005 20:20:31 +0200
To: Becky Bruce <bgill@freescale.com>
Message-ID: <20051005182031.GA15359@iram.es>
References: <Pine.LNX.4.61.0509271427090.21928@cde-tx32-ldt329.sps.mot.com>
	<20050927211534.GA32173@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050927211534.GA32173@iram.es>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: improved byte swapping functions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Gabriel Paubert <paubert@iram.es>

The previous versions of ___arch__swab16 and ___arch__swab32 were
not optimal. In most cases the code can be made shorter and faster
with this patch.

Signed-off-by: Gabriel Paubert <paubert@iram.es>

---

Additional notes: 

1) for ___arch__swab16, the trick is to let the compiler 
generate a single rlwinm instruction for the final right 
shift and cast. 

2) For ___arch_swab32, the rotated value passed as a parameter 
already has 2 bytes at the right place, so only 2 rlwimi 
instructions are necessary to complete the byte swap.

3) edit if you don't like the formatting of the result.

4) I've been reading the thread about how to format patches
and I hope that I got it right. But I believe that the
diffstat output is overkill for such a small patch.

	Regards,
	Gabriel

diff --git a/include/asm-powerpc/byteorder.h b/include/asm-powerpc/byteorder.h
--- a/include/asm-powerpc/byteorder.h
+++ b/include/asm-powerpc/byteorder.h
@@ -42,23 +42,22 @@ static __inline__ void st_le32(volatile 
 
 static __inline__ __attribute_const__ __u16 ___arch__swab16(__u16 value)
 {
-	__u16 result;
+	__u32 tmp;
 
-	__asm__("rlwimi %0,%1,8,16,23"
-	    : "=r" (result)
-	    : "r" (value), "0" (value >> 8));
-	return result;
+	__asm__("rlwimi %0,%0,16,8,15"
+		: "=r" (tmp) : "0" (value));
+	return (__u16)(tmp>>8);
 }
 
 static __inline__ __attribute_const__ __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
-	__asm__("rlwimi %0,%1,24,16,23\n\t"
-	    "rlwimi %0,%1,8,8,15\n\t"
-	    "rlwimi %0,%1,24,0,7"
+	__asm__(
+"	rlwimi %0,%1,24,16,23\n"
+"	rlwimi %0,%1,24,0,7\n"
 	    : "=r" (result)
-	    : "r" (value), "0" (value >> 24));
+	    : "r" (value), "0" ((value >> 24)|(value<<8)));
 	return result;
 }
 
