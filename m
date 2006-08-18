Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF87B67B6D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:42:19 +1000 (EST)
In-Reply-To: <1155924687.9659.25.camel@farscape.rchland.ibm.com>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<36A1A5C6-5269-4BDA-9F3E-A632B3A627DB@kernel.crashing.org>
	<1155924687.9659.25.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FE1A4DBD-9AAB-434A-B487-06B68AC61CC0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Fri, 18 Aug 2006 14:42:16 -0500
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

>
> +static int emulate_popcntb_inst(struct pt_regs *regs, u32 instword)
> +{
> +	u32 ra,rs;
> +	unsigned long tmp;
> +
> +	ra = (instword >> 16) & 0x1f;
> +	rs = (instword >> 21) & 0x1f;
> +
> +	tmp = regs->gpr[rs];
> +	tmp = tmp - ((tmp >> 1) & 0x5555555555555555);
> +	tmp = (tmp & 0x3333333333333333) + ((tmp >> 2) &  
> 0x3333333333333333);
> +	tmp = (tmp + (tmp >> 4)) & 0x0f0f0f0f0f0f0f0f;
> +	regs->gpr[ra] = tmp;
> +
> +	return 0;
> +}

This is going to give warnings on ppc32 kernel compiles, maybe  
something like:

(unsigned long) 0x5555555555555555ull

- kumar
