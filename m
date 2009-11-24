Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE838B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 11:47:39 +1100 (EST)
In-Reply-To: <1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A07AD196-D33F-477C-B53C-AB05BA236FEC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
Date: Tue, 24 Nov 2009 01:54:19 +0100
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

You set up DBAT1 here...

> +setup_usbgecko_bat:
> +	/* prepare a BAT for early io */
> +	lis	r8, 0x0c00
> +	ori	r8, r8, 0x002a	/* uncached, guarded ,rw */
> +	lis	r11, 0xcc00
> +	ori	r11, r11, 0x3	/* 128K */
> +#ifdef CONFIG_WII
> +	oris	r8, r8, 0x0100
> +	oris	r11, r11, 0x0100
> +#endif
> +	mtspr	SPRN_DBAT1L, r8
> +	mtspr	SPRN_DBAT1U, r11
> +	sync
> +	isync
> +	blr

... and again here:

> +void __init udbg_init_usbgecko(void)
> +{
> +	unsigned long vaddr, paddr;
> +
> +#if defined(CONFIG_GAMECUBE)
> +	paddr = 0x0c000000;
> +#elif defined(CONFIG_WII)
> +	paddr = 0x0d000000;
> +#else
> +#error Invalid platform for USB Gecko based early debugging.
> +#endif
> +
> +	vaddr = 0xc0000000 | paddr;
> +	setbat(1, vaddr, paddr, 128*1024, PAGE_KERNEL_NCG);

Do you need to do it twice?

> +	ug_io_base = (void __iomem *)(vaddr | 0x6814);

Oh, hardcoded slot2, now i'm confused which one should be it :-)


Segher
