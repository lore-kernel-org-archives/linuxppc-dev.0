Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9602D67B17
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jun 2006 08:25:05 +1000 (EST)
Subject: Re: [PATCH] powerpc: system call micro optimisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060610151555.GV23891@krispykreme>
References: <20060610151555.GV23891@krispykreme>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 08:24:58 +1000
Message-Id: <1149978298.12687.152.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-06-11 at 01:15 +1000, Anton Blanchard wrote:
> In the syscall path we currently have:
> 
>        crclr   so
>        mfcr    r9
> 
> If we shift the crclr up we can avoid a stall on some CPUs.

Can you maybe have a quick look at the vDSO's ? They might have similar
room for optimisations...

Cheers,
Ben.

> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: kernel/arch/powerpc/kernel/entry_64.S
> ===================================================================
> --- kernel.orig/arch/powerpc/kernel/entry_64.S	2006-04-26 08:03:05.380651922 -0500
> +++ kernel/arch/powerpc/kernel/entry_64.S	2006-04-26 08:03:28.076523958 -0500
> @@ -59,6 +59,7 @@ system_call_common:
>  	beq-	1f
>  	ld	r1,PACAKSAVE(r13)
>  1:	std	r10,0(r1)
> +	crclr	so
>  	std	r11,_NIP(r1)
>  	std	r12,_MSR(r1)
>  	std	r0,GPR0(r1)
> @@ -77,7 +78,6 @@ system_call_common:
>  	std	r11,GPR11(r1)
>  	std	r11,GPR12(r1)
>  	std	r9,GPR13(r1)
> -	crclr	so
>  	mfcr	r9
>  	mflr	r10
>  	li	r11,0xc01
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
