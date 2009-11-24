Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3032F1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 11:26:38 +1100 (EST)
In-Reply-To: <1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <90646C9F-F27D-47AD-9985-83DB7381D6BF@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 05/19] powerpc: wii: bootwrapper bits
Date: Tue, 24 Nov 2009 01:33:17 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> + * We enter with an unknown cache, high BATs and MMU status.

What does this mean?  You know the low four BATs on entry and
nothing else?

> +asm ("\n\

Global asm() is evil.

> +	mfmsr	9\n\
> +	andi.	0, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\

> +	andc	9, 9, 0\n\

mfmsr 9 ; rlwinm 9,9,0,~0x30 ?

> +	mtspr	0x01a, 8	/* SRR0 */\n\
> +	mtspr	0x01b, 9	/* SRR1 */\n\

mtsrr0 and mtsrr1

> +	sync\n\
> +	rfi\n\

No need for sync before rfi

> +	mtspr	0x210, 8	/* IBAT0U */\n\
> +	mtspr	0x211, 8	/* IBAT0L */\n\

You only need to set the upper BAT to zero, saves some code.

> +	isync\n\

isync here is cargo cult

> +	li	8, 0x01ff	/* first 16MiB */\n\
> +	li	9, 0x0002	/* rw */\n\
> +	mtspr	0x210, 8	/* IBAT0U */\n\
> +	mtspr	0x211, 9	/* IBAT0L */\n\
> +	mtspr	0x218, 8	/* DBAT0U */\n\
> +	mtspr	0x219, 9	/* DBAT0L */\n\

M=0 for RAM?

>

Also, you should normally write the lower BAT first.  Doesn't matter
here because IR=DR=0 of course.

> +	lis	8, 0xcc00	/* I/O mem */\n\
> +	ori	8, 8, 0x3ff	/* 32MiB */\n\
> +	lis	9, 0x0c00\n\
> +	ori	9, 9, 0x002a	/* uncached, guarded, rw */\n\
> +	mtspr	0x21a, 8	/* DBAT1U */\n\
> +	mtspr	0x21b, 9	/* DBAT1L */\n\

Is there any real reason you don't identity map this?

> +	sync\n\
> +	isync\n\
> +\n\

Don't need these

> +	/* enable high BATs */\n\
> +	lis	8, 0x8200\n\
> +	mtspr	0x3f3, 8	/* HID4 */\n\

You need to use read-modify-write here.  Also, shouldn't you
enable the extra BATs before setting them?

And you _do_ need isync here as far as I can see.

> +	/* enable caches */\n\
> +	mfspr	8, 0x3f0\n\
> +	ori	8, 8, 0xc000\n\
> +	mtspr	0x3f0, 8	/* HID0 */\n\
> +	isync\n\

You need to invalidate the L1 caches at the same time as you enable
them.

> +void platform_init(unsigned long r3, unsigned long r4, unsigned  
> long r5)
> +{
> +	u32 heapsize = 24*1024*1024 - (u32)_end;
> +
> +	simple_alloc_init(_end, heapsize, 32, 64);
> +	fdt_init(_dtb_start);
> +
> +	if (!ug_grab_io_base() && ug_is_adapter_present())

The "!" reads weird.  Can you not make ug_is_adapter_present()
call ug_grab_io_base(), anyway?


Segher
