Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7E887DEA8D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 02:20:20 +1000 (EST)
Date: Tue, 19 Aug 2008 18:20:15 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] powerpc: Make the 64-bit kernel as a
	position-independent executable
In-Reply-To: <18594.15027.214064.283433@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0808191816450.25348@vixen.sonytel.be>
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<18594.15027.214064.283433@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-694076064-1219162815=:25348"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-694076064-1219162815=:25348
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Aug 2008, Paul Mackerras wrote:
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -1163,7 +1163,9 @@ void __init early_init_devtree(void *params)
>  	parse_early_param();
>  
>  	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
> -	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
> +	lmb_reserve(0, __end_interrupts - _stext);
> +	lmb_reserve(__pa(__end_interrupts),
> +		    klimit - (unsigned long)__end_interrupts);
>  	reserve_kdump_trampoline();
>  	reserve_crashkernel();
>  	early_reserve_mem();

This part broke ppc32:

| arch/powerpc/kernel/prom.c: In function 'early_init_devtree':
| arch/powerpc/kernel/prom.c:1166: error: '__end_interrupts' undeclared (first use in this function)
| arch/powerpc/kernel/prom.c:1166: error: (Each undeclared identifier is reported only once
| arch/powerpc/kernel/prom.c:1166: error: for each function it appears in.)

After applying the patch below, I was able to build and boot a kernel for the
Sequoia.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/kernel/prom.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1163,9 +1163,13 @@ void __init early_init_devtree(void *par
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
+#ifdef CONFIG_PPC64
 	lmb_reserve(0, __end_interrupts - _stext);
 	lmb_reserve(__pa(__end_interrupts),
 		    klimit - (unsigned long)__end_interrupts);
+#else
+	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+#endif
 	reserve_kdump_trampoline();
 	reserve_crashkernel();
 	early_reserve_mem();

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
---584349381-694076064-1219162815=:25348--
