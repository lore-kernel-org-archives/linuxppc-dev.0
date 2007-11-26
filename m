Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id B0449DDF51
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 03:49:53 +1100 (EST)
Date: Mon, 26 Nov 2007 17:24:43 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: kill sparse warning in HPTE_V_COMPARE()
Message-ID: <Pine.LNX.4.62.0711261724120.32260@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-731037697-1196094283=:32260"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-731037697-1196094283=:32260
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

sparse warning: constant 0xffffffffffffff80 is so big it is unsigned long

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 include/asm-powerpc/mmu-hash64.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -80,7 +80,7 @@ extern char initial_stab[];
 #define HPTE_V_AVPN_SHIFT	7
 #define HPTE_V_AVPN		ASM_CONST(0x3fffffffffffff80)
 #define HPTE_V_AVPN_VAL(x)	(((x) & HPTE_V_AVPN) >> HPTE_V_AVPN_SHIFT)
-#define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & 0xffffffffffffff80))
+#define HPTE_V_COMPARE(x,y)	(!(((x) ^ (y)) & 0xffffffffffffff80UL))
 #define HPTE_V_BOLTED		ASM_CONST(0x0000000000000010)
 #define HPTE_V_LOCK		ASM_CONST(0x0000000000000008)
 #define HPTE_V_LARGE		ASM_CONST(0x0000000000000004)

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-731037697-1196094283=:32260--
