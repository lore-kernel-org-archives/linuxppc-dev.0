Return-Path: <amodra@bigpond.net.au>
Received: from omta04sl.mx.bigpond.com (omta04sl.mx.bigpond.com
	[144.140.93.156]) by ozlabs.org (Postfix) with ESMTP id DB00FDDEC0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 08:31:52 +1100 (EST)
Date: Wed, 3 Jan 2007 08:01:51 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Simon Vallet <linux-ppc@castalie.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
Message-ID: <20070102213151.GA24185@bubble.grove.modra.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 02, 2007 at 05:25:54PM +0100, Simon Vallet wrote:
> Is there a reason for this ?

I guess no one has needed the reloc before.  gcc tends to use
"li, addis" pairs to load 32-bit constants.  Your code must be using
"lis, ori".

> If there are no reasons, then how about the following patch ?

Looks good to me.

> --- arch/powerpc/kernel/module_32.c.orig	2007-01-02 17:07:21.000000000 +0100
> +++ arch/powerpc/kernel/module_32.c	2007-01-02 17:11:55.000000000 +0100
> @@ -222,6 +222,11 @@ int apply_relocate_add(Elf32_Shdr *sechd
>  			*(uint16_t *)location = value;
>  			break;
>  		
> +		case R_PPC_ADDR16_HI:
> +			/* Higher half of the symbol */
> +			*(uint16_t *)location = (value >> 16);
> +			break;
> +
>  		case R_PPC_ADDR16_HA:
>  			/* Sign-adjusted lower 16 bits: PPC ELF ABI says:
>  			   (((x >> 16) + ((x & 0x8000) ? 1 : 0))) & 0xFFFF.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
