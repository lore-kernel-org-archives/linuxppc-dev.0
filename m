Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1DABEDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 03:25:44 +1100 (EST)
Date: Thu, 2 Apr 2009 18:25:41 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Correct dependency of KEXEC (was: Re: kexec:
	proc/device-tree/chosen/linux,kernel-end: No such file or directory)
In-Reply-To: <alpine.LRH.2.00.0903311808310.32461@vixen.sonytel.be>
Message-ID: <alpine.LRH.2.00.0904021823380.21587@vixen.sonytel.be>
References: <alpine.LRH.2.00.0903311808310.32461@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 31 Mar 2009, Geert Uytterhoeven wrote:
> With today's kernel, I can no longer kexec any kernel on PS3:
> 
> | /proc/device-tree/chosen/linux,kernel-end: No such file or directory
> | Could not get memory layout
> 
> Today's bad version: 15f7176eb1cccec0a332541285ee752b935c1c85
> Yesterday's good version: 0d34fb8e93ceba7b6dad0062dbb4a0813bacd75b
> 
> Before I start bisecting (tomorrow or the day thereafter), anyone with an idea?

Subject: powerpc: Correct dependency of KEXEC

commit 28794d34ecb6815a3fa0a4256027c9b081a17c5f ("powerpc/kconfig: Kill
PPC_MULTIPLATFORM") broke KEXEC, by making it dependant on BOOK3S, while it
should be PPC_BOOK3S.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -313,7 +313,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on BOOK3S && EXPERIMENTAL
+	depends on PPC_BOOK3S && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot

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
