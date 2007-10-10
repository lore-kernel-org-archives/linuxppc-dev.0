Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D18F1DDFF3
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 06:47:36 +1000 (EST)
Message-ID: <470D3A64.2000507@freescale.com>
Date: Wed, 10 Oct 2007 15:47:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Eno 3 Compton <one@ecom.com>
Subject: Re: irq identification has changed from 2.6.10 to 2.6.23. an
	explanation is requested
References: <f6c0dc290710101339t30a15881t3ffbe02324006b28@mail.gmail.com>
In-Reply-To: <f6c0dc290710101339t30a15881t3ffbe02324006b28@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eno 3 Compton wrote:
> I had a driver working under 2.6.10 on a mpc8248. The kernel got changed 
> under me to 2.6.23. Now, when I call request_irq with SIU_INT_IRQ5, 
> which is defined in asm-powerpc/irq.h, and once compiled and worked 
> properly, I get compilation errors. The compiler can't find the symbol 
> definition because CONFIG_PPC_MERGE  is defined. I suspect the kernel 
> guys have migrated things to a new arrangement, which I've been unable 
> to discern.
> 
> An explanation or advice on where to find information about this would 
> be hugely appreciated.

Ideally, you should put whatever device you're trying to drive in the 
device tree, and use of_irq_to_resource() on the device node to find the 
virtual IRQ number.

Failing that, you can call irq_find_mapping(), but you'll need to either 
pass in the device node of the relevant interrupt controller, or call 
irq_set_default_host() -- but really, it's better to just use the device 
tree.

-Scott
