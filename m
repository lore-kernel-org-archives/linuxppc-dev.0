Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D94DDE36A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 00:22:05 +1000 (EST)
In-Reply-To: <18585.14669.954874.540716@drongo.ozlabs.ibm.com>
References: <18585.14669.954874.540716@drongo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A1BAD7C8-8459-4D6E-80BA-639D305611DD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH] Link the bootwrapper as a position-independent
	executable
Date: Wed, 6 Aug 2008 16:21:57 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Instead we now link the bootwrapper with -pie to get a position-
> independent executable, and process the relocations in the dynamic
> relocation section that the linker puts into the executable.

Hurray!  Looks good, just a few nits...

> +	bl	.+4
> +p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */

bl p_base  instead?

> +10:	or.	r8,r0,r9	/* skip relocation if we don't have both */
>  	beq	3f

Either the code or the comment is wrong -- the code says "skip  
relocation
if we don't have either".

> +	cmpwi	r0,22		/* R_PPC_RELATIVE */
> +	bne	3f

It would be nice if there was some way to complain (at build time?)
if there are unhandled relocations present.  Prevents a lot of headaches
when things go wrong (and they will ;-) )

>  4:	dcbf	r0,r9
>  	icbi	r0,r9

Fix these while you're at it?  It's not r0, it's 0.

> +  .dynsym : { *(.dynsym) }
> +  .dynstr : { *(.dynstr) }
> +  .dynamic :
> +  {
> +    __dynamic_start = .;
> +    *(.dynamic)
> +  }
> +  .hash : { *(.hash) }
> +  .interp : { *(.interp) }
> +  .rela.dyn : { *(.rela*) }

Do some of these sections need alignment?


Segher
