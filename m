Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id B662FDDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 19:18:12 +1100 (EST)
Date: Tue, 13 Nov 2007 09:18:11 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Make isa_mem_base common to 32 and 64 bits
In-Reply-To: <20071113044429.461B1DDE2E@ozlabs.org>
Message-ID: <Pine.LNX.4.62.0711130917350.31003@pademelon.sonytel.be>
References: <20071113044429.461B1DDE2E@ozlabs.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-892745891-1194941891=:31003"
Cc: linuxppc-dev@ozlabs.org
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

---584337861-892745891-1194941891=:31003
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 13 Nov 2007, Benjamin Herrenschmidt wrote:
> This defines isa_mem_base on both 32 and 64 bits (it used to be 32 bits
> only). This avoids a few ifdef's in later patches and potentially can
> allow support for VGA text mode on 64 bits powerpc.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Small cleanup pre-requisite for my next patch
> 
>  arch/powerpc/kernel/pci-common.c |    4 ++++
>  arch/powerpc/kernel/pci_32.c     |    1 -
>  include/asm-powerpc/io.h         |    5 +++--
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> Index: linux-work/arch/powerpc/kernel/pci-common.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/pci-common.c	2007-11-13 14:11:11.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/pci-common.c	2007-11-13 14:15:43.000000000 +1100
> @@ -52,6 +52,10 @@ int global_phb_number;		/* Global phb co
>  
>  extern struct list_head hose_list;
>  
> +/* ISA Memory physical address (or 0 if none) */
                                   ^^^^^^^^^^^^
> +resource_size_t isa_mem_base    = 0;

Let's hope this doesn't confuse too many people, as 0 is the valid value on
legacy PC hardware ;-)

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
---584337861-892745891-1194941891=:31003--
