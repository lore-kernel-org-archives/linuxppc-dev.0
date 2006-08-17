Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84F8167B5C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 05:24:57 +1000 (EST)
In-Reply-To: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Thu, 17 Aug 2006 21:24:44 +0200
To: will_schmidt@vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static int emulate_popcntb_inst(struct pt_regs *regs, u32 instword)
> +{
> +	u32 ra,rs;
> +	u32 countreg,tmp;
> +	u32 x,y;
> +
> +	ra = (instword >> 16) & 0x1f;
> +	rs = (instword >> 21) & 0x1f;
> +	countreg = regs->gpr[rs];
> +	regs->gpr[ra] = 0;
> +
> +	/* y=4 bytes, x=8 bits/byte */
> +	for (y = 0; y < 4; y++) {
> +		for (tmp = 0, x = 0; x < 8; x++)
> +			if (countreg & (0x1 << (x + 8 * y))) tmp++;
> +		regs->gpr[ra] += (tmp <<  8 * y );
> +	}
> +	return 0;
> +}

x in, x out:

	x -= (x >> 1) & 0x5555555555555555;
	x = (x & 0x3333333333333333) + ((x >> 2) & 0x3333333333333333);
	x = (x + (x >> 4)) & 0x0f0f0f0f0f0f0f0f;

(Your code only runs on 4 bytes; shouldn't it be 8?)


Segher
