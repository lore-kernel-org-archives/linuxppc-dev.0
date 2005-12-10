Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 282FC68888
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Dec 2005 05:31:40 +1100 (EST)
Date: Sat, 10 Dec 2005 19:31:35 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051210183134.GA16930@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de> <20051119172900.GA11829@suse.de>
	<20051119204742.GA17604@suse.de> <20051123202115.GA17320@suse.de>
	<17284.61088.219693.162392@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17284.61088.219693.162392@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Thu, Nov 24, Paul Mackeras wrote:

> Olaf Hering writes:
> 
> > It just died while uncompressing vmlinux. Some unaligned load.
> > So we either need a very simple byte by byte memcpy, or my version below.
> 
> This should achieve the same effect and is quite a bit simpler.  Your
> version looks a bit strange - it copies 1-3 bytes to align the source
> pointer, then copies 1-3 bytes to align the destination pointer, then
> if the source pointer isn't aligned it goes back and tries again... :)

My version worked better:

0 > .registers
Client's Fix Pt Regs:
 00 00000000 003FFDE0 00000000 0115F890 0112FFF5 0000461D 0116007C FAAD15E5
 08 CD12EF34 0000461E 00538042 01167890 0115DBA8 DEADBEEF DEADBEEF DEADBEEF
 10 DEADBEEF DEADBEEF DEADBEEF DEADBEEF 00000006 00000000 0002BA4C 0115F890
 18 0000461D 01133E26 00000000 00000000 003FFE70 0115C16C 0100F991 0000461D
Special Regs:
    %IV: 00000600   %SRR0: 01000EAC   %SRR1: 00003070     %MQ: 00000000
    %CR: 39000035     %LR: 010034CC    %CTR: 000007C5    %XER: E000BE6F
   %DAR: 0112FFFD  %DSISR: 00004104   %SDR1: 004E0000

> diff -urN powerpc/arch/powerpc/boot/string.S merge-hack/arch/powerpc/boot/string.S
> --- powerpc/arch/powerpc/boot/string.S	2005-11-16 15:55:17.000000000 +1100
> +++ merge-hack/arch/powerpc/boot/string.S	2005-11-24 09:18:47.000000000 +1100
> @@ -107,7 +107,7 @@
>  	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
>  	addi	r6,r3,-4
>  	addi	r4,r4,-4
> -	beq	2f			/* if less than 8 bytes to do */
> +	beq	3f			/* if less than 8 bytes to do */
>  	andi.	r0,r6,3			/* get dest word aligned */

r4 is still unaligned at this point,

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
