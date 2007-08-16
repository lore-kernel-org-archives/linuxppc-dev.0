Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A344ADDEB6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 01:20:21 +1000 (EST)
In-Reply-To: <46C46AB7.6070903@freescale.com>
References: <11872134502476-git-send-email-timur@freescale.com>
	<2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>
	<46C46AB7.6070903@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9CE3D32E-B9C6-43B8-B944-45CE1DCCE8A2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
Date: Thu, 16 Aug 2007 10:21:54 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 16, 2007, at 10:18 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> Can you post a driver that uses this.  I'm interested in seeing  
>> what the readability is really like using these macros.
>
> I do not yet have any drivers ready, but I can give you an example:
>
> 	setmaskedbits_be32(&uccp->gumr_l,
> 		UCC_SLOW_GUMR_L_MODE_QMC | UCC_SLOW_GUMR_L_TDCR_1 |
> 		UCC_SLOW_GUMR_L_RDCR_16,
>                 UCC_SLOW_GUMR_L_MODE_MASK |  
> UCC_SLOW_GUMR_L_TDCR_MASK |
> 		UCC_SLOW_GUMR_L_RDCR_MASK);
>
> 	setmaskedbits_be32(&uccp->gumr_h,
> 		UCC_SLOW_GUMR_H_SUART | UCC_SLOW_GUMR_H_TRX |
> 		UCC_SLOW_GUMR_H_TTX, UCC_SLOW_GUMR_H_RFW);

Can you also show what the UCC_SLOW* values look like.

> The alternative to using a macro like this is to do this:
>
> 	reg = in_be32(p);
> 	reg &= ~some-mask-bits;
> 	reg |= some-other-bits;
> 	out_be32(p, reg);
>
> -- 
> Timur Tabi
> Linux Kernel Developer @ Freescale
