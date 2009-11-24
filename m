Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AE09B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 09:06:39 +1100 (EST)
In-Reply-To: <1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
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
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BEFB28A5-8BA2-43F8-B917-0C838246B962@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 17/19] powerpc: wii: bootmii starlet 'mini' firmware
	support
Date: Tue, 24 Nov 2009 23:13:07 +0100
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

> Add support for the BootMii 'mini' firmware replacement for the
> Starlet processor.
>
> 'mini' is an open source IOS replacement written from scratch by
> Team Twiizers.

It's not a replacement, it doesn't have any of the same functionality.

> It grants full access to the hardware found on the
> Nintendo Wii video game console via a custom IPC mechanism.

This is out of date, you get full register-level hardware access now.

Do you want to mainline any of the drivers that work via mini proxy?
If not, you can remove quite some bit of code here I think.

> +enum starlet_ipc_flavour {
> +	STARLET_IPC_IOS,
> +	STARLET_IPC_MINI,
> +};

I thought you don't support IOS at all anymore?

> +config STARLET_MINI
> +	bool "BootMii Starlet 'mini' firmware support"
> +	depends on WII && EXPERIMENTAL

Given that this is the only supported starlet firmware interface,
does it make sense to expose the option to the user?

<big snip, see my "remove stuff" comment above>

> +static void mipc_init_ahbprot(struct mipc_device *ipc_dev)
> +{
> +	void __iomem *hw_ahbprot;
> +	u32 initial_ahbprot, ahbprot = 0;
> +
> +	hw_ahbprot = mipc_get_hw_reg(HW_AHBPROT_OF_COMPATIBLE);
> +	if (!hw_ahbprot)
> +		goto done;
> +
> +	initial_ahbprot = mipc_readl(hw_ahbprot);
> +	if (initial_ahbprot != 0xffffffff) {
> +		pr_debug("AHBPROT=%08X (before)\n", initial_ahbprot);
> +		/* enable full access from the PowerPC side */
> +		mipc_writel(0xffffffff, hw_ahbprot);
> +	}
> +
> +	ahbprot = mipc_readl(hw_ahbprot);
> +	if (initial_ahbprot != ahbprot)
> +		pr_debug("AHBPROT=%08X (after)\n", ahbprot);
> +done:
> +	if (ahbprot != 0xffffffff)
> +		pr_err("failed to set AHBPROT\n");
> +}

Modern mini will always have AHBPROT set up to give you full access,
so this isn't needed either.

> +#ifdef CONFIG_HLWD_PIC
> +	/*
> +	 * Setup the Hollywood interrupt controller as soon as
> +	 * we detect that we are running under the mini firmware.
> +	 */
> +	hlwd_pic_probe();
> +#endif

Why?  The comment doesn't say.


Do you need this driver to boot?  If not, it might be best to leave it
out for now.


Segher
