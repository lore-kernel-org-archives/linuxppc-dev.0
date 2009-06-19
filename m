Return-Path: <lorenz@missinglinkelectronics.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81A48B7271
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 03:06:39 +1000 (EST)
Received: from smtp.esic-solutions.com (h1371364.stratoserver.net
	[85.214.87.145]) by ozlabs.org (Postfix) with ESMTP id 903C5DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 03:06:38 +1000 (EST)
Message-ID: <4A3BC58A.7050408@missinglinkelectronics.com>
Date: Fri, 19 Jun 2009 19:06:18 +0200
From: Lorenz Kolb <lorenz@missinglinkelectronics.com>
MIME-Version: 1.0
To: Fahd Abidi <fabidi@ultsol.com>
Subject: Re: Problem with memcpy on ppc8536
References: <71DEA556544D7A4F9C6848402D8184340C4A13__24467.8549039692$1245370891$gmane$org@usi01.ultsol.local>
In-Reply-To: <71DEA556544D7A4F9C6848402D8184340C4A13__24467.8549039692$1245370891$gmane$org@usi01.ultsol.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Could you please try the following patch, I am quite sure that checking 
for > 4 was accidentially done within io.c instead of >= 4 as if it's 4 
we still can copy a 32-bit word. Some hardware might not be happy about 
8-bit accesses...

Index: 2.6.30-source/arch/powerpc/kernel/io.c
===================================================================
--- a/2.6.30-source/arch/powerpc/kernel/io.c
+++ b/2.6.30-source/arch/powerpc/kernel/io.c

@@ -162,5 +162,5 @@
                  n--;
          }
-        while(n > 4) {
+        while(n >= 4) {
                  *((u32 *)dest) = *((volatile u32 *)vsrc);
                  eieio();
@@ -191,5 +191,5 @@
                  n--;
          }
-        while(n > 4) {
+        while(n >= 4) {
                  *((volatile u32 *)vdest) = *((volatile u32 *)src);
                  src += 4;

Fahd Abidi wrote:
> Hello, 
> 
> I am trying to debug a crash during memcpy while copying data from the
> FCM buffer of an mpc8536 to the ddr ram. I debugged memcpy enough
> through my BDI3000 to see that the entire contents of the fcm buffer I
> want moved are actually moved off to memory location I specify. The
> crash comes after it memcpy finishes copying and performs the
> instruction "2: cmplwi 0,r5,4": 
> 
> memcpy: 
> rlwinm. r7,r5,32-3,3,31 /* r0 = r5 >> 3 */ 
> addi r6,r3,-4 
> addi r4,r4,-4 
> beq 2f /* if less than 8 bytes to do */ 
> andi. r0,r6,3 /* get dest word aligned */ 
> mtctr r7 
> bne 5f 
> 1: lwz r7,4(r4) 
> lwzu r8,8(r4) 
> stw r7,4(r6) 
> stwu r8,8(r6) 
> bdnz 1b 
> andi. r5,r5,7 
> 2: cmplwi 0,r5,4 
> 
> contents of r5 are 0x0 showing that the entire 0x1000 size transfer I
> specified correctly finished. At this point I can check the memory
> contents through my BDI and verify all the data is in the ddr as I
> expect. Now the strange thing happens, if I execute the "cmplwi 0,r5,4"
> the program takes an exception and eventually gets struck at exception
> vector 0x700 which I saw from start.S is an "Alignment" exception. I am
> not sure what this exception means, can someone help me understand what
> is happening? 
> 
> Does this exception somehow mean that memcpy did not move all the data?
> Does memcpy expect contents of r5 to be 4 and not 0 when it hits the
> cmplwi instruction? 
> 
> 
> Fahd Abidi
> Product Manager - Technical Tools and Development
> Ultimate Solutions, Inc.
> ================================================================
> Your Single Source for Professional Development Tools and Embedded
> Solutions
> Ph: 978-455-3383 x255
> Fx: 978-926-3091
> Email: fabidi@ultsol.com
> Visit: http://www.ultsol.com <http://www.ultsol.com/>  
>  
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
