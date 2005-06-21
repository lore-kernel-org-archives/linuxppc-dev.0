Return-Path: <blofeldus@yahoo.com>
Received: from web53508.mail.yahoo.com (web53508.mail.yahoo.com
	[206.190.37.69]) by ozlabs.org (Postfix) with SMTP id 1662067A6B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2005 05:51:43 +1000 (EST)
Message-ID: <20050621194419.69010.qmail@web53508.mail.yahoo.com>
Date: Tue, 21 Jun 2005 12:44:19 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [PATCH] gcc4 fix for asm/time.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi
 GCC4 complains:

include/asm/time.h:61: warning: type qualifiers ignored on function
return type

so I propose this patch.

Signed off by: Roger Blofeld <blofeldus@yahoo.com>

diff --git a/include/asm-ppc/time.h b/include/asm-ppc/time.h
--- a/include/asm-ppc/time.h
+++ b/include/asm-ppc/time.h
@@ -58,7 +58,7 @@ static __inline__ void set_dec(unsigned 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_const__ __USE_RTC(void) {
        return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else



		
__________________________________ 
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 
