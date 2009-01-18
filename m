Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 20FD1474C5
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 06:43:56 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 18 Jan 2009 20:43:53 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20081219051455.EBC28DE04A@ozlabs.org>
Message-ID: <20090118194353.85500@gmx.net>
MIME-Version: 1.0
References: <20081219051455.EBC28DE04A@ozlabs.org>
Subject: Re: [PATCH 9/10] powerpc/mm: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED v2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Fri, 19 Dec 2008 16:13:51 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Paul Mackerras <paulus@samba.org>
> CC: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
> Betreff: [PATCH 9/10] powerpc/mm: Rework usage of	_PAGE_COHERENT/NO_CACHE/GUARDED v2

> Currently, we never set _PAGE_COHERENT in the PTEs, we just OR it in
> in the hash code based on some CPU feature bit. We also manipulate
> _PAGE_NO_CACHE and _PAGE_GUARDED by hand in all sorts of places.
> 
> This changes the logic so that instead, the PTE now contains
> _PAGE_COHERENT for all normal RAM pages thay have I = 0 on platforms
> that need it. The hash code clears it if the feature bit is not set.
This somehow breaks Linux on my AmigaOne, as its northbridge doesn't like pages
marked as coherent. I removed the CPU_FTR_NEED_COHERENT feature bit
in setup_32.c before the fixups are done, but the system still locks up (doing the
fixup in the platform code is too late). It only works stable, if I remove the
_PAGE_COHERENT flag in pgtable-ppc32.h below.

> +#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
> +#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)

>  BEGIN_FTR_SECTION
> -	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
> -END_FTR_SECTION_IFSET(CPU_FTR_NEED_COHERENT)
> +	rlwinm	r8,r8,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
> +END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
I'm pretty sure that the hack for setup_32.c above protects this code in hash_low_32.S/
create_hpte() from being overwritten with nops. But I wonder which other paths exists
in the memory management code to set the coherent flag in PTEs? Any ideas how I
can get it to work without removing _PAGE_COHERENT from _PAGE_BASE?

Thanks!

Gerhard
-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a
