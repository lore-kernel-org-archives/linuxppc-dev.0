Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8C1DBB70C1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 08:52:15 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCEFDDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 08:52:14 +1000 (EST)
Message-Id: <2AF4BA69-D05A-4D2E-BD32-5E1C93ACF445@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Date: Mon, 8 Jun 2009 17:52:09 -0500
References: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2009, at 5:13 PM, Nate Case wrote:

> +static void xes_mpc85xx_configure_l1(void)
> +{
> +	uint spr;
> +	asm volatile("msync; isync");
> +	spr = mfspr(SPRN_L1CSR1);
> +	asm volatile("msync; isync");
> +	/* Enable instruction cache */
> +	mtspr(SPRN_L1CSR1, spr | L1CSR1_ICFI | L1CSR1_ICE | L1CSR1_CPE);
> +
> +	/* Enable L1 data cache if it isn't already enabled */
> +	if (mfspr(SPRN_L1CSR0) == 0x0) {
> +		printk(KERN_INFO "xes_mpc85xx: Enabling L1 caches\n");
> +		asm volatile("msync; isync");
> +		mtspr(SPRN_L1CSR0, 0x0);		/* Disable */
> +		asm volatile("msync; isync");
> +		mtspr(SPRN_L1CSR0, L1CSR0_DCFI);	/* Invalidate */
> +		asm volatile("msync; isync");
> +		spr = mfspr(SPRN_L1CSR0);
> +		asm volatile("msync; isync");
> +		mtspr(SPRN_L1CSR0, spr | L1CSR0_DCFI | L1CSR0_DCE |
> +				   L1CSR0_CPE);		/* Enable */
> +	}
> +}
> +

I'd prefer we move this into __setup_cpu_e500v1/__setup_cpu_e500v2 so  
its done for all processors regardless of platform.

- k
