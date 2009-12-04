Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A06A2B7BEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 22:57:12 +1100 (EST)
In-Reply-To: <4f4baca1cd65f7949610ca901c9a8bcb1bb74cfd.1259871725.git.albert_herranz@yahoo.es>
References: <cover.1259871725.git.albert_herranz@yahoo.es>
	<4f4baca1cd65f7949610ca901c9a8bcb1bb74cfd.1259871725.git.albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <364F1867-9601-44FD-B140-EAA0FCC2C237@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v4 2/2] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Fri, 4 Dec 2009 13:04:53 +0100
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

> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> +setup_usbgecko_bat:
> +	/* prepare a BAT for early io */
> +#if defined(CONFIG_GAMECUBE)
> +	lis	r8, 0x0c00
> +#elif defined(CONFIG_WII)
> +	lis	r8, 0x0d00
> +#else
> +#error Invalid platform for USB Gecko based early debugging.
> +#endif

A kernel with both CONFIG_WII and CONFIG_GAMECUBE works fine
on either, right?  If so, could you please switch the two #ifs?
A dual-platform kernel will be used on a Wii much more likely
than on a GC.

> +	/*
> +	 * The virtual address used must match the virtual address
> +	 * associated to the fixmap entry FIX_EARLY_DEBUG_BASE.
> +	 */
> +	lis	r11, 0xfffe	/* top 128K */
> +	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
> +	ori	r11, r11, 0x3	/* 128K */

I think you should clear Vp since the BAT mapping can survive until
after user space is started; it won't hurt to remove it either way.
So 2 instead of 3.  And put the meaning in the comment :-)

Looks fine otherwise.


Segher
