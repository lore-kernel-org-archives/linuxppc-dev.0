Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 40D41DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 00:21:17 +1100 (EST)
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id A270D58ABD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 14:21:15 +0100 (MET)
Date: Tue, 17 Feb 2009 14:21:15 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: setup_64.c:450: warning: format '%lx' expects type 'long unsigned int'
Message-ID: <alpine.LRH.2.00.0902171418050.8852@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With CONFIG_RELOCATABLE=y, I get for PS3:

| arch/powerpc/kernel/setup_64.c:450: warning: format '%lx' expects type 'long unsigned int', but argument 2 has type 'phys_addr_t'

as phys_addr_t is u64 on ppc64, while u64 is now `unsigned long long'.

Unfortunately just changing the format string is not sufficient, due to:

| #if defined(CONFIG_RELOCATABLE)
| #ifndef __ASSEMBLY__
| 
| extern phys_addr_t memstart_addr;
| extern phys_addr_t kernstart_addr;
| #endif
| #define PHYSICAL_START  kernstart_addr
| #else
| #define PHYSICAL_START  ASM_CONST(CONFIG_PHYSICAL_START)
| #endif

and ASM_CONST() appends "UL" to the constant.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
