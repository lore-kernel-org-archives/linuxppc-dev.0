Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E302DDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 01:18:23 +1000 (EST)
Message-ID: <46C46AB7.6070903@freescale.com>
Date: Thu, 16 Aug 2007 10:18:15 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
References: <11872134502476-git-send-email-timur@freescale.com>
	<2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>
In-Reply-To: <2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Can you post a driver that uses this.  I'm interested in seeing what the 
> readability is really like using these macros.

I do not yet have any drivers ready, but I can give you an example:

	setmaskedbits_be32(&uccp->gumr_l,
		UCC_SLOW_GUMR_L_MODE_QMC | UCC_SLOW_GUMR_L_TDCR_1 |
		UCC_SLOW_GUMR_L_RDCR_16,
                 UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
		UCC_SLOW_GUMR_L_RDCR_MASK);

	setmaskedbits_be32(&uccp->gumr_h,
		UCC_SLOW_GUMR_H_SUART | UCC_SLOW_GUMR_H_TRX |
		UCC_SLOW_GUMR_H_TTX, UCC_SLOW_GUMR_H_RFW);

The alternative to using a macro like this is to do this:

	reg = in_be32(p);
	reg &= ~some-mask-bits;
	reg |= some-other-bits;
	out_be32(p, reg);

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
